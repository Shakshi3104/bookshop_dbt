with cleaned_sales as (
    select
        -- Awardを見ると2100年代なので、200年足す
        date_add(parse_date('%x', sales_date), interval 200 year) as sales_date,
        * except(sales_date)

    from {{ source('bronze', 'Sales') }}
),
final as (
    select
        book_id,
        price,
        cleaned_sales.*

    from cleaned_sales
    left join {{ source('bronze', 'Edition') }}
    using(isbn)
)

select * from final