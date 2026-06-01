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

## Validating canned outputs

Run the validator script from the repo root:

```bash
python3 tools/validate_outputs.py
```
