import {
  dirname,
  join,
  normalize,
} from "https://deno.land/std@0.187.0/path/mod.ts";
import {
  cyan,
  dim,
  green,
  red,
  yellow,
} from "https://deno.land/std@0.187.0/fmt/colors.ts";

const HOME = Deno.env.get("HOME");
if (!HOME) throw new Error("Could not find HOME");

const expandTilde = (path: string) => {
  if (!path) return path;
  if (path === "~") return HOME;
  if (path.slice(0, 2) !== "~/") return path;
  return join(HOME, path.slice(2));
};

export function cp(from: `~/${string}`, to?: string): Promise<void>;
export function cp(from: string, to: string): Promise<void>;
export async function cp(from: string, to?: string): Promise<void> {
  if (!to) to = from.replace("~/", "");

  try {
    await Deno.mkdir(dirname(to), { recursive: true });
  } catch { /* */ }

  await Deno.copyFile(
    normalize(expandTilde(from)),
    join(Deno.cwd(), normalize(to)),
  );

  console.log(`${green("Copied")} ${from} ${dim("to")} ${to}`);
}

export const exec = async (cmd: [string, ...string[]]) => {
  const command = new Deno.Command(cmd[0], {
    args: cmd.slice(1),
    stdout: "piped",
  });

  const { stdout, success, code } = await command.output();
  if (!success) {
    console.error(
      `${red("Error")} running ${cmd.join(" ")} failed with code ${code}`,
    );
    Deno.exit(1);
  }

  return new TextDecoder().decode(stdout);
};

export const writeText = async (to: string, text: string) => {
  try {
    await Deno.mkdir(dirname(to), { recursive: true });
  } catch { /* */ }
  await Deno.writeTextFile(to, text);
};

export const logExec = (thing: string, to: string) => {
  console.log(cyan("Wrote"), thing, dim("to"), to);
};

const CLEAN_EXEMPTIONS = [".vscode", ".git", ".gitignore"];
export const clean = async () => {
  if (!Deno.cwd().endsWith("dotfiles")) {
    throw new Error(
      "Not in dotfiles directory, emergency aborting cleaning procedure",
    );
  }

  for await (const item of Deno.readDir(Deno.cwd())) {
    if (item.name.startsWith("_") || CLEAN_EXEMPTIONS.includes(item.name)) {
      continue;
    }

    await Deno.remove(item.name, { recursive: true });
  }

  console.log(`${yellow("Cleared")} current directory`);
};
