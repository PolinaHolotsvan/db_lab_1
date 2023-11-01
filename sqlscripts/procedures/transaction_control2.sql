create or replace procedure transaction_control2()
as
$$
begin
    drop table if exists procedure_test2;
    create table procedure_test2(id integer, description varchar);
    insert into procedure_test2 values (1, 'it`s a test');
    insert into procedure_test2 values (2, 'just a test!');
    commit;
end;
$$
    language plpgsql;

call transaction_control2()