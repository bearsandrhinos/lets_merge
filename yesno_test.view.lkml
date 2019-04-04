explore: yesno_test {
  hidden: yes
}
view: yesno_test {
  derived_table: {
    sql: select [0, 1] as bool
      WHERE {% condition ynfilter %} bool {% endcondition %};;

  }

  dimension: bool {
    type: yesno
    sql: ${TABLE}.bool = 0 ;;
  }

  filter: ynfilter {
    type: yesno
  }
}
