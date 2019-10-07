### Pull Request Checklist

Check/accept these:

- [ ] The tool I added is stable, and __does not require frequent updates__. _Preinstalled tools on the LTS stacks
  are not updated, so if the tool requires frequent updates you should handle the installation on-demand (see: [Install Any Additional Tool - DevCenter](https://bitrise-io.github.io/devcenter/tips-and-tricks/install-additional-tools/) for more information)_
- [ ] I've updated the version in the Dockerfile
- [ ] I've updated the CHANGELOG.md
- [ ] I've provided a link or explanation below which describes the changes in the tool itself
- [ ] I added a version report line to [`system_report.sh`](/system_report.sh) for the new tool(s) I added

`Copy or link the tool's changelog here`
