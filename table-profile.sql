-- Create object type for output records
CREATE OR REPLACE TYPE data_profile_record AS OBJECT (
    table_name    VARCHAR2(40 CHAR),
    column_name   VARCHAR2(40 CHAR),
    column_id     NUMBER,
    n_unique      NUMBER,
    n_null        NUMBER
);
/

-- Create table type for report output
CREATE OR REPLACE TYPE data_profile_table AS TABLE OF data_profile_record;
/

-- Create function for generating table report
CREATE OR REPLACE FUNCTION data_profile (
    table_name_in VARCHAR2
) RETURN data_profile_table AS

    v_ret          data_profile_table;
    CURSOR c1 IS SELECT
        column_name,
        column_id
                 FROM
        all_tab_cols
                 WHERE
        table_name = UPPER(table_name_in)
    ORDER BY
        column_id;

    n_unique_cnt   NUMBER;
    n_null_cnt NUMBER;
BEGIN
    v_ret := data_profile_table ();
    FOR rec_in IN c1 LOOP
        EXECUTE IMMEDIATE 'select count(distinct '
        || rec_in.column_name
        || ') from '
        || table_name_in INTO
            n_unique_cnt;
        EXECUTE IMMEDIATE 'select count(*) from ' || table_name_in || ' where ' || rec_in.column_name || ' is null ' INTO n_null_cnt;
        v_ret.extend;
        v_ret(v_ret.COUNT) := data_profile_record(UPPER(table_name_in),rec_in.column_name,rec_in.column_id,n_unique_cnt, n_null_cnt);

    END LOOP;

    RETURN v_ret;
END data_profile;
/