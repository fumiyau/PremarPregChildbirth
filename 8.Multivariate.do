*Discrete time logit models
cd "/Users/fumiyau/Documents/GitHub/OrderMatters/Results/Regressions"

*Model selection
qui logit bev2 i.lmonthcat4 c.bripreg7 i.redu i.spedu i.marcohort i.marcat i.type15a i.jobssm15a pld15a  if group ~=.
est sto model0
qui logit bev2 i.lmonthcat4 c.bripreg7 i.redu i.spedu i.marcohort i.marcat i.type15a i.jobssm15a pld15a  div   if group ~=.
est sto model1
qui logit bev2 i.lmonthcat4 c.bripreg7 i.redu i.spedu i.marcohort i.marcat i.type15a i.jobssm15a pld15a  i.birthcat1  if group ~=.
est sto model2
qui logit bev2 i.lmonthcat4 c.bripreg7 i.redu i.spedu i.marcohort i.marcat i.type15a i.jobssm15a pld15a  div i.birthcat1  if group ~=.
est sto model3
qui logit bev2 i.lmonthcat4##c.bripreg7 i.redu i.spedu i.marcohort i.marcat i.type15a i.jobssm15a pld15a  if group ~=.
est sto model4
qui logit bev2 i.lmonthcat4##c.bripreg7 i.redu i.spedu i.marcohort i.marcat i.type15a i.jobssm15a pld15a div  if group ~=.
est sto model5
qui logit bev2 i.lmonthcat4##c.bripreg7 i.redu i.spedu i.marcohort i.marcat i.type15a i.jobssm15a pld15a i.birthcat1  if group ~=.
est sto model6
qui logit bev2 i.lmonthcat4##c.bripreg7 i.redu i.spedu i.marcohort i.marcat i.type15a i.jobssm15a pld15a  div i.birthcat1  if group ~=.
est sto model7
esttab model0 model1 model2 model3 model4 model5 model6 model7 using Secondbirth7_wide2_modelfit.csv, se scalar(N chi2 df_m ll bic aic r2_p) star(† 0.1 * 0.05 ** 0.01 *** 0.001) b(3)  replace label  wide noomitted title(Determinants of second childbirth (left: adjusted right: observed))

*Accepted model 
qui logit bev2 i.lmonthcat4##c.bripreg7 i.redu i.spedu i.marcohort i.marcat i.type15a i.jobssm15a pld15a div i.birthcat1 if group ~=.
est sto model1
qui logit bev2 i.lmonthcat4##c.bripreg7 i.redu i.spedu i.marcohort i.marcat i.type15a i.jobssm15a pld15a div i.birthcat1
est sto model2
esttab  model1 model2  using Secondbirth7_wide2_aftermodelfit_2ndround.csv, se scalar(N chi2 df_m ll aic r2_p) star(# 0.1 * 0.05 ** 0.01 *** 0.001) b(3)  replace label  wide noomitted title(Determinants of second childbirth (left: adjusted right: observed))

*Predicted hazard
qui logit bev2 i.lmonthcat4##i.bripreg7 i.redu i.spedu i.marcohort i.marcat i.type15a i.jobssm15a pld15a div i.birthcat1 if group ~=.
estpost margins bripreg7, at(lmonthcat4=(0(1)7) ) 
esttab . using hazardbybripreg7.csv, replace r(b) label wide nostar
qui logit bev2 i.lmonthcat4##i.bripreg7 i.redu i.spedu i.marcohort i.marcat i.type15a i.jobssm15a pld15a div i.birthcat1 if group ~=.
estpost margins bripreg7
