### Simulate some data

### 3 Factor Variables
FacVar1 = as.factor(rep(c("level1", "level2"), 25))
FacVar2 = as.factor(rep(c("levelA", "levelB", "levelC"), 17)[-51])
FacVar3 = as.factor(rep(c("levelI", "levelII", "levelIII", "levelIV"), 13)[-c(51:52)])

### 4 Numeric Vars
set.seed(123)
NumVar1 = round(rnorm(n = 50, mean = 1000, sd = 50), digits = 2)  ### Normal distribution
set.seed(123)
NumVar2 = round(runif(n = 50, min = 500, max = 1500), digits = 2)  ### Uniform distribution
set.seed(123)
NumVar3 = round(rexp(n = 50, rate = 0.001))  ### Exponential distribution
NumVar4 = 2001:2050

simData = data.frame(FacVar1, FacVar2, FacVar3, NumVar1, NumVar2, NumVar3, NumVar4)


library(rCharts)

data(tips, package = 'reshape2')

# compute boxplot statistics and cast it as a dataframe with no headers
bwstats = setNames(
        as.data.frame(boxplot(tip ~ sex, data = tips, plot = F)$stats),
        nm = NULL
)

# load rCharts and initialize
library(rCharts)
h1 <- Highcharts$new()

# pass data as a list of lists
h1$set(series = list(list(
        name = 'Observations',
        data = bwstats
)))

# set xaxis/yaxis titles and labels
h1$xAxis(
        categories = levels(tips$sex),
        title = list(text = 'Gender')
)
h1$yAxis(
        title = list(text = 'Tip')
)
h1$chart(type = 'boxplot')
h1


### dummy variable created
simData$tmpFac = "tmp"
bwstats = setNames(as.data.frame(boxplot(NumVar1 ~ tmpFac, data = simData, plot = F)$stats),
                   nm = NULL)
h2 = Highcharts$new()
h2$set(series = list(list(name = "NumVar1 Distribution", data = bwstats)))
h2$xAxis(categories = levels(simData$tmpFac), title = list(text = "Dummy Fac Var"))
h2$yAxis(title = list(text = "NumVar1"))
h2$chart(type = "boxplot")
# h2$publish('h2',host='gist') h2$save('h2.html',cdn=TRUE)
#
#
# bwstats = setNames(as.data.frame(boxplot(NumVar1 ~ FacVar1, data = simData,
plot = F)$stats), nm = NULL)
h3 = Highcharts$new()
h3$set(series = list(list(name = "NumVar1 Distribution", data = bwstats)))
h3$xAxis(categories = levels(simData$FacVar1), title = list(text = "FacVar1"))
h3$yAxis(title = list(text = "NumVar1"))
h3$chart(type = "boxplot")
# h3$publish('h3',host='gist') h3$save('h3.html',cdn=TRUE)


bwstats = setNames(as.data.frame(boxplot(NumVar1 ~ (FacVar1 * FacVar2), data = simData,
                                         plot = F)$stats), nm = NULL)
h5 = Highcharts$new()
h5$set(series = list(list(name = "NumVar1 Distribution", data = bwstats)))
h5$xAxis(categories = unique(interaction(simData$FacVar1, simData$FacVar2)),
         title = list(text = "Interaction of FacVar1 and FacVar2"))
h5$yAxis(title = list(text = "NumVar1"))
h5$chart(type = "boxplot")
h5
# h5$publish('h5',host='gist') h5$save('h5.html',cdn=TRUE)
