
setwd('~/Development/docking/covid19-docking/')
require(data.table)

run_pymol <- function(ligand_path, image_path){
  
  script = sprintf('
reinitialize 

##### Load protein
load protein/protein_6yb7.pdbqt, protein
select hetatm
remove sele
show surface, protein

# Hide cartoon and set surface
hide cartoon
set surface_color, white
bg_color white
#set solvent_radius, 1

load %s, drug
show spheres, drug
set sphere_scale, 0.7, drug

set_view (\\
     0.653096735,    0.308816165,   -0.691443324,\\
    -0.395566553,    0.917719483,    0.036244851,\\
     0.645744741,    0.249840796,    0.721521676,\\
    -0.000025807,    0.000011973, -173.567214966,\\
     2.680393219,   -2.178984165,   22.382369995,\\
   115.596817017,  231.541671753,  -20.000000000 )
   
# Color the drug
color rutherfordium, elem c
color platinum, elem h
color meitnerium, elem o
color rubidium, elem n
color orange, elem s

##### Ray trace options
set ray_trace_mode, 1
set ray_trace_fog, 0
# set ray_shadows, 0
unset depth_cue
set antialias,2

ray 1600,1200
png %s, 1600, 1200

', ligand_path, image_path)
  
  writeLines(script, 'script.pml')
  system('/usr/local/bin/pymol -cq script.pml')
  unlink('script.pml')
  
}


# pymol quercetin
if(F){
  q = head(fread('quercetin/quercetin_docking_affinity_results.csv'), 20)
  picked_quercetin = sprintf('quercetin/docked/docked_%s.pdbqt', q$`PubChem ID`)
  picked_quercetin_out = sprintf('quercetin/images/%s.png', basename(picked_quercetin))
  
  for(i in 1:length(picked_quercetin))
    run_pymol(picked_quercetin[i], picked_quercetin_out[i])
}



if(F){
  # pymol drugbank
  db = head(fread('nano_drugbank/drugbank_docking_affinity_results.csv'), 20)
  picked_db = sprintf('nano_drugbank/docked/docked_%s.pdbqt', db$`DrugBank ID`)
  picked_db_out = sprintf('nano_drugbank/images/%s.png', basename(picked_db))
  
  for(i in 1:length(picked_db))
    run_pymol(picked_db[i], picked_db_out[i])
}

if(F){
  run_pymol('nano_drugbank/docked/docked_DB08930.pdbqt', 
            'nano_drugbank/images/docked_DB08930.pdbqt.png')
}
