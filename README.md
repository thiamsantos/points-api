# Points API

Conceptual API that return at max 2 (it can return less), users with more than a random number of points.

## Requirements

* [asdf](https://github.com/asdf-vm/asdf)
* [asdf-elixir](https://github.com/asdf-vm/asdf-elixir)
* [asdf-erlang](https://github.com/asdf-vm/asdf-erlang)
* [Docker](https://www.docker.com/)

## Setup

```sh
# Install the versions of elixir, erlang defined at .tool-versions
$ asdf install
# Download the dependencies
$ mix deps.get
# Start the database
$ docker-compose up -d
# Create and migrate the database
$ mix ecto.setup
# Start the server
$ mix phx.server
# The API will be available at localhost:4000
$ curl http://localhost:4000
```

## Testing

```sh
# Run the tests suite
$ mix test
```

## Formatter

```sh
# Run the formatter
$ mix format
```

## Linter

```sh
# Run the linter
$ mix credo
```

## Dotenv

This project includes a custom script to load environment variables at compile time.
The dotenv will override the env vars in the following order (highest defined variable overrides lower):

| Hierarchy Priority | Filename              | Environment      | Should I `.gitignore`it? | Notes                                             |
| ------------------ | --------------------- | ---------------- | ------------------------ | ------------------------------------------------- |
| 1st (highest)      | `.env.local.$MIX_ENV` | dev/test/prod    | Yes!                     | Local overrides of environment-specific settings. |
| 2nd                | `.env.$MIX_ENV`       | dev/test/prod    | No.                      | Overrides of environment-specific settings.       |
| 3rd                | `.env.local`          | All Environments | Yes!                     | Local overrides                                   |
| Last               | `.env`                | All Environments | No.                      | The Original®                                     |

**Note**: `$MIX_ENV` refers to the environment of the build, as `dev`, `test` and `prod`. Ex: `.env.local.test` will be loaded only when the environment is `test`.
