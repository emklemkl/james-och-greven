# james-och-greven

# 🛠️ Git Setup

This guide will help you get started with Git and our team workflow.
---

## 1. 🔧 Install Git (Windows via winget)

1. Open **Command Prompt** as Administrator (Win + R, in run, write: cmd, press CTRL+SHIFT+ENTER).
2. Run the following command:
   ```
   winget install --id Git.Git -e --source winget
   ```
3. Run the following command, if you see something like: "git version 2.5X.X." all things are good.
   ```
   git --version
   ```

## 2. Setup git credentials
1. Create a github account github.com 
2. In the same (or a new) cmd window, run (keep the quotes and replace "your name" and "your@email.com" with you creds):
   ```
   git config --global user.name "Your Name"
   git config --global user.email "your@email.com"
   ```
3. Generate a Personal Access Token (PAT) (this might not be necessary depending on if a password is needed. Sometimes passwords aren't allowed when cloning via HTTPS, in that case u ned to follow the steps below to create a PAT):
   1. Go to: https://github.com/settings/tokens
   2. Click "Generate new token (classic)"
   3. Select scopes: repo, workflow, read:org
   4. Copy the token (you might have to use it instead of your password in the next step)

## 3. Clone the repo
1. In the terminal (cmd), run 
    ```
    cd C:\
    mkdir dev
    cd dev
    git clone https://github.com/emklemkl/james-och-greven.git
    ```
    *You might need your PAT when cloning*


# 🧭 GitFlow Guide for New Contributors

Follow these steps after you've downloaded the project to contribute effectively.

---

## 1. Check Your Current Branch

Make sure you're on the `main` branch:

   ```
   git branch
   ```

If you're not on main, switch to it:
   ```
   git switch master
   ```

## 2. Create a new branch

When you start a new task, create a branch with a descriptive name, **make sure the you stand on master/main before branching**:
   ```
   git switch -c my-new-branch-with-descriptive-name

   ```
## 3. Make Your Changes to the Files
For example, add your name to the bottom of this README.md file. 
Then to see changed files, run: 
   ```
   git status
   ```
Then to stage your changes ready for commit run:
   ```
   git add <path-and-name-of-file-1> <path-and-name-of-file-2>.....
   ```
Then commit changes by running:
   ```
   git commit -m "write a short description on the changes u have made"
   ```

To push your commited changes to a branch with the same name as your local branch, run:
*-u is to set the upstream (the remote github branch that links towards your local branch) to match github.com/emklemkl/james-och-greven (which equals origin) and the branch name my-new-branch-with-descriptive-name*
   ```
   git push -u origin my-new-branch-with-descriptive-name
   ```
   - origin is the default name Git gives to the remote repository where your code is stored online (usually on GitHub, GitLab, Bitbucket, etc.).
      - It acts as a shortcut or nickname for the remote URL, like https://github.com/emklemkl/james-och-greven.git.
      - So when you run commands like git push origin main, you're telling Git: “send my changes to the main branch at the origin remote.”
   - The -u flag sets the upstream tracking reference, which links your local branch to the remote branch on GitHub. Once set, future git push or git pull commands will automatically target this branch without extra arguments, ie you can write git pull and git push without extras.

After pushing your commits o the remote branch you can enter the github project page and start a pull request, make sure the branch you just pushed to is merged into main inside the pull request (PR).


