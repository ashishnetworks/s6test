This is a simple experiment repo on difference between `s6-overlay` signals handling and `tini` signal handling. I have added both `s6` and `tini` as part of docker image. I will request you to create two docker images

 1. Clone this repo locally and go to repo directory locally
 2. Create first docker image no changes are needed,
     - Run following command
` docker build --no-cache . -t test:s6`

 3. For second image
	 - Just make one slight change in `Dockerfile`, replace the `entrypoint` command with `/tini` in place of `/init`
	 - Create another docker image with following command: `docker build --no-cache . -t test:tini`

Now run both the above images and try to kill each of them with following command
- Container starting command

    docker run -it tests:s6

 - Container Killing command

     docker kill --signal="SIGINT" <containerIdHere>

Observations
1. For first image, where s6 was used as entry point, we will see, two SIGNALS are received. First SIGHUP and next one is SIGTERM
2. For second image where tini was used as entry point, we will see, expected single SIGNAL is received i.e SIGINT

> Question here is why are we receiving two signals for single signal
> sent to the container??




