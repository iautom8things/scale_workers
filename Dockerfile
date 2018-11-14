FROM elixir:alpine as build
LABEL maintainer="ChapterSpot Developers <developers@chapterspot.com>"

ENV PHOENIX_VERSION 1.3.4

# Need git for HEX, nodejs for Phoenix's assets compilation, ionotify for live reload
RUN apk add --update git nodejs yarn inotify-tools

# Install hex, rebar, and deps
RUN mix local.hex --force && \
  mix local.rebar --force && \
  mix hex.info

# Install assets and stuff

WORKDIR /app
COPY mix.exs mix.lock ./

RUN mix do deps.get, deps.compile

COPY . /app

FROM build

WORKDIR /app
COPY --from=build /app ./

RUN mix compile

CMD iex -S mix
