require(bio3d)
setwd('~/Development/docking/covid19-docking/nano_drugbank/')

fi = list.files('pdbqt/', 'pdbqt', full.names = T)

print(length(fi))
for(x in fi){
  if(file.info(x)$size == 0) unlink(x)
}
fi = list.files('pdbqt', 'pdbqt', full.names = T)
print(length(fi))

# Read PSBs
all = lapply(fi, function(x){  read.pdb(x)$atom })
az = sapply(all, function(pdb){  all(pdb$x == 0) })

message(paste(sum(az)))

raw = fi[az]
id = gsub('.pdbqt', '', basename(raw))
docked = sprintf('docked/docked_%s.pdbqt', id)
log = sprintf('logs/%s.pdbqt.log', id)
unlink(raw)
unlink(docked)
unlink(log)

stop('done')


pp = gsub('.pdbqt', '', list.files('pdbqt', 'pdbqt', full.names = F))
ll = gsub('.pdbqt.log', '', list.files('logs/', '.log', full.names = F))
dd = gsub('docked_|.pdbqt', '', list.files('docked', 'pdbqt', full.names = F))
