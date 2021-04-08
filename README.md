<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Deploy Operator Lifecycle Manager](#deploy-operator-lifecycle-manager)
  - [News](#news)
  - [Usage](#usage)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Deploy Operator Lifecycle Manager

## News

This Project use DCO signoff contributors.
* https://github.com/apps/dco/

Please signoff your contributions by doing ONE of the following:
* Use `git commit -s ...` with each commit to add the signoff or
* Manually add a `Signed-off-by: Your Name <your.email@example.com>` to each commit message.

The email address must match your primary GitHub email. You do NOT need cryptographic (e.g. gpg) signing.
* Use `git commit -s --amend ...` to add a signoff to the latest commit, if you forgot.

To automatically signoff on every commit, copy the `community/dco-signoff-hook/prepare-commit-msg` file to the `.git/hooks` directory in your repo or if you already have such a hook, merge the contents into your existing hook.

## Usage
Deploy Operator Lifecycle Manager on kubernetes cluster

```bash
Usage:
  make <target>

General
  help             Display this help.

Build
  build-chart      Build helm chart package
  lint-chart       Verify chart lint error

Development
  install-chart    Install chart for dev test
  uninstall-chart  Uninstall chart for dev test

Release
  push-images      Push olm related images to repo
```
