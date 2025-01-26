#!/usr/bin/env -S node
//MISE quiet=true
//MISE description="Creates a changelist from one or more modified files and prompts for a description."
//USAGE arg "<files>" var=#true help="The files to include in the changelist."

import { execSync } from 'child_process'
import readline from 'readline'

async function promptYesNo(message) {
	const rl = readline.createInterface({
		input: process.stdin,
		output: process.stdout
	});

	const answer = await new Promise((resolve) => {
		rl.question(`${message} [Y/N]`, (answer) => {
			rl.close();
			resolve(answer.trim().toLowerCase());
		});
	});

	return answer === 'y'
}

function stageAndCommitFiles(files) {
	execSync(`git add ${files.join(' ')}`)
	execSync(`git commit --no-verify -m "feat(art): update ${files.join(', ')}"`)
}

const files = process.argv.slice(2)
if (files.length === 0) {
	console.log("Error: No files specified.")
	process.exit(1)
}

const is_in_main = execSync("git branch --show-current").toString().trim() === "main"

if (!is_in_main) {
	if (await promptYesNo("Already in a changelist. Would you like to add these files to it?")) {
		stageAndCommitFiles(files)
	} else if (await promptYesNo("Would you like to return to the main branch?")) {
		execSync("git checkout main")
	} else {
		console.log("Cancelled")
		process.exit(1)
	}
} else {
	try {
		const stagedFiles = execSync('git diff --name-only --cached').toString().trim().split('\n');
		const filesToUnstage = stagedFiles.filter(file => !files.includes(file) && file.trim().length > 0);
		if (filesToUnstage.length > 0) {
			console.log(`Unstaging ${filesToUnstage.join(', ')}`)
			execSync(`git restore --staged ${filesToUnstage.join(' ')}`);
		}

		const branchName = `changelist-${crypto.randomUUID()}`
		execSync(`git checkout -b ${branchName}`)
		stageAndCommitFiles(files)
		console.log(execSync('git status').toString())
	} catch (error) {
		console.error("Error creating changelist:", error.message)
		process.exit(1)
	}
}
