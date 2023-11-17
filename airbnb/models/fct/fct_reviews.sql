{{
  config(
    materialized = 'incremental'
    )
}}

with stg_reviews 
as (
    select {{ dbt_utils.generate_surrogate_key(['listing_id','review_date','reviewer_name','review_comment'])}} as review_id
          ,* 
    from {{ ref('stg_reviews') }}
)
select * 
from stg_reviews
where review_comment is not null
{% if is_incremental() %}
  and review_date > (select max(review_date) from {{ this }})
{% endif %}