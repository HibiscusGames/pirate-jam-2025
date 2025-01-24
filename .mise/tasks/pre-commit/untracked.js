#!/usr/bin/env -S node
//MISE hide=true
//MISE description="Check for untracked files and prompt user to add them to the commit"

import { execSync } from 'child_process'
import readline from 'readline'

const COLORS = {
	GREEN: '\x1b[32m',
	YELLOW: '\x1b[33m',
	RED: '\x1b[31m',
	RESET: '\x1b[0m'
};

function getUntrackedFiles() {
	return execSync('git ls-files --modified --others --exclude-standard')
		.toString()
		.trim()
		.split('\n')
		.filter(Boolean);
}

function promptToStageFile(file) {
	const rl = readline.createInterface({
		input: process.stdin,
		output: process.stdout
	});

	return new Promise((resolve) => {
		rl.question(`Would you like to stage '${COLORS.RED}${file}${COLORS.RESET}'? [Y/N/A/Q] `, (answer) => {
			rl.close();
			resolve(answer.trim().toLowerCase());
		});
	});
}

async function main() {
	try {
		console.log(`${COLORS.YELLOW}Checking for untracked files...${COLORS.RESET}`);
		const untrackedFiles = getUntrackedFiles();

		if (untrackedFiles.length > 0) {
			console.log(`${COLORS.YELLOW}Found untracked files:${COLORS.RED}`);
			untrackedFiles.forEach(file => console.log(`  - ${file}`));
			console.log(COLORS.RESET);

			let count = 0
			for (const file of untrackedFiles) {
				const answer = await promptToStageFile(file);

				if (answer === 'y') {
					execSync(`git add ${file}`);
				} else if (answer === 'a') {
					execSync(`git add ${untrackedFiles.slice(count).join(' ')}`);
					return
				} else if (answer === 'q') {
					return
				}

				count++
			}
		} else {
			console.log(`${COLORS.GREEN}No untracked files found.${COLORS.RESET}`);
		}
	} catch (error) {
		console.error('Error:', error);
		return
	}
}

await main();
