shinyServer(
    function(input, output) {

        output$plot_trend <- renderPlotly({
            data_vis1 <- join_1 %>%
                filter(customer_state == input$state) %>%
                group_by(month_sales, year_sales) %>%
                summarise(Total_Order = sum(price), .groups = "drop") %>%
                arrange(year_sales)

            data_vis1 <- data_vis1 %>% replace(is.na(.), 0)

            plot <- data_vis1 %>%
                ggplot(aes(x = month_sales,
                           y = Total_Order,
                           color = year_sales,
                           group = year_sales,
                           text = glue("Year : {year_sales}
                          Month : {month_sales}
                           Total Sales : {number(Total_Order, big.mark = ',')}")
                )) +
                geom_line() +
                geom_point() +
                labs(title = "Trend Total Sales by State of Brazil",
                     x = "Month",
                     y = "Total Sales",
                     color = "Period") +
                scale_y_continuous(labels = dollar_format(prefix = "R$")) + theme_algo

            ggplotly(plot, tooltip = "text")
        })

        output$plot_trend_2 <- renderPlotly({
            data_vis2 <- join_1 %>%
                filter(customer_state == input$state) %>%
                group_by(month_sales, year_sales) %>%
                summarise(Total_Freight = sum(freight_value), .groups = "drop") %>%
                arrange(year_sales)

            data_vis2 <- data_vis2 %>% replace(is.na(.), 0)

            plot <- data_vis2 %>%
                ggplot(aes(x = month_sales,
                           y = Total_Freight,
                           color = year_sales,
                           group = year_sales,
                           text = glue("Year : {year_sales}
                          Month : {month_sales}
                           Total Freight : {number(Total_Freight, big.mark = ',')}")
                )) +
                geom_line() +
                geom_point() +
                labs(title = "Trend Total Freight by State of Brazil",
                     x = "Month",
                     y = "Total Freight",
                     color = "Period") + theme_algo

            ggplotly(plot, tooltip = "text")
        })

        output$plot_trend_3 <- renderPlotly({
            data_vis3 <- join_1 %>%
                filter(customer_state == input$state) %>%
                group_by(month_sales, year_sales) %>%
                summarise(Total_Transaction = n(), .groups = "drop") %>%
                arrange(year_sales)

            data_vis3 <- data_vis3 %>% replace(is.na(.), 0)

            plot <- data_vis3 %>%
                ggplot(aes(x = month_sales,
                           y = Total_Transaction,
                           color = year_sales,
                           group = year_sales,
                           text = glue("Year : {year_sales}
                          Month : {month_sales}
                           Total Transaction : {number(Total_Transaction, big.mark = ',')}")
                )) +
                geom_line() +
                geom_point() +
                labs(title = "Trend Total Transaction by State of Brazil",
                     x = "Month",
                     y = "Total Transaction",
                     color = "Period") + theme_algo

            ggplotly(plot, tooltip = "text")
        })

        output$plot_stat_1 <- renderPlotly({
            data_vis4 <- join_1 %>%
                filter(year_sales == input$year) %>%
                group_by(seller_id, seller_city, seller_state) %>%
                summarise(Total_Sales = sum(price), .groups = "drop") %>%
                arrange(-Total_Sales) %>%
                top_n(15)

            plot <- data_vis4 %>%
                ggplot(aes(x = Total_Sales,
                           y = reorder(seller_id, Total_Sales),
                           fill = Total_Sales,
                           text = glue("State : {seller_state}
                                    City : {seller_city}
                                    Sales : {number(Total_Sales, big.mark = ',')}")
                )) +
                geom_col() +
                theme_test() +
                labs(x = "Sales Performance in R$",
                     y = "ID Seller",
                     title = "Top 15 Best Seller based on Sales Performance"
                ) +
                scale_fill_gradient(low = "red", high = "blue") +
                scale_x_continuous(labels = number_format(big.mark = ",")) +
                theme(legend.position = "none")

            ggplotly(plot, tooltip = "text")
        })

        output$plot_stat_2 <- renderPlotly({
            data_vis5 <- join_1 %>%
                filter(year_sales == input$year) %>%
                group_by(customer_id, customer_city, customer_state) %>%
                summarise(Total_Spending = sum(price), .groups = "drop") %>%
                arrange(-Total_Spending) %>%
                top_n(15)

            plot <- data_vis5 %>%
                ggplot(aes(x = Total_Spending,
                           y = reorder(customer_id, Total_Spending),
                           fill = Total_Spending,
                           text = glue("State : {customer_state}
                                    City : {customer_city}
                                    Spending : {number(Total_Spending, big.mark = ',')}")
                )) +
                geom_col() +
                theme_test() +
                labs(x = "The amount of money spent in R$",
                     y = "ID Customer",
                     title = "Top 15 Loyal Customer based on Money spent"
                ) +
                scale_fill_gradient(low = "red", high = "blue") +
                scale_x_continuous(labels = number_format(big.mark = ",")) +
                theme(legend.position = "none")

            ggplotly(plot, tooltip = "text")
        })

        output$plot_stat_3 <- renderPlotly({
            data_vis6 <- join_1 %>%
                filter(year_sales == input$year) %>%
                group_by(product_category_name_english) %>%
                summarise(amount_of_item = n(),
                          amount_of_sales = sum(price)) %>%
                arrange(-amount_of_item) %>%
                top_n(15)

            plot <- data_vis6 %>%
                ggplot(aes(x = amount_of_item,
                           y = reorder(product_category_name_english, amount_of_item),
                           fill = amount_of_item,
                           text = glue("Product Type : {product_category_name_english}
                                    Total Product : {number(amount_of_item, big.mark = ',')}
                                    Total Sales : {number(amount_of_sales, big.mark = ',')}")
                )) +
                geom_col() +
                theme_test() +
                labs(x = "The Number of Products Sold",
                     y = "Product Category",
                     title = "Top 15 Product Category"
                ) +
                scale_fill_gradient(low = "red", high = "blue") +
                scale_x_continuous(labels = number_format(big.mark = ",")) +
                theme(legend.position = "none")

            ggplotly(plot, tooltip = "text")
        })

        output$plot_stat_4 <- renderPlotly({
            data_vis7 <- join_1 %>%
                filter(year_sales == input$year) %>%
                group_by(geolocation_city) %>%
                summarise(total_transaction = n(),
                          amount_of_sales = sum(price)) %>%
                arrange(-total_transaction) %>%
                top_n(15)

            plot <- data_vis7 %>%
                ggplot(aes(x = total_transaction,
                           y = reorder(geolocation_city, total_transaction),
                           fill = total_transaction,
                           text = glue("City : {geolocation_city}
                                    Total Sales : {number(amount_of_sales, big.mark = ',')}
                                    Total Transaction : {number(total_transaction, big.mark = ',')}")
                )) +
                geom_col() +
                theme_test() +
                labs(x = "The Number of Transaction",
                     y = "City of Brazil",
                     title = "Top 15 Product Category"
                ) +
                scale_fill_gradient(low = "red", high = "blue") +
                scale_x_continuous(labels = number_format(big.mark = ",")) +
                theme(legend.position = "none")

            ggplotly(plot, tooltip = "text")
        })

        output$dat <- DT::renderDataTable({

            DT::datatable(join_1,
                          options = list(scrollX = T))
        })

        output$download <- downloadHandler(
            filename = function() {paste("dataset",".csv", sep="")},
            content = function(file) {
                write.csv(join_1, file, row.names = F)
            }
        )
    }
)
