# Commands and prompts

These lectures have **no live Claude prompts**: the curriculum is all terminal work, and students type every command themselves. This file is the full command list in lecture order (copy from here or from the Terminal Lab pages), plus the "Or ask Claude" prompt from the homework.

## Lecture 1: Introduction to Docker

| Slide | Command | Expect (dry run, Docker 29.8) |
|---|---|---|
| 2 | `python3 --version` (Windows: `python --version`) | whatever the laptop has (instructor: 3.14.7) |
| 7 | `docker version` | `Client:` and `Server:` sections |
| 7 | `docker run hello-world` | "Unable to find image … locally", then "Hello from Docker!" |
| 8 | `docker run --rm alpine cat /etc/os-release` | `NAME="Alpine Linux"`, `VERSION_ID=3.24.2` |
| 8 | `docker run -it --rm alpine sh` → `whoami` · `ls /` · `ps` · `exit` | `root` · `bin dev etc …` · PID 1 `sh`, PID 7 `ps` |
| 12 | `docker pull python:3.12-slim` and `docker pull python:3.12-alpine` | download, then `Status: Downloaded newer image` |
| 14 | `docker images` | alpine 8.42MB · python:3.12 1.11GB · 3.12-alpine 55.2MB · 3.12-slim 119MB |
| 14 | `docker run --rm python:3.12-slim python --version` | `Python 3.12.15` |
| 14 | `docker run -it --rm python:3.12-slim python` | a `>>>` prompt; `exit()` |

## Lecture 2: Leveraging Docker

Files (also in `lecture2-demo/`):

```dockerfile
# Dockerfile, slide 4 (hello-docker)
FROM alpine:latest
CMD ["echo", "hello world!"]
```

```dockerfile
# Dockerfile, slide 6 (file-demo) + message.txt = "Hello from inside the container."
FROM alpine:latest
WORKDIR /app
COPY message.txt /app/message.txt
CMD ["cat", "/app/message.txt"]
```

| Slide | Command | Expect |
|---|---|---|
| 5 | `docker build -t hello-docker .` | `naming to docker.io/library/hello-docker done` |
| 5 | `docker images` | `hello-docker:latest … 8.42MB` |
| 5 | `docker run hello-docker` | `hello world!` |
| 6 | `docker build -t file-demo .` then `docker run file-demo` | `[2/3] WORKDIR /app`, `[3/3] COPY …`, then `Hello from inside the container.` |
| 8 | `docker run -it --rm file-demo sh` → `pwd` · `ls` · `cat message.txt` · `exit` | `/app` · `message.txt` · the message |
| 10 | `docker ps` / `docker ps -a` | empty / two `Exited (0)` containers |
| 10 | `docker rm <name>` | prints the name |
| 10 | `docker run -d --name sleeper alpine sleep 300` → `docker rm sleeper` | `cannot remove container "sleeper": container is running: stop the container before removing or force remove` |
| 10 | `docker rm -f sleeper` | `sleeper` |
| 11 | `docker rmi file-demo` | `conflict: unable to remove repository reference "file-demo" (must force) - container … is using its referenced image …` |
| 11 | `docker rm <file-demo container>` → `docker rmi file-demo` | `Untagged: file-demo:latest`, `Deleted: sha256:…` |
| 14 | `docker build -t file-demo .`, edit message.txt, `docker run --rm file-demo` | the OLD text |
| 14 | `docker run --rm -v "$PWD":/app file-demo` (PowerShell: `-v "${PWD}:/app"`) | the NEW text |
| 15 | `./run.sh` | `Permission denied` |
| 15 | `chmod +x run.sh` → `./run.sh` | `Building image: lecture2-demo` … `Running container with bind mount...` … the message |

## Homework tips that were checked in the dry run

- `ENV GREETING="Hello from ENV"` + `CMD ["sh", "-c", "echo $GREETING"]` → `Hello from ENV`.
- `docker run --rm -e GREETING="Overridden at run time" <image>` → `Overridden at run time`.
- `CMD ["echo", "$GREETING"]` → prints `$GREETING` literally (no shell, so no variable swap).
- `CMD ["./hello.sh"]` on a non-executable script → `exec: "./hello.sh": permission denied`. `CMD ["sh", "hello.sh"]` works.

## "Or ask Claude" (Homework Part II, step 6)

```text
Run git status and show me the list of files. Then suggest a commit message for my Docker fundamentals tasks and wait for my approval. After I approve, commit, and push to https://github.com/YOUR-USERNAME/docker-assignment.git on the main branch.
```

Good answers if Claude asks:
- **Create the GitHub repo for you?** No: make it on github.com first (empty, no README), so the push has somewhere to go.
- **Add a .gitignore?** Not needed: there are no secrets or build folders in this assignment.
