FROM winsent/geoserver:2.10-beta 
MAINTAINER Victor Maus <maus@iiasa.ac.at>

ENV GEOGIG_VERSION="1.0-RC3"
ENV GEOGIG_PLUGIN_VERSION="2.9"

RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
                    postgresql-client postgis &&\
    rm -rf /var/lib/apt/lists/*

# install GeoGig 
RUN wget -c https://github.com/locationtech/geogig/releases/download/${GEOGIG_VERSION}/geogig-${GEOGIG_VERSION}.zip -O ~/geogig.zip &&\
    unzip -o ~/geogig.zip -d /opt/ &&\
    echo "PATH=\$PATH:/opt/geogig/bin" >> ~/.bashrc &&\ 
    rm ~/geogig.zip

# Get Geogig plugin 
RUN wget -c https://github.com/locationtech/geogig/releases/download/${GEOGIG_VERSION}/geoserver-${GEOGIG_PLUGIN_VERSION}-geogig-plugin.zip -O ~/geoserver-geogig-plugin.zip &&\
    unzip -o ~/geoserver-geogig-plugin.zip -d /opt/geoserver/webapps/geoserver/WEB-INF/lib/ && \
    rm ~/geoserver-geogig-plugin.zip

# Get JDBC Image Mosaic plugin
RUN wget -c http://downloads.sourceforge.net/project/geoserver/GeoServer/$GEOSERVER_VERSION/extensions/geoserver-$GEOSERVER_VERSION-imagemosaic-jdbc-plugin.zip -O ~/geoserver-imagemosaic-jdbc-plugin.zip &&\
    unzip -o ~/geoserver-imagemosaic-jdbc-plugin.zip -d /opt/geoserver/webapps/geoserver/WEB-INF/lib/ && \
    rm ~/geoserver-imagemosaic-jdbc-plugin.zip

ENV PATH /opt/geogig/bin:$PATH

EXPOSE 8080
CMD ["/opt/geoserver/bin/startup.sh"]

