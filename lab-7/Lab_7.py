import sqlite3
from sqlite3 import Error

def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)
    
    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

    return conn

def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def createTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create table")

    try:
        _conn.execute("""
        CREATE TABLE IF NOT EXISTS warehouse (
            w_warehousekey decimal(9,0) not null,
            w_name char(100) not null,
            w_capacity decimal(6,0) not null,
            w_suppkey decimal(9,0) not null,
            w_nationkey decimal(2,0) not null
        );
        """)
        print("Table created successfully")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def dropTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Drop tables")
    try:
        _conn.execute("DROP TABLE IF EXISTS warehouse;")
        print("success")
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")

def populateTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Populate table")
    try:
        _conn.execute("""
        WITH temp_tb AS(
        SELECT  *
        FROM(
            SELECT  supplier.s_suppkey AS supplier_key,
                    supplier.s_name AS supplier_name,
                    nation.n_nationkey AS cus_nationkey,
                    nation.n_name AS cus_nationname,
                    sum(part.p_size) AS total_size,
                    count(*) AS total_lineitem,
                    row_number() over (partition by supplier.s_suppkey order by count(*) DESC) AS rn
            FROM    lineitem
            JOIN    part ON lineitem.l_partkey = part.p_partkey
            JOIN    supplier ON lineitem.l_suppkey = supplier.s_suppkey
            JOIN    orders ON lineitem.l_orderkey = orders.o_orderkey
            JOIN    customer ON orders.o_custkey = customer.c_custkey
            JOIN    nation ON customer.c_nationkey = nation.n_nationkey
            GROUP BY supplier.s_suppkey, nation.n_nationkey
            ) WHERE rn <= 3
        )

        INSERT INTO warehouse (w_warehousekey,w_name,w_capacity,w_suppkey,w_nationkey)
        SELECT  row_number() OVER () AS w_warehousekey,
                supplier_name || '____' || cus_nationname AS w_name,
                total_size*3 AS w_capacity,
                supplier_key AS w_suppkey,
                cus_nationkey AS w_nationkey
        FROM    temp_tb;
        """)
        print("success")
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")

def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")

    try:
        output = open('output/1.out', 'w')

        header = "{:>10} {:<40} {:>10} {:>10} {:>10}"
        output.write((header.format("wId", "wName", "wCap", "sId", "nId")) + '\n')

        cursor = _conn.cursor()
        cursor.execute("""
        SELECT  *  FROM warehouse ORDER BY w_warehousekey;
        """)
        rows = cursor.fetchall()
        for row in rows:
            output.write(("{:>10} {:<40} {:>10} {:>10} {:>10}".format(row[0], row[1], row[2], row[3], row[4])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    try:
        output = open('output/2.out', 'w')

        header = "{:<40} {:>10} {:>10}"
        output.write((header.format("nation", "numW", "totCap")) + '\n')

        cursor = _conn.cursor()
        cursor.execute("""
        SELECT  nation.n_name AS nation,
                count(*) AS numW,
                sum(w_capacity) AS totCap
        FROM    warehouse
        JOIN    nation ON warehouse.w_nationkey = nation.n_nationkey
        GROUP BY nation.n_name
        ORDER BY numW DESC, totCap DESC, nation.n_name;
        """)
        rows = cursor.fetchall()
        for row in rows:
            output.write(("{:<40} {:>10} {:>10}".format(row[0], row[1], row[2])) + '\n')
        
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")

    try:
        input = open("input/3.in", "r")
        nation = input.readline().strip()
        input.close()


        output = open('output/3.out', 'w')

        header = "{:<20} {:<20} {:<40}"
        output.write((header.format("supplier", "nation", "warehouse")) + '\n')
        
        cursor = _conn.cursor()
        cursor.execute("""
        SELECT  supplier.s_name AS supplier,
                nation.n_name AS nation,
                warehouse.w_name AS warehouse
        FROM    warehouse
        JOIN    supplier ON warehouse.w_suppkey = supplier.s_suppkey
        JOIN    nation ON warehouse.w_nationkey = nation.n_nationkey
        WHERE   nation.n_name = ?
        ORDER BY supplier.s_name;
        """, (nation,))
        rows = cursor.fetchall()
        for row in rows:
            output.write(("{:<20} {:<20} {:<40}".format(row[0], row[1], row[2])) + '\n')
        
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    try:
        input = open("input/4.in", "r")
        region = input.readline().strip()
        cap = input.readline().strip()
        input.close()

        output = open('output/4.out', 'w')

        header = "{:<40} {:>10}"
        output.write((header.format("warehouse", "capacity")) + '\n')
        
        cursor = _conn.cursor()
        cursor.execute("""
        SELECT  w_name AS warehouse,
                w_capacity AS capacity
        FROM    warehouse
        JOIN    nation ON warehouse.w_nationkey = nation.n_nationkey
        JOIN    region ON nation.n_regionkey = region.r_regionkey
        WHERE   region.r_name = ? AND w_capacity > ?
        ORDER BY w_capacity DESC;
        """, (region, cap))
        rows = cursor.fetchall()
        for row in rows:
            output.write(("{:<40} {:>10}".format(row[0], row[1])) + '\n')
    
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

    try:
        input = open("input/5.in", "r")
        nation = input.readline().strip()
        input.close()


        output = open('output/5.out', 'w')

        header = "{:<20} {:>20}"
        output.write((header.format("region", "capacity")) + '\n')

        cursor = _conn.cursor()
        cursor.execute("""
        SELECT  region.r_name AS region,
                sum(w_capacity) AS capacity
        FROM    warehouse
        JOIN    nation ON warehouse.w_nationkey = nation.n_nationkey
        JOIN    region ON nation.n_regionkey = region.r_regionkey
        WHERE   nation.n_name = ?
        GROUP BY region.r_name
        ORDER BY region.r_name;
        """, (nation,))
        rows = cursor.fetchall()
        for row in rows:
            output.write(("{:<20} {:>20}".format(row[0], row[1])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        dropTable(conn)
        createTable(conn)
        populateTable(conn)

        Q1(conn)
        Q2(conn)
        Q3(conn)
        Q4(conn)
        Q5(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
