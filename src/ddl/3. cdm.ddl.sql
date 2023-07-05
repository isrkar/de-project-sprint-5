drop table if exists cdm.dm_settlement_report;
create table cdm.dm_settlement_report
(
    id                       integer generated always as identity
        primary key,
    restaurant_id            varchar                  not null,
    restaurant_name          varchar                  not null,
    settlement_date          date                     not null
        constraint dm_settlement_report_settlement_date_check
            check ((settlement_date > '2022-01-01'::date) AND (settlement_date < '2050-01-01'::date)),
    orders_count             integer                  not null
        constraint dm_settlement_report_orders_count_check
            check (orders_count >= 0),
    orders_total_sum         numeric(14, 2) default 0 not null
        constraint dm_settlement_report_orders_total_sum_check
            check (orders_total_sum >= (0)::numeric),
    orders_bonus_payment_sum numeric(14, 2) default 0 not null
        constraint dm_settlement_report_orders_bonus_payment_sum_check
            check (orders_bonus_payment_sum >= (0)::numeric),
    orders_bonus_granted_sum numeric(14, 2) default 0 not null
        constraint dm_settlement_report_orders_bonus_granted_sum_check
            check (orders_bonus_granted_sum >= (0)::numeric),
    order_processing_fee     numeric(14, 2) default 0 not null
        constraint dm_settlement_report_order_processing_fee_check
            check (order_processing_fee >= (0)::numeric),
    restaurant_reward_sum    numeric(14, 2) default 0 not null
        constraint dm_settlement_report_restaurant_reward_sum_check
            check (restaurant_reward_sum >= (0)::numeric),
    unique (restaurant_id, settlement_date)
);

drop table if exists cdm.dm_courier_ledger;
create table cdm.dm_courier_ledger
(
    id                   serial
        primary key,
    courier_id           varchar  not null,
    courier_name         varchar  not null,
    settlement_year      smallint not null
        constraint dm_courier_ledger_settlement_year_check
            check ((settlement_year >= 2022) AND (settlement_year < 2099)),
    settlement_month     varchar  not null,
    orders_count         smallint       default 0
        constraint dm_courier_ledger_orders_count_check
            check (orders_count >= 0),
    orders_total_sum     numeric(14, 2) default 0
        constraint dm_courier_ledger_orders_total_sum_check
            check (orders_total_sum >= (0)::numeric),
    rate_avg             numeric(14, 2) default 0
        constraint dm_courier_ledger_rate_avg_check
            check (rate_avg >= (0)::numeric),
    order_processing_fee numeric(14, 2) default 0
        constraint dm_courier_ledger_order_processing_fee_check
            check (order_processing_fee >= (0)::numeric),
    courier_order_sum    numeric(14, 2) default 0
        constraint dm_courier_ledger_courier_order_sum_check
            check (courier_order_sum >= (0)::numeric),
    courier_tips_sum     numeric(14, 2) default 0
        constraint dm_courier_ledger_courier_tips_sum_check
            check (courier_tips_sum >= (0)::numeric),
    courier_reward_sum   numeric(14, 2) default 0
        constraint dm_courier_ledger_courier_reward_sum_check
            check (courier_reward_sum >= (0)::numeric),
    constraint dm_courier_ledger_courier_id_settlement_month_unq
        unique (courier_id, settlement_year, settlement_month)
);


