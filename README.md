# Wanda

This codebase contains Wanda application based on Elixir.

## Installation

To run this project, you will need to install the following dependencies on your system:

- [Elixir](https://elixir-lang.org/install.html)

To get started, run the following commands in your project folder:

```shell
mix deps.get  # installs the dependencies
```

## Configuration

To run the application you will need a environment variables:

`SOCRATA_BASE_URL` - base url of Socrata API

To set these variables, create an .env file in the project root directory and add the following values to it:

SOCRATA_BASE_URL=socrata_base_url

## Tests

To run the tests for this project, simply run in your terminal:

```shell
mix test
```

## What is done 

In the current version, there is a separate context for food trucks containing two functions for fetching data from external API. 
We are able to fetch food trucks for the given coordinates and radius. Also, we are able to fetch specific trucks by their ID.

## Ideas for the future

* Visualize results
* Visualize near food trucks on the map
* Add users and its favorite foodtrucks