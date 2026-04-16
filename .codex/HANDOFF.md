Goal
- Ship a public GitHub repo for Codex Insane Search and keep the local Codex install live from this repo.

Done
- Created the Codex plugin scaffold under `plugins/insane-search`.
- Wrote the main skill and focused reference docs.
- Added English `README.md` and Korean `README.ko.md`.
- Added `install-local.ps1`, `uninstall-local.ps1`, and `validate.ps1`.
- Verified repo manifests and installed the plugin locally via junction.

Blocked or risky
- Public endpoint behavior can drift over time.
- The repo currently documents a practical subset of the original idea, not every original reference file.

Next step
- Keep the references current as endpoint behavior changes.
- If the plugin grows, add more focused reference files instead of bloating `SKILL.md`.

Ground-truth files
- `README.md`
- `README.ko.md`
- `plugins/insane-search/.codex-plugin/plugin.json`
- `plugins/insane-search/skills/insane-search/SKILL.md`
- `scripts/install-local.ps1`
- `scripts/validate.ps1`

Verification
- `powershell -ExecutionPolicy Bypass -File .\scripts\validate.ps1`
- `powershell -ExecutionPolicy Bypass -File .\scripts\install-local.ps1 -Force`
- Verified junction at `C:\Users\sinmb\plugins\insane-search`
- Verified home marketplace entry at `C:\Users\sinmb\.agents\plugins\marketplace.json`
