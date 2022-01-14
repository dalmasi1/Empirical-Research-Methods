STATA=stata -b do

Data/nlys/nlys_merged.dta: Do/4-nlsy_cleaning.do
	$(STATA) Do/4-nlys_cleaing.do
	echo: "Executing the cleaning of the NLSY data in Stata batch mode."
Results/Tables: Data/nlys/nlsy_cleaning.dta Do/4-nlsy_cleaning.do
	$(STATA) Do/5-nlsy_analysis.do
	echo: "Executing the analysis of the NLSY data in Stata batch mode."