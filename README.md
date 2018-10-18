# docker-android

Android Docker image, based on the Bitrise Base Docker
image ( https://github.com/bitrise-docker/android / `bitriseio/docker-bitrise-base` ),
and extends it with pre-installed Android tools/setup.

This docker image is pre-cached on the related [bitrise.io](https://www.bitrise.io)
Virtual Machines.

**If you'd like to add a tool** to be pre-installed you can create a
Pull Request, adding your changes to the `Dockerfile` of this repository.
*Please also add* a related test/report to the `system_report.sh` file,
which is used to test & list the pre-installed tools.

When a new version of this stack is available on [bitrise.io](https://www.bitrise.io)
we'll run `system_report.sh` and post the result into
the [bitrise.io GitHub repository](https://github.com/bitrise-io/bitrise.io), under the `system_reports` folder. The `system_report.sh` script can be run with `docker-compose` locally too,
with: `docker-compose run --rm app bash system_report.sh`.

[Request a feature](https://discuss.bitrise.io/c/feature-request)

[Report an issue](https://discuss.bitrise.io/c/issues/other-issues)

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
