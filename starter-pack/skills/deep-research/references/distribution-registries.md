# Distribution Registries Checklist

Use this checklist during step 4.5 (distribution and installability pass) for domain ecosystem scans and landscape-first passes.

## Why this matters

A GitHub repo is not proof that something is installable and maintained. A package on PyPI with weekly downloads is often stronger adoption evidence than a repo with 1,000 stars and no package, but download counts are noisy signals and need freshness and maintenance checks.

Distribution truth answers: "what is actually installable and maintained?"

## Checklist

For each domain ecosystem scan, check these registries when relevant:

### General package registries
- **PyPI** (pypi.org) -> Python packages. Check download stats.
- **npm** (npmjs.com) -> JavaScript/TypeScript packages. Check weekly downloads.
- **Conda-forge** (conda-forge.org) -> cross-platform scientific packages
- **Docker Hub** (hub.docker.com) -> containerized tools and services
- **Homebrew** (formulae.brew.sh) -> macOS/Linux CLI tools

### AI/ML specific
- **Hugging Face** (huggingface.co) -> models, datasets, and Spaces. Check downloads and likes.
- **Ollama** (ollama.com/library) -> local model registry
- **Replicate** (replicate.com) -> hosted model API marketplace

### Agent/skill specific
- **ClawHub** / **Smithery** -> MCP server marketplaces
- **Glama** -> MCP directory
- **Claude skill ecosystem** -> check for installable skill packs

### Domain-specific registries
- **Bioconda** (bioconda.github.io) -> bioinformatics packages
- **Galaxy ToolShed** (toolshed.g2.bx.psu.edu) -> Galaxy bioinformatics platform
- **CRAN** (cran.r-project.org) -> R packages
- **ROS Index** (index.ros.org) -> robotics packages
- **Terraform Registry** (registry.terraform.io) -> infrastructure modules

### How to use in a report

For each candidate tool in an ecosystem scan:
1. Check if it exists on a distribution registry (not just GitHub)
2. Note download counts, last update, and version history
3. A tool on a registry with active downloads is often more actionable than a repo with stars but no package, but do not treat download counts as decisive on their own
4. Log "not on any registry" as a negative signal, not a blocker

If a domain has its own registry (Bioconda, Galaxy, CRAN, etc.), searching that registry is mandatory for the domain scan. Missing it is a coverage gap.
