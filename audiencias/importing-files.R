### Load all PACKAGES

lapply(c("data.table","stringr","tidyverse","rio","here","intergraph","igraph"), require, character.only=TRUE)

### Make a list of all CSV files in specified path
file.list  <-  list.files(path="p:/r-Projects/aportes/audiencias",pattern="*.csv",full.names=TRUE)
file.names  <- file.list %>% str_replace_all(c(".csv"="", "p:/r-Projects/aportes/audiencias/"=""," "="_"))

### Make a for loop to read each data file and recover list of individual dataframes
dat.ind  <-  list()
for(x in unique(file.list)){
    dat.ind[[x]]  <- fread(x,header=TRUE,colClasses="character",encoding="UTF-8")
}
dat.ind <- dat.ind %>% set_names(file.names)
invisible(list2env(dat.ind,.GlobalEnv))
ls()
dat  <- do.call(rbind,dat.ind)

dat.ind  <-  list()
for(x in unique(file.list)){
    dat.ind[[x]]  <- import(x,header=TRUE,encoding="Latin-1")
}
dat.ind <- dat.ind %>% set_names(file.names)
invisible(list2env(dat.ind,.GlobalEnv))
ls()
dat  <- do.call(rbind,dat.ind)



### Import pre-2016 data

dat0  <- import(here("input_data","audiencias_viejo.xlsx")

export(head(dat0,20),here("output","audiencias_viejo_sample_structure.xlsx"))
export(head(dat,20),here("output","audiencias_nuevo_sample_structure.xlsx"))


### Tidy up data
levels(as.factor(dat$sujeto_obligado_nombre))
dat$sujeto_obligado_nombre  <- str_replace(dat$sujeto_obligado_nombre,",","")
dat$solicitante_nombre  <- str_replace(dat$solicitante_nombre,",","")


### Work with network data

dat.try  <- dat[,c(12,19)]

net  <- graph_from_data_frame(dat.try,directed=FALSE)
V(net)
vcount(net)
E(net)
ecount(net)

out  <- degree(net,mode=c("out"))
table(out)
which.max(out)

net.2  <- subgraph.edges(net,150:200)
net.3  <- subgraph.edges(net,c("105","120"))
net.4  <- subgraph.edges(net,c('Mauricio Macri'),c('Guillermo Dietrich'))

plot(net.2,
     vertex.label.color = "black",
     edge.color = 'blue',
     vertex.size = 5,
     edge.arrow.size = 1,
     layout = layout.fruchterman.reingold,main="fruchterman.reingold")

plot(net.2,
     vertex.label.color = "black",
     edge.color = 'blue',
     vertex.size = 5,
     edge.arrow.size = 1,
     layout = layout.random,main="random")

plot(net.2,
     vertex.label.color = "black",
     edge.color = 'blue',
     vertex.size = 5,
     edge.arrow.size = 1,
     layout = layout.sphere,main="sphere")

net.1  <- fastgreedy.community(net.1)

### Other method to do that but NEEDS VERY TIDY DATA (DPLYR)
df  <- list.files(path="/r-Projects/aportes/audiencias") %>%
    lapply(fread) %>%
    bind_rows


hist  <-  fread("audiencias-historico.csv",header=TRUE)

