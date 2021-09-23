# diffimg container
* This image provides DiffImg command to compare two different images.

	    ```shell
$ docker build . -t mtagu:diffimg
		```

## How to use
* This command uses X11, so you have to config your X server to connect from container.
    + Easy going , but it not secure.
	
```shell
$ xhost +
$ docker run -e DISPLAY  -v .:/work  mtagu:diffimg 
```
    + 
