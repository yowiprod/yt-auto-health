# Project: YouTube Automation Pipeline (YowiProd)

Repo: `yowiprod/youtube-automation-health`

## Stack

- **Orchestration:** n8n — workflow JSON files under `workflows/`
- **LLM:** Anthropic Claude API
- **TTS:** ElevenLabs
- **Video rendering:** Creatomate + FFmpeg (compiled with `--enable-libass`)
- **Publishing:** YouTube Data API v3
- **VCS:** GitHub, shared between two dev PCs

---

## Hard rules for editing n8n workflow JSON

Workflow files are large. Streaming a full rewrite from Claude Code frequently causes
`API Error: Stream idle timeout - partial response received`. Follow these rules without
exception when touching anything under `workflows/` or `.n8n/`:

1. **Never rewrite a workflow file in full.**
   Do not call `create_file` or a full-file write on an existing workflow JSON. If the
   change feels like it requires that, stop and refactor into a subworkflow first (see below).

2. **Edit with `str_replace` on the smallest region that works.**
   One node's JSON, one connection entry, one parameter — not a whole section.

3. **One tool call = one logical edit.**
   Adding three nodes = three separate `str_replace` calls for the nodes, plus one or more
   additional calls for the `connections` object. Never bundle into a single write.

4. **Locate before reading.**
   Use `grep -n` or `rg` to find line numbers for anchor strings (node names, IDs) *before*
   opening the file. Then `view` with an explicit `view_range`. Never `cat` or full-view a
   workflow JSON end-to-end to make one edit.

5. **Preserve identity exactly.**
   Do not regenerate node `id` UUIDs. Do not rewrite `credentials` objects when editing
   adjacent fields. Do not reformat the file (no prettifying, no key reordering).

6. **Follow the existing grid for `position`.**
   Match neighbor coordinates — typically ~240px horizontal, ~200px vertical increments.
   Do not invent new coordinates.

7. **`filter_complex` strings stay single-line.**
   FFmpeg filter chains inside n8n nodes are stored as literal strings. Do not wrap, indent,
   or prettify them; n8n will serialize newlines literally and break the filter.

---

## When a change would touch more than ~5 nodes

Stop editing. Refactor into a **subworkflow** before continuing.

Pattern:

- Create `workflows/sub-<name>.json` with a `When called by another workflow` trigger.
- Put the affected block of nodes inside it.
- In the main workflow, replace the whole block with a single `Execute Workflow` node
  pointing at the sub.
- Target: every individual workflow file stays under ~15 nodes.

This keeps each file small enough for surgical edits, makes the pipeline reusable across
channels (e.g., main YouTube channel + rain/sleep channel), and massively reduces the
chance of stream timeouts.

---

## Current workflow inventory

- `workflows/main.json` — master orchestration
- `workflows/sub-overlay-pipeline.json` — video overlays (libass title, subtitle, watermark)
- _(add new subworkflows here as they are created)_

---

## FFmpeg / libass notes

- FFmpeg is compiled with `--enable-libass`. The `subtitles` and `ass` filters are available.
- `.ass` files for overlays are generated on the fly from ElevenLabs timing data.
- All overlay logic lives in `sub-overlay-pipeline.json`, not in the main workflow.

---

## Environment rules

- Two dev PCs share this repo. **Always `git pull` before starting a Claude Code session.**
- Never run two Claude Code sessions writing to `workflows/` simultaneously across PCs.
- Test every workflow change with a short sample clip before a full pipeline run.
- n8n instance runs locally on each PC; credentials are per-machine and should never be
  committed.

---

## Session kickoff checklist

Before Claude Code starts editing, it should:

1. Read this file (you're doing it now).
2. Run `git status` and `git pull`.
3. Run `ls workflows/` to see the current inventory.
4. Ask which workflow is the target of the change and confirm the scope before touching
   anything.
