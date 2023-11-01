create or replace function was_replied(parent_comment_id uuid)
    returns boolean as $$
declare
    was_replied boolean;
begin
    was_replied := false;
    if exists(
        select "comment_id"
        from "comment"
        where "comment_id" = parent_comment_id and "comment_id" in (
            select "parent_id"
            from "comment"
        )
    )
    then was_replied := true;
    end if;

    return was_replied;
end
$$
    language plpgsql;

select was_replied('ea8f48f5-96cb-4ed3-8a7b-db647af7dec1');
select was_replied('ab250f69-bc93-40d3-8774-f284b2599b7b')