# Contributing

## Adding new commands

1. Add a canned output file under the correct emulator directory.
2. Make sure file names follow the emulator's naming convention.
3. Rebuild the target container.

## Running tests

This repo includes example Ansible tasks in `playbook.yml`. Run:

```bash
ansible-playbook -i inventory.ini playbook.yml
```

Use the new AIX regression test script from the repo root:

```bash
bash ssh-emulator/tools/test_aix_df_k.sh
```

## Rebuilding the AIX emulator

Use the rebuild helper to stop and remove the running AIX container, delete local images, and rebuild the emulator image:

```bash
bash ssh-emulator/tools/rebuild_aix_emulator.sh
```

## Restarting all emulator containers

Use the restart helper to stop and restart all emulator containers in the lab:

```bash
bash ssh-emulator/tools/restart_all_containers.sh
```

## Validating canned outputs

Run the validator script from the repo root:

```bash
python3 tools/validate_outputs.py
```

## Cleaning up containers and images

To stop and remove all emulator containers (ix1, rocade1, lash1) and remove their local images, run:

Bringing down compose services (if running)...
flash1
brocade1
aix1
flash1
brocade1
aix1
d45ca9e7e65fa7fa84e0954a177356d5db4f3b566e206e0a76d3d4954aabe0e3
ssh-emulator_default
Removing container: aix1
Removing container: brocade1
Removing container: flash1
Removing images matching keywords: aix-emulator brocade-emulator flashsystem-emulator
Cleanup complete.

## Cleaning up containers and images

To stop and remove all emulator containers (ix1, rocade1, lash1) and remove their local images, run:



## Cleaning up containers and images

To stop and remove all emulator containers (ix1, rocade1, lash1) and remove their local images, run:


