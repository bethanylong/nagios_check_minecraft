Scripts for checking Minecraft servers and clients with Nagios (NRPE).

Put the scripts in Nagios's plugin directory on the Minecraft server, and ensure the NRPE user (probably `nagios`) can read and execute them.

* Debian: /usr/lib/nagios/plugins/
* FreeBSD: /usr/local/libexec/nagios/

Example:

    # Nagios server (include in nagios.cfg)

    define host {
        use                 generic-host
        host_name           mc
        alias               Minecraft
        address             mc.local
    }

    define service {
        use                 server-service
        name                minecraft-clients-service
        service_description Minecraft Clients
        check_command       check_nrpe_1arg!check_minecraft_clients
        register            0
    }
    define service {
        use                 server-service
        name                minecraft-servers-service
        service_description Minecraft Servers
        check_command       check_nrpe_1arg!check_minecraft_servers
        register            0
    }

    define service {
        use                 minecraft-clients-service
        host_name           mc
    }
    define service {
        use                 minecraft-servers-service
        host_name           mc
    }



    # NRPE client (include in nrpe.cfg)

    command[check_minecraft_clients]=/usr/lib/nagios/plugins/check_minecraft_clients.sh
    command[check_minecraft_servers]=/usr/lib/nagios/plugins/check_minecraft_servers.sh
