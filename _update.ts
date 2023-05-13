import { clean, cp, exec, logExec, writeText } from "./_utils.ts";

await clean();

await cp("~/.zshrc");
await cp("~/.zprofile");
await cp("~/.gitconfig");

await cp("~/.config/neofetch/config.conf");
await cp("~/.config/hyfetch.json");
await cp("~/.config/starship.toml");
await cp("~/.config/helix/config.toml");
await cp("~/.config/bat/config");
await cp("~/.config/silicon/config");

await exec(["brew", "bundle", "dump", "--file=-"]).then(async (output) => {
  await writeText("packages/Brewfile", output);
  logExec("Homebrew packages", "packages/Brewfile");
});

await exec(["fnm", "ls"]).then(async (output) => {
  const versions = output
    .split("\n")
    .filter(Boolean)
    .map((k) => k.split(" ").filter(Boolean).slice(1))
    .filter((v) => v[0] !== "system");

  await writeText(
    "packages/fnm.sh",
    versions
      .map((v) =>
        `fnm install ${v[0]}` + (v[1] ? ` && fnm alias ${v[0]} ${v[1]}` : "")
      )
      .join("\n") +
      "\n",
  );

  logExec("Node.js versions (fnm)", "packages/fnm.sh");
});

await exec(["pyenv", "versions"]).then(async (output) => {
  const versions = output
    .split("\n")
    .map((line) => line.startsWith("*") ? line.slice(1) : line)
    .map((line) => line.split(" ").filter(Boolean)[0])
    .filter((k) => !!k && k !== "system");

  await writeText(
    "packages/pyenv.sh",
    versions.map((v) => `pyenv install ${v}`).join("\n") + "\n",
  );

  logExec("Python versions (pyenv)", "packages/pyenv.sh");
});

await exec(["pipx", "list", "--json"]).then(async (output) => {
  const data = JSON.parse(output) as { venvs: { [name: string]: unknown } };

  await writeText(
    "packages/pipx.sh",
    Object.keys(data.venvs).map((k) => `pipx install ${k}`).join("\n") + "\n",
  );

  logExec("Python applications (pipx)", "packages/pipx.sh");
});
