create or replace function get_comment_count(article_id_ integer)
    returns integer as
$$
declare
    comment_count integer;
begin
    select count(comment_id)
    into comment_count
    from "comment"
    where "article_id" = article_id_;

    return comment_count;
end
$$
    language plpgsql;

select get_comment_count(5);
