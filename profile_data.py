"""et profiling script — reads all CSVs in data/raw/ and writes a report."""
import pandas as pd
import os, sys

RAW = r"c:\PYTHON p45\New_Project\data\raw"
OUT = r"c:\PYTHON p45\New_Project\reports\dataset_profiling_report.md"

csvs = sorted([f for f in os.listdir(RAW) if f.endswith(".csv")])

lines = ["# Dataset Profiling Report\n",
         f"**Files profiled:** {len(csvs)}  ",
         f"**Source:** `data/raw/`\n",
         "---\n"]

for fname in csvs:
    path = os.path.join(RAW, fname)
    df = pd.read_csv(path)

    
    n_rows, n_cols = df.shape
    dup_rows = df.duplicated().sum()

    lines.append(f"## {fname}\n")
    lines.append(f"- **Rows:** {n_rows:,}")
    lines.append(f"- **Columns:** {n_cols}")
    lines.append(f"- **Duplicate rows:** {dup_rows}\n")

    # --- Column details ---
    lines.append("### Column Details\n")
    lines.append("| Column | Dtype | Missing | Missing % | Unique |")
    lines.append("|--------|-------|---------|-----------|--------|")
    for col in df.columns:
        miss = df[col].isna().sum()
        miss_pct = f"{miss / n_rows * 100:.2f}" if miss > 0 else "0"
        uniq = df[col].nunique(dropna=False)
        lines.append(f"| {col} | {df[col].dtype} | {miss} | {miss_pct}% | {uniq} |")
    lines.append("")

    # --- Numeric stats ---
    num_cols = df.select_dtypes(include="number").columns.tolist()
    if num_cols:
        lines.append("### Numeric Statistics\n")
        lines.append("| Column | Min | Max | Mean | Median | Std |")
        lines.append("|--------|-----|-----|------|--------|-----|")
        for col in num_cols:
            s = df[col]
            lines.append(
                f"| {col} | {s.min():.4g} | {s.max():.4g} | {s.mean():.4g} | {s.median():.4g} | {s.std():.4g} |"
            )
        lines.append("")

    # --- Categorical unique values ---
    cat_cols = df.select_dtypes(include=["object", "category"]).columns.tolist()
    if cat_cols:
        lines.append("### Categorical Columns — Unique Values\n")
        for col in cat_cols:
            vals = df[col].dropna().unique()
            if len(vals) <= 25:
                sample = ", ".join(str(v) for v in sorted(vals))
            else:
                sample = ", ".join(str(v) for v in sorted(vals)[:15]) + f" ... ({len(vals)} total)"
            lines.append(f"- **{col}** ({len(vals)} unique): {sample}")
        lines.append("")

    # --- Quality observations ---
    obs = []
    if dup_rows > 0:
        obs.append(f"⚠️ {dup_rows} duplicate rows detected.")
    for col in df.columns:
        miss = df[col].isna().sum()
        if miss > 0:
            obs.append(f"⚠️ `{col}` has {miss} missing values ({miss / n_rows * 100:.2f}%).")
    for col in num_cols:
        if (df[col] < 0).any():
            neg_count = (df[col] < 0).sum()
            obs.append(f"⚠️ `{col}` has {neg_count} negative values — verify if expected.")
    if obs:
        lines.append("### Data-Quality Observations\n")
        for o in obs:
            lines.append(f"- {o}")
        lines.append("")
    else:
        lines.append("### Data-Quality Observations\n")
        lines.append("- ✅ No obvious issues found.\n")

    lines.append("---\n")

report = "\n".join(lines)
os.makedirs(os.path.dirname(OUT), exist_ok=True)
with open(OUT, "w", encoding="utf-8") as f:
    f.write(report)
print(f"Report written to {OUT}")
print(f"Total lines: {len(lines)}")
