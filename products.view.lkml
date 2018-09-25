view: products {
  sql_table_name: public.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.distribution_center_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  dimension: wrapper {
    type:  string
    sql: quote_literal("I am going to write this and hopefully it is long enough and it will wrap and then I will add the HTML") ;;
#     html: <td nowrap> <p align="right"> {{rendered_value}} </p></td> ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, distribution_centers.id, distribution_centers.name, inventory_items.count]
  }

  measure: total_retail {
    type: sum
    sql: ${retail_price} ;;
  }

  measure: total_markup {
    type: number
    sql: ${order_items.total_sale_price} - ${total_retail} ;;
  }
}
