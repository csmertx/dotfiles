sudo docker run -d \
--volume /home/$USER/.config/jellyfin/config:/config \
--volume /home/$USER/.config/jellyfin/cache:/cache \
--volume /mnt/Storage/Videos:/data/videos \
--volume /mnt/Storage/Music:/data/music \
--volume /mnt/Storage/Pictures:/data/pictures \
--user 1000:1000 \
--net=host \
--restart=unless-stopped \
jellyfin/jellyfin
