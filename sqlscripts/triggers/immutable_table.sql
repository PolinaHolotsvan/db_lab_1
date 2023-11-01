create table if not exists immutable_table(id integer, description varchar);
insert into immutable_table values (1, 'it`s an immutable table');
insert into immutable_table values (2, 'just an immutable table!');

create or replace function immutable_table() returns trigger
as
$$
begin
    raise exception 'The table is immutable';
end
$$
    language plpgsql;

create or replace trigger immutable_table
    before insert or update or delete
    on "immutable_table"
execute procedure immutable_table();