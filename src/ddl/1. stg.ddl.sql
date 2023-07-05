drop table if exists stg.bonussystem_users;
create table stg.bonussystem_users
(
    id            integer not null primary key,
    order_user_id text    not null
);

drop table if exists stg.bonussystem_ranks;
create table stg.bonussystem_ranks
(
    id                    integer                  not null primary key,
    name                  varchar(2048)            not null,
    bonus_percent         numeric(19, 5) default 0 not null
        constraint ranks_bonus_percent_check
            check (bonus_percent >= (0)::numeric)
        constraint ranks_bonus_percent_check1
            check (bonus_percent >= (0)::numeric),
    min_payment_threshold numeric(19, 5) default 0 not null
);

drop table if exists stg.bonussystem_events;
create table stg.bonussystem_events
(
    id          integer   not null primary key,
    event_ts    timestamp not null,
    event_type  varchar   not null,
    event_value text      not null
);

drop table if exists stg.ordersystem_users;
create table stg.ordersystem_users
(
    id           serial primary key,
    object_id    varchar(24) not null
        constraint ordersystem_users_object_id_uindex
            unique,
    object_value text        not null,
    update_ts    timestamp   not null
);

drop table if exists stg.ordersystem_orders;
create table stg.ordersystem_orders
(
    id           serial primary key,
    object_id    varchar(24) not null
        constraint ordersystem_orders_object_id_uindex
            unique,
    object_value text        not null,
    update_ts    timestamp   not null
);

drop table if exists stg.ordersystem_restaurants;
create table stg.ordersystem_restaurants
(
    id           serial primary key,
    object_id    varchar(24) not null
        constraint ordersystem_restaurants_object_id_uindex
            unique,
    object_value text        not null,
    update_ts    timestamp   not null
);

drop table if exists stg.srv_wf_settings;
create table stg.srv_wf_settings
(
    id                integer generated always as identity
        primary key,
    workflow_key      varchar not null
        unique,
    workflow_settings json    not null
);

drop table if exists stg.deliverysystem_couriers;
create table stg.deliverysystem_couriers
(
    id           serial primary key,
    created_at   timestamp default (now()::timestamp),
    courier_id   varchar not null,
    object_value text
);


drop table if exists stg.deliverysystem_deliveries;
create table stg.deliverysystem_deliveries
(
    id           serial primary key,
    created_at   timestamp default (now()::timestamp),
    delivery_id  varchar not null,
    object_value text
);