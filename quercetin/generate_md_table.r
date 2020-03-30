setwd('~/Development/docking/covid19-docking/quercetin/')
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

x = fread('PubChem_compound_text_quercetin.csv')[,c('cid', 'cmpdname')]
m = merge(df, x, by='cid')
m = m[order(value)]

q = subset(m, cmpdname == 'Quercetin')
p = gghistogram(m, 'value', bins = 50, fill='#333333', color='white') + grids(color='#eeeeee') + 
  xlab('Affinity kcal/mol') + ylab('Count') + geom_vline(xintercept = q$value, linetype=2, color='red') + 
  ggtitle('Distribution of affinity values for Quercetin analogues')
#print(p)


tab = m[,c('cmpdname', 'cid', 'value')]

# Write table
tmp = tab
names(tmp) = c('Compound', 'PubChem ID', 'Affinity')
write.csv(tmp, 'quercetin_docking_affinity_results.csv', row.names=F)

tab$cid = sprintf('[%s](https://pubchem.ncbi.nlm.nih.gov/compound/%s)', tab$cid, tab$cid)
ind = nchar(tab$cmpdname) > 80
tab$cmpdname[ind] = paste0(substring(tab$cmpdname[ind], 1, 77), '...')
names(tab) = c('Compound', 'PubChem ID', 'Affinity')


ggsave('images/hist_quercetin.png', p)

writeLines(knitr::kable(head(tab, 20)), 'images/top10.md')
