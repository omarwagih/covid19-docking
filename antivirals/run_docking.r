setwd('~/Development/docking/covid19-docking/')

require(data.table)
require(parallel)
source('scripts/dock_helpers.r')

# J05 - Antivirals for systemic use
# WHO ATC ATC 
df = fread('antivirals/1489656498827507994.txt')





x = mclapply(1:nrow(df), function(i){
  name = df$V1[i]
  smiles = df$V2[i]
  message('### ', name)

  ## Check if PDBQT file was already generated 
  path = sprintf('antivirals/pdbqt/%s.pdbqt', name)
  if(!file.exists(path)){
    path = generate_ligand_pdbqt(smiles, name, out_dir = 'antivirals/pdbqt')
  }else{
    message('-- skipping generate pdbqt - pdbqt file already exists')
    path = generate_ligand_pdbqt(smiles, name, out_dir = 'antivirals/pdbqt')
  }
  
  if(length(readLines(path)) == 0){
    message('-- skipping empty')
    return(NULL)
  }
  
  ## Check if it was already docked 
  fout = sprintf('antivirals/docked/docked_%s', basename(path))
  if(file.exists(fout)){
    message('-- skipping ', name)
    return(NULL)
  }

  ## Skip high mwt compounds
  mw = get_mwt(path)
  if(is.na(mw) | mw > 500){
    message('-- skipping too large')
    return(NULL)
  }
  

  run_docking( path, exhaustiveness = 10, cores = 10, active_site = T,
               dock_dir = 'antivirals/docked', log_dir = 'antivirals/logs' )
  
}, mc.cores = 1)




if(F){
  fi = list.files('antivirals/pdbqt/', '*.pdbqt', full.names = T)
  mwt = sapply(fi, function(path){
    message(basename(path))
    get_mwt(path)
  })
  names(mwt) = gsub('.pdbqt', '', basename(fi))
}



