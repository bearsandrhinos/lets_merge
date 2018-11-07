view: order_items {
  sql_table_name: public.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      minute,
      hour_of_day,
      fiscal_year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: fy {
    type: string
    sql: 'FY' || ' ' || ltrim(${created_fiscal_year}, 'FY20') || '-' || (ltrim(${created_fiscal_year}, 'FY20') :: int +1) ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
    value_format_name: usd
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: traffic_source_2 {
    type: string
    sql: ${users.traffic_source} ;;
  }



  #dynamic parameter time period
  parameter: date_granularity {
    type: string
    default_value: "Week"
    allowed_value: { value: "Day" }
    allowed_value: { value: "Week" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Quarter" }
    allowed_value: { value: "Year" }
  }

  dimension: periods {
  description: "Use this field in combination with the Date Granularity field for dynamic date filtering"
  suggestions: ["Current Period","Previous period", "Last Year Period"]
  type: string
#   sql: case when ${delivered_date} <= date({% date_start period_start_date %}) AND ${delivered_date} > dateadd({% parameter date_granularity %}, -1, date({% date_start period_start_date %})) then 'Current Period'
#             when ${delivered_date} <= dateadd({% parameter date_granularity %}, -1, date({% date_start period_start_date %})) AND ${delivered_date} > dateadd({% parameter date_granularity %}, -2, date({% date_start period_start_date %})) then 'Previous Period'
#             when ${delivered_date} <= dateadd(year,-1, date({% date_start period_start_date %})) and ${delivered_date} > dateadd(year,-1, dateadd({% parameter date_granularity %}, -1, date({% date_start period_start_date %}))) then 'Last Year Period'
#             else 'Other Period' end ;;

  sql: case when ${delivered_date} <= current_date AND ${delivered_date} > dateadd({% parameter date_granularity %}, -1, current_date) then 'Current Period'
  when ${delivered_date} <= dateadd({% parameter date_granularity %}, -1, current_date) AND ${delivered_date} > dateadd({% parameter date_granularity %}, -2, current_date) then 'Previous Period'
  when ${delivered_date} <= dateadd(year,-1, current_date) and ${delivered_date} > dateadd(year,-1, dateadd({% parameter date_granularity %}, -1, current_date)) then 'Last Year Period'
  end ;;

}


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_sale_price {
    hidden: yes
    type: sum
    sql: ${sale_price} ;;
    drill_fields: [id, sale_price,created_date]
  }

  measure: avg_sale_price {
    type: average
    sql: ${sale_price} ;;
  }

  measure: profit {
    type: number
    sql: ${total_sale_price} - ${inventory_items.total_cost} ;;
  }

  measure: percent_prof {
    type: percent_of_total
    sql: ${profit} ;;
    drill_fields: [id, sale_price,created_date]
  }

  measure: percentile_normal {
    type: percentile
    percentile: 75
    sql: ${sale_price} ;;
  }

  parameter: percentile_value {
    type: number
  }

  measure: Percentile_parameter {
    type: number
    sql: PERCENTILE_CONT({% parameter percentile_value %}) WITHIN GROUP (ORDER BY ${sale_price} ) ;;
  }



  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.id,
      users.first_name,
      users.last_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}