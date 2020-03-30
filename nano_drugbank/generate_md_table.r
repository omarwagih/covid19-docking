setwd('~/Development/docking/covid19-docking/nano_drugbank/')
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

df$drugbank_id = gsub('\\..*', '', df$file)

x = fread('df_drugbank_smiles.csv')[,c('drugbank_id', 'name')]
m = merge(df, x, by='drugbank_id')
m = m[order(value)]

q = subset(m, name == 'Quercetin')
p = gghistogram(subset(m, value <0), 'value', bins = 50, fill='#333333', color='white') + grids(color='#eeeeee') + 
  xlab('Affinity kcal/mol') + ylab('Count') + geom_vline(xintercept = q$value, linetype=2, color='red') + 
  ggtitle('Distribution of affinity values for DrugBank subset compounds')
#print(p)


tab = m[,c('name', 'drugbank_id', 'value')]

# Write table
tmp = tab
names(tmp) = c('Compound', 'DrugBank ID', 'Affinity')
write.csv(tmp, 'drugbank_docking_affinity_results.csv', row.names=F)

tab$drugbank_id = sprintf('[%s](https://www.drugbank.ca/drugs/%s)', tab$drugbank_id, tab$drugbank_id)
ind = nchar(tab$name) > 80
tab$name[ind] = paste0(substring(tab$name[ind], 1, 77), '...')
names(tab) = c('Compound', 'DrugBank ID', 'Affinity')


ggsave('images/hist_drugbank.png', p)

writeLines(knitr::kable(head(tab, 20)), 'images/top20.md')
