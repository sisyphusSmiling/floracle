# Repository template
A template enabled repository, including all necesary files to open source.
(create an issue with the following content if you want to track the repo configuration)

## Repository settings and configuration
- [ ]  Repository info
    - [ ]  Add repo description
    - [ ]  Update website to https://onflow.org
    - [ ]  Add relevant repository topics (i.e. `blockchain` `onflow`, etc)
    - [ ]  Check issue labels on `.github/labels.yml` and do any commit to main to get them synced
- [ ]  Define merge workflow (create new branch protection rule)
    - [ ]  `main` branch rule:
        - [ ]  **Require pull request reviews before merging (2 approving reviews)**
            - [ ]  **Require review from Code Owners**
        - [ ]  **Require status checks to pass before merging**
            - [ ]  **Require branches to be up to date before merging**
        - [ ]  **Require linear history**
        - [ ]   **Restrict who can push to matching branches**
            - [ ]  Choose `onflow/flow` team
- [ ]  Add necessary team members, adjust access levels
    - [ ]  `onflow/flow-admin` ⇒ Admin access
    - [ ]  `onflow/flow-engineering ` ⇒ Write access

## Dealing with private keys
Get used to define your private keys on the `.env` file rather than straight on the `flow.json` file.
Uncomment the `.env` entry on the `.gitignore` file to make sure you don't share any private keys by mistake.