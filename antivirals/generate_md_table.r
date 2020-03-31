setwd('~/Development/docking/covid19-docking/antivirals/')
require(data.table)
require(ggpubr)
x = list.files('logs/', full.names = T)


df = rbindlist(lapply(x, function(file){
  z = readLines(file)
  sp = strsplit(grep('^1 ', trimws(z), value = T), '\\s+')
  if(length(sp) == 0) return(NULL)
  v = sp[[1]][2]
  v = as.numeric(v)
  data.table(file = basename(file), value=v)
}))

df$cid = as.numeric(gsub('\\..*', '', df$file))

x = fread('PubChem_compound_list.csv')[,c('cid', 'cmpdname')]
m = merge(df, x, by='cid')
m = m[order(value)]

p = gghistogram(m, 'value', bins = 50, fill='#333333', color='white') + grids(color='#eeeeee') + 
  xlab('Affinity kcal/mol') + ylab('Count') +
  ggtitle('Distribution of antiviral compounds')
#print(p)


tab = m[,c('cmpdname', 'cid', 'value')]

# Write table
tmp = tab
names(tmp) = c('Compound', 'PubChem ID', 'Affinity')
write.csv(tmp, 'antiviral_docking_affinity_results.csv', row.names=F)

tab$cid = sprintf('[%s](https://pubchem.ncbi.nlm.nih.gov/compound/%s)', tab$cid, tab$cid)
ind = nchar(tab$cmpdname) > 80
tab$cmpdname[ind] = paste0(substring(tab$cmpdname[ind], 1, 77), '...')
names(tab) = c('Compound', 'PubChem ID', 'Affinity')


ggsave('images/hist_antiviral.png', p)

writeLines(knitr::kable(head(tab, 20)), 'images/top20.md')
