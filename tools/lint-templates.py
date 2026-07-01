#!/usr/bin/env python3
"""Consistency checks for claude-project-kit's templates/ tree.

Not generated into bootstrapped projects — this is a maintenance tool for
the kit itself. Run before committing a change to templates/ or to
bootstrap-claude-env.md:

    python3 tools/lint-templates.py

Checks:
1. Structural parity between templates/<lang>/ variants: same set of
   relative file paths in every language directory.
2. Every FULL-ONLY / MINIMAL-ONLY / CHANGELOG-ONLY marker is balanced
   (open == close) within each file.
3. Rendering each file for every (profile, changelog) combination never
   leaves a residual {{PLACEHOLDER}}, a residual marker, or a blank line
   sitting between two Markdown table rows (which breaks the table).

Exits non-zero with a printed report if anything fails.
"""
import re
import sys
from pathlib import Path

KIT = Path(__file__).resolve().parent.parent
TPL_ROOT = KIT / 'templates'

PLACEHOLDERS = {
    '{{PROJECT_NAME}}': 'Widgetizer',
    '{{PROJECT_ONE_LINER}}': 'A small widget API + web demo',
    '{{PRIMARY_STACK}}': 'Node.js / TypeScript (Express backend), npm',
}

ALL_TAGS = ('FULL', 'MINIMAL', 'CHANGELOG')

MINIMAL_SKIP_DIRS = {'adr', 'plans', 'prefs', 'changelog'}
MINIMAL_SKIP_FILES = {'workflow.md.tpl', 'claude-code-tooling.md.tpl', 'lessons-domain.md.tpl'}
MINIMAL_SKIP_COMMANDS = {'new-adr.md', 'capture-lessons.md', 'whats-left.md', 'dashboard.md',
                         'changelog-capture.md', 'changelog-draft.md'}
CHANGELOG_PATH_MARKERS = ('docs/changelog', 'dot-claude/commands/changelog-capture.md',
                          'dot-claude/commands/changelog-draft.md')


def check_marker_balance(errors):
    for f in sorted(TPL_ROOT.rglob('*')):
        if f.is_dir():
            continue
        text = f.read_text(encoding='utf-8')
        for tag in ALL_TAGS:
            open_n = text.count(f'<!-- {tag}-ONLY -->')
            close_n = text.count(f'<!-- /{tag}-ONLY -->')
            if open_n != close_n:
                errors.append(f'{f.relative_to(KIT)}: unbalanced {tag}-ONLY markers '
                               f'(open={open_n}, close={close_n})')


def check_lang_parity(errors):
    langs = sorted(p.name for p in TPL_ROOT.iterdir() if p.is_dir())
    rel_sets = {}
    for lang in langs:
        rel_sets[lang] = {str(p.relative_to(TPL_ROOT / lang)) for p in (TPL_ROOT / lang).rglob('*') if p.is_file()}
    if len(langs) < 2:
        return
    base_lang, base_set = langs[0], rel_sets[langs[0]]
    for lang in langs[1:]:
        missing = base_set - rel_sets[lang]
        extra = rel_sets[lang] - base_set
        for m in sorted(missing):
            errors.append(f'templates/{lang}/{m}: missing (present in templates/{base_lang}/)')
        for e in sorted(extra):
            errors.append(f'templates/{lang}/{e}: extra (not present in templates/{base_lang}/)')


def strip_markers(text, active_tags):
    for tag in ALL_TAGS:
        if tag in active_tags:
            text = text.replace(f'<!-- {tag}-ONLY -->', '').replace(f'<!-- /{tag}-ONLY -->', '')
        else:
            text = re.sub(rf'[ \t]*<!-- {tag}-ONLY -->.*?<!-- /{tag}-ONLY -->[ \t]*\n?', '', text, flags=re.DOTALL)
    return text


def substitute(text):
    for k, v in PLACEHOLDERS.items():
        text = text.replace(k, v)
    return text


def check_broken_tables(text):
    lines = text.split('\n')
    problems = []
    for i in range(len(lines) - 2):
        if lines[i].lstrip().startswith('|') and lines[i + 1].strip() == '' and lines[i + 2].lstrip().startswith('|'):
            problems.append(f'blank line inside table near: {lines[i][:60]!r}')
    return problems


def check_rendering(errors):
    langs = sorted(p.name for p in TPL_ROOT.iterdir() if p.is_dir())
    combos = [('full', True), ('full', False), ('minimal', False)]
    for lang in langs:
        tpl = TPL_ROOT / lang
        for profile, changelog in combos:
            active_tags = {'FULL'} if profile == 'full' else {'MINIMAL'}
            if changelog:
                active_tags.add('CHANGELOG')
            for f in sorted(tpl.rglob('*')):
                if f.is_dir():
                    continue
                rel = f.relative_to(tpl)
                parts = rel.parts
                rel_str = str(rel).replace('\\', '/')

                if profile == 'minimal':
                    if len(parts) > 1 and parts[1] in MINIMAL_SKIP_DIRS:
                        continue
                    if parts[-1] in MINIMAL_SKIP_FILES:
                        continue
                    if parts[0] == 'tools':
                        continue
                    if len(parts) > 2 and parts[0] == 'dot-claude' and parts[1] == 'commands' and parts[2] in MINIMAL_SKIP_COMMANDS:
                        continue
                if not changelog and any(rel_str.startswith(m) for m in CHANGELOG_PATH_MARKERS):
                    continue

                text = substitute(strip_markers(f.read_text(encoding='utf-8'), active_tags))
                label = f'{lang}/{profile}/changelog={changelog}:{rel_str}'
                # Backtick-wrapped mentions (e.g. `{{PROJECT_NAME}}`) are docs explaining the
                # convention (see propose-kit-improvement.md), not an unresolved placeholder.
                if re.search(r'(?<!`)\{\{[A-Z_]+\}\}(?!`)', text):
                    errors.append(f'{label}: residual placeholder')
                # Only the real marker-comment form counts; bare mentions like `FULL-ONLY`
                # in prose (documenting the convention) are not a residual marker.
                if re.search(r'<!--\s*/?\s*(FULL|MINIMAL|CHANGELOG)-ONLY\s*-->', text):
                    errors.append(f'{label}: residual profile marker')
                for p in check_broken_tables(text):
                    errors.append(f'{label}: {p}')


def main():
    errors = []
    check_marker_balance(errors)
    check_lang_parity(errors)
    check_rendering(errors)

    if errors:
        print(f'lint-templates: {len(errors)} problem(s) found\n')
        for e in errors:
            print(' -', e)
        return 1
    print('lint-templates: OK — marker balance, lang parity, and rendering all clean.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
