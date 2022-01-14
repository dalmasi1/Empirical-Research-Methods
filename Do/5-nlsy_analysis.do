*Analysis part of the nlsy data.

**** Define macros ****

global topdir "C:\Users\David\Desktop\CEU\Courses_year2\Empirical_Research_Methods\Deming_2017_SocialSkills_Replication\Deming_2017_SocialSkills_Replication"
local dodir "${topdir}/Do"

local rawdir "${topdir}/Data/census-acs/raw"
local cleandir "${topdir}/Data/census-acs/clean"
local collapdir "${topdir}/Data/census-acs/collapsed" 
local occdir "${topdir}/Data/census-acs/xwalk_occ"
local inddir "${topdir}/Data/census-acs/xwalk_ind"

local onetdir "${topdir}/Data/onet"
local txtdir "${topdir}/Data/onet/text_files"
local dotdir "${topdir}/Data/dot"

local nlsydir "${topdir}/Data/nlsy"
local import79dir "${topdir}/Data/nlsy/import/nlsy79"
local import97dir "${topdir}/Data/nlsy/import/nlsy97"
local name79 "socskills_nlsy79_final"			/* Name of NLSY79 extract */
local name97 "socskills_nlsy97_final"			/* Name of NLSY97 extract */
local afqtadj "${topdir}/Data/nlsy/altonjietal2012"

local figdir "${topdir}/Results/figures"
local tabdir "${topdir}/Results/tables"

** Set working directory
cd "`tabdir'"


****************
****Analysis****
****************

set more off

****Table 1 - Labor Market Returns to Skills in the NLSY79****

local covs "female hisp_male hisp_female black_male black_female i.age i.year i.div i.metro i.urban"

xi: regress ln_wage soc_nlsy_std `covs' [w=weight] if complete79==1 & sample==0 ///
	& age>=23, vce(cluster pubid)
outregress2 using table1, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3) replace	

xi: regress ln_wage afqt_std soc_nlsy_std `covs' [w=weight] if complete79==1 ///
	& sample==0 & age>=23, vce(cluster pubid)
outregress2 using table1, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)

xi: regress ln_wage afqt_std soc_nlsy_std afqt_socnlsy `covs' [w=weight] ///
	if complete79==1 & sample==0 & age>=23, vce(cluster pubid)
outregress2 using table1, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)

xi: regress ln_wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std `covs' [w=weight] ///
	if complete79==1 & sample==0 & age>=23, vce(cluster pubid)
outregress2 using table1, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)

xi: regress ln_wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std i.educ `covs' ///
	[w=weight] if complete79==1 & sample==0 & age>=23, vce(cluster pubid)
outregress2 using table1, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)

xi: regress ln_wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std afqt_noncog `covs' ///
	[w=weight] if complete79==1 & sample==0 & age>=23, vce(cluster pubid)
outregress2 using table1, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)

xi: regress ln_wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std afqt_noncog i.educ ///
	`covs' [w=weight] if complete79==1 & sample==0 & age>=23, vce(cluster pubid)
outregress2 using table1, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)


****Table 2 - Occupational Sorting on Skills in the NLSY79****

local covs "female hisp_male hisp_female black_male black_female i.age i.year i.div i.metro i.urban"

xi: regress routine afqt_std soc_nlsy_std afqt_socnlsy i.educ `covs' i.ind6090 ///
	[w=weight] if complete79==1 & sample==0 & age>=23 & wage!=., vce(cluster pubid)
outregress2 using table2, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3) replace	
	
xi: regress routine afqt_std soc_nlsy_std afqt_socnlsy math number_facility reason info_use ///
	i.educ `covs' [w=weight] if complete79==1 & sample==0 & age>=23 & wage!=., vce(cluster pubid)
outregress2 using table2, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)

xi: regress socskills afqt_std soc_nlsy_std afqt_socnlsy i.educ `covs' i.ind6090 ///
	[w=weight] if complete79==1 & sample==0 & age>=23 & wage!=., vce(cluster pubid)
outregress2 using table2, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)
	
xi: regress socskills afqt_std soc_nlsy_std afqt_socnlsy math number_facility reason info_use ///
	i.educ `covs' [w=weight] if complete79==1 & sample==0 & age>=23 & wage!=., vce(cluster pubid)
outregress2 using table2, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)


****Table 3 - Returns to Skills by Occupation Task Intensity in the NLSY79****

xtset uniqueID
local covs "i.age i.year i.div i.metro i.urban"

xi: xtregress ln_wage routine afqt_routine socnlsy_routine afqt_socnlsy_routine ///
	`covs' [w=weight] if complete79==1 & age>=23 & sample==0, fe vce(cluster uniqueID)
outregress2 using table3, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(4) replace	

xi: xtregress ln_wage socskills afqt_socskills socnlsy_socskills afqt_socnlsy_socskills ///
	`covs' [w=weight] if complete79==1 & age>=23 & sample==0, fe vce(cluster uniqueID)
outregress2 using table3, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(4)

xi: xtregress ln_wage routine afqt_routine socnlsy_routine afqt_socnlsy_routine ///
	socskills afqt_socskills socnlsy_socskills afqt_socnlsy_socskills ///
	`covs' [w=weight] if complete79==1 & age>=23 & sample==0, fe vce(cluster uniqueID)
outregress2 using table3, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(4)


****Table 4 - Labor Market Returns to Skills in the NLSY79 vs. the NLSY97****

local covs "female hisp_male hisp_female black_male black_female i.age i.year i.div i.metro i.urban"

xi: regress emp afqt_std afqt_sample soc_nlsy2_std soc_nlsy2_sample afqt_socnlsy2 ///
	afqt_socnlsy2_sample sample `covs' if age>=25 & age<=33, ///
	vce(cluster pubid)
outregress2 using table4, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3) replace

xi: regress emp afqt_std afqt_sample soc_nlsy2_std soc_nlsy2_sample afqt_socnlsy2 ///
	afqt_socnlsy2_sample sample i.educ `covs' if age>=25 & age<=33, ///
	vce(cluster pubid)
outregress2 using table4, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)

xi: regress emp afqt_std afqt_sample soc_nlsy2_std soc_nlsy2_sample afqt_socnlsy2 ///
	afqt_socnlsy2_sample  noncog_std noncog_sample sample i.educ `covs' ///
	if age>=25 & age<=33, vce(cluster pubid)
outregress2 using table4, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)

xi: regress ln_wage afqt_std afqt_sample soc_nlsy2_std soc_nlsy2_sample afqt_socnlsy2 ///
	afqt_socnlsy2_sample sample `covs' if age>=25 & age<=33 & complete97==1, ///
	vce(cluster pubid)
outregress2 using table4, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)

xi: regress ln_wage afqt_std afqt_sample soc_nlsy2_std soc_nlsy2_sample afqt_socnlsy2 ///
	afqt_socnlsy2_sample sample i.educ `covs' if age>=25 & age<=33 & complete97==1, ///
	vce(cluster pubid)
outregress2 using table4, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)

xi: regress ln_wage afqt_std afqt_sample soc_nlsy2_std soc_nlsy2_sample afqt_socnlsy2 ///
	afqt_socnlsy2_sample sample i.educ `covs' noncog_std noncog_sample ///
	if age>=25 & age<=33 & complete97==1, vce(cluster pubid)
outregress2 using table4, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)


****Table 5 - Returns to Skills by Occupation Task Intensity in the NLSY79 vs. the NLSY97****

local covs "i.age i.year i.div i.metro i.urban"

* Col 1
xtregress ln_wage socskills socskills_sample `covs' ///
	if age>=25 & age<=33 & complete97==1, fe vce(cluster uniqueID)
outregress2 using table5, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(4) replace

* Col 2
xtregress ln_wage socskills socskills_sample math math_sample `covs' ///
	if age>=25 & age<=33 & complete97==1, fe vce(cluster uniqueID)
outregress2 using table5, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(4)

* Col 3
xtregress ln_wage socskills socskills_sample math math_sample afqt_socskills ///
	afqt_socskills_sample socnlsy2_socskills socnlsy2_socskills_sample	`covs' ///
	if age>=25 & age<=33 & complete97==1, fe vce(cluster uniqueID)
outregress2 using table5, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(4)

* Col 3 Coefficient Tests
file open table5tests using "`tabdir'/table5tests.txt", write replace

test (socnlsy2_socskills+socnlsy2_socskills_sample=0)
local pval: di r(p)
file write table5tests "Col 3, Test 1: `pval'" _n

test (socnlsy2_socskills+socnlsy2_socskills_sample=0) (afqt_socskills+afqt_socskills_sample=0)
local pval: di r(p)
file write table5tests "Col 3, Test 2: `pval'" _n

* Col 4
xtregress ln_wage socskills socskills_sample math math_sample afqt_socskills ///
	afqt_socskills_sample socnlsy2_socskills socnlsy2_socskills_sample ///
	afqt_math afqt_math_sample socnlsy2_math socnlsy2_math_sample `covs' ///
	if age>=25 & age<=33 & complete97==1, fe vce(cluster uniqueID)
outregress2 using table5, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(4)

* Col 4 Coefficient Tests
test (socnlsy2_socskills+socnlsy2_socskills_sample=0)
local pval: di r(p)
file write table5tests "Col 4, Test 1: `pval'" _n

test (socnlsy2_socskills+socnlsy2_socskills_sample=0) (afqt_socskills+afqt_socskills_sample=0)
local pval: di r(p)
file write table5tests "Col 4, Test 2: `pval'" _n

test (socnlsy2_socskills_sample=0) (afqt_socskills_sample=0) (socnlsy2_math_sample=0) ///
	(afqt_math_sample=0)
local pval: di r(p)
file write table5tests "Col 4, Test 3: `pval'" _n

file close table5tests


****Table A2 - Labor Market Returns to Skills in the NLSY79 with Unlogged Wages****

local covs "female hisp_male hisp_female black_male black_female i.age i.year i.div i.metro i.urban"

xi: regress wage soc_nlsy_std `covs' [w=weight] if complete79==1 & sample==0 & age>=23, ///
	vce(cluster pubid)
outregress2 using tableA2, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(2) rdec(3) replace	

xi: regress wage afqt_std soc_nlsy_std `covs' [w=weight] if complete79==1 & sample==0 ///
	& age>=23, vce(cluster pubid)
outregress2 using tableA2, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(2)

xi: regress wage afqt_std soc_nlsy_std afqt_socnlsy `covs' [w=weight] if complete79==1 ///
	& sample==0 & age>=23, vce(cluster pubid)
outregress2 using tableA2, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(2) rdec(3)

xi: regress wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std `covs' [w=weight] ////
	if complete79==1 & sample==0 & age>=23, vce(cluster pubid)
outregress2 using tableA2, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(2) rdec(3)

xi: regress wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std i.educ `covs' [w=weight] ////
	if complete79==1 & sample==0 & age>=23, vce(cluster pubid)
outregress2 using tableA2, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(2) rdec(3)


****Table A3 - Heterogenerateeity in Returns to Skills (NLSY79)****

local covs "female hisp_male hisp_female black_male black_female i.age i.year i.div i.metro i.urban"

xi: regress ln_wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std `covs' [w=weight] ///
	if complete79==1 & sample==0 & age>=23 & female==0, vce(cluster pubid)
outregress2 using tableA3, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3) replace	

xi: regress ln_wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std `covs' [w=weight] ///
	if complete79==1 & sample==0 & age>=23 & female==1, vce(cluster pubid)
outregress2 using tableA3, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)

xi: regress ln_wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std `covs' [w=weight] ///
	if complete79==1 & sample==0 & age>=23 & (race==1 | race==2), vce(cluster pubid)
outregress2 using tableA3, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)

xi: regress ln_wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std `covs' [w=weight] ///
	if complete79==1 & sample==0 & age>=23 & race==3, vce(cluster pubid)
outregress2 using tableA3, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)

xi: regress ln_wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std `covs' [w=weight] ///
	if complete79==1 & sample==0 & age>=23 & educ<=12, vce(cluster pubid)
outregress2 using tableA3, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)

xi: regress ln_wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std `covs' [w=weight] ///
	if complete79==1 & sample==0 & age>=23 & educ>12, vce(cluster pubid)
outregress2 using tableA3, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(3)


****Table A4 - Heterogenerateeity in Returns to Skills (NLSY79)****

local covs "female hisp_male hisp_female black_male black_female i.age i.year i.div i.metro i.urban"

xi: regress wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std `covs' [w=weight] ///
	if complete79==1 & sample==0 & age>=23 & female==0, vce(cluster pubid)
outregress2 using tableA4, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(2) rdec(3) replace	

xi: regress wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std `covs' [w=weight] ///
	if complete79==1 & sample==0 & age>=23 & female==1, vce(cluster pubid)
outregress2 using tableA4, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(2) rdec(3)

xi: regress wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std `covs' [w=weight] ///
	if complete79==1 & sample==0 & age>=23 & (race==1 | race==2), vce(cluster pubid)
outregress2 using tableA4, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(2) rdec(3)

xi: regress wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std `covs' [w=weight] ///
	if complete79==1 & sample==0 & age>=23 & race==3, vce(cluster pubid)
outregress2 using tableA4, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(2) rdec(3)

xi: regress wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std `covs' [w=weight] ///
	if complete79==1 & sample==0 & age>=23 & educ<=12, vce(cluster pubid)
outregress2 using tableA4, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(2) rdec(3)

xi: regress wage afqt_std soc_nlsy_std afqt_socnlsy noncog_std `covs' [w=weight] ///
	if complete79==1 & sample==0 & age>=23 & educ>12, vce(cluster pubid)
outregress2 using tableA4, alpha(0.01, 0.05, 0.10) bracket nocons excel dec(2) rdec(3)
