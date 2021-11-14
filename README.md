# docker-isc-dhcp-glass-alpine
reverse build from djaydev/glass-isc-dhcp (with help from jnovack/docker-dhcpd) wich seems not to be available anymore...

# example use
```
version: '3.3'
services:
    glass-isc-dhcp:
        container_name: glass-isc-dhcp
        network_mode: host
        environment:
            - TZ=Europe/Berlin
        volumes:
            - /opt/docker/glass-isc-dhcp/config:/opt/glass-isc-dhcp/config:rw
            - /opt/docker/glass-isc-dhcp/data:/etc/dhcp:rw
            - /opt/docker/glass-isc-dhcp/data/leases:/var/lib/dhcp:rw
            - /opt/docker/glass-isc-dhcp/logs:/var/log:rw
            - /opt/docker/glass-isc-dhcp/data/config_backups:/opt/glass-isc-dhcp/config_backups:rw
        image: kubax/glass-isc-dhcp:latest
        restart: always
```

# Thanks
- djaydev
- jnovack
