library(shiny)

# creates data frame with countries and corresponding FIFA points
country1<-c("","Spain","Germany","Brazil","Portugal","Argentina","Switzerland","Uruguay","Colombia","Italy","England","Belgium","Greece","USA","Chile","Netherlands","France","Croatia","Russia","Mexico","Bosnia and Herzegovina","Algeria","Ivory Coast","Ecuador","Costa Rica","Honduras","Ghana","Iran","Nigeria","Japan","Cameroon","Korea Republic","Australia")
points<-c(0,1485,1300,1242,1189,1175,1149,1147,1137,1104,1090,1074,1064,1035,1026,981,913,903,893,882,873,858,809,791,762,731,704,641,640,626,558,547,526)
df<-data.frame(country1,points)

# Function to return the FIFA points of the two selected teams
getPoints <- function(home,away){
	# check the validity of the input
	if(home==away & home!=""){return ("countries should be different, try again")}
	if(home==away & home==""){return ()}
	# get points and return them
	pointsh<-df[df$country1==home,]$points
	pointsa<-df[df$country1==away,]$points
	return (c(home,": ",pointsh,"  ",away,": ",pointsa))
}

# Function to apply the model
# it will always start for the higher ranked 
# will switch the teams if the higher ranked is country 2 (away team)

getPrediction<- function(home,away){
	# this is to avoid displaying when there are invalid inputs
	if(home==away & home!=""){return ()}
	if(home==away & home==""){return ()}
	#get the points
	pointsh<-df[df$country1==home,]$points
	pointsa<-df[df$country1==away,]$points
	
	#assign points to variables
	w<-pointsh
	l<-pointsa
	switched<-FALSE
	
	#if the away points are higher, switch the variables and flag it
	if(pointsh<pointsa){
		switched<-TRUE
		w<-pointsa
		l<-pointsh
	}
	
	# applies the model 
	# (skews the uniform probabilities to the higher ranked in proportion to the lower ranked)
	probwin <-as.integer(34+((67/50) * ((w/(w+l))*100 -50)))
	probdraw<-as.integer((100-probwin)* w/(w+l))
	problose<-as.integer(100-(probwin+probdraw))
	# assign the points to the display variables
	homewin<-probwin
	draw<-probdraw
	awaywin<-problose
	
	# if the points had been switched, switch their probabilities back
	if(switched==TRUE){
		homewin<-problose
		awaywin<-probwin
	}
	return(c(home,": ",homewin,"% ",away,": ",awaywin,"%   draw: ",draw,"%"))
}
# main server function
shinyServer(
  function(input, output) {
	output$inputValue <- renderText({c(input$home,' ',input$away)})
    output$fifaPoints <- renderText({getPoints(input$home,input$away)})
	output$prediction <- renderText({getPrediction(input$home,input$away)})
  }
)