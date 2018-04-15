# Sync/backup entire directories to personal Gitlab projects

Since ~2000 I always setup a "/labs" folder on new computers, it contains various kind of projects.

Even if I have continuous backup in place through [Backblaze](https://secure.backblaze.com/r/00mm6m), I wanted, for non-public & non-open-source project to be able to quickly sync/backup them to Gitlab. That's what this script do.

## Requirements

- zsh
- curl
- git
- nodejs & [jq.node](https://github.com/FGRibreau/jq.node)

## Usage

- open `sync-to-gitlab.sh`
- edit `USER_NAME`, `USER_ID`, `PRIVATE_TOKEN`
- run it `./sync-to-gitlab.sh`
- it will browse every folder located in `pwd`
- create for them a local git repository if it does not exist
- add every file (following global gitignore rules)
- commit them
- create a personnal *private* project on gitlab
- git push to it

## Roadmap / will accept pull-request for

- [ ] Dockerfile + auto-build for easier use
