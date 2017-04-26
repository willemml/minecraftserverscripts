#!/bin/sh

. /etc/rc.subr

name=blazemc
rcvar=blazemc_enable
minecraftdir=/minecraft/blazemc/
spigotdl=https://cdn.getbukkit.org/spigot/spigot-1.11.2.jar
bungeedl=http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar

start_cmd="${name}_start"
stop_cmd="${name}_stop"
restart_cmd="${name}_restart"

load_rc_config $name
: ${blazemc_enable:=no} 
: ${blazemc_msg="Nothing started."}

blazemc_start()
{
	echo "Servers starting..."	

    cd ${minecraftdir}bungee
    rm BungeeCord.jar
    wget ${bungeedl}
    clear
    screen -dmS "bungee" java -Dmybungee -Xmx500M -Xms500M -jar BungeeCord.jar
    clear

    cd ${minecraftdir}hub
#    rm spigot-1.11.2.jar
#    wget ${spigotdl}
    clear   
    screen -dmS "hub" java -Dmyhub -Xmx4000M -Xms4000M -jar spigot-1.11.2.jar
    clear

    cd ${minecraftdir}survival
#    rm spigot-1.11.2.jar
#    wget ${spigotdl}
    clear 
    screen -dmS "survival" java -Dmysurvival -Xmx4000M -Xms4000M -jar spigot-1.11.2.jar
    clear

    cd ${minecraftdir}bedwars
#    rm spigot-1.11.2.jar
#    wget ${spigotdl}
    clear 
    screen -dmS "bedwars" java -Dmybedwars -Xmx4000M -Xms4000M -jar spigot-1.11.2.jar
    clear

    cd ${minecraftdir}bending
#    rm spigot-1.11.2.jar
#    wget ${spigotdl} 
    clear
    screen -dmS "bending" java -Dmybending -Xmx4000M -Xms4000M -jar spigot-1.11.2.jar
    clear

    
    sleep 30
    echo "Servers should be started!"
}

blazemc_stop()
{
    echo "Servers stopping..."
    kill $(ps xa | grep Dmyhub | cut -f1 -d' ' | sed 's/\W//g')
    clear
    kill $(ps xa | grep Dmybungee | cut -f1 -d' ' | sed 's/\W//g')
    clear
    kill $(ps xa | grep Dmybedwars | cut -f1 -d' ' | sed 's/\W//g')
    clear
    kill $(ps xa | grep Dmysurvival | cut -f1 -d' ' | sed 's/\W//g')
    clear
    kill $(ps xa | grep Dmybending | cut -f1 -d' ' | sed 's/\W//g')
    clear
    sleep 2
    echo "Servers stopped."
}

blazemc_restart()
{
    echo "Servers restarting..."
    cd ${minecraftdir}
    ./blazemc.sh stop
    ./blazemc.sh start
    clear
    echo "Servers should be restarted..."
}

run_rc_command "$1"