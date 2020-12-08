* Encoding: UTF-8.
* This script produces output to check the data and outcomes in the report. 
* Open data.
GET
  FILE='C:\Surfdrive\Temp\L_CoronaMelder_wave1_3p.sav'.
DATASET NAME DataSet2 WINDOW=FRONT.

* Remove the 10 participants for which data was not complete.
USE ALL.
COMPUTE filter_$=( ~ SYSMIS(duur)).
VARIABLE LABELS filter_$ ' ~ SYSMIS(duur) (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

* Demographics.
FREQUENCIES VARIABLES=geslacht lftdcat sted belbezig burgstat nettocat oplmet woonvorm Riskgroup_contact
  /ORDER=ANALYSIS.

* Health motivation.
FREQUENCIES VARIABLES=CoronaInfectionSelf CoronaInfectionSelfTest CoronaInfectionSelfTest_1 CoronaInfectionSelfTest_2 
 /ORDER=ANALYSIS.

FREQUENCIES VARIABLES= HBM_PSus_self1 HBM_PSev_other2 
 /ORDER=ANALYSIS.

* Adherence general behavioral measures.
FREQUENCIES VARIABLES= Intention_AdherenceGeneralMeasures_quarantaine Behavior_AdherenceGeneralMeasures_handwashing Corona_complaints Behavior_AdherenceGeneralMeasures_quarantaine
 /ORDER=ANALYSIS.

* Conspiracy theories and trust government.
FREQUENCIES VARIABLES= Beliefs_Conspiracy2 Beliefs_TrustGovernment
 /ORDER=ANALYSIS.

* Awareness.
FREQUENCIES VARIABLES= Awareness
 /ORDER=ANALYSIS.

* Use and intention. 
FREQUENCIES VARIABLES= Behavior_UTAUT BI1a_UTAUT BI1b_UTAUT
 /ORDER=ANALYSIS.

* Use and intention. 
FREQUENCIES VARIABLES= Behavior_UTAUT BI1b_UTAUT
 /ORDER=ANALYSIS.

* CheckBI1a_UTAUT for only never users.  
USE ALL.
COMPUTE filter_$=( ~ SYSMIS(duur)  & (Behavior_UTAUT = 3)).
VARIABLE LABELS filter_$ ' ~ SYSMIS(duur)  & (Behavior_UTAUT = 3) (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES= Behavior_UTAUT BI1a_UTAUT 
 /ORDER=ANALYSIS.
