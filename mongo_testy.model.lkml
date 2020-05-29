connection: "mongobi_test"

include: "*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: mongo_oi {
  join: mongo_orders {
    relationship: many_to_one
    sql_on: ${mongo_oi.order_id} = ${mongo_orders.id} ;;
  }
}
