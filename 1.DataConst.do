*Difine id, age. Omit male sample (1198) and respondents without child (445)
gen id=_n
gen age = ageb 
drop if sexa == 1
drop if ccnumttl==0 | ccnumttl==.

*Marital status
*1 married, 2 divorced, 3 widowed, 4 never married 
gen marriage = domarry
*Omit widowed and never married cases (11)
drop if marriage == 3 | marriage == 4

*Timing of child birth (ref: 1982)
forvalues i=1/5{
rename cc0`i'byr cby`i'
recode cby`i' 8888=. 9999=.
replace cby`i' = (cby`i'-1982)*12
rename cc0`i'bm cbm`i'
recode cbm`i' 88=. 99=.
gen cbirth`i' = cby`i' + cbm`i'
}
*omit cases wityout information about first child birth
drop if cbirth1==.
*omit cases who had twins
drop if cbirth1==cbirth2

/* Number of marriage */
rename mrg0* mrg*
/* Age of marriage/divorce/remarriage（at month） */
forvalues i=1/2{
recode mrg`i'sty 8888=. 9999=.
recode mrg`i'stm 88=. 99=.
replace mrg`i'sty = (mrg`i'sty - 1982)*12
gen mrgst`i' = mrg`i'sty + mrg`i'stm
recode mrg`i'eny 8888=. 9999=.
recode mrg`i'enm 88=. 99=.
replace mrg`i'eny = (mrg`i'eny - 1982)*12
gen mrgen`i' = mrg`i'eny + mrg`i'enm
}
/*devorce in the past (35 cases）*/
gen pastdiv = mrg2
recode pastdiv 2=0

/*Bridal pregnancy at first marriage*/
gen bripreg=0
recode bripreg 0=. if ccnumttl==0 | ccnumttl==.
recode bripreg 0=1 if cbirth1 < mrgst1+9 & mrgst1~=. & cbirth1~=.
gen bripreg7=0
recode bripreg7 0=. if ccnumttl==0 | ccnumttl==.
recode bripreg7 0=1 if cbirth1 < mrgst1+8 & mrgst1~=. & cbirth1~=.
gen bripreg9=0
recode bripreg9 0=. if ccnumttl==0 | ccnumttl==.
recode bripreg9 0=1 if cbirth1 < mrgst1+10 & mrgst1~=. & cbirth1~=.
/*Bridal pregnancy after second marriage is not included (below)*/
/*recode bripreg 0=1 if cbirth1 < mrgst2+9 & cbirth1 > mrgen1 & mrgst2~=. & cbirth1~=. & mrgen1 ~=.*/

//Parity dummies//
gen ccnum1 = ccnumttl
recode ccnum1 1/7=1
gen ccnum2 = ccnumttl
recode ccnum2 0/1=0 2/7=1

*Educational attainment
*1"Junior high school"2"High school"3"Junior/two year colleges"4"University and more"
gen redu = 0
recode redu 0=1 if schtpno == 1
recode redu 0=2 if schtphs == 1 & schtpvs == 0 & schtpunv == 0 & schtpot == 0 & schtpgs == 0 & schtpct == 0 & schtp2yc == 0 & schtpno == 0
recode redu 0=3 if schtphs == 1 & schtpvs == 1 & schtpunv == 0 & schtpot == 0 & schtpgs == 0 & schtpct == 0 & schtp2yc == 0 & schtpno == 0
recode redu 0=3 if schtphs == 0 & schtpvs == 1 & schtpunv == 0 & schtpot == 0 & schtpgs == 0 & schtpct == 0 & schtp2yc == 0 & schtpno == 0
recode redu 0=4 if schtphs == 1 & schtpvs == 0 & schtpunv == 0 & schtpot == 0 & schtpgs == 0 & (schtpct == 1 | schtp2yc == 1) & schtpno == 0
recode redu 0=5 if schtphs == 1 & schtpunv == 1 & schtpgs == 0 & schtpno == 0
recode redu 0=5 if schtphs == 1 & schtpunv == 1 & schtpgs == 1 & schtpno == 0
recode redu 0=.
recode redu (3/4=3)(5=4)

*Spouse education
*1"Junior high school"2"High school"3"Junior/two year colleges"4"University and more"6"Unknown"
gen spedu = sslstsch
recode spedu 3/4=4 6=5 7=6 8/9=.
*Spouse's education is unknown if respondents are married, divorced, or never married but have a child
replace spedu=6 if marriage == 1 & spedu ==.
replace spedu=6 if marriage == 2
replace spedu=6 if marriage == 4 & ccnumttl ~=0 & ccnumttl ~=.
replace spedu = 3 if pspsch == 1 & (spedu == 1 | spedu == 2)
recode  spedu (3/4=3)(5=4)

*Year of high school graduation
recode hseny hsenm (99=.)(9999=.)
gen hsgrady=(hseny-1982)*12 + hsenm
gen jsgrady=(jhsgdyr-2)*12 + 3
*time of school graduation
gen upon=hsgrady if redu ==2
replace upon=jsgrady if redu == 1
*time of age 16
gen age16 = (jhsgdyr-2)*12 + 3 + 12

*birth cohort
recode dobyear 1966/1970 = 1 1971/1975=2 1976/1980=3, gen(cohort)
*marital year and age
gen maryear = (mrg1sty/12)+1982
gen marage = maryear - dobyear
recode maryear 1985/1994=1 1995/1999=2 2000/2004=3 2005/2009=4,gen(marcohort)
recode marage 16/22=1 23/25=2 26/28=3 29/31=4 32/34=5 35/39=6,gen(marcat)

*time of bith year(classification corresponds to Iwasawa Kamata (2015）
forvalues i=1/3{
gen bch`i' = (cby`i'/12)+1982
gen birthage`i' = (cby`i'/12)+1982-dobyear
recode bch`i' 1986/1991=1 1992/1994=2 1995/2001=3 2002/2004=4 2005/2009=5
recode birthage`i' 16/22=1 23/25=2 26/28=3 29/31=4 32/34=5 35/41=6,gen(birthcat`i')
}

*Covariates
/* Number of jobs */
forvalues i=1/9{
rename job0`i' noj`i'
recode jb0`i'sty 8888=. 9999=.
recode jb0`i'stm 88=. 99=.
replace jb0`i'stm = 4 if jb0`i'sty ~=. & jb0`i'stm ==.
replace jb0`i'sty = (jb0`i'sty - 1982)*12
gen jobst`i' = jb0`i'sty + jb0`i'stm
}

gen beginjob = jobst1

gen begin16 = (dobyear+16-1982)*12
recode spagex 999=.
replace begin16=(2009-spagex+16-1982)*12 if sex == 1

/* Age at job quit */
forvalues i=1/9{
recode jb0`i'eny 8888=. 9999=.
recode jb0`i'enm 88=. 99=.
replace jb0`i'enm = 3 if jb0`i'eny ~=. & jb0`i'enm ==.
replace jb0`i'eny = (jb0`i'eny - 1982)*12
gen joben`i' = jb0`i'eny + jb0`i'enm
replace joben`i' = 326 if jb0`i'ong == 2
}

/* SSM 8 classification (including non-employed) */
/* 1"専門" 2"管理" 3"事務" 4"販売" 5"熟練" 6"半熟練" 7"非熟練" 8"農林" 9"無職"*/
forvalues i=1/9{
gen jobssm`i' = jb0`i's0oc 
recode jobssm`i' (501/544 = 1)(609/610 = 1)(615 = 1)(703 = 1) (545/553 = 2)(608 = 2)(554/565 = 3)(586 = 3)(590 = 3)(593/598 = 3)(616/619 = 3)(701 = 3) (566/577 = 4)(582/585 = 4)(587/589 = 4) (579 = 5)(581 = 5)(623/624 = 5)(626 = 5)(628 = 5)(631 = 5)(633 = 5)(635/644 = 5)(647 = 5)(651 = 5)(654/656 = 5)(658 = 5)(660/666= 5)(668 = 5)(670/675 = 5)(677/681 = 5)(684 = 5)(702 = 5) (580 = 6)(606/607 = 6)(611/614 = 6)(625 = 6)(627 = 6)(629/630 = 6)(632 = 6)(634 = 6)(645/646 = 6)(648/650 = 6)(652/653 = 6)(657 = 6)(659 = 6)(667 = 6)(669 = 6)(672 = 6)(676 = 6)(704 = 6)(706=6) (578 = 7)(591/592 = 7)(620/622 = 7)(682/683 = 7)(685/688 = 7)(599/605 = 8)(998 =9)(689 =.)(987 =.)(999 =.)(988=.)(701 = 4)(702 = 5)(703 = 2)(704 = 7)(705 =.)(706 = 8)(707 =.)(801 = 4)(802 = 4)(803 = 4)(804 = 4)
rename jb0`i's0tp type`i'
recode type`i' (8=.) (99=.) 
gen jobpres`i' = jb0`i's0oc 
}
recode type1 .=0 if noj1 == 2
recode jobssm1 .=9 if noj1 == 2
recode jobssm* (1/2=1)(3=2)(4=3)(5/8=4)(9=5)

/*Living with parents*/
recode plv01jh 8=. 9=.
forvalues i=1/4{
recode plv0`i'sty 8888=. 9999=.
recode plv0`i'eny 8888=. 9999=.
recode plv0`i'stm 88=. 99=.
recode plv0`i'enm 88=. 99=.
gen plsty`i' = plv0`i'sty
}

replace plsty1 = (((2009 - age) + 15)-1982)*12 if plv01jh == 2
replace plsty1 = (plv01sty-1982)*12 if plv01jh == 1
replace plsty2 = (plv02sty-1982)*12
replace plsty3 = (plv03sty-1982)*12
replace plsty4 = (plv04sty-1982)*12

forvalues i=1/4{
gen pleny`i' = plv0`i'eny
replace pleny`i' = (plv0`i'eny-1982)*12 
recode plv0`i'ong 8=. 9=.
replace pleny`i' = 326 if plv0`i'ong == 2
}

/*deleting variables*/
drop psncns cnsdbcar cnsdbmcy cnsdbftv cnsdbdry cnsdbstk cnsdbno exrsmeal exrshous exrsutl exrsclth exrscomm exrsmed exrsedu exrsent exrsot exrsno exwtfood exwthous exwtappl exwtcar exwtfshn exwtlssn exwtfrd exwttrav exwtsprt exwtsmc exwthk exwtedu exwtpet exwtot exwtno jhclbphy jhclbcul
drop cndflx cndsmpr cndsmamt cndsmhdy cndjnt cndunrst cndins cndspt cndknlg cndtrn cndrep cndabl cndeft cndacmp cndwrth cndblc cowkamt cowkidea cowkspt skscdoc sksceng sksccoop skscintv skscvers sksclead skscmnnr  skscrcpt skscchrc skscsoc sksclaw skscrght skscno skwkdoc skwkeng skwkcoop skwkintv skwkvers skwklead skwkmnnr skwkrcpt skwkchrc skwksoc skwklaw skwkrght skwkno skwknw skwtdoc skwteng skwtcoop skwtintv skwtvers  skwtlead skwtmnnr skwtrcpt skwtchrc skwtsoc skwtlaw skwtrght skwtno tmalwk tmalhby tmalfam tmalhw
drop hrtv fq5read fq5comic docompj docompp dophs dononex doinbrs doinshop doinbank doinhpb doinpic doinbbs doincs doinnone fq6email netfrnd comabprg comabset comabins comabgr comabdoc comabno opplnet menhlnrv menhlclm menhldp menhlpls menhldwn xtraum5y st5areay st5leisy st5lifey st5ecny st5friy st5hlthy st5ssrel op5happz arbptjb xworkl
drop tpjob tpjobp tpjsfam tpjsfrd tpjswk tpjsrec tpjsoff tpjsweb tpjsad tpjspub tpjsprv tpjspt tpjsfb tpjsnew tpjsot tpjsdk tpjsapot
drop jb01sjno jb01sjdp jb01sjpt jb01sjfb jb01sjot jb02sjno jb02sjdp jb02sjpt jb02sjfb jb02sjot jb03sjno jb03sjdp jb03sjpt jb03sjfb jb03sjot jb04sjno jb04sjdp jb04sjpt jb04sjfb jb04sjot jb05sjno jb05sjdp jb05sjpt  jb05sjfb jb05sjot jb06sjno jb06sjdp jb06sjpt jb06sjfb jb06sjot jb07sjno jb07sjdp jb07sjpt jb07sjfb jb07sjot jb08sjno jb08sjdp jb08sjpt jb08sjfb jb08sjot jb09sjno jb09sjdp jb09sjpt jb09sjfb jb09sjot jb10sjno jb10sjdp jb10sjpt jb10sjfb jb10sjot jb11sjno jb11sjdp jb11sjpt jb11sjfb jb11sjot jb12sjno jb12sjdp jb12sjpt jb12sjfb jb12sjot jb13sjno jb13sjdp jb13sjpt jb13sjfb jb13sjot jb14sjno jb14sjdp jb14sjpt jb14sjfb jb14sjot jb15sjno jb15sjdp jb15sjpt jb15sjfb jb15sjot jb16sjno jb16sjdp jb16sjpt jb16sjfb jb16sjot jb17sjno jb17sjdp jb17sjpt jb17sjfb jb17sjot jb18sjno jb18sjdp jb18sjpt jb18sjfb jb18sjot jb19sjno jb19sjdp jb19sjpt jb19sjfb jb19sjot jb20sjno jb20sjdp jb20sjpt jb20sjfb jb20sjot
drop jb10sty jb10stm jb10ong jb10eny jb10enm jb11sty jb11stm jb11ong jb11eny jb11enm jb12sty jb12stm jb12ong jb12eny jb12enm jb13sty jb13stm jb13ong jb13eny jb13enm jb14sty jb14stm jb14ong jb14eny jb14enm jb15sty jb15stm jb15ong jb15eny jb15enm jb16sty jb16stm jb16ong jb16eny jb16enm jb17sty jb17stm jb17ong jb17eny jb17enm jb18sty jb18stm jb18ong jb18eny jb18enm jb19sty jb19stm jb19ong jb19eny jb19enm jb10s0tp jb10s0tl jb10s0oc jb10s1 jb10s1tp jb10s1tl jb10s1oc jb10s1y jb10s1m jb10s2 jb10s2tp jb10s2tl jb10s2oc jb10s2y jb10s2m jb10s3 jb10s3tp jb10s3tl jb10s3oc jb10s3y jb10s3m jb10s4 jb10s4tp jb10s4tl jb10s4oc jb10s4y jb10s4m jb11s0tp jb11s0tl jb11s0oc jb11s1 jb11s1tp jb11s1tl jb11s1oc jb11s1y jb11s1m jb11s2 jb11s2tp jb11s2tl jb11s2oc jb11s2y jb11s2m jb11s3 jb11s3tp jb11s3tl jb11s3oc jb11s3y jb11s3m jb11s4 jb11s4tp jb11s4tl jb11s4oc jb11s4y jb11s4m jb12s0tp jb12s0tl jb12s0oc jb12s1 jb12s1tp jb12s1tl jb12s1oc jb12s1y jb12s1m jb12s2 jb12s2tp jb12s2tl jb12s2oc jb12s2y jb12s2m jb12s3 jb12s3tp jb12s3tl jb12s3oc jb12s3y jb12s3m jb12s4 jb12s4tp jb12s4tl jb12s4oc jb12s4y jb12s4m jb13s0tp jb13s0tl jb13s0oc jb13s1 jb13s1tp jb13s1tl jb13s1oc jb13s1y jb13s1m jb13s2 jb13s2tp jb13s2tl jb13s2oc jb13s2y jb13s2m jb13s3 jb13s3tp jb13s3tl jb13s3oc jb13s3y jb13s3m jb13s4 jb13s4tp jb13s4tl jb13s4oc jb13s4y jb13s4m jb14s0tp jb14s0tl jb14s0oc jb14s1 jb14s1tp jb14s1tl jb14s1oc jb14s1y jb14s1m jb14s2 jb14s2tp jb14s2tl jb14s2oc jb14s2y jb14s2m jb14s3 jb14s3tp jb14s3tl jb14s3oc jb14s3y jb14s3m jb14s4 jb14s4tp jb14s4tl jb14s4oc jb14s4y jb14s4m jb15s0tp jb15s0tl jb15s0oc jb15s1 jb15s1tp jb15s1tl jb15s1oc jb15s1y jb15s1m jb15s2 jb15s2tp jb15s2tl jb15s2oc jb15s2y jb15s2m jb15s3 jb15s3tp jb15s3tl jb15s3oc jb15s3y jb15s3m jb15s4 jb15s4tp jb15s4tl jb15s4oc jb15s4y jb15s4m jb16s0tp jb16s0tl jb16s0oc jb16s1 jb16s1tp jb16s1tl jb16s1oc jb16s1y jb16s1m jb16s2 jb16s2tp jb16s2tl jb16s2oc jb16s2y jb16s2m jb16s3 jb16s3tp jb16s3tl jb16s3oc jb16s3y jb16s3m jb16s4 jb16s4tp jb16s4tl jb16s4oc jb16s4y jb16s4m jb17s0tp jb17s0tl jb17s0oc jb17s1 jb17s1tp jb17s1tl jb17s1oc jb17s1y jb17s1m jb17s2 jb17s2tp jb17s2tl jb17s2oc jb17s2y jb17s2m jb17s3 jb17s3tp jb17s3tl jb17s3oc jb17s3y jb17s3m jb17s4 jb17s4tp jb17s4tl jb17s4oc jb17s4y jb17s4m jb18s0tp jb18s0tl jb18s0oc jb18s1 jb18s1tp jb18s1tl jb18s1oc jb18s1y jb18s1m jb18s2 jb18s2tp jb18s2tl jb18s2oc jb18s2y jb18s2m jb18s3 jb18s3tp jb18s3tl jb18s3oc jb18s3y jb18s3m jb18s4 jb18s4tp jb18s4tl jb18s4oc jb18s4y jb18s4m jb19s0tp jb19s0tl jb19s0oc jb19s1 jb19s1tp jb19s1tl jb19s1oc jb19s1y jb19s1m jb19s2 jb19s2tp jb19s2tl jb19s2oc jb19s2y jb19s2m jb19s3 jb19s3tp jb19s3tl jb19s3oc jb19s3y jb19s3m jb19s4 jb19s4tp jb19s4tl jb19s4oc jb19s4y jb19s4m 
