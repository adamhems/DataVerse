FROM ubuntu

RUN apt-get update
RUN apt-get install -y wget
RUN mkdir dataverse
RUN apt-get install -y unzip
WORKDIR dataverse
RUN wget http://downloads.sourceforge.net/project/dvn/dvn/3.6.2/dvninstall_v3_6_2.zip
RUN unzip dvninstall_v3_6_2.zip
WORKDIR dvninstall
RUN chmod +x install

# Get mail server and start it
RUN apt-get install -y sendmail
RUN service sendmail restart

# Get PostgreSQL and start it
RUN apt-get install -y postgresql
RUN service postgresql restart

# Now for GlassFish...
RUN adduser --home /home/glassfish --system --shell /bin/bash glassfish
RUN groupadd glassfishadm

#add your users that shall be Glassfish adminstrators
#RUN usermod -a -G glassfishadm $myAdminUser


# get and install java
RUN mkdir downloads

WORKDIR downloads
RUN wget http://dataverse.azurewebsites.net/jdk-8u40-linux-x64.tar.gz
RUN tar -xvf jdk-8u40-linux-x64.tar.gz

#make sure our destination folder exists
RUN mkdir /usr/lib/jvm
#move extracted files
RUN mv ./jdk1.8.0_40 /usr/lib/jvm/jdk1.8.0
RUN chgrp -R root /usr/lib/jvm/jdk1.8.0

RUN chown -R root /usr/lib/jvm/jdk1.8.0

#update alternatives...
RUN update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0/bin/java" 1
RUN update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0/bin/javac" 1
RUN update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.8.0/bin/javaws" 1
RUN update-alternatives --config java

RUN mkdir /usr/lib/jvm/jdk1.8.0/bin/apt
RUN update-alternatives --install "/usr/bin/apt" "apt" "/usr/lib/jvm/jdk1.8.0/bin/apt" 1
RUN update-alternatives --install "/usr/bin/idlj" "idlj" "/usr/lib/jvm/jdk1.8.0/bin/idlj" 1
RUN update-alternatives --install "/usr/bin/jarsigner" "jarsigner" "/usr/lib/jvm/jdk1.8.0/bin/jarsigner" 1
RUN update-alternatives --install "/usr/bin/java-rmi.cgi" "java-rmi.cgi" "/usr/lib/jvm/jdk1.8.0/bin/java-rmi.cgi" 1
RUN update-alternatives --install "/usr/bin/javadoc" "javadoc" "/usr/lib/jvm/jdk1.8.0/bin/javadoc" 1
RUN update-alternatives --install "/usr/bin/javah" "javah" "/usr/lib/jvm/jdk1.8.0/bin/javah" 1
RUN update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.8.0/bin/javaws" 1
RUN update-alternatives --install "/usr/bin/jconsole" "jconsole" "/usr/lib/jvm/jdk1.8.0/bin/jconsole" 1
RUN update-alternatives --install "/usr/bin/jdb" "jdb" "/usr/lib/jvm/jdk1.8.0/bin/jdb" 1
RUN update-alternatives --install "/usr/bin/jinfo" "jinfo" "/usr/lib/jvm/jdk1.8.0/bin/jinfo" 1
RUN update-alternatives --install "/usr/bin/jps" "jps" "/usr/lib/jvm/jdk1.8.0/bin/jps" 1
RUN update-alternatives --install "/usr/bin/jsadebugd" "jsadebugd" "/usr/lib/jvm/jdk1.8.0/bin/jsadebugd" 1
RUN update-alternatives --install "/usr/bin/jstat" "jstat" "/usr/lib/jvm/jdk1.8.0/bin/jstat" 1
RUN update-alternatives --install "/usr/bin/jvisualvm" "jvisualvm" "/usr/lib/jvm/jdk1.8.0/bin/jvisualvm" 1
RUN update-alternatives --install "/usr/bin/native2ascii" "native2ascii" "/usr/lib/jvm/jdk1.8.0/bin/native2ascii" 1
RUN update-alternatives --install "/usr/bin/pack200" "pack200" "/usr/lib/jvm/jdk1.8.0/bin/pack200" 1
RUN update-alternatives --install "/usr/bin/rmic" "rmic" "/usr/lib/jvm/jdk1.8.0/bin/rmic" 1
RUN update-alternatives --install "/usr/bin/rmiregistry" "rmiregistry" "/usr/lib/jvm/jdk1.8.0/bin/rmiregistry" 1
RUN update-alternatives --install "/usr/bin/serialver" "serialver" "/usr/lib/jvm/jdk1.8.0/bin/serialver" 1
RUN update-alternatives --install "/usr/bin/tnameserv" "tnameserv" "/usr/lib/jvm/jdk1.8.0/bin/tnameserv" 1
RUN update-alternatives --install "/usr/bin/wsgen" "wsgen" "/usr/lib/jvm/jdk1.8.0/bin/wsgen" 1
RUN update-alternatives --install "/usr/bin/xjc" "xjc" "/usr/lib/jvm/jdk1.8.0/bin/xjc" 1
RUN update-alternatives --install "/usr/bin/appletviewer" "appletviewer" "/usr/lib/jvm/jdk1.8.0/bin/appletviewer" 1
RUN update-alternatives --install "/usr/bin/extcheck" "extcheck" "/usr/lib/jvm/jdk1.8.0/bin/extcheck" 1
RUN update-alternatives --install "/usr/bin/jar" "jar" "/usr/lib/jvm/jdk1.8.0/bin/jar" 1
RUN update-alternatives --install "/usr/bin/javafxpackager" "javafxpackager" "/usr/lib/jvm/jdk1.8.0/bin/javafxpackager" 1
RUN update-alternatives --install "/usr/bin/javap" "javap" "/usr/lib/jvm/jdk1.8.0/bin/javap" 1
RUN update-alternatives --install "/usr/bin/jcmd" "jcmd" "/usr/lib/jvm/jdk1.8.0/bin/jcmd" 1
RUN update-alternatives --install "/usr/bin/jcontrol" "jcontrol" "/usr/lib/jvm/jdk1.8.0/bin/jcontrol" 1
RUN update-alternatives --install "/usr/bin/jhat" "jhat" "/usr/lib/jvm/jdk1.8.0/bin/jhat" 1
RUN update-alternatives --install "/usr/bin/jmap" "jmap" "/usr/lib/jvm/jdk1.8.0/bin/jmap" 1
RUN update-alternatives --install "/usr/bin/jrunscript" "jrunscript" "/usr/lib/jvm/jdk1.8.0/bin/jrunscript" 1
RUN update-alternatives --install "/usr/bin/jstack" "jstack" "/usr/lib/jvm/jdk1.8.0/bin/jstack" 1
RUN update-alternatives --install "/usr/bin/jstatd" "jstatd" "/usr/lib/jvm/jdk1.8.0/bin/jstatd" 1
RUN update-alternatives --install "/usr/bin/keytool" "keytool" "/usr/lib/jvm/jdk1.8.0/bin/keytool" 1
RUN update-alternatives --install "/usr/bin/orbd" "orbd" "/usr/lib/jvm/jdk1.8.0/bin/orbd" 1
RUN update-alternatives --install "/usr/bin/policytool" "policytool" "/usr/lib/jvm/jdk1.8.0/bin/policytool" 1
RUN update-alternatives --install "/usr/bin/rmid" "rmid" "/usr/lib/jvm/jdk1.8.0/bin/rmid" 1
RUN update-alternatives --install "/usr/bin/schemagen" "schemagen" "/usr/lib/jvm/jdk1.8.0/bin/schemagen" 1
RUN update-alternatives --install "/usr/bin/servertool" "servertool" "/usr/lib/jvm/jdk1.8.0/bin/servertool" 1
RUN update-alternatives --install "/usr/bin/unpack200" "unpack200" "/usr/lib/jvm/jdk1.8.0/bin/unpack200" 1
RUN update-alternatives --install "/usr/bin/wsimport" "wsimport" "/usr/lib/jvm/jdk1.8.0/bin/wsimport" 1
RUN update-alternatives --config java

RUN AS_JAVA=/usr/lib/jvm/jdk1.8.0

#now switch user to the glassfish user we created
RUN su glassfish

#change to home dir of glassfish
WORKDIR /home/glassfish/

#create new directory if not already available
RUN mkdir downloads

#go to the directory we created
WORKDIR /home/glassfish/downloads/

#download Glassfish and unzip
RUN wget http://dlc.sun.com.edgesuite.net/glassfish/4.1/release/glassfish-4.1.zip
RUN unzip glassfish-4.1.zip

#move the relevant content to home directory
RUN cp -r /home/glassfish/downloads/glassfish4/* /home/glassfish/
RUN exit

#change group of glassfish home directory to glassfishadm
RUN chgrp -R glassfishadm /home/glassfish

#just to make sure: change owner of glassfish home directory to glassfish
RUN chown -R glassfish /home/glassfish

#make sure the relevant files are executable/modifyable/readable for owner and group
RUN chmod -R ug+rwx /home/glassfish/bin/
RUN chmod -R ug+rwx /home/glassfish/glassfish/bin/

#others are not allowed to execute/modify/read them
RUN chmod -R o-rwx /home/glassfish/bin/
RUN chmod -R o-rwx /home/glassfish/glassfish/bin/
#now switch user to the glassfish user
RUN su glassfish

#start glassfish
RUN /home/glassfish/bin/asadmin start-domain domain1

#Need to Install R and also Solr I think. Please add Commands here:

# Finall we have all pre-req's installed on an Ubuntu base image in our Docker container. Start the Dataverse installer. Is there a way to script this?!?!
WORKDIR dataverse
CMD RUN ./install
