library(shiny)

# Data for the select input boxes
    country<-c("","Spain","Germany","Brazil","Portugal","Argentina","Switzerland","Uruguay","Colombia","Italy","England","Belgium","Greece","USA","Chile","Netherlands","France","Croatia","Russia","Mexico","Bosnia and Herzegovina","Algeria","Ivory Coast","Ecuador","Costa Rica","Honduras","Ghana","Iran","Nigeria","Japan","Cameroon","Korea Republic","Australia")
	
	shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("World cup 2014 game prediction"),
 
 
    sidebarPanel(
	p("This application allows you to compare any two teams of the 32 countries participating in the 2014 world cup
	 It will show their current FIFA points and also estimate the probable outcome of a game between them, based
	 on the difference in points that separate them."),
	 p("Select the countries you wish to compare on the boxes below by clicking on the arrow and scrolling until the desired
	 country is highlighted, click the mouse or press enter to select. Once the two countries are selected click on 
	 the Submit button and you will see the results on the right. The process can be repeated as many times as required."),

	  selectInput('home', 'Country 1:',country),
	  selectInput('away', 'Country 2:',country),
      submitButton('Submit')
    ),
    mainPanel(
        h4('You entered:'),
        verbatimTextOutput("inputValue"),
        h5('At the start of the world cup 2014, these countries had the following points in FIFA ranking:'),
        verbatimTextOutput("fifaPoints"),
		h5('Which according to our prediction model yields the following probabilities:'),
        verbatimTextOutput("prediction")

    )
  )
)
