#!/bin/sh	

minecraftdir=/minecraft/blazemc/
spigotjar=spigot-1.11.2.jar
bungeecmd=java -Xmx600M -Xms600M -jar -o -Dmybungee BungeeCord.jar
spigotcmd=java -Xmx4000M -Xms4000M -o -jar ${spigotjar}
bungeedl=http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar
spigotdl=https://ci.getbukkit.org/job/Spigot/lastSuccessfulBuild/artifact/spigot-1.11.2.jar

wget ${spigotdl}
wget ${bungeedl}

cd ${minecraftdir}bungee
rm BungeeCord.jar
cp ${minecraftdir}BungeeCord.jar ${minecraftdir}bungee/
${bungeecmd}

cd ${minecraftdir}hub
rm ${spigotjar}
cp ${minecraftdir}${spigotjar} ${minecraftdir}hub/  
${spigotcmd} -Dmyhub

cd ${minecraftdir}survival
rm ${spigotjar}
cp ${minecraftdir}${spigotjar} ${minecraftdir}survival/
${spigotcmd} -Dmysurvival

cd ${minecraftdir}bedwars
rm ${spigotjar}
cp ${minecraftdir}${spigotjar} ${minecraftdir}bedwars/
${spigotcmd} -Dmybedwars

#cd /minecraft/blazemc/bending
#rm spigot-1.11.2.jar
#wget https://ci.getbukkit.org/job/Spigot/lastSuccessfulBuild/artifact/spigot-1.11.2.jar   
#screen -dmS "bending" java -Xmx4000M -Xms4000M -jar spigot-1.11.2.jar
