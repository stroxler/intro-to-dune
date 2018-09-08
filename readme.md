# Why this repo? What are the sources?

This is my first ocaml project, which is just a walkthrough of the
ceremonial parts of the language
 - the build system
 - how to make simple commandline apps
 - unit tests

I built this demo app based on
[this video](https://www.youtube.com/watch?v=BNZhmMAJarw) introducing
`Jbuildder` / `Dune`, and the
[associated github repo](https://github.com/diml/jbuilder-tutorial1).

There are some minor improvements I made
 - switched from old jbuilder syntax to dune syntax (lighter-weight S-exprs)
 - made the tests in OUnit (using [this Cornell ebook](http://www.cs.cornell.edu/courses/cs3110/2018fa/textbook/data/ounit.html)
   to get started with OUnit)
 - added an extra module with a `list_max` to demonstrate a little more
   ocaml syntax to myself

# Setup

First, install opam. There are a bunch of ways to do this; on osx
you can just `brew install opam`.

Then, switch to the project directory. At this point we ought to
set up a dedicated alias (the equivalent of a python pyenv+virtualenv)
for this project, but to get started we can skip this step since it
doesn't change anything else.

We need to install our basic tools:
```
opam install -y dune merlin utop ocp-indent
```
Here
  - dune is our build system
  - merlin is the basic introspection tool for editor integrations
    (kind of like pyflakes + jedi in python)
  - utop is an improved repl
  - ocp-indent enables editors to auto-indent your code

Note that you do not generally need to install libraries upfront in
order to use dune. You *will* have to `opam install` them, but dune
can tell you, based on the `dune` config files in the project, what
to install.

The top-level `dune-project` file is optional, but it tells dune
that the repository root is the project root; having a root is helpful
for larger builds.

# How to do things

To get an interactive shell with our library in scope:
```
dune utop src
```

To build our executable:
```
dune build bin/cli.exe
```

To run the resulting executable:
```
dune exec bin/cli.exe -- fact 5
```
A few notes:
  - You could also run it manually with `_build/default/bin/cli.exe`
  - The ` -- ` isn't really needed *unless* your cli has a flag
    that clashes with a `dune` flag. But it can come up; e.g. if you
    try to use the `--help` flag without this you wind up getting dune
    help instead of your own help.

To run tests, you can use the generic alias form
```
dune build @runtest
```
or the shorthand
```
dune runtest
```

### Some notes on tests

Dune is smart about running tests - it knows your dag of dependencies,
and it only reruns tests that either failed before or that depend on something
which changed. This makes the tests more modular, so that you can get efficient
reruns.

These tests demonstrate dune integration that is production-ready,
but since we aren't using a testing library our tests themselves aren't
very nice; there's no output on success and we crash on the first failure
because we're just running an executable full of raw asserts.

# How to see the dune config files and how they are laid out

```
find . -name dune | xargs head -n 100
```

Note that the dune file in `src/gen` is associated with how we generate
source code as part of a build (which is kind of a cool thing to have as
an intro feature - doing similar things in java took me a long time to figure
out for gradle and maven)

# Guides to dune

[Here](https://youtu.be/BNZhmMAJarw) is a super useful intro / walkthrough video. Do
be aware that it's slightly out of date. Most things are correct, but:
 - the command to run is now `dune` rather than `jbuilder`
 - the s-expression dsl files are now called `dune` rather than `jbuild`
 - the s-expression syntax got more lightweight: most of the list arguments are now
   unpacked as varargs, so that you don't need as many redundant parentheses.
   (If you just walk through the video, substituting `dune` for `jbuilder` and `jbuild`,
   the tool itself will tell you pretty clearly what you need to tweak).

There's a more recent [blog post](https://medium.com/@bobbypriambodo/starting-an-ocaml-app-project-using-dune-d4f74e291de8)
that goes through a dune project setup in really awesome detail.
