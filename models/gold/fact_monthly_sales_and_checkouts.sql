with monthly_sales as (
    select
        book_id,
        date_trunc(sales_date, month) as sales_month,
        count(book_id) as amount

    from {{ ref('silver_sales') }}
    -- 月別で集計する
    group by book_id, date_trunc(sales_date, month)
),
final as (
    select
        monthly_sales.book_id,
        ifnull(sales_month, checkout_month) as year_month,
        monthly_sales.amount,
        checkouts.number_of_checkouts as checkouts

    from monthly_sales
    left join {{ ref('silver_checkouts') }} as checkouts
    on monthly_sales.book_id = checkouts.book_id
    and monthly_sales.sales_month = checkouts.checkout_month
)

select * from final