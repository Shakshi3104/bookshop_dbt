with final as (
    select
        sales_checkouts.*,
        dim_book.* except(book_id)

    from {{ ref('fact_monthly_sales_and_checkouts') }} as sales_checkouts
    left join {{ ref('dim_book') }} as dim_book
    using(book_id)
)

select * from final