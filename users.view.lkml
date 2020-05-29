view: users {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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
      year
    ]
    sql: cast(${TABLE}.created_at as timestamp) ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: distinct_name {
    type: string
    sql: distinct ${first_name} ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.state ;;
  }

  dimension: case_when {
    case: {
      when: {
        sql: ${state} = "Alaska" ;;
        label: "AK"
      }
    }
    case: {
      when: {
        sql: ${state} = "Oregon" ;;
        label: "OR"
      }
    }
    sql: ${state} ;;
    type: string
  }

  dimension: case_when_sql {
    type: string
    sql: case when ${state} = "Alaska" then "AK"
            when ${state} = "Oregon" then "OR"
            else ${state} end;;
    suggest_dimension: state
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: traffic_source_with_minus {
    type: string
    sql: CONCAT('-', ${traffic_source}) ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, events.count, order_items.count]
  }

  measure: avg_age {
    type: average
    sql: ${age} ;;
  }

  measure: test_stuff {
    type: number
    sql: ${count}-${avg_age} ;;
  }

  measure: percent_age {
    type: percent_of_total
    sql: ${count} ;;
  }

  measure: min_date {
    type: date_time
    sql:  min(${created_raw} ;;
    convert_tz: no
  }
}
