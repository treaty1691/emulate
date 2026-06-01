# FlashSystem Emulator

The FlashSystem emulator behaves like the Brocade emulator, but for IBM storage CLI commands.

## Behavior

- Listens on port `2224`.
- Authenticates with `admin/admin`.
- Maps exact command text to files under `flashsystem-emulator/commands/`.
- Unknown commands return `Unknown command: <command>` and exit `1`.

## Adding commands

1. Add a new `*.txt` file under `flashsystem-emulator/commands/`.
2. Name it with spaces replaced by `_`.
3. Rebuild the container.
