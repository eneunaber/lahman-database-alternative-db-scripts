#!/usr/bin/env python3
import csv
import pathlib
import sqlite3
import sys


CSV_TABLES = [
    "AllstarFull",
    "Appearances",
    "AwardsManagers",
    "AwardsPlayers",
    "AwardsShareManagers",
    "AwardsSharePlayers",
    "Batting",
    "BattingPost",
    "CollegePlaying",
    "Fielding",
    "FieldingOF",
    "FieldingOFsplit",
    "FieldingPost",
    "HallOfFame",
    "HomeGames",
    "Managers",
    "ManagersHalf",
    "Parks",
    "People",
    "Pitching",
    "PitchingPost",
    "Salaries",
    "Schools",
    "SeriesPost",
    "Teams",
    "TeamsFranchises",
    "TeamsHalf",
]


def q(name: str) -> str:
    return '"' + name.replace('"', '""') + '"'


def is_numeric_type(t: str) -> bool:
    u = (t or "").upper()
    return any(x in u for x in ("INT", "REAL", "NUM", "DEC", "DOUB", "FLOA"))


def convert_expr(col: str, col_type: str, not_null: bool) -> str:
    col_q = q(col)
    trimmed = f"TRIM({col_q})"
    if is_numeric_type(col_type):
        # Let STRICT affinity conversion handle numeric text.
        # Empty strings become NULL for nullable numeric columns.
        return trimmed if not_null else f"NULLIF({trimmed}, '')"
    if not_null:
        return col_q
    return f"NULLIF({col_q}, '')"


def load_table(conn: sqlite3.Connection, data_dir: pathlib.Path, table: str) -> None:
    csv_path = data_dir / f"{table}.csv"
    if not csv_path.exists():
        raise FileNotFoundError(f"Missing CSV file: {csv_path}")

    schema_rows = conn.execute(f'PRAGMA table_info({q(table)})').fetchall()
    if not schema_rows:
        raise RuntimeError(f"Target table not found: {table}")

    # PRAGMA columns: cid, name, type, notnull, dflt_value, pk
    target_cols = [r[1] for r in schema_rows]
    target_types = {r[1]: r[2] for r in schema_rows}
    target_notnull = {r[1]: bool(r[3]) for r in schema_rows}

    with csv_path.open("r", encoding="utf-8", newline="") as f:
        reader = csv.reader(f)
        header = next(reader, None)
        if header is None:
            raise RuntimeError(f"CSV has no header: {csv_path}")
        header = [h.strip() for h in header]
        if header:
            # Some CSV exports include UTF-8 BOM in the first header cell.
            header[0] = header[0].lstrip("\ufeff")

        if header != target_cols:
            raise RuntimeError(
                f"Header mismatch for {table}. "
                f"Expected {target_cols}, got {header}"
            )

        temp_table = f"__stg_{table}"
        conn.execute(f"DROP TABLE IF EXISTS {q(temp_table)}")
        conn.execute(
            f"CREATE TEMP TABLE {q(temp_table)} ("
            + ", ".join(f"{q(c)} TEXT" for c in header)
            + ")"
        )

        placeholders = ", ".join("?" for _ in header)
        insert_staging = (
            f"INSERT INTO {q(temp_table)} ("
            + ", ".join(q(c) for c in header)
            + f") VALUES ({placeholders})"
        )
        conn.executemany(insert_staging, reader)

        select_exprs = [
            f"{convert_expr(c, target_types[c], target_notnull[c])} AS {q(c)}"
            for c in target_cols
        ]
        insert_target = (
            f"INSERT INTO {q(table)} ("
            + ", ".join(q(c) for c in target_cols)
            + ") SELECT "
            + ", ".join(select_exprs)
            + f" FROM {q(temp_table)}"
        )
        conn.execute(insert_target)
        conn.execute(f"DROP TABLE {q(temp_table)}")


def main() -> int:
    db_path = pathlib.Path(sys.argv[1]) if len(sys.argv) > 1 else pathlib.Path("lahman.sqlite")
    data_dir = pathlib.Path("data")

    if not db_path.exists():
        print(f"SQLite database file not found: {db_path}", file=sys.stderr)
        return 2
    if not data_dir.exists():
        print("Data directory not found: ./data", file=sys.stderr)
        return 2

    conn = sqlite3.connect(str(db_path))
    try:
        conn.execute("PRAGMA foreign_keys=OFF")
        conn.execute("BEGIN")
        for table in CSV_TABLES:
            load_table(conn, data_dir, table)
        conn.execute("COMMIT")
        conn.execute("PRAGMA foreign_keys=ON")
    except Exception:
        conn.execute("ROLLBACK")
        raise
    finally:
        conn.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
