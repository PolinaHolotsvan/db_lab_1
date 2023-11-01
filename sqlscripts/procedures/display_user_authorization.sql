create or replace procedure display_user_authorization(arg_user_id uuid)
as
$$
declare
begin
    if not exists(select "user_id"
                  from "user"
                  where "user_id" = arg_user_id)
    then
        raise notice 'This user does`nt exist';
    else
        if exists(select "user_id"
                  from "user"
                  where "user_id" = arg_user_id
                    and "login_data_id" is not null)
        then
            raise notice 'This user was authorized via internal provider';
        else
            raise notice 'This user was authorized via external provider';
        end if;
    end if;
end;
$$
    language plpgsql;

call display_user_authorization('bb640153-72ca-4c53-9001-5ce51dc1459b');
call display_user_authorization('ee2a7a74-8613-4089-8620-160606bbb7a1');
call display_user_authorization('eb9d0ec5-04f8-423e-be78-403f1d19de18')