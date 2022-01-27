header <- dashboardHeader(title = "Women In Workplace",
                          dropdownMenu(type = "tasks", badgeStatus = "success",
                                       taskItem(value = 90, color = "green",
                                                "Documentation"
                                       ),
                                       taskItem(value = 17, color = "aqua",
                                                "Project X"
                                       ),
                                       taskItem(value = 75, color = "yellow",
                                                "Server deployment"
                                       ),
                                       taskItem(value = 80, color = "red",
                                                "Overall project"
                                       )
                          ),
                          dropdownMenu(type = "notifications",
                                       notificationItem(
                                         text = "5 new users today",
                                         icon("users")
                                       ),
                                       notificationItem(
                                         text = "12 items delivered",
                                         icon("truck"),
                                         status = "success"
                                       ),
                                       notificationItem(
                                         text = "Server load at 86%",
                                         icon = icon("exclamation-triangle"),
                                         status = "warning"
                                       )
                          )
                          )
  
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Dashboard", 
             icon = icon("dashboard"),
             tabName="dashboard"),
    menuItem("Distribution Earning", 
             icon = icon("chart-area"),
             tabName="dist"),
    menuItem(text = "Data", 
             icon = icon("table"),
             tabName = "data")
  )
)
  
body <- dashboardBody(
  tabItems(
    tabItem(tabName = "dashboard",
            fluidRow(
              box(width = 3, 
                  title = "Choose Year",
                  status = "danger", 
                  solidHeader = TRUE,
                  selectInput(inputId = "year_data",
                              label = "Choose year:",
                              choices = levels(workers_clean$year))),
              column(width = 9,
                plotlyOutput(
                  outputId = "plot1"
                )
              )
            ),
            br(),
            fluidRow(
              column(width = 12),
              plotlyOutput(
                outputId = "plot2"
              )
            )
            ),
    tabItem(tabName = "dist",
            fluidRow(
              box(width = 3,
                  title = "Choose Year",
                  status = "primary", 
                  solidHeader = TRUE,
                  radioButtons(
                    inputId = "year_btn",
                    label = "Choose year: ",
                    choices = levels(workers_clean$year))),
              column(width = 9,
                     plotlyOutput(
                       outputId = "plot3"
                     ))
            )),
    tabItem(
      tabName = "data",
      fluidRow(
        column(width = 12,
               h2("Women in Workplace"),
               dataTableOutput("table"))
      )
    )
  )
)

dashboardPage(
  header = header, 
  sidebar = sidebar,
  body = body,
  skin = "purple"
)