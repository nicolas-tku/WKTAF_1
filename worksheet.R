install.packages('icesTAF')
install.packages('stockassessment', repos = 'https://fishfollower.r-universe.dev')
install.packages('cat3advice', repos = 'https://ices-tools-prod.r-universe.dev')
library(gitcreds)
update.packages(checkBuilt = TRUE, ask = FALSE)

library(icesTAF)
taf.skeleton() #generates data, model, output and report files

mkdir("data") #generates directories

icesTAF::dir.tree() #directory tree

data(trees)

draft.data(
  data.files = "trees.csv",
  data.scripts = NULL,
  originator = "Ryan, T. A., Joiner, B. L. and Ryan, B. F. (1976) The Minitab Student Handbook. Duxbury Press.",
  title = "Diameter, Height and Volume for Black Cherry Trees",
  file = TRUE, # if true, creates a DATA.bib
  append = FALSE # create a new DATA.bib
)
?trees #now has a reference

taf.boot() #error, file does not exist

write.taf(trees, dir = "boot/initial/data") #the csv appears there

taf.boot() #now it works

data(trees)
data(cars)
# make the directory we want to write to
mkdir("boot/initial/data/my-collection")
# save files there
write.taf(trees, dir = "boot/initial/data/my-collection")
write.taf(cars, dir = "boot/initial/data/my-collection")

draft.data(
  data.files = "my-collection",
  data.scripts = NULL,
  originator = "R datasets package",
  title = "Collection of R data",
  source = "folder",
  file = TRUE,
  append = TRUE # create a new DATA.bib
)
taf.boot()

draft.data(
  data.files = "HadSST.4.0.1.0_median.nc",
  data.scripts = NULL,
  originator = "UK MET office",
  title = "Met Office Hadley Centre observations datasets",
  year = 2022,
  source = "https://www.metoffice.gov.uk/hadobs/hadsst4/data/netcdf/HadSST.4.0.1.0_median.nc",
  file = FALSE,
  append = TRUE
)

#the following doesn't work but the explanation went too fast. check the video 
# afterwards. seems like it works with the downloaded zip
cat('library(icesTAF) 
library(sf)

download(
  "https://gis.ices.dk/shapefiles/OSPAR_Subregions.zip"
)

unzip("OSPAR_Subregions.zip")
unlink("OSPAR_Subregions.zip")

areas <- st_read("OSPAR_subregions_20160418_3857.shp")

# write as csv
st_write(
  areas, "ospar-areas.csv",
  layer_options = "GEOMETRY=AS_WKT"
)

unlink(dir(pattern = "OSPAR_subregions_20160418_3857"))
',
file = "bootstrap/ospar-areas.R")

library(sf)
unzip("OSPAR_Subregions.zip")
unlink("OSPAR_Subregions.zip")
areas <- st_read("OSPAR_subregions_20160418_3857.shp") 
#write as csv
st_write(
  areas, "ospar-areas.csv",
  layer_options = "GEOMETRY=AS_WKT"
)
unlink(dir(pattern = "OSPAR_subregions_20160418_3857"))
  file = "boot/ospar-areas.R" #works until here but I don't see where this one is written. 
                              #try to catch up from the recording.









install.deps("boot")
###########################
library(icesSD)

sd <- getSD(year = 2022)

write.taf(sd, quote = TRUE)
