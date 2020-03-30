setwd('~/docking/covid19/')

require(data.table)
require(parallel)
source('run_dock.r')

# J05 - Antivirals for systemic use
# WHO ATC ATC 
df = fread('antivirals/1489656498827507994.txt')

mclapply(1:nrow(df), function(i){
  name = df$V1[i]
  smiles = df$V2[i]
  message('### ', name)

  path = sprintf('antivirals/pdbqt/%s.pdbqt', name)
  if(!file.exists(path)){
    path = generate_ligand_pdbqt(smiles, name, out_dir = 'antivirals/pdbqt')
  }else{
    if(length(readLines(path)) == 0){
      path = generate_ligand_pdbqt(smiles, name, out_dir = 'antivirals/pdbqt')
    }else{
      message('-- skipping generate pdbqt - pdbqt file already exists')
    }
  }
  
  fout = sprintf('antivirals/docked/docked_%s', basename(path))
  if(file.exists(fout)){
    message('-- skipping ', name)
    return(NULL)
  }

  prop = system(paste('/home/omar/.conda/envs/dock/bin/obprop', path), intern=T)
  mw = prop[grepl('mol_weight', prop)]
  mw = as.numeric(gsub('mol_weight\\s+', '', mw))

  if(is.na(mw) | mw > 500){
    message('-- skipping too large')
    return(NULL)
  }

  run_docking( path, exhaustiveness = 10, cores = 40, active_site = T, 
               dock_dir = 'antivirals/docked', log_dir = 'antivirals/logs' )
  
}, mc.cores = 1)
  