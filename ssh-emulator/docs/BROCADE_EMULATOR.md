# Brocade Emulator

The Brocade emulator is a fake SSH server that accepts execution requests over SSH and returns canned CLI output.

## Behavior

- Listens on port `2223`.
- Authenticates with `admin/admin`.
- Maps exact command text to files under `brocade-emulator/commands/`.
- Unknown commands return `Unknown command: <command>` and exit `1`.

## Adding commands

1. Add a new `*.txt` file under `brocade-emulator/commands/`.
2. Name it with spaces replaced by `_`.
3. Rebuild the container.
