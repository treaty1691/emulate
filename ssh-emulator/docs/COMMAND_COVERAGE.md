# Command Coverage

Use this document to track which commands are implemented with canned output.

## AIX commands
- `oslevel -s`
- `lslpp -L`
- `lsdev -Cc disk`
- `errpt`
- `df -k`
- `uname -a`

## Brocade commands
- `show version`
- `show running-config`

## FlashSystem commands
- `lssystem`
- `lsdrive`

## Notes

For AIX-style commands, the file name must be built from the exact command string and arguments.
For Brocade and FlashSystem, command text is mapped by replacing spaces with `_`.
