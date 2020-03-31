<img src="animated.gif" width="400px" align="right">

# Docking of compounds against the SARS-CoV-2 protease structure

## Overview
Initial exploratory analysis of identifying existing compounds that would serve as potential inhibitors of the SARS-CoV-2 protease. Several thousand compounds are docked on top the active site of the protease and the affinity is assessed. The compounds used range from ~700 Quercetin analogues (a known antiviral agent), ~5600 compounds in DrugBank, and ~500 antiviral compounds as determined by the ATC classification. 

## Getting started

### Requirements 


- [AutoDock Vina](http://vina.scripps.edu/). This is for carrying out the docking itself. It can be obtained [from Anaconda](https://anaconda.org/bioconda/autodock-vina).
- [AutoDockTools](http://autodock.scripps.edu/resources/adt) is optionally required for selecting docking grid box.
- [Open Babel](http://openbabel.org/wiki/Main_Page). This is for converting pdb/smiles formats to pdbqt required for docking. It can be obtained [from Anaconda](https://anaconda.org/openbabel/openbabel).
- [PyMol](https://pymol.org/2/) for visualizing drug-ligand interactions.

**If you are like myself and have never done any docking, I would reccomend walking through the [AutoDock Vina tutorial by Oleg Trott](http://vina.scripps.edu/tutorial.html).**


### Preparing the protein for docking

- The protein used for the docking is pdb ID 6LU7 [COVID19 main protease in complex with an inhibitor](https://www.rcsb.org/pdb/explore/sequenceCluster.do?structureId=6LU7). Using AutoDockTools, any solvent molecules and existing ligands are first removed and polar hydrogens are added. The saved protein pdbqt file is provided in [`protein/protein_6yb7.pdbqt`](protein/protein_6yb7.pdbqt).

- The grid box must then be defined in AutoDockTools. This tells the docking software where what regions of the protein to attempt docking to. The grid box I have defined is based on the protease active site and has the following parameters: 

```
center_x 10.568
center_y -1.892
center_z 21.485

size_x 20
size_y 18
size_z 18 
```

See the [AutoDock Vina tutorial](http://vina.scripps.edu/tutorial.html) for how to do this. 

## Docking Quercetin analogues

The first batch of compounds that were docked are analogues of Quercetin. Quercetin is plant pigment (flavonoid) that is found in many plants and foods, such as red wine and onions. It has shown to have antiviral properties, specifically by inhibiting viral proteases e.g. [PMID:30064445](https://pubmed.ncbi.nlm.nih.gov/30064445/) including that of Ebola [PMID:27297486](https://pubmed.ncbi.nlm.nih.gov/27297486/). There is also a [clinical trial planned](https://www.mcgilltribune.com/sci-tech/montreal-researchers-propose-a-treatment-for-covid-19-170320/) to assess efficiacy of quercetin at inhibiting COVID19.

There are hundreds of compounds that are analogues of quercetin. Using PubChem, I obtained the smiles for any compounds matching "quercetin" in the search result. This resulted in 693 compounds, which can be found in [`quercetin/PubChem_compound_text_quercetin.csv`](quercetin/PubChem_compound_text_quercetin.csv). Smiles for each compound was converted to pdbqt using open babel. Each compound was docked against the COVID19 main protease using an exhaustiveness of 10. A total of 667 compounds were successfully docked. The docked pdbqt files can be found in [`quercetin/docked`](quercetin/docked).

Vina uses affinity (in kcal/mol) to assess how well the compound is expected to bind. This table shows the top compounds identified, sorted by affinity. The full list of pdbqt files for these compounds can be found in [`quercetin/quercetin_docking_affinity_results.csv`](quercetin/quercetin_docking_affinity_results.csv).


### Distribution of quercetin analogue affinity to the COVID19 protease

Quercetin is shown in the dotted red line:

![](quercetin/images/hist_quercetin.png)

### Table of top quercetin analogues ordered by affinity to the COVID19 protease

- Table shows top 20 identified compounds ordered by affinity

|Compound                                                                         |PubChem ID                                                       | Affinity|
|:--------------------------------------------------------------------------------|:----------------------------------------------------------------|--------:|
|2-(3,4-Dihydroxyphenyl)-5,7-dihydroxy-3-[(2S,3R,4S,5S,6R)-3,4,5-trihydroxy-6-... |[10232597](https://pubchem.ncbi.nlm.nih.gov/compound/10232597)   |     -8.6|
|Camellianoside                                                                   |[11988368](https://pubchem.ncbi.nlm.nih.gov/compound/11988368)   |     -8.6|
|Quercetin 3-rhamnosyl-(1->4)-rhamnosyl-(1->6)-glucoside                          |[44259158](https://pubchem.ncbi.nlm.nih.gov/compound/44259158)   |     -8.6|
|Quercetin 3-O-alpha-D-arabinopyranoside                                          |[44259270](https://pubchem.ncbi.nlm.nih.gov/compound/44259270)   |     -8.6|
|CID 129826674                                                                    |[129826674](https://pubchem.ncbi.nlm.nih.gov/compound/129826674) |     -8.6|
|[2-Hydroxy-5-(3,5,7-trihydroxy-4-oxochromen-2-yl)phenyl] 4-aminobenzoate         |[16102833](https://pubchem.ncbi.nlm.nih.gov/compound/16102833)   |     -8.4|
|Quercetin 7-(6''-galloylglucoside)                                               |[44257998](https://pubchem.ncbi.nlm.nih.gov/compound/44257998)   |     -8.4|
|Quercetin 5-glucuronide                                                          |[44259271](https://pubchem.ncbi.nlm.nih.gov/compound/44259271)   |     -8.4|
|Quercetin 3-rhamnosyl-(1->2)-glucosyl-(1->6)-galactoside                         |[44259283](https://pubchem.ncbi.nlm.nih.gov/compound/44259283)   |     -8.4|
|Quercetin 3-methyl ether 7-rhamnoside-3'-xyloside                                |[44259666](https://pubchem.ncbi.nlm.nih.gov/compound/44259666)   |     -8.4|
|[(2R,3S,4S,5R,6S)-3,4,5-Trihydroxy-6-[2-hydroxy-4-(3,5,7-trihydroxy-4-oxochro... |[60150859](https://pubchem.ncbi.nlm.nih.gov/compound/60150859)   |     -8.4|
|2,3-Dehydrosilybin                                                               |[5467200](https://pubchem.ncbi.nlm.nih.gov/compound/5467200)     |     -8.3|
|Quercetin 3-rhamnosyl-(1->6)-glucosyl-(1->6)-galactoside                         |[44259284](https://pubchem.ncbi.nlm.nih.gov/compound/44259284)   |     -8.3|
|CID 129826737                                                                    |[129826737](https://pubchem.ncbi.nlm.nih.gov/compound/129826737) |     -8.3|
|2-(3,4-Dihydroxyphenyl)-5,7-dihydroxy-3-(3,4,5-trihydroxyoxan-2-yl)oxychromen... |[5878729](https://pubchem.ncbi.nlm.nih.gov/compound/5878729)     |     -8.2|
|Alcesefoliside                                                                   |[11828754](https://pubchem.ncbi.nlm.nih.gov/compound/11828754)   |     -8.2|
|Quercetin 3-(3R-glucosylrutinoside)                                              |[44259156](https://pubchem.ncbi.nlm.nih.gov/compound/44259156)   |     -8.2|
|Quercetin 3-(2''',3''',4'''-triacetyl-alpha-L-arabinopyranosyl)(1->6)-glucoside  |[44259196](https://pubchem.ncbi.nlm.nih.gov/compound/44259196)   |     -8.2|
|Quercetin 3-alpha-L-arabionopyranoside-7-glucoside                               |[44259239](https://pubchem.ncbi.nlm.nih.gov/compound/44259239)   |     -8.2|
|3,5,7-Trihydroxy-2-[4-hydroxy-3-[(2R,3R,4S,5S,6R)-3,4,5-trihydroxy-6-(hydroxy... |[67128564](https://pubchem.ncbi.nlm.nih.gov/compound/67128564)   |     -8.2|



### Visualizing top quercetin analogues in complex with the COVID19 protease

#### Camellianoside, PubChem:11988368 (-8.6 kcal/mol)

Has been shown to have an inhibitory effect on the HIV-1 protease [PMID:16926516](https://pubmed.ncbi.nlm.nih.gov/16926516/)

![](quercetin/images/docked_11988368.pdbqt.png)

#### Quercetin 3-O-alpha-D-arabinopyranoside, PubChem:44259270 (-8.6 kcal/mol)
![](quercetin/images/docked_44259270.pdbqt.png)

#### Quercetin 5-glucuronide, PubChem:44259271 (-8.4 kcal/mol)
![](quercetin/images/docked_44259271.pdbqt.png)

#### Alcesefoliside, PubChem:11828754 (-8.2 kcal/mol)
![](quercetin/images/docked_11828754.pdbqt.png)



## Docking compounds in DrugBank
To expand this, I smilarly next docked over 5600 compounds found in DrugBank. 4878 successfully docked. The smiles for each of those compounds were pulled from [this repository](https://github.com/choderalab/nano-drugbank/blob/master/df_drugbank_smiles.csv), converted to pdbqt files, and used for the vina docking in a similar manner to the quercetin analogues.

This resulted in dozens of compounds with strong binding affinities, many stronger than the strongest quercetin analogue. This table shows the top compounds identified. The full list of docked pdbqt files for these compounds can be found in [`nano_drugbank/docked`](nano_drugbank/docked).

The file containing affinities of the docked DrugBank compounds can be found in [`nano_drugbank/drugbank_docking_affinity_results.csv`](nano_drugbank/drugbank_docking_affinity_results.csv).

### Distribution of DrugBank compound affinity to the COVID19 protease

Quercetin is shown in the dotted red line:

![](nano_drugbank/images/hist_drugbank.png)

### Table of top DrugBank compounds ordered by affinity to the COVID19 protease 

- Table shows top 20 identified compounds ordered by affinity

|Compound                                                                         |DrugBank ID                                      | Affinity|
|:--------------------------------------------------------------------------------|:------------------------------------------------|--------:|
|N-[2-Hydroxy-2-(8-Isopropyl-6,9-Dioxo-2-Oxa-7,10-Diaza-Bicyclo[11.2.2]Heptade... |[DB03768](https://www.drugbank.ca/drugs/DB03768) |    -11.5|
|2-(11-{2-[Benzenesulfonyl-(3-Methyl-Butyl)-Amino]-1-Hydroxy-Ethyl}-6,9-Dioxo-... |[DB02411](https://www.drugbank.ca/drugs/DB02411) |    -10.6|
|Conivaptan                                                                       |[DB00872](https://www.drugbank.ca/drugs/DB00872) |     -9.9|
|N-(2-(((5-CHLORO-2-PYRIDINYL)AMINO)SULFONYL)PHENYL)-4-(2-OXO-1(2H)-PYRIDINYL)... |[DB07800](https://www.drugbank.ca/drugs/DB07800) |     -9.3|
|Lumacaftor                                                                       |[DB09280](https://www.drugbank.ca/drugs/DB09280) |     -9.3|
|N-[4-(2-CHLOROPHENYL)-1,3-DIOXO-1,2,3,6-TETRAHYDROPYRROLO[3,4-C]CARBAZOL-9-YL... |[DB07226](https://www.drugbank.ca/drugs/DB07226) |     -9.2|
|SP2456                                                                           |[DB03957](https://www.drugbank.ca/drugs/DB03957) |     -9.1|
|5-(4-PHENOXYPHENYL)-5-(4-PYRIMIDIN-2-YLPIPERAZIN-1-YL)PYRIMIDINE-2,4,6(2H,3H)... |[DB07117](https://www.drugbank.ca/drugs/DB07117) |     -9.1|
|N-[(13-CYCLOHEXYL-6,7-DIHYDROINDOLO[1,2-D][1,4]BENZOXAZEPIN-10-YL)CARBONYL]-2... |[DB08031](https://www.drugbank.ca/drugs/DB08031) |     -9.1|
|4-Oxo-2-Phenylmethanesulfonyl-Octahydro-Pyrrolo[1,2-a]Pyrazine-6-Carboxylic A... |[DB02723](https://www.drugbank.ca/drugs/DB02723) |     -9.0|
|(2e,3s)-3-Hydroxy-5'-[(4-Hydroxypiperidin-1-Yl)Sulfonyl]-3-Methyl-1,3-Dihydro... |[DB03583](https://www.drugbank.ca/drugs/DB03583) |     -9.0|
|(5S)-5-(2-amino-2-oxoethyl)-4-oxo-N-[(3-oxo-3,4-dihydro-2H-1,4-benzoxazin-6-y... |[DB07397](https://www.drugbank.ca/drugs/DB07397) |     -9.0|
|5-(AMINOCARBONYL)-1,1':4',1''-TERPHENYL-3-CARBOXYLICACID                         |[DB04583](https://www.drugbank.ca/drugs/DB04583) |     -8.9|
|(1S,5S,7R)-N~7~-(BIPHENYL-4-YLMETHYL)-N~3~-HYDROXY-6,8-DIOXA-3-AZABICYCLO[3.2... |[DB07026](https://www.drugbank.ca/drugs/DB07026) |     -8.9|
|2-({[3,5-DIFLUORO-3'-(TRIFLUOROMETHOXY)BIPHENYL-4-YL]AMINO}CARBONYL)CYCLOPENT... |[DB07975](https://www.drugbank.ca/drugs/DB07975) |     -8.9|
|(3Z)-1-[(6-fluoro-4H-1,3-benzodioxin-8-yl)methyl]-4-[(E)-2-phenylethenyl]-1H-... |[DB08010](https://www.drugbank.ca/drugs/DB08010) |     -8.9|
|Dolutegravir                                                                     |[DB08930](https://www.drugbank.ca/drugs/DB08930) |     -8.9|
|Nilotinib                                                                        |[DB04868](https://www.drugbank.ca/drugs/DB04868) |     -8.8|
|4-[[2-[[4-chloro-3-(trifluoromethyl)phenyl]amino]-3H-benzimidazol-5-yl]oxy]-N... |[DB06938](https://www.drugbank.ca/drugs/DB06938) |     -8.8|
|(2R)-N-HYDROXY-2-[(3S)-3-METHYL-3-{4-[(2-METHYLQUINOLIN-4-YL)METHOXY]PHENYL}-... |[DB07145](https://www.drugbank.ca/drugs/DB07145) |     -8.8|



*Visualizing top DrugBank compounds in complex with the COVID19 protease*


#### EXPT01695, DB03768 (-11.5 kcal/mol)
![](nano_drugbank/images/docked_DB03768.pdbqt.png)



#### EXPT01696, DB02411 (-10.6 kcal/mol)
![](nano_drugbank/images/docked_DB02411.pdbqt.png)



#### Conivaptan, DB00872 (-11.5 kcal/mol)
![](nano_drugbank/images/docked_DB00872.pdbqt.png)



#### Lumacaftor, DB09280 (-9.3 kcal/mol)
![](nano_drugbank/images/docked_DB09280.pdbqt.png)


#### Dolutegravir, DB08930 (-8.9 kcal/mol)
- Dolutegravir is an existing FDA-approved HIV-1 antiviral agent. It inhibits HIV integrase by binding to the active site and blocking the strand transfer step of retroviral DNA integration in the host cell.
- Also predicted as an effective treatment for COVID19 in [this paper](https://www.genengnews.com/artificial-intelligence/ai-predicts-coronavirus-vulnerable-to-hivs-atazanavir/).

![](nano_drugbank/images/docked_DB08930.pdbqt.png)




## Docking antiviral compounds
573 compounds with the ATC code `J05 - Antivirals for systemic use` were obtained from PubChem and docked similarly. 374 successfully docked. 


The file containing affinities of the docked DrugBank compounds can be found in [`antivirals/antivirals_docking_affinity_results.csv`](antivirals/antivirals_docking_affinity_results.csv).

### Distribution of DrugBank compound affinity to the COVID19 protease

![](nano_drugbank/images/hist_antivirals.png)

### Table of top DrugBank compounds ordered by affinity to the COVID19 protease 


|Compound                                                                         |PubChem ID                                                       | Affinity|
|:--------------------------------------------------------------------------------|:----------------------------------------------------------------|--------:|
|CID 131752309                                                                    |[131752309](https://pubchem.ncbi.nlm.nih.gov/compound/131752309) |     -9.2|
|CID 130400467                                                                    |[130400467](https://pubchem.ncbi.nlm.nih.gov/compound/130400467) |     -8.6|
|N-[(2,4-Difluorophenyl)methyl]-11-hydroxy-7-methyl-9,12-dioxo-4-oxa-1,8-diaza... |[57414794](https://pubchem.ncbi.nlm.nih.gov/compound/57414794)   |     -8.5|
|Raltegravir                                                                      |[54671008](https://pubchem.ncbi.nlm.nih.gov/compound/54671008)   |     -8.4|
|CID 129010421                                                                    |[129010421](https://pubchem.ncbi.nlm.nih.gov/compound/129010421) |     -8.4|
|N-(3,5-Dioxo-4-azatetracyclo[5.3.2.02,6.08,10]dodec-11-en-4-yl)-4-(trifluorom... |[25101755](https://pubchem.ncbi.nlm.nih.gov/compound/25101755)   |     -8.3|
|(16alpha,17beta)-3-(Benzyloxy)estra-1,3,5(10)-triene-16,17-diol                  |[3271](https://pubchem.ncbi.nlm.nih.gov/compound/3271)           |     -8.2|
|Tecovirimat                                                                      |[16124688](https://pubchem.ncbi.nlm.nih.gov/compound/16124688)   |     -8.1|
|Dolutegravir                                                                     |[54726191](https://pubchem.ncbi.nlm.nih.gov/compound/54726191)   |     -8.1|
|Delavirdine                                                                      |[5625](https://pubchem.ncbi.nlm.nih.gov/compound/5625)           |     -8.0|
|Amenamevir                                                                       |[11397521](https://pubchem.ncbi.nlm.nih.gov/compound/11397521)   |     -8.0|
|4,4-Difluoro-N-[(1R)-3-[(1S,5R)-3-(3-methyl-5-propan-2-yl-1,2,4-triazol-4-yl)... |[23725098](https://pubchem.ncbi.nlm.nih.gov/compound/23725098)   |     -8.0|
|CID 135905396                                                                    |[135905396](https://pubchem.ncbi.nlm.nih.gov/compound/135905396) |     -8.0|
|N-[(2S,6R,8R,10S)-3,5-Dioxo-4-azatetracyclo[5.3.2.02,6.08,10]dodec-11-en-4-yl... |[11485687](https://pubchem.ncbi.nlm.nih.gov/compound/11485687)   |     -7.9|
|4-[(4-Fluorophenyl)methylcarbamoyl]-1-methyl-2-[2-[(5-methyl-1,3,4-oxadiazole... |[54728271](https://pubchem.ncbi.nlm.nih.gov/compound/54728271)   |     -7.9|
|CID 129626579                                                                    |[129626579](https://pubchem.ncbi.nlm.nih.gov/compound/129626579) |     -7.9|
|1-[4-Benzyl-2-hydroxy-5-[(2-hydroxy-2,3-dihydro-1H-inden-1-yl)amino]-5-oxopen... |[3706](https://pubchem.ncbi.nlm.nih.gov/compound/3706)           |     -7.8|
|N-[4-[3-(Tert-butylcarbamoyl)-3,4,4a,5,6,7,8,8a-octahydro-1H-isoquinolin-2-yl... |[3579812](https://pubchem.ncbi.nlm.nih.gov/compound/3579812)     |     -7.8|
|CID 129317853                                                                    |[129317853](https://pubchem.ncbi.nlm.nih.gov/compound/129317853) |     -7.7|
|CID 134692005                                                                    |[134692005](https://pubchem.ncbi.nlm.nih.gov/compound/134692005) |     -7.7|



*Visualizing top DrugBank compounds in complex with the COVID19 protease*


#### CID131752309, PubChem:131752309 (-9.2 kcal/mol)
![](antivirals/images/docked_131752309.pdbqt.png)


#### Raltegravir, PubChem:54671008 (-8.4 kcal/mol)
![](antivirals/images/docked_54671008.pdbqt.png)


#### Tecovirimat, PubChem:16124688 (-8.1 kcal/mol)
![](antivirals/images/docked_16124688.pdbqt.png)


#### Dolutegravir, PubChem:54726191 (-8.1 kcal/mol)
![](antivirals/images/docked_54726191.pdbqt.png)


#### Delavirdine, PubChem:5625 (-8.0 kcal/mol)
![](antivirals/images/docked_5625.pdbqt.png)






## TODO
- There are a large number of cases where babel does not correctly convert SMILES to pdbqt format OR where the docking fails when there is additional ions or solvents in the ligand file OR docking/converstion takes too long. These cases are ignored and should be dealt with properly. 
- Re-run top compounds at higher exhaustiveness.


