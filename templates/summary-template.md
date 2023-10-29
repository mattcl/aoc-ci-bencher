# Advent of Code {{ year }} aggregated inputs, solutions, and benchmarks

The contained benchmarks are auto-generated via
[hyperfine](https://github.com/sharkdp/hyperfine) by a CI system running on
dedicated hardware.

[CI pipeline]({{ pipeline_url }})

Participants are required to implement solutions that can handle any official
input, and are requested to conform to the following specification:
[https://github.com/mattcl/aoc-benchmarks/blob/master/SPECIFICATION.md](https://github.com/mattcl/aoc-benchmarks/blob/master/SPECIFICATION.md).

There are some spec-compliant templates you can use as starting points:

* [python template](https://github.com/mattcl/aoc-python-template) via
  [cookiecutter](https://cookiecutter.readthedocs.io/en/stable/)
* [rust template](https://github.com/mattcl/aoc-template) via
  [cargo-generate](https://github.com/cargo-generate/cargo-generate)


## Participants for {{ year }}
{% for project in participants %}
- [{{ project.username }}]({{ project.repo }}) ({{ project.language }})
{%- endfor %}
