view: mongo_oi {
  sql_table_name: looker.order_items ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: sku_num {
    type: number
    sql: ${TABLE}.sku_num ;;
  }

  set: detail {
    fields: [_id, amount, id, order_id, sku_num]
  }
}
