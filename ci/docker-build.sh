Tag="${GIT_COMMIT::8}"
REPO="ghcr.io/$docker_username/"

echo "${REPO}"

docker build -t "${REPO}frontend:latest" -t "${REPO}frontend:1.0-$Tag" ./frontend/
docker build -t "${REPO}backend:latest" -t "${REPO}backend:1.0-$Tag" ./backend/