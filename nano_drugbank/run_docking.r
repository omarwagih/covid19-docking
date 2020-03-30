setwd('~/docking/covid19/')
require(data.table)
require(parallel)
source('run_dock.r')
df = fread('nano_drugbank/df_drugbank_smiles.csv')
df = df[,c('drugbank_id', 'name', 'smiles')]


X = mclapply(1:nrow(df), function(i){
  name = df$drugbank_id[i]
  smiles = df$smiles[i]
  path = generate_ligand_pdbqt(smiles, name, out_dir = 'nano_drugbank/pdbqt')
  
  fout = sprintf('nano_drugbank/docked/docked_%s', basename(path))
  if(file.exists(fout)){
    message('-- skipping ', name)
    return(NULL)
  }
  
  run_docking( path, exhaustiveness = 10, cores = 1, active_site = T, 
               dock_dir = 'nano_drugbank/docked', log_dir = 'nano_drugbank/logs' )
}, mc.cores = 40)

# for(i in 3:3){
#   
# }
