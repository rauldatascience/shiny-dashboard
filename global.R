#Library Requirements
library(shiny)
library(shinydashboard)
library(lubridate)
library(dplyr)
library(ggplot2)
library(glue)
library(scales)
library(plotly)
library(DT)

#Read Dataset
dataset_customers <- read.csv("olist_customers_dataset.csv")
dataset_geolocation <- read.csv("olist_geolocation_dataset.csv")
dataset_order_item <- read.csv("olist_order_items_dataset.csv")
dataset_order_payments <- read.csv("olist_order_payments_dataset.csv")
dataset_order_reviews <- read.csv("olist_order_reviews_dataset.csv")
dataset_orders <- read.csv("olist_orders_dataset.csv")
dataset_products <- read.csv("olist_products_dataset.csv")
dataset_seller <- read.csv("olist_sellers_dataset.csv")
dataset_products_category <- read.csv("product_category_name_translation.csv")

#Pre-processing each dataset
#dataset geolocation
dataset_customers <-  rename(.data = dataset_customers, geolocation_zip_code_prefix = customer_zip_code_prefix)
dataset_geolocation <-  dataset_geolocation %>% distinct(geolocation_zip_code_prefix, .keep_all = TRUE)

#Combining Dataset
join_1 <-  dataset_customers %>% left_join(dataset_orders, by = "customer_id")
join_1 <-  join_1 %>% left_join(dataset_order_item, by = "order_id")
join_1 <- join_1 %>% left_join(dataset_geolocation, by = "geolocation_zip_code_prefix")
join_1 <- join_1 %>% left_join(dataset_products, by = "product_id")
join_1 <- join_1 %>% left_join(dataset_products_category, by = "product_category_name")
join_1 <- join_1 %>% left_join(dataset_seller, by = "seller_id")

#Feature Engineering
join_1 <- join_1 %>%
  mutate(time_sales = ymd_hms(order_purchase_timestamp))

join_1 <- join_1 %>%
  mutate(month_sales = month(join_1$time_sales, label = TRUE),
         year_sales = as.factor(year(join_1$time_sales)))

lineplot_dataset <- join_1 %>%
  filter(customer_state == "AC") %>%
  group_by(month_sales, year_sales) %>%
  summarise(Total_Order = sum(price)) %>%
  arrange(year_sales)

lineplot_dataset <- lineplot_dataset %>% replace(is.na(.), 0)

plot2_1 <-  join_1 %>%
  filter(year_sales == 2017) %>%
  group_by(seller_id, seller_city, seller_state) %>%
  summarise(Total_Sales = sum(price), .groups = "drop") %>%
  arrange(-Total_Sales) %>%
  top_n(15)


#Theme PLot
theme_algo <- theme(
  panel.background = element_rect(fill = "white"),
  panel.grid.major.y = element_line(colour = "grey80"),
  panel.grid.minor = element_blank(),
  plot.title = element_text(family = "serif", size = 18))

#inputs
selectState <- unique(join_1$customer_state)
