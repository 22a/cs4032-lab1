# Eko

Simple script that talks to an echo server via manually constructed http get request sent over tcp connection.

## Prerequisites
* Elixir, mix, erlang, etc. `brew update && brew install elixir`
* PHP of some sort (to run the server)

## Usage

You'll need to have the lab echo server running somwhere, you can do that with:
```bash
php -S 0.0.0.0:8000 -t .
```

```bash
./client.sh <IP_ADDRESS> <PORT_NUMBER> <MESSAGE>
```

for example
```bash
./client.sh 0.0.0.0 8000 hi_there
```
