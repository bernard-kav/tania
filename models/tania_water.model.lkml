connection: "biquery_publicdata_standard_sql"

include: "/views/*.view.lkml"

#  This is a caching policy
datagroup: tania_water_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: tania_water_default_datagroup


# This is how we set a query page/explore for our table
explore: users {
  join: products {
    type: left_outer
    relationship: one_to_many
    sql_on: ${users.id} = ${products.id} ;;
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.id} = ${inventory_items.product_id} ;;
  }
}
