/*Econ 4848 Do-File for Final P_roject  Shubha Swamy*/

clear /*Removes any existing data from memory*/
set more off /*Tells stata to continue working through the rest of the program 
even if the results are larger than the display screen*/

cd g: /*Replace the word workspace with the path to your workspace, e.g. f: or 
d:\users\myfolder or h:\myfolder*/

capture log close /*Closes any previously running log files*/
log using FinalProjectLog_Swamy.txt, replace text /*Changes logname to the desired file 
name which will be a text file.  Writes over any existing file with 
the same name*/

use FinalProjectData-Clean.dta

/*---------------------------------------------------------------------------*/
*DESCRIBE THE DATA


browse 
desc
sum 

tab educ 
tab city, sum(valueh)

/*---------------------------------------------------------------------------*/
*DESCIPTIVE STATISTICS AND GRAPHS
*overall descriptive stats for numerical vars 
tabstat hhincome valueh collegedeg, statistics(count mean p25 median p75 min max sd)

*descriptive stats for housing prices in U.S.
sum valueh, detail 

*education summary stats 
tab educ 

*summarize housing prices by college degree (associates or above) or no college degree
bysort collegedeg: sum valueh


*histogram for housing prices 
histogram valueh, bin(7) title(Frequency of Housing Prices in the U.S.)

*bar graph house value by education category
graph hbar valueh, over(educ) title("Average House Value by Education Level")

*boxplot for housing prices by has college degree or not 
gr box valueh, over(collegedeg)


/*---------------------------------------------------------------------------*/
*THE FOLLOWING REGRESSIONS WERE INITIALLY USED TO UNDERSTAND WHICH REGRESSIONS 
*WERE SIGNIFICANT, FINAL REGRESSIONS USED IN THE PAPER ARE IN THE BELOW SECTION.
/*
*effect of having a college degree on housing prices 
reg lvalueh collegedeg, robust 

*one additional year of education results in 2.7% inc in housing costs holding income constant 
reg lvalueh educ lhhincome, robust 

*relationsip between incolme and house value 
reg lvalueh lhhincome, robust

* ttest for house value for those who have college deg vs dont 
ttest lvalueh, by(collegedeg) unequal

*without holding income constant 
reg lvalueh hsgrad collegedrop assocdeg bachdeg advdeg, robust 
*categorical variable regression 
reg lvalueh hsgrad collegedrop assocdeg bachdeg advdeg lhhincome, robust

test hsgrad = collegedrop 
test hsgrad = assocdeg 
test collegedrop = assocdeg 

*joint hypothesis 
test hsgrad collegedrop assocdeg bachdeg advdeg 

*interaction model 
reg lvalueh collegedeg lhhincome collegedeg_income, robust 
*/
/*---------------------------------------------------------------------------*/

*REGRESSION

*effect of having a college degree on housing prices 
reg lvalueh collegedeg, robust 

*one additional year of education results in 2.7% inc in housing costs holding income constant 
reg lvalueh educ lhhincome, robust 

*relationsip between incolme and house value 
reg lvalueh lhhincome, robust

*categorical variable regression 
reg lvalueh hsgrad collegedrop assocdeg bachdeg advdeg lhhincome, robust

*joint hypothesis 
test hsgrad collegedrop assocdeg bachdeg advdeg 

*interaction model 
reg lvalueh collegedeg lhhincome collegedeg_income, robust 


/*---------------------------------------------------------------------------*/

*JOINT HYPOTHESIS TEST
reg lvalueh hsgrad collegedrop assocdeg bachdeg advdeg lhhincome, robust
test hsgrad collegedrop assocdeg bachdeg advdeg 

/*---------------------------------------------------------------------------*/
