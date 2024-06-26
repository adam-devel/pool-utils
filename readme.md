A collection of scripts for managing symlinks in a particular way.

# The Pool

The pool is where all files are supposed to reside.
Every other file must be a link (symbolic or otherwise),
to the files at the pool.

The `collect.sh` script, collects all the files of the current
directory to a pool folder (.pool by default), then replaces the
files with symlinks (or hardlinks).

Upon re-execution, `collect.sh` script looks for new files to pool.

# Unpool

The `unpool.sh` script undoes everything `collect.sh` does, it turns all
the symlinks back to real files and gets rid of the pool.

# TODO

- Implement hardlinking and use extended attributes to mark already pooled files
- List siblings: given some link, list paths to other links sharing the same content
- delete all: delete a all links to a file and optionally the file itself
- List and clean unused pooled files: list files in the pool that aren't linked to anywhere
- Track files to notice when one is removed so that the pool can be cleaned

# Tags layer

This project can be use for tagging/classifying files without wasting space or
making horrendous hierarchies. one could do so by pooling all the content then
linking to said content from directories representing different
categories/tags/classes.

The system built on this would be aware of folders as tags and therefore would
provide features related to tagging:

- Infos: given a file, the programs lists categories it belongs to
- Diffing and comparison between categories
- Backlog: display files not in any category yet
- Query: maybe some kind of simple query language for finding files based on
  tags, the syntax can be as simple as a list of space separated tags that can be
  nagted by starting with a minus `[+-]tag`
- this is far-fetched but
