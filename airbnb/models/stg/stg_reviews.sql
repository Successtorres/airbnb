WITH source AS (
        SELECT *

        FROM {{ source('airbnb', 'reviews') }}
)

SELECT
        LISTING_ID,
        DATE as review_date,
        REVIEWER_NAME,
        COMMENTS as review_comment,
        SENTIMENT as review_sentiment

FROM source


