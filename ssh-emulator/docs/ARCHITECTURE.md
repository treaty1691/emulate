# Architecture

This repository implements a multi-vendor emulator lab for Ansible testing.

## Components

- `aix-emulator/`
  - Real SSH host with a standard shell and a command shim layer that returns canned outputs.
  - Supports `.ansible/tmp`, SFTP, and Ansible file/command modules.

- `brocade-emulator/`
  - Fake SSH server using `asyncssh`.
  - Accepts command execution requests and returns canned Brocade CLI output.

- `flashsystem-emulator/`
  - Fake SSH server using `asyncssh`.
  - Returns canned IBM FlashSystem CLI responses.

- `tools/`
  - Utilities to capture command lists and validate canned output files.

- `inventory.ini` and `playbook.yml`
  - Demo Ansible inventory and playbook for the lab.
