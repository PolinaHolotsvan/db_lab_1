create or replace function log_term_change_history() returns trigger
as
$$
declare
    max_id integer;
begin
    select max(change_id)
    into max_id
    from "term_change_history";

    if TG_OP = 'INSERT' OR new <> old then
        insert into term_change_history
        values (max_id + 1, new.term_id, now());
    end if;
    return null;
end
$$
    language plpgsql;

create or replace trigger name_length_check
    after insert or update
    on "term"
    for each row
execute procedure log_term_change_history();