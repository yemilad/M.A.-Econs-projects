clear all
set more off
global id id 
global t t
global ylist STD.FDI

global xlist lnpop tradeopeness inflation gdpgrowth gov
describe $id $t $STD.FDI $xlist lnpop tradeopeness inflation gdpgrowth gov
summarize $id $t $ylist $xlist

*set data as panel
sort id year
xtset id year
xtdescribe
xtsum logfdi lnpop tradeopeness inflation gdpgrowth gov logfdigov
xtreg logfdi lnpop tradeopeness inflation gdpgrowth gov logfdigov,pa
xtregar logfdi lnpop tradeopeness inflation gdpgrowth gov logfdigov,fe
tabulate unit, summarize gov
**************************************************************************
xtsum logfdi lnpop tradeopeness inflation gdpgrowth gov


*pooled ols estimator
reg ylist xlist


*population-averaged estimator
xtreg $ylist $xlist,pa

*Between estimator
xtreg $ylist $xlist,be

*Fixed effect or within etimator
xtreg $ylist $xlist,fe

*First-differences estimator
reg D. ($ylist $xlist),nonconstant

*random effects esimator
xtreg $ylist $xlist, re theta

*Hausmann test for fixed vs random
quietly xtreg $ylist $xlist, fe
estimates store fixed
quietly xtreg $ylist $xlist, re
estimates store fixed
hausman fixed random

*Breusch-pagan LM test for random effects vs OLS
quietly xtreg $ylist $xlist, re
xttest0
//**************************************************************

xtset id year
