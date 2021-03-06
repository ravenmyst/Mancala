-- file: /install/mancala.sql
-- by: ravenmyst
-- description: import this file in mysql to initialize database

-- start transaction
start transaction;

-- make database
create database mancala
-- set encoding utf-8_general_ci
    default character set utf8
    default collate utf8_general_ci;

-- use new database
use mancala;

-- make users table
create table users 
(
    id int(6) unsigned auto_increment,
    username varchar(100) not null,
    password varchar(512) not null,
    reg_date timestamp,

    primary key(id)
);

-- make trial account
insert into users 
( 
    username, 
    password
) 
values 
( 
    "test", 
    "test"
);

-- make hole type table
create table hole_type 
(
    id int(6) unsigned auto_increment,
    name varchar(256) not null,

    primary key(id)
);

-- insert basic mancala hole types
insert into hole_type 
( 
    name
) 
values 
( 
    "divot"
);

insert into hole_type 
( 
    name
) 
values 
( 
    "pot"
);

-- make hole table
create table hole
(
    id int(6) unsigned auto_increment,
    name varchar(256) not null,
    type int (6) unsigned not null,
    
    primary key (id),

    foreign key (type)
        references hole_type(id)
            on delete cascade
);

-- insert all mancala holes into the structure
insert into hole
( 
    name,
    type
) 
values 
(
    "p1_hole_0",
    2
);

insert into hole
( 
    name,
    type
) 
values 
(
    "p1_hole_1",
    1
);

insert into hole
( 
    name,
    type
) 
values 
(
    "p1_hole_2",
    1
);

insert into hole
( 
    name,
    type
) 
values 
(
    "p1_hole_3",
    1
);

insert into hole
( 
    name,
    type
) 
values 
(
    "p1_hole_4",
    1
);

insert into hole
( 
    name,
    type
) 
values 
(
    "p1_hole_5",
    1
);

insert into hole
( 
    name,
    type
) 
values 
(
    "p1_hole_6",
    1
);

insert into hole
( 
    name,
    type
) 
values 
(
    "p2_hole_0",
    2
);

insert into hole
( 
    name,
    type
) 
values 
(
    "p2_hole_1",
    1
);

insert into hole
( 
    name,
    type
) 
values 
(
    "p2_hole_2",
    1
);

insert into hole
( 
    name,
    type
) 
values 
(
    "p2_hole_3",
    1
);

insert into hole
( 
    name,
    type
) 
values 
(
    "p2_hole_4",
    1
);

insert into hole
( 
    name,
    type
) 
values 
(
    "p2_hole_5",
    1
);

insert into hole
( 
    name,
    type
)
values 
(
    "p2_hole_6",
    1
);

-- make game_config table
create table game_config
(
    id int(6) unsigned auto_increment,
    color_1_player_1 int (6) unsigned not null,
    color_2_player_1 int (6) unsigned not null,
    color_1_player_2 int (6) unsigned not null,
    color_2_player_2 int (6) unsigned not null,

     primary key(id)
);

-- insert default game_config
insert into game_config
( 
    color_1_player_1,
    color_2_player_1,
    color_1_player_2,
    color_2_player_2
) 
values 
(
    "000000",
    "A020F0",
    "0000FF",
    "00FF00"
);

-- make game table
create table game
(
    id int(6) unsigned auto_increment,
    game_hash varchar(256) not null,
    game_config_id int (6) unsigned not null,
    active int (6) unsigned not null,
    user_id_player_1 int (6) unsigned not null,
    user_id_player_2 int (6) unsigned not null,
    turn_number int (6) unsigned not null,
    last_played_hole_id int (6) unsigned not null,
    last_played_user_id int (6) unsigned not null,
    last_played_timestamp timestamp,
    bonus_moves_player_1 int (6) unsigned not null,
    bonus_moves_player_2 int (6) unsigned not null,

    primary key(id),

    foreign key (game_config_id)
        references game_config(id)
            on delete cascade,

    foreign key (user_id_player_1)
        references users(id)
            on delete cascade,

    foreign key (user_id_player_2)
        references users(id)
            on delete cascade, 

    foreign key (last_played_user_id)
        references users(id)
            on delete cascade,       
    
    foreign key (last_played_hole_id)
        references hole(id)
            on delete cascade
);

-- make game_state table
create table game_state_relation
(
    game_id int (6) unsigned not null,
    hole_id int (6) unsigned not null,
    gem_count int (6) unsigned not null,

    foreign key (game_id)
        references game(id)
            on delete cascade,

    foreign key (hole_id)
        references hole(id)
            on delete cascade 
);

-- commit transaction
commit;