explore: dt_sme {}

view: dt_sme {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
            orders.id  AS order_id,
            orders.user_ids  AS user_ids,
            users.city  AS city,
            COUNT(*) AS count_of_items
            FROM order_items  AS order_items
LEFT JOIN orders  AS orders ON order_items.order_id = orders.id
LEFT JOIN users  AS users ON orders.user_ids = users.id

GROUP BY 1,2,3
ORDER BY COUNT(*) DESC
LIMIT 500
      ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: user_ids {
    type: number
    sql: ${TABLE}.user_ids ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: count_of_items {
    type: number
    sql: ${TABLE}.count_of_items ;;
  }

  measure: max_items {
    type: max
    sql: ${count_of_items} ;;
  }




}