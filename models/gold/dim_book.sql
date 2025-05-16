with average_ratings as (
    select
        book_id,
        avg(rating) as average_rating

    from {{ source('bronze', 'Ratings') }}
    group by book_id
),
cleaned_info as (
    select
        concat(book_id_1, book_id_2) as book_id,
        * except(book_id_1, book_id_2)

    from {{ source('bronze', 'Info') }}
),
final as (
    select
        book.book_id,
        book.title,
        info.genre,
        concat(author.first_name, ' ', author.last_name) as author_name,
        average_rating


    from {{ source('bronze', 'Book') }} as book

    left join {{ source('bronze', 'Author') }} as author
    using(auth_id)

    left join cleaned_info as info
    using(book_id)

    left join average_ratings
    using(book_id)
)

select * from final