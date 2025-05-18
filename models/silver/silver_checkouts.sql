with final as (
    select
        -- Salesを見ると2193年のデータ
        DATE(2193, checkout_month, 1) as checkout_month,
        * except(checkout_month)

    from {{ source('bronze', 'Checkouts') }}
)

select * from final