create or replace function name_length_check() returns trigger
as
$$
begin
    if char_length(new.description) < 10
    then raise exception 'The description is too short';
    end if;
    return null;
end
$$
    language plpgsql;

create or replace trigger name_length_check
    after insert or update
    on "term"
    for each row
execute procedure name_length_check();