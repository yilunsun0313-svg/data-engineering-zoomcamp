{% macro get_vendor_names(arg) -%}

case 
    when {{ arg }} = 1 then 'Creative Mobile Technologies'
    when {{ arg }} = 2 then 'VeriFone Inc.'
    when {{ arg }} = 3 then 'Unknown Vendor'
end

{%- endmacro %}