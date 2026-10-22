# Live demo runbook: Docker, in the terminal

**The story:** these lectures are hands-on. Students type every command along with you, on their own laptops. There's no app and no Claude prompt: the "live demo" is your terminal, and the backup is the Terminal Lab page plus `lecture2-demo/`.
- **Lecture 1 (Introduction to Docker):** what a container is, containers vs VMs, Docker Hub and tags. Hands-on: hello-world, a shell inside Alpine, pulling and comparing Python images.
- **Lecture 2 (Leveraging Docker):** Dockerfile → image → container. Hands-on: hello-docker, file-demo, a shell inside, cleaning up (`ps -a`, `rm`, `rm -f`, `rmi`, `--rm`), a bind mount, `run.sh`.

## What's in the kit

| File | What it is |
|---|---|
| `prompts.md` | Every command in order, plus the "Or ask Claude" prompts from the homework |
| `lecture2-demo/` | The finished Lecture 2 folder: `Dockerfile` (file-demo), `Dockerfile.hello` (hello-docker), `message.txt`, `run.sh`. The backup if your own typing goes wrong |
| `pre-pull.sh` | Pulls every image both lectures use (including the 1.11 GB `python:3.12`, which only you need) |
| `reset.sh` | Removes the lecture's containers and images (hello-docker, file-demo, lecture2-demo, sleeper), keeps alpine and python |

## Setup (once, before Lecture 1)

```bash
docker version                   # Client AND Server sections
bash demo-kit/pre-pull.sh        # ~1.3 GB the first time; do it at home
bash demo-kit/reset.sh           # no leftovers from earlier practice
```
- Terminal font big (Cmd/Ctrl +). Light theme reads better on a projector.
- Have the **Terminal Lab** page open in a tab: students can copy from there while you type.
- For Lecture 1: want students to see "Unable to find image 'hello-world:latest' locally" on **your** screen too? Run `docker rmi hello-world` just before class (it's 10 kB, re-downloads instantly).

## Dry run (the night before), then reset

1. Present each deck with the presenter window (**P**) and type every command yourself, in a fresh folder.
2. Time the hands-on slides. They're the risky part: students are slower than you.
3. Reset: `bash demo-kit/reset.sh`, and delete your practice `docker-lecture/` folder.

## Lecture 1 in class (Introduction to Docker)

| Slide (~min) | Where | Do | Say |
|---|---|---|---|
| 1 (0) | Deck | Press **T**. Ask everyone to open a terminal | "Laptops open: you'll type along all lecture." |
| 2 (1) | Terminal | `python3 --version`. Ask chat for theirs | "How many different answers? That's the problem." |
| 3–6 (3–9) | Deck | Diagrams + table | "A container is an isolated process that borrows your OS." |
| 5 (7) | Deck | Point at **container 1** and **container 2** | "Two apps = two separate containers. No Compose needed for that." |
| 7 (11) | Terminal | `docker version`, `docker run hello-world`. Thumbs up in chat | "Client = what you type. Server = the engine that runs containers." |
| 8 (14) | Terminal | `docker run --rm alpine cat /etc/os-release`, then `docker run -it --rm alpine sh` → `whoami`, `ls /`, `ps`, `exit` | "Two processes. Your laptop runs hundreds. That's isolation." |
| 9–10 (18–20) | Deck | Modern stack, four habits | "These four habits are the activity's answers." |
| 11 (22) | Deck | Docker Hub flow | "Docker looks on your machine first, then Docker Hub." |
| 12 (24) | Browser | hub.docker.com/_/python: badge, Tags, sizes, pull command. Then everyone pastes the two `docker pull`s | "They download while we do the activity." |
| 13 (26) | Activity page | 6 cards, Space reveals | "HABIT or TRAP in chat on go." |
| 14 (32) | Terminal | `docker images`, `docker run --rm python:3.12-slim python --version`, the REPL | "Nobody installed Python 3.12." |
| 15–16 (36–38) | Deck | Wrap, homework | "Come to Lecture 2 with hello-world working." |

**Time check, Lecture 1:**
- **Not at slide 9 by ~min 19:** skip the REPL on slide 14 later, and talk slides 9–10 in 2 minutes total.
- **Installs broken for many students:** don't debug live. "Watch my screen; Lab step 1 has a fix table; finish it at home."
- **Pulls still running at slide 14:** students watch your screen and do Lab steps 3–4 after class.

## Lecture 2 in class (Leveraging Docker)

| Slide (~min) | Where | Do | Say |
|---|---|---|---|
| 1 (0) | Deck | `bash demo-kit/reset.sh` done before class. Press **T** | "All in your terminal today." |
| 2 (1) | Terminal | `mkdir docker-lecture && cd docker-lecture && code .` | "Files in the editor, commands in the terminal." |
| 3 (2) | Deck | Pipeline diagram | "Recipe, blueprint, building." |
| 4 (4) | Editor | Create `Dockerfile` (hello world) | "Capital D, no extension." |
| 5 (6) | Terminal | `docker build -t hello-docker .` → `docker images` → `docker run hello-docker` | "Don't forget the dot." |
| 6 (9) | Editor + terminal | `message.txt`, new Dockerfile, `docker build -t file-demo .`, `docker run file-demo` | "Your file is now part of the image." |
| 7 (13) | Deck | Container state diagram | "Build time vs run time." |
| 8 (14) | Terminal | `docker run -it --rm file-demo sh` → `pwd`, `ls`, `cat message.txt`, `exit` | "If you can't see it, open a shell and look." |
| 9 (16) | Deck | Cleanup diagram | "Docker does not clean up after you." |
| 10 (17) | Terminal | `docker ps`, `docker ps -a`, `docker rm <hello-docker container>`, `docker run -d --name sleeper hello-docker sleep 300`, `docker rm sleeper` (error), `docker rm -f sleeper` | "Use YOUR container names." |
| 11 (21) | Terminal | `docker rmi file-demo` (error), `docker rm <file-demo container>`, `docker rmi file-demo` | "Containers first, then the image." |
| 12 (24) | Activity page | 6 cards | "The command in chat on go." |
| 13 (30) | Deck | COPY vs bind mount | "A photocopy vs a window." |
| 14 (31) | Editor + terminal | `docker build -t file-demo .`, edit message.txt, `docker run --rm file-demo` (old), `docker run --rm -v "$PWD":/app file-demo` (new) | "No rebuild." |
| 15 (33) | Editor + terminal | `run.sh` from the lab page, `./run.sh` (Permission denied), `chmod +x run.sh`, `./run.sh` | "Teams turn repeated steps into scripts." |
| 16 (36) | Deck | ENV / script tips | "Two things the homework needs." |
| 17 (38) | Deck | Homework | "If Docker feels repetitive, that's the point." |

**Time check, Lecture 2:**
- **Not at the activity (slide 12) by ~min 26:** shorten the activity to the first 4 cards.
- **Not at slide 13 by ~min 32:** do the bind mount on your screen only (students do Lab step 7 at home), go straight to `run.sh`.
- **Your own terminal goes wrong:** `cd demo-kit/lecture2-demo`: every finished file is there. `docker build -t hello-docker -f Dockerfile.hello .` builds the hello-world version; `docker build -t file-demo .` builds file-demo; `./run.sh` runs the script.

## Things to expect

- **Names and IDs differ for everyone.** Slides show the dry run's (`stupefied_blackburn`, `2c35db8c8953`). Keep saying "use yours"; Tab completes names.
- **`docker images` columns differ:** Docker 29 prints `IMAGE  ID  DISK USAGE  CONTENT SIZE  EXTRA`; older versions print `REPOSITORY  TAG  IMAGE ID  CREATED  SIZE`. Same information. Sizes differ a little on an M-series Mac.
- **Windows:** `Dockerfile.txt` from Notepad; Git Bash needs `winpty` for `-it` and `MSYS_NO_PATHCONV=1` for `-v`; `run.sh` needs Git Bash or WSL; PowerShell's `-v` is `"${PWD}:/app"`.
- **Linux:** `permission denied … docker.sock` → `sudo usermod -aG docker $USER`, log out and in.
- **Students' `docker ps -a` also shows Lecture 1's hello-world container.** Good: more to clean up.
- **"Can I just use `docker run python`?"** It pulls `python:latest` (~1.1 GB) and prints nothing: no `-it`, so Python exits at once. Pin a small tag.
