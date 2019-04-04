explore: quote_generated_sql {}

view: quote_generated_sql {
  derived_table: {
    sql:
    SELECT quote_literal('This is a single quote')::text as single,
      '"This is a double quote"'::text as dub,
      'No quotes'::text as no_quotes;;
  }

  dimension: single {
    type: string
    sql: ${TABLE}.single ;;
  }

  dimension: double {
    type: string
    sql: ${TABLE}.dub ;;
  }

  dimension: no_quotes {
    type: string
    sql: ${TABLE}.no_quotes ;;
  }
  }
