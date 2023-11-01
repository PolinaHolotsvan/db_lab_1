create or replace function get_longest_term() returns varchar
as
$$
declare
    t1           varchar;
    longest_term varchar;
    term_array   varchar[];
begin
    select array_agg("description") into term_array
    from "term";
    longest_term := '';
    foreach t1 in array term_array
        loop
            if char_length(longest_term) < char_length(t1)
            then
                longest_term := t1;
            end if;
        end loop;
    return longest_term;
end;
$$
    language plpgsql;

select get_longest_term();