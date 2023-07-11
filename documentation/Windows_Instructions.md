# Weather Data Pipeline - Windows details

This pipeline has not been tested on Windows.

However, one known Windows issue is that Docker does not support the `--chmod` instruction in the `COPY` line of the Postgres Dockerfile.

From Docker's online Reference:
https://docs.docker.com/engine/reference/builder/#copy

A possible workaround for Windows is to remove the chmod instruction from the Postgres Dockerfile (in the `builds\postgres` directory) so the `COPY` line reads like this instead:

```
COPY .pgpass .
```

Then the permissions of the .pgpass file (created in the root directory of this repo after setting up a postgres password) can be manually updated before running docker compose:

```
chmod 600 .pgpass
```
