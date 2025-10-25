```bash 
sudo docker run -it   --name nam-sim   --env DISPLAY=$DISPLAY   --env XAUTHORITY=$XAUTHORITY   --volume /tmp/.X11-unix:/tmp/.X11-unix   --volume "$HOME/.Xauthority:/root/.Xauthority:rw"   nam-sim
```

start it again with:
```bash
sudo docker start -ai nam-sim
```

```bash
apt update && apt install nano
```
