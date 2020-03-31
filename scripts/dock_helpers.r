
OBABEL = c('/Users/omarwagih/miniconda2/envs/dock/bin/obabel', 
           '/home/omar/.conda/envs/dock/bin/obabel')
OBABEL = OBABEL[file.exists(OBABEL)][1]

VINA = c('~/Development/docking/autodock_vina_1_1_2_mac_catalina_64bit/bin/vina',
         '/home/omar/.conda/envs/dock/bin/vina')
VINA = VINA[file.exists(VINA)][1]

OBPROP = c('/home/omar/.conda/envs/dock/bin/obprop', 
           '/Users/omarwagih/miniconda2/envs/dock/bin/obprop')
OBPROP = OBPROP[file.exists(OBPROP)][1]

generate_ligand_pdbqt <- function(smiles_string, name, out_dir='ligands'){
  # Get paths
  smiles_path = sprintf('%s/%s.smi', out_dir, name)
  pdbqt_path = sprintf('%s/%s.pdbqt', out_dir, name)
  
  # Generate pdbqt
  writeLines(smiles_string, smiles_path)
  msg = system(sprintf('%s %s --gen3d -O %s 2>&1', OBABEL, smiles_path, pdbqt_path), intern = T, ignore.stderr = F)
  
  # Delete smiles file
  unlink(smiles_path)
  
  if(any(grepl('Stereochemistry is wrong', msg)) | any(grepl('Segmentation fault', msg))){
    unlink(pdbqt_path)
    message('-- stereochemistry is wrong, returning NA')
    return(NA)
  }
  
  if(file.info(pdbqt_path)$size == 0){
    unlink(pdbqt_path)
    message('-- empty pdbqt file')
    return(NA)
  }
  
  # Return path to pdbqt
  return(pdbqt_path)
}


run_docking <- function(ligand_path, exhaustiveness=10, active_site=T, cores=6, dock_dir='docked_ligands', log_dir='logs'){
  
  fout = sprintf('%s/docked_%s', dock_dir, basename(ligand_path))
  log_out = sprintf('%s/%s.log', log_dir, basename(ligand_path))
  protein_path = 'protein/protein_6yb7.pdbqt'
  
  print(fout)
  if(active_site){
    cmd = sprintf('%s --receptor %s --ligand %s --out %s --log %s --cpu %s --seed 1 --center_x 10.568 --center_y -1.892 --center_z 21.485 --size_x 20 --size_y 18 --size_z 18 --exhaustiveness %s',
                  VINA, protein_path, ligand_path, fout, log_out, cores, exhaustiveness)
  }else{
    cmd = sprintf('%s --receptor %s --ligand %s --out %s --log %s --cpu %s --seed 1 --center_x 11.748 --center_y 0.681 --center_z 4.364 --size_x 40 --size_y 76 --size_z 70 --exhaustiveness %s',
                  VINA, protein_path, ligand_path, fout, log_out, cores, exhaustiveness)
  }
  
  print(cmd)
  system(cmd)
  
  if(file.info(fout)$size == 0){
    unlink(fout)
    message('-- empty docked pdbqt file')
    return(NA)
  }
}


get_mwt <- function(path){
  prop = system(paste(OBPROP, path), intern=T)
  mw = prop[grepl('mol_weight', prop)]
  mw = as.numeric(gsub('mol_weight\\s+', '', mw))
  if(length(mw) == 0) return(NA)
  return(mw)
}


get_mwt_smiles <- function(smiles){
  smi = tempfile('smiles', fileext = '.smi')
  writeLines(smiles, smi)
  return(get_mwt(smi))
}





