---
name: ai-word-skill
description: "SOP and python-docx scripts to modify Word (.docx) files while preserving their formatting, styles, page setups, tables, headers, and footers. Use when editing or creating .docx files from template/master documents."
metadata:
  source: https://github.com/sgsss998/AI-Word-Skill
---

# AI Word Skill - python-docx Formatting Preservation SOP

This skill provides the standard operating procedures (SOP) and helper scripts for modifying MS Word (.docx) documents in Python while preserving the existing formatting, fonts, font sizes, margins, alignments, headers, footers, and table styles.

## Core Principle
**Copy the template/master document first, and modify the runs inside paragraph elements in the copy.**
Never create a blank document `Document()` and add text if you need to match the branding or styling of an existing template.

## Rules & Code Snippets

### 1. In-place Editing Workflow
```python
import shutil
from docx import Document

# 1. Copy the source template
shutil.copy("template.docx", "output.docx")

# 2. Open the copy for editing
doc = Document("output.docx")

# 3. Perform edits...
# 4. Save
doc.save("output.docx")
```

### 2. Replacing Text Within Paragraphs
A Word paragraph (`w:p`) contains one or more runs (`w:r`), each having its own run properties (`w:rPr`) like font family (e.g. East Asian vs Western), font size, bold/italic, etc.
Directly setting `paragraph.text = "new text"` will clear all runs and destroy their styles. Instead, you must edit `run.text`.

#### 2.1 Single-Run Replacement (Safest)
If the target keyword is fully contained in a single run:
```python
def replace_in_paragraph(paragraph, old_text, new_text) -> bool:
    """Replaces old_text with new_text inside a single run if found, keeping the format."""
    for run in paragraph.runs:
        if old_text in run.text:
            run.text = run.text.replace(old_text, new_text)
            return True
    return False
```

#### 2.2 Cross-Run Replacement (Advanced)
If Word split the keyword across multiple runs (e.g. `run[0].text = "word"` and `run[1].text = "preservation"`), search the concatenated text and merge/clear affected runs:
```python
def replace_cross_runs(paragraph, old_text, new_text) -> bool:
    """Finds old_text split across multiple runs, replaces it in the first run, and clears the rest."""
    full_text = ''.join(r.text for r in paragraph.runs)
    if old_text not in full_text:
        return False

    start = full_text.find(old_text)
    end = start + len(old_text)

    char_pos = 0
    affected = []
    for i, run in enumerate(paragraph.runs):
        r_start = char_pos
        r_end = char_pos + len(run.text)
        if r_start < end and r_end > start:
            affected.append(i)
        char_pos = r_end

    if not affected:
        return False

    merged = ''.join(paragraph.runs[i].text for i in affected)
    merged = merged.replace(old_text, new_text, 1)
    paragraph.runs[affected[0]].text = merged
    for i in affected[1:]:
        paragraph.runs[i].text = ''
    return True
```

### 3. Rewriting Entire Paragraphs (Retaining Style)
To replace the entire content of a paragraph while retaining the formatting of its first run:
```python
def rewrite_paragraph(paragraph, new_text: str) -> None:
    """Sets the first run's text to new_text and clears all subsequent runs."""
    if not paragraph.runs:
        paragraph.add_run(new_text)
        return
    paragraph.runs[0].text = new_text
    for run in paragraph.runs[1:]:
        run.text = ""
```

### 4. Modifying Tables
You must also traverse `doc.tables` to replace text in cell paragraphs:
```python
def replace_all(doc, old: str, new: str) -> int:
    """Replaces text in all paragraphs and tables, preserving formatting."""
    count = 0
    # Process main paragraphs
    for p in doc.paragraphs:
        if replace_cross_runs(p, old, new):
            count += 1
    # Process table cells
    for table in doc.tables:
        for row in table.rows:
            for cell in row.cells:
                for p in cell.paragraphs:
                    if replace_cross_runs(p, old, new):
                        count += 1
    return count
```

### 5. Inserting New Paragraphs with Style (deepcopy XML)
Using `doc.add_paragraph()` can cause KeyErrors or drop style context. Instead, deepcopy a style-compliant paragraph from the template:
```python
from copy import deepcopy
from docx.oxml.ns import qn

def insert_paragraph_after(paragraph, template_paragraph, text: str):
    """Deepcopies a template paragraph's XML, sets its text, and inserts it after target paragraph."""
    new_p_xml = deepcopy(template_paragraph._element)
    
    # Clear existing runs in the XML copy
    for r in new_p_xml.findall(qn('w:r')):
        new_p_xml.remove(r)
        
    # Copy a single run structure from the template and set text
    template_runs = template_paragraph.runs
    if template_runs:
        new_run_xml = deepcopy(template_runs[0]._element)
        # Clear or edit w:t text node
        t_nodes = new_run_xml.findall(qn('w:t'))
        for t in t_nodes:
            t.text = text
            t.set('{http://www.w3.org/XML/1998/namespace}space', 'preserve')
        new_p_xml.append(new_run_xml)
        
    # Insert in the document body
    paragraph._element.addnext(new_p_xml)
    # Return the docx.text.paragraph.Paragraph instance
    return paragraph.parent._paragraphs[paragraph.parent._paragraphs.index(paragraph) + 1]
```

## Checklist before Saving
- [ ] No placeholder values remaining.
- [ ] Table headers and content match.
- [ ] Checked for orphaned runs that might contain partial words.
- [ ] Document verified by opening in MS Word or converting/previewing.
