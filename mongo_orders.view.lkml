view: mongo_orders {
  sql_table_name: looker.orders ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: _id {
    primary_key: yes
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: created_at {
    type: string
    sql: ${TABLE}.created_at ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: order_amount {
    type: number
    sql: ${TABLE}.order_amount ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  set: detail {
    fields: [
      _id,
      created_at,
      id,
      order_amount,
      status,
      user_id
    ]
  }
}
