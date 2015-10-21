# docker-android

Android Docker image, based on `bitriseio/docker-bitrise-base`

## docker-compose template

A `docker-compose.yml` is also included, configured for quick testing.

To build the image with `docker-compose` all you have to do is: `docker-compose build`

Then to run `bitrise --version` in the container: `docker-compose run --rm app bitrise --version`

To log into an interactive `bash` shell **inside** the container just run: `docker-compose run --rm app /bin/bash` - when you want to exit just run `exit` inside the container.

For convenience / experimenting the `./_tmp` folder (which is in `.gitignore`)
will be shared to `/bitrise/tmp`, to make it easy for you to share files
with the container.

Every time you change your `Dockerfile` you'll have to run `docker-compose build` again,
so your next `docker-compose run` will run in the environment you specify in
the `Dockerfile`.
