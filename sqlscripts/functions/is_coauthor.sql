create or replace function is_coauthor(author_id_1 uuid, author_id_2 uuid)
    returns boolean as $$
declare
    is_coauthor boolean;
begin
    is_coauthor := false;
    if exists(
        select "admin_article_id"
        from "admin_article"
        where "admin_id" = author_id_1 and "article_id" in (
            select "article_id"
            from "admin_article"
            where "admin_id" = author_id_2
        )
    )
    then is_coauthor := true;
    end if;

    return is_coauthor;
end
$$
    language plpgsql;

select is_coauthor('263a67cb-107a-4594-99c5-543994f2c643', '3fb50925-4607-45a1-b8fc-bc4a7d0ea617');

select is_coauthor('e51ffaac-4610-417a-8dff-b2b6d65a4290', '263a67cb-107a-4594-99c5-543994f2c643');
