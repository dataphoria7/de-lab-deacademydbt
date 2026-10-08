
{{
    config
    (
        materialized = 'incremental',
        incremental_strategy = 'append'
    )
}}


with sales_src as (
    SELECT 
        SALE_ID,
        SALE_DATE,
        CUSTOMER_ID,
        PRODUCT_ID,
        QUANTITY,
        TOTAL_AMOUNT,
        CREATED_AT,
        CURRENT_TIMESTAMP AS INSERT_DTS
        
    FROM {{source('sales_input','SALES_SRC')}}

    {% if is_incremental() %}
    where CREATED_AT > (select max(INSERT_DTS) from {{this}})
    {% endif %}
)

select * from sales_src

