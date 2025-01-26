#!/usr/bin/env -S node
//MISE quiet=true
//MISE description="Synchronises your changes with the remote repository. This will first pull changes from the remote and then push your changes up."

import { execSync } from 'child_process'

function getUntrackedFiles() {
	return execSync('git ls-files --modified --others --exclude-standard', {stdout: 'inherit'})
		.toString()
		.trim()
		.split('\n')
		.filter(Boolean);
}

function getStagedFiles() {
	return execSync('git diff --name-only --cached', {stdout: 'inherit'})
		.toString()
		.trim()
		.split('\n')
		.filter(Boolean);
}

const otherFiles = getUntrackedFiles().concat(getStagedFiles())
let stashed = otherFiles.length > 0
if (stashed) {
	execSync(`git add ${otherFiles.join(' ')}`)
	execSync('git stash')
}

try {
	const branch = execSync('git branch --show-current', {stdout: 'inherit'}).toString().trim()
	
	if (execSync(`git ls-remote --heads origin ${branch}`, {stdout: 'inherit'}).toString().trim() !== '') {
		execSync(`git branch --set-upstream-to=origin/${branch} ${branch}`, {stdout: 'inherit'})
		execSync('git pull', {stdout: 'inherit'})
		execSync('git lfs pull', {stdout: 'inherit'})

		if (stashed) {
			execSync('git stash pop')
			stashed = false
		}
	}
	if (branch === 'main') {
		process.exit(0)
	} 

	execSync(`git lfs push origin ${branch} --all`, {stdout: 'inherit'})

	const locked = JSON.parse(execSync('git lfs locks --local --json', {stdout: 'inherit'})).map(it => it.path)
	if (locked.length > 0) {
		execSync(`git lfs unlock ${locked.join(' ')}`, {stdout: 'inherit'})
	}

	execSync(`git push -u origin ${branch}`, {stdout: 'inherit'})
} catch (error) {
	console.log(error.stdout?.toString())
	console.error('Error:', error.stderr?.toString())
	console.error(error)
	
	if (stashed) {
		execSync('git stash pop')
		stashed = false
	}
	
	process.exit(1)
}

if (stashed) {
	execSync('git stash pop')
	stashed = false
}
