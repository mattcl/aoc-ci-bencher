# Specification: Advent of code comparative benchmarking

Version 1.1.0

## Introduction

The normal Advent of Code leaderboard only takes into consideration time to
submit an answer for a given day's problems. This is a proposal for enabling
evaluating submissions on 1) the ability to solve the generalized problem
against any official input, and 2) the time a solution takes to to produce the
answer.

In the past, this was done by creating bespoke shell scripts and runtime
environments that enabled comparing code written in different languages. While
the goal is to still allow for writing in a variety of languages, this proposal
is for a standard interface to reduce the overhead involved in aggregating
inputs, validating solutions, and running comparative benchmarks.


## Definitions

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
"SHOULD NOT", "RECOMMENDED",  "MAY", and "OPTIONAL" in this document are to be
interpreted as described in [RFC 2119](https://www.rfc-editor.org/rfc/rfc2119).

1. Official input(s): Official inputs are the inputs generated/distributed by
   Advent of Code.

2. Unofficial input(s)/challenge input(s): Unofficial inputs or challenge inputs
   are inputs sourced from the community that demonstrate an edge case not
   necessarily present in the official inputs. These may be larger and/or more
   complicated.


## Quick-start reference templates

The following templates generate projects that conform to this specification.

* [python template](https://github.com/mattcl/aoc-python-template) via
  [cookiecutter](https://cookiecutter.readthedocs.io/en/stable/)
* [rust template](https://github.com/mattcl/aoc-template) via
  [cargo-generate](https://github.com/cargo-generate/cargo-generate)

If you want to implement in a different language or implement things on your
own, you MUST implement the required sections of this specification.


## Pipeline

Submitted solutions are evaluated using the following pipeline sequence:

1. Inputs are collected from the submission's project repository.
2. The submission's build task is executed.
3. The submission is checked against all available official inputs.
4. The submission is compared to other submissions using `hyperfine`.
   Comparisons happen in two phases:
    1. Solutions are compared using official inputs.
    2. Solutions are compared using unofficial inputs (if they exist).


Solutions that do not pass a particular step will not be evaluated for
subsequent steps.


## Publicly accessible git repository

Submissions MUST be available via a single, publicly accessible git repository.


## General solutions

Submissions MUST solve any official input. Submissions are not required to solve
the unofficial (challenge) inputs.


## Inputs

Submissions are encouraged to include their inputs, but it's not strictly
necessary. If inputs are included, a way (script, executable, etc.) MUST be
provided that MUST consume the following environment variables:

1. `AOC_DAY`: an integer corresponding to the desired day to run.

The script MUST output a path - relative to the project root - that corresponds
to the input for the day specified by `AOC_DAY`. The input MUST exist in the
submission's repository.

If an input for a specified day does not exist, the script MUST exit with a
nonzero exit code.

This is the input script provided by the python template at
`ci/scripts/input_path.sh`:

```sh
#!/bin/sh
set -e

# This script is used by the ci pipeline to extract our inputs for use in the
# benchmarking and checking of solutions.

# The specification says that AOC_DAY will be set from 1-25, so make sure that
# var is set.
if [ -z ${AOC_DAY+x} ]; then
    echo "env var AOC_DAY must be set"
    exit 1
fi

# We need to zero-pad the day to 2 digits to properly match our inputs.
padded=$(printf "%02d" "$AOC_DAY")

# paths are relative tot he project root
expected="inputs/day${padded}.txt"

# The specification says that if an input does not exist for a given day, we
# need to exit with a nonzero code.
if [ -f "$expected" ]; then
    echo "$expected"
else
    echo "no input for day ${AOC_DAY}"
    exit 1
fi
```


## Entrypoint

Submissions MUST provide an entrypoint that minimally accepts the following
environment variables:

1. `AOC_DAY`: an integer from 1 to 25 inclusive, corresponding to the desired
   day to run.
2. `AOC_INPUT`: a path corresponding to a file containing the problem input.
3. `AOC_JSON`: if present, will ALWAYS be set to `true` (`AOC_JSON=true`).

A fourth `AOC_CI=true` environment variable will be specified. Consuming this
variable is OPTIONAL.

If `AOC_JSON` is specified, the solution MUST exit with 0 _AND_ be rendered as
valid JSON to stdout with the following schema:

```
{"part_one": <SOLUTION1>, "part_two": <SOLUTION2>}
```

Where the solution values are whatever appropriate type for the given day's
answer. The solution values will be interpreted as strings for checking
purposes.

If `AOC_JSON` is set _AND_ a solution does not exist for a given day, then the
entrypoint MUST exit with 0 _AND_ write the following to stdout (notice the
quotes making it valid JSON):

```
"not implemented"
```

In the case that `AOC_JSON` is NOT set and the solution does not exist, then
then entrypoint SHOULD, but is not required to, exit with 0 _AND_ write the
following to stdout:

```
not implemented
```


## Pipeline build task

The build task in the pipeline is intended to be used by a submission to run
linters, tests, and local benchmarks.

A submission SHOULD contain a `ci` directory at the root of the repository, and
that SHOULD contain at least a `build-task.yaml` that specifies the image the
build step will use and what will be done during the build step. This is a
[concourse CI task file](https://concourse-ci.org/tasks.html) that will be run
as a part of the overall pipeline.

The following is the build task from the python template.

```yaml
# ci/build-task.yaml
platform: linux
image_resource:
  type: registry-image
  source:
    # the docker image to use
    repository: mattcl/aoc-python
    tag: 3.12

inputs:
  # this repository will be provided to the task in the registry-image as a
  # directory named `repo`
  - name: repo

run:
  # we execute the build script in the context of the this in the aoc-python
  # container, which contains py 3.12 and poetry, among other things.
  dir: repo
  path: ci/scripts/build.sh

```

and the accompanying script at `ci/scripts/build.sh`

```shell
#!/bin/sh
set -e

# This script can pretty much do whatever, but the most basic thing would be
# ensuring the project's dependencies are installable and that the tests and
# benchmarks run

poetry install

# Without filtering any of the marks, this should run the example and real input
# tests as well as running the benchmarks.
poetry run pytest

```

If you need help writing this, Matt can provide additional examples/assistance.

## Optional Installer

A submission MAY include an installer script for installing the submission if
it's something that is installable.

An example is the `ci/scripts/install.sh` from the python template:

```shell
#!/bin/sh
set -e

# build to create the dist
poetry build

# install the built package via pipx
pipx install -f dist/{{ cookiecutter.__bin_name }}*.tar.gz

```


## Runtime environment.

Submissions MUST be runnable in a debian bookworm x86 container that is
provisioned with the following runtimes/packages (additional packages may be
available, but these are the explicitly specified ones):

* python 3.12.x
* ruby 3.2.2
* poetry 1.6.1
* clang
* llvm-11
* pipx
* virtualenv
* just
* hyperfine

Python solutions will be installed in separate virtual environments to isolate
their dependencies.

Any additional requirements MUST be communicated to the event organizer (Matt)
so that they may be added to the container.
