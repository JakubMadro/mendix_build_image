#!/bin/sh
set -e

# Czekaj na start demona Docker (można to ustawić w bazowym obrazie)
if [ ! -S /var/run/docker.sock ]; then
  echo "Docker socket not available, starting Docker daemon..."
  dockerd &
  
  echo "Waiting for Docker daemon to start..."
  for i in $(seq 1 30); do
    if docker info >/dev/null 2>&1; then
      echo "Docker daemon started"
      break
    fi
    echo "Still waiting... ($i/30)"
    sleep 1
  done
else
  echo "Docker socket available, using existing Docker daemon"
fi

# Uruchom build.py
python3 --version
./build.py --source /app/source --destination /app/target build-mda-dir

# Jeśli podano jakieś argumenty, wykonaj je
exec "$@"