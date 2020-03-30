setwd('~/docking/covid19/')
source('run_dock.r')
require(data.table)
require(parallel)
df = fread('quercetin/smiles.txt')

mclapply(1:nrow(df), function(i){
  name = df$V1[i]
  smiles = df$V2[i]
  path = generate_ligand_pdbqt(smiles, name, out_dir = 'quercetin/pdbqt')
  
  fout = sprintf('quercetin/docked/docked_%s', basename(path))
  if(file.exists(fout)){
    message('-- skipping ', name)
    return(NULL)
  }
  
  run_docking( path, exhaustiveness = 10, cores = 1, active_site = T, 
               dock_dir = 'quercetin/docked', log_dir = 'quercetin/logs' )
  
}, mc.cores = 40)

# for(i in 1:nrow(df)){
#   
# }


