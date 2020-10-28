#!/usr/bin/env bash
set -euo pipefail

echo "Running Tests"

# Test
curl -v "http://localhost:8001/hello"
printf "\n"
curl -X POST "http://localhost:8001/test" --data "This is event 1"
printf "\n"
curl -v "http://localhost:8001/bombed"


# Node 1
curl -v "http://localhost:5555/status"
printf "\n"
curl -X POST "http://localhost:5555/event" --data "This is event 1"
printf "\n"
curl -X POST "http://localhost:5555/event" --data "This is event 2"
printf "\n"
curl -X POST "http://localhost:5555/event" --data "This is event 3"
printf "\n"
curl -X POST "http://localhost:5555/event" --data "This is event 1111111"
printf "\n"
curl -v "http://localhost:5555/log"


# Node 2
curl -v "http://localhost:5556/status"
printf "\n"
curl -X POST "http://localhost:5556/event" --data "This is event 1"
printf "\n"
curl -X POST "http://localhost:5556/event" --data "This is event 2"
printf "\n"
curl -X POST "http://localhost:5556/event" --data "This is event 3"
printf "\n"
curl -X POST "http://localhost:5556/event" --data "This is event 2222222"
printf "\n"
curl -v "http://localhost:5556/log"


# Node 3
curl -v "http://localhost:5557/status"
printf "\n"
curl -X POST "http://localhost:5557/event" --data "This is event 1"
printf "\n"
curl -X POST "http://localhost:5557/event" --data "This is event 2"
printf "\n"
curl -X POST "http://localhost:5557/event" --data "This is event 3"
printf "\n"
curl -X POST "http://localhost:5557/event" --data "This is event 3333333"
printf "\n"
curl -v "http://localhost:5557/log"
