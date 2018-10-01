drop if redu ==. 
drop if spedu ==.
drop if ageb ==.
drop if marcohort == .
drop if marcat == .
drop if bripreg ==.
***Create person-month data using length***
gen tf = 326 - begin16 + 1
expand tf
sort id 
by id: gen length = begin16 + _n - 1
sort iduse length

do "/Users/fumiyau/Documents/GitHub/OrderMatters/3.OccupationHistory.do"

*Leaving home dummy
gen pld = .
*Never
replace pld =0 if plv01jh == 2 & plv01ong == 2
*From JHS graduation to one point
replace pld =0 if plv01jh == 2 & plv01ong == 1 & length <= pleny1 & pleny1~=.
replace pld =1 if pleny1 < length & pleny1 ~=.
*Left before JHS graduation
replace pld =1 if plv01jh == 1 & length < plsty1 & plsty1 ~=.
*Live with parents since then
replace pld =0 if plv01jh == 1 & plv01ong == 2 & plsty1 <= length & plsty1 ~=.
*Live with parents until some point
replace pld =0 if plv01jh == 1 & plsty1 <= length & length <= pleny1 & plsty1 ~=. & pleny1 ~=.
*Left home then
replace pld =1 if plv01jh == 1 & length < pleny1 & pleny1~=.
*Living with parents to the present (2nd time)
replace pld =0 if plsty2 <= length & plv02ong == 2 & plsty2~=.
*Living with parents until some point (2nd time)
replace pld =0 if plsty2 <= length & length <= pleny2 & plsty2 ~=. & pleny2 ~=.
*Left at home then
replace pld =1 if length < pleny2  & pleny2 ~=.
*Living with parents to the present (3rd time)
replace pld =0 if plsty3 <= length & plv03ong == 2 & plsty3~=.
*Living with parents until some point (3rd time)
replace pld =0 if plsty3 <= length & length <= pleny3 & plsty3 ~=. & pleny3 ~=.
*Left home then
replace pld =1 if length < pleny3  & pleny3 ~=.
*Living with parents to the present (4th time)
replace pld =0 if plsty4 <= length & plv04ong == 2 & plsty4~=.
*Living with parents to the present (4th time)
replace pld =0 if plsty4 <= length & length <= pleny4 & plsty4 ~=. & pleny4 ~=.
*Left home then
replace pld =1 if length < pleny4  & pleny4 ~=.

*Occupation 12, 18, or 24 months ago）
bysort iduse: gen jobssm1a = jobssm[_n-12] if iduse==iduse[_n-12]
bysort iduse: gen type1a = type[_n-12] if iduse==iduse[_n-12]
bysort iduse: gen jobssm2a = jobssm[_n-24] if iduse==iduse[_n-24]
bysort iduse: gen type2a = type[_n-24] if iduse==iduse[_n-24]
bysort iduse: gen jobssm15a = jobssm[_n-18] if iduse==iduse[_n-18]
bysort iduse: gen pld15a = pld[_n-18] if iduse==iduse[_n-18]
bysort iduse: gen type15a = type[_n-18] if iduse==iduse[_n-18]
recode type1a type2a type15a (.=4)
recode jobssm1a jobssm2a jobssm15a (0=5)
recode jobssm1a  (.=5) if type1a == 4
recode jobssm2a  (.=5) if type2a == 4
recode jobssm15a (.=5) if type15a == 4

*time varying marital status
gen mrgstst = 0
recode mrgstst 0=1 if mrgst1 <= length & length <= mrgen1 
recode mrgstst 0=1 if mrgst2 <= length & length <= mrgen2

*Year of child birth
gen bch=bch1 if cbirth1 == length
replace bch=bch2 if cbirth2 == length
replace bch=bch3 if cbirth3 == length

*1"Upper non-manual"2"Lower non-manual"3"Upper manual"4"Lower manual"5"Non-employed"
recode type1 (1/2=1) (3/5=2) (6/7=3) (0=4)

*Risk at month starting from 12+1 months after the first birth
gen lmonth = length - cbirth1 - 12 + 1
*Omitting person-month before 12 months after the first birth (36 cases are omitted from the sample)
drop if length < cbirth1+12
///////////////////////////////////////////////////
*creating event dummy using bev and length
forvalues i=1/3{
gen bev`i'=0
recode bev`i' 0=1 if cbirth`i'==length
}

*Time varing divorce dummy
gen div=0
replace div=1 if mrgen1 < length & mrgen1 ~=.
replace div=0 if length < mrgst2 & mrgst2 ~=.
replace div=1 if mrgen2 < length & mrgen2 ~=.

recode bripreg 0=1 1=2, gen(bripregx)

