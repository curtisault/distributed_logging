# DistributedLogging

## Init application command used:

  mix new . --sup --app distributed_logging

## Dependencies Used

* Cowboy
* Plug

I decided to use cowboy as my HTTP Server and Plug to create the endpoints as they are established and I didn't have to create my own handler.

# Architecture

    .
    ├── ./README.md
    ├── ./lib
    │   ├── ./lib/distributed_logging
    │   │   └── ./lib/distributed_logging/application.ex
    │   ├── ./lib/distributed_logging.ex
    │   ├── ./lib/log.ex
    │   └── ./lib/routers
    │       ├── ./lib/routers/node1.ex
    │       ├── ./lib/routers/node2.ex
    │       ├── ./lib/routers/node3.ex
    │       └── ./lib/routers/router.ex
    ├── ./mix.exs
    ├── ./mix.lock
    └── ./test
        ├── ./test/distributed_logging_test.exs
        └── ./test/test_helper.exs


Application wide logic is placed in the `lib/distributed_logging/application.ex` file or more aptly known as the Application Module that is ran at startup.

All Modules that contains routes are placed in the `lib/routers` folder. 

Application specific business logic for logging is in the `DistributedLogging.Log` module in the `lib/log.ex` file.

The application uses 4 total ports:

* 8001: For testing purposes to make sure the app is running
* 5555: The first Node in the sequence
* 5556: The second Node in the sequence
* 5557: The final Node in the sequence

More can be added with ease by having additional children processes in the `DistributedLogging.Application` module. Each child process implements it's own Module which allows for different business logic to be executed on different ports. In the case of this project, the only difference between Node modules is which node to log to.

Each Node Module also contains a catch all fail in case you make a request to an endpoint that doesn't exist.

# Tests

All the unit tests ensure that each endpoint in all Node modules work and that each public function in `DistributedLogging.Log` are working as intended.

To run integration tests, set `run.sh`

# Tools
Mostly command line but I threw in a Postman collection in addition to the tests that get ran.
