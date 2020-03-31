setwd('~/docking/covid19-docking/')

require(data.table)
require(parallel)
source('scripts/dock_helpers.r')
df = fread('quercetin/smiles.txt')

mclapply(1:nrow(df), function(i){
  name = df$V1[i]
  smiles = df$V2[i]
  path = generate_ligand_pdbqt(smiles, name, out_dir = 'quercetin/pdbqt')
  
  
  if(is.na(path)){
    unlink(sprintf('nano_drugbank/pdbqt/%s.pdbqt', name))
    unlink(sprintf('nano_drugbank/docked/docked_%s.pdbqt', name))
    unlink(sprintf('nano_drugbank/logs/%s.pdbqt.log', name))
    return(NULL)
  }
  
  return(NULL)
  
  
  fout = sprintf('quercetin/docked/docked_%s', basename(path))
  if(file.exists(fout)){
    message('-- skipping ', name)
    return(NULL)
  }
  
  
  mwt = get_mwt(path)
  if(!is.na(mwt) | mwt > 500){
    message('-- too large')
    return(NULL)
  }
  
  run_docking( path, exhaustiveness = 10, cores = 1, active_site = T, 
               dock_dir = 'quercetin/docked', log_dir = 'quercetin/logs' )
  
}, mc.cores = 40)
