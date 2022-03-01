# diffimg container
* This image provides DiffImg command to compare two different images.

* image : https://hub.docker.com/repository/docker/mtagu/diffimg
   based on ubuntu

* Based source from [sandsmark patched](https://github.com/sandsmark/diffimg), not [original source](https://sourceforge.net/projects/diffimg/).


## How to use
* This command uses X11, so you have to config your X server to connect from container.
    + Easy going , but it not secure.
	
```shell
$ xhost +
$ docker run -e DISPLAY="$DISPLAY" -v $HOME/.Xauthority:/root/.Xauthority mtagu/diffimg:latest -v ./a:/diff -w /diff diffimg /diff/a.jpg /diff/b.jpg
```
    
