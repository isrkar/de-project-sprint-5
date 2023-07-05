drop table if exists dds.dm_users;
create table dds.dm_users
(
    id         serial
        primary key,
    user_id    varchar not null constraint dm_users_object_id_uindex unique,
    user_name  varchar not null,
    user_login varchar not null
);

drop table if exists dds.dm_restaurants;
create table dds.dm_restaurants
(
    id              serial
        primary key,
    restaurant_id   varchar   not null,
    restaurant_name varchar   not null,
    active_from     timestamp not null,
    active_to       timestamp not null
);

drop table if exists dds.dm_products;
create table dds.dm_products
(
    id            serial
        primary key,
    restaurant_id integer                  not null
        references dds.dm_restaurants,
    product_id    varchar                  not null,
    product_name  varchar                  not null,
    product_price numeric(14, 2) default 0 not null
        constraint dm_products_price_check
            check (product_price >= (0)::numeric),
    active_from   timestamp                not null,
    active_to     timestamp                not null
);

drop table if exists dds.dm_timestamps;
create table dds.dm_timestamps
(
    id    serial
        primary key,
    ts    timestamp not null,
    year  smallint  not null
        constraint dm_timestamps_year_check
            check ((year >= 2022) AND (year < 2500)),
    month smallint  not null
        constraint dm_timestamps_month_check
            check ((month >= 1) AND (month <= 12)),
    day   smallint  not null
        constraint dm_timestamps_day_check
            check ((day >= 1) AND (day <= 31)),
    time  time      not null,
    date  date      not null
);

drop table if exists dds.srv_wf_settings;
create table dds.srv_wf_settings
(
    id                integer generated always as identity
        primary key,
    workflow_key      varchar not null
        unique,
    workflow_settings json    not null
);

drop table if exists dds.dm_couriers;
create table dds.dm_couriers
(
    id           serial
        primary key,
    courier_id   varchar not null,
    courier_name varchar not null
);

drop table if exists dds.dm_orders;
create table dds.dm_orders
(
    id            serial
        primary key,
    user_id       integer not null
        references dds.dm_users,
    restaurant_id integer not null
        references dds.dm_restaurants,
    timestamp_id  integer not null
        references dds.dm_timestamps,
    order_key     varchar not null
        unique,
    order_status  varchar not null,
    courier_id    integer
        references dds.dm_couriers
            on update cascade
);

drop table if exists dds.fct_product_sales;
create table dds.fct_product_sales
(
    id            serial
        primary key,
    product_id    integer                  not null
        references dds.dm_products,
    order_id      integer                  not null
        references dds.dm_orders,
    count         integer        default 0 not null
        constraint fct_product_sales_count_check
            check (count >= 0),
    price         numeric(14, 2) default 0 not null
        constraint fct_product_sales_price_check
            check (price >= (0)::numeric),
    total_sum     numeric(14, 2) default 0 not null
        constraint fct_product_sales_total_sum_check
            check (total_sum >= (0)::numeric),
    bonus_payment numeric(14, 2) default 0 not null
        constraint fct_product_sales_bonus_payment_check
            check (bonus_payment >= (0)::numeric),
    bonus_grant   numeric(14, 2) default 0 not null
        constraint fct_product_sales_bonus_grant_check
            check (bonus_grant >= (0)::numeric)
);

drop table if exists dds.dm_deliveries;
create table dds.dm_deliveries
(
    id           serial
        primary key,
    delivery_key varchar not null,
    order_id     integer not null
        references dds.dm_orders,
    courier_id   integer not null
        references dds.dm_couriers
);

drop table if exists dds.fct_deliveries;
create table dds.fct_deliveries
(
    id          serial
        primary key,
    delivery_id integer not null
        references dds.dm_deliveries,
    rate        integer        default 0
        constraint fct_deliveries_rate_check
            check ((rate >= 1) AND (rate <= 5)),
    sum         numeric(14, 2) default 0
        constraint fct_deliveries_sum_check
            check (sum >= (0)::numeric),
    tip_sum     numeric(14, 2) default 0
        constraint fct_deliveries_tip_sum_check
            check (tip_sum >= (0)::numeric)
);

