setwd('~/Development/docking/covid19/')

OBABEL = '/Users/omarwagih/miniconda2/envs/dock/bin/obabel'
VINA = '~/Development/docking/autodock_vina_1_1_2_mac_catalina_64bit/bin/vina'


generate_ligand_pdbqt <- function(smiles_string, name, out_dir='ligands'){
  # Get paths
  smiles_path = sprintf('%s/%s.smi', out_dir, name)
  pdbqt_path = sprintf('%s/%s.pdbqt', out_dir, name)
  
  # Generate pdbqt
  writeLines(smiles_string, smiles_path)
  system(sprintf('%s %s --gen3d -O %s', OBABEL, smiles_path, pdbqt_path))
  # Delete smiles file
  unlink(smiles_path)
  
  # Return path to pdbqt
  return(pdbqt_path)
}


run_docking <- function(ligand_path, exhaustiveness=10, active_site=T, cores=6, dock_dir='docked_ligands', log_dir='logs'){
  
  fout = sprintf('%s/docked_%s', dock_dir, basename(ligand_path))
  log_out = sprintf('%s/%s.log', log_dir, basename(ligand_path))
  protein_path = 'protein_6yb7.pdbqt'
  
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
}


