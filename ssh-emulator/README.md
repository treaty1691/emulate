# AIX SSH Emulator Lab

A containerized emulator suite for testing Ansible playbooks against:
- AIX-like SSH host with real shell and command shims
- Brocade CLI device emulator over SSH
- IBM FlashSystem CLI emulator over SSH

This lab is designed to run on RHEL-based hosts using Podman/Podman Compose or Docker Compose.

## Quick Start

1. Build and start the containers:

   ```bash
   podman-compose up -d --build
   ```

2. Run the example playbook:

   ```bash
   ansible-playbook -i inventory.ini playbook.yml
   ```

3. Add canned output files for new commands under the appropriate `data/` or `commands/` directory.
4. Use the provided regression test and rebuild helper scripts in `tools/` as needed.

## Structure

- `aix-emulator/` — real shell host with AIX command shim overrides
- `brocade-emulator/` — fake SSH server for Brocade CLI commands
- `flashsystem-emulator/` — fake SSH server for IBM FlashSystem CLI commands
- `tools/` — utility scripts for capture, validation, and container management
- `docs/` — architecture and usage documentation
- `inventory.ini` — Ansible inventory for the demo lab
- `playbook.yml` — example playbook against all emulated devices

## Utility scripts

- `tools/test_aix_df_k.sh` — regression test for AIX `df -k`
- `tools/rebuild_aix_emulator.sh` — stop/remove the AIX container, delete its image, and rebuild the emulator image
- `tools/restart_all_containers.sh` — stop and restart all running emulator containers
