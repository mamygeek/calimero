



CREATE TABLE users (
    id integer NOT NULL,
    first_name character varying(30),
    last_name character varying(30),
    email character varying(30),
    from_date timestamp without time zone DEFAULT now(),
    last_date timestamp without time zone DEFAULT now(),
    CONSTRAINT users_check
        CHECK (last_date > from_date)
        PRIMARY_KEY id
);



CREATE TABLE images(
    id CHAR(8) PRIMARY KEY,
    url VARCHAR(200)
);


CREATE TABLE doleances(
usr_id integer,
msg varchar(300),
img_id CHAR(8),
date timestamp DEFAULT now(),
primary key (usr_id, msg, img_id),
foreign key (usr_id)
        references users(id)
        on delete Cascade
        on update cascade,
foreign key (img_id)
        references images(id)
        on delete Cascade
        on update cascade
);

-- TODO
delimiter //
CREATE trigger updateLastDate
after insert on doleances
begin
for each row
update users set last_date = now() where id = new.usr_id;
end;//
delimiter ;