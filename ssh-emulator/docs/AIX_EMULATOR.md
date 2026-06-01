# AIX Emulator

The AIX emulator is a real SSH server that exposes a user shell. It uses a shim directory at `/opt/mock/aix/bin` that is placed first in `PATH`.

## How it works

- The command shim `_shim_template` reads the invoked command name and arguments.
- It converts the command string into a safe file name.
- If a matching canned output file exists under `/opt/mock/aix/data`, it prints the file contents.
- If no match exists, it returns exit `127`.

## Adding new AIX commands

1. Add a canned output file in `aix-emulator/data/`.
2. Name the file using the command and arguments, replacing invalid characters with `_`.
3. Rebuild the container.

## Regression test

Use the AIX regression test script to verify `df -k` output:

```bash
bash tools/test_aix_df_k.sh
```

## Rebuild helper

Use the rebuild helper to stop/remove the running AIX container, delete the image, and rebuild the emulator image:

```bash
bash tools/rebuild_aix_emulator.sh
```
