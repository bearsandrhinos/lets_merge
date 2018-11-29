explore: twilio_test {}
view: twilio_test {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
        'Peter'::text as name,
        '+19702314889'::text as telephone
      ;;
  }

dimension: name {
  type: string
  sql: ${TABLE}.name ;;
}

dimension: tele {
  tags: ["phone"]
  type: string
  sql: ${TABLE}.telephone ;;
}

}
