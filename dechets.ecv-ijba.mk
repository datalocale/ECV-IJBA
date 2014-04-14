#!/usr/bin/env make
# DESCRIPTION
#   Extract Chinese articles title from French articles
#
# USAGE
#   cd ~/cfdict/resources/script/wikipedia/ && make -f wikipedia.makefile
#
# @author: Édouard Lopez <dev+cfdict@edouard-lopez.com>

ifneq (,)
This makefile requires GNU Make.
endif

# force use of Bash
# SHELL := /bin/bash


# function
today=$(shell date '+%Y-%m-%d')
contours-france=contours-france-EPCI
contours-gironde=contours-gironde-EPCI

# .PHONY: all
# all: france-epci-100m-shp.zip gironde-odt_epci2014-shp.zip

get-contours-france: france-epci-100m-shp.zip
get-contours-gironde: gironde-odt_epci2014-shp.zip

# @alias: get-contours-france
# EPCI de Gironde
# @source: http://catalogue.datalocale.fr/fr/dataset/odt_cg_epci2014
# @format: Shapefile
gironde-%-shp.zip: ${contours-gironde}
	@printf "Fetching...\n\tGironde GIS data\n"
	@curl --output gironde-odt_epci2014-shp.zip http://catalogue.datalocale.fr//fr/storage/f/2014-04-14T153618/odt_epci2014.zip
	unzip gironde-odt_epci2014-shp.zip -d ${contours-gironde}

# @alias: get-contours-france
# EPCI de France
# @source: http://www.data.gouv.fr/fr/dataset/contours-des-epci-2014
# @format: Shapefile
france-%-shp.zip: ${contours-france}
	@printf "Fetching...\n\tFrance GIS data\n"
	@curl --output france-epci-100m-shp.zip http://osm13.openstreetmap.fr/~cquest/openfla/export/epci-20140306-100m-shp.zip
	unzip france-epci-100m-shp.zip -d ${contours-france}


${contours-france}: 
	mkdir ${contours-france}/

${contours-gironde}: 
	mkdir ${contours-gironde}/

install: 
	sudo apt-get install gdal-{bin,contrib}
	sudo npm install -g topojson