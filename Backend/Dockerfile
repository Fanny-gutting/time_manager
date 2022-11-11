FROM elixir:latest

RUN mkdir /Backend

RUN apt-get update && apt-get -y install elixir && apt-get install -y erlang && apt-get install -y postgresql postgresql-client
RUN apt-get -y install inotify-tools

COPY . ./Backend
WORKDIR /Backend

RUN mix local.hex --force
RUN mix archive.install --force hex phx_new
RUN mix phx.new timeManager –app timeManager –module Todolist –no-html –no-webpack
RUN mix local.rebar --force
RUN mix deps.get

# RUN mix ecto.create
# RUN mix ecto.migrate
EXPOSE 4000

ENTRYPOINT [ "mix", "ecto.migrate" ]
CMD [ "mix", "phx.server" ]
# RUN mix phx
