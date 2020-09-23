header <- dashboardHeader(title = "Monitoring")

sidebar <- dashboardSidebar(
    sidebarMenu(menuItem(text = "Trend Sales",
                         tabName = "Trend",
                         icon = icon("dashboard"),
                         badgeLabel = "annually",
                         badgeColor = "red"),
                menuItem(text = "Statistical",
                         tabName = "statistic",
                         icon = icon("th")),
                menuItem(text = "Data",
                         tabName = "data",
                         icon = icon("database"))

    )
)

body <- dashboardBody(
    tabItems(
        tabItem(tabName = "Trend", align = "center",
                h1("Trend Sales Anually"),

                selectInput(inputId = "state",
                            label = "Choose State",
                            selected = "AC",
                            choices = unique(join_1$customer_state),
                            multiple = F
                            ),

                fluidRow(
                    box(width = 6,
                        background = "maroon",
                        solidHeader = TRUE,
                        collapsible = TRUE,
                        plotlyOutput("plot_trend", height = "500")),
                    box(width = 6,
                        background = "maroon",
                        solidHeader = TRUE,
                        collapsible = TRUE,
                        plotlyOutput("plot_trend_2", height = "500"))
                ),
                fluidRow(
                    box(width = 12,
                        background = "maroon",
                        solidHeader = TRUE,
                        collapsible = TRUE,
                        plotlyOutput("plot_trend_3", height = "500"))
                )
        ),

        tabItem(tabName = "statistic", align = "center",
                h1("Top 15 Statistical"),

                selectInput(inputId = "year",
                            label = "Choose Year",
                            choices = unique(join_1$year_sales)
                            ),
                fluidRow(
                    box(width = 6,
                        background = "maroon",
                        solidHeader = TRUE,
                        collapsible = TRUE,
                        plotlyOutput("plot_stat_1")),
                    box(width = 6,
                        background = "maroon",
                        solidHeader = TRUE,
                        collapsible = TRUE,
                        plotlyOutput("plot_stat_2"))
                ),
                fluidRow(
                    box(width = 6,
                        background = "maroon",
                        solidHeader = TRUE,
                        collapsible = TRUE,
                        plotlyOutput("plot_stat_3")),
                    box(width = 6,
                        background = "maroon",
                        solidHeader = TRUE,
                        collapsible = TRUE,
                        plotlyOutput("plot_stat_4"))
                )
        ),

        tabItem(tabName = "data",
                DT::dataTableOutput("dat"),
                br(),
                downloadButton(outputId = "download", label = "Download Data Here!")
        )
    )
)

dashboardPage(
    title = "My Dashboard",
    skin = "red",
    header = header,
    body = body,
    sidebar = sidebar
)
