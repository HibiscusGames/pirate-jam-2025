# Pirate Jam 2025

[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC_BY--SA_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/) [![License: AGPL v3](https://img.shields.io/badge/License-AGPL_v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

StabStab is a short game chronicling the adventures of a magical sentient flying
dagger as they embark on a journey to gain power and find a being worthy of their loyalty.

This is our entry for the [Pirate Jam 2025](https://itch.io/jam/pirate-jam-2025) game jam.
The game is available on [itch.io](https://hibiscusgames.itch.io/stabstab).

## Setup

[Download the setup helper](https://github.com/HibiscusGames/pirate-jam-2025/TBD) and follow the instructions on screen
[or set up the tools manually](docs/contributing/manual-setup.md) and come back here to check out the suggested workflow based on what you're working on.

### General note

**Binary files need to be checked-out when you are working on them**. This is regardless of size or whether you're working on them for 5 minutes or 3 days.
The setup tool will install a UI that can help you monitor the status of your files, check them out and commit them when you're done.
Check out a quick user guide in [the docs](docs/contributing/lfs-helper/README.md).

We don't have a way to merge binary files so if two of us are working on one at the same time, someone is going to have to redo their work.
That sucks. So make sure it's checked out before you start working on it so the other person gets a warning.

## Workflows

### I'm working on art / audio / etc

Remember, **binary files need to be checked-out when you are working on them**.
Art is 99.99% binary files so check-out all the files you are planning to work on before you start.

1. Install [mise-en-place](https://mise.jdx.dev/installing-mise.html), it will manage tool versions, build scripts and environments.
2. When editing the GDD use the `mise lfs:checkout <file>` command
3. When you are ready to commit your changes use the `mise lfs:commit <file>` command.

### I'm working on the GDD or some documentation

The documentation lives in the docs folder.
It's currently markdown, but can be any other form of structured text so long as we have an easy way to build and display it.

The GDD is a special case. As it's one of the deliverables, we may want to make it more visually appealing than can easily be achieved in markdown.
If we're working with a binary format, eg: .docx and the like, we'll be using `git-lfs` in a similar way to the artist workflow.

1. Install [mise-en-place](https://mise.jdx.dev/installing-mise.html), it will manage tool versions, build scripts and environments.
2. When editing the GDD use the `mise lfs:checkout <file>` command
3. When you are ready to commit your changes use the `mise lfs:commit <file>` command.

### I'm working on level design / game design / integration / etc

1. Install [Godot v4.3-stable](https://godotengine.org/download/archive/)
2. Open the project in Godot and work on it as normal.

### I'm working on game code

1. Install [mise-en-place](https://mise.jdx.dev/installing-mise.html), it will manage tool versions, build scripts and environments.
2. Install [Godot v4.3-stable](https://godotengine.org/download/archive/)
3. Optionally, install your IDE of choice. [VSCodium](https://vscodium.com/) is a nice unmicrosfted port of VSCode with a solid gdscript extension.

### I'm working on tools

1. Install [mise-en-place](https://mise.jdx.dev/installing-mise.html), it will manage tool versions, build scripts and environments.
2. See the [tools README](tools/README.md) for detailed setup instructions.

## License

Copyright (C) 2025 Pierre Fouilloux, Iain Armour, and Irvin Dos Reis

This game by Pierre Fouilloux, Iain Armour and Irvin dos Reis is dual-licensed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0)
and [GNU AGPL3](https://www.gnu.org/licenses/agpl-3.0.html).

- The art, story, music, sound effects, and other art assets are licensed under [Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0).
- The code and the combined work of the code and the art assets are licensed under [GNU AGPL3](https://www.gnu.org/licenses/agpl-3.0.html).

See the [LICENSE](license/LICENSE.md) file for more details.

## Attribution

When using or modifying this work, you must provide proper attribution as described in the [ATTRIBUTION](ATTRIBUTION.md) file.
