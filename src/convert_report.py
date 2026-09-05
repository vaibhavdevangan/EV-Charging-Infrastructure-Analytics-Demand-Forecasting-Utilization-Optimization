"""Convert the profiling report .md into a .ipynb notebook."""
import json

md_path = r"c:\PYTHON p45\New_Project\reports\dataset_profiling_report.md"
nb_path = r"c:\PYTHON p45\New_Project\reports\dataset_profiling_report.ipynb"

with open(md_path, "r", encoding="utf-8") as f:
    content = f.read()

# Split on "---" separator lines that divide each file section
# The first section is the header, then one section per CSV file
raw_sections = content.split("\n---\n")

cells = []
for section in raw_sections:
    section = section.strip()
    if not section:
        continue
    cell = {
        "cell_type": "markdown",
        "metadata": {},
        "source": [line + "\n" for line in section.split("\n")]
    }
    # Remove trailing newline from last line
    if cell["source"]:
        cell["source"][-1] = cell["source"][-1].rstrip("\n")
    cells.append(cell)

notebook = {
    "nbformat": 4,
    "nbformat_minor": 5,
    "metadata": {
        "kernelspec": {
            "display_name": "Python 3",
            "language": "python",
            "name": "python3"
        },
        "language_info": {
            "name": "python",
            "version": "3.10.0"
        }
    },
    "cells": cells
}

with open(nb_path, "w", encoding="utf-8") as f:
    json.dump(notebook, f, indent=1, ensure_ascii=False)

print(f"Notebook written to {nb_path}")
print(f"Total cells: {len(cells)}")
