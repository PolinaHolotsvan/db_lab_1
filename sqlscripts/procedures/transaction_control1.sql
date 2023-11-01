create or replace procedure transaction_control1()
as
$$
begin
    create table procedure_test1(id integer, description varchar);
    rollback;
end;
$$
language plpgsql;

call transaction_control1();