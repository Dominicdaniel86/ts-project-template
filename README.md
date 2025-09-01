# TypeScript Project Template

This repository offers a ready-to-use TypeScript template with sensible defaults and best-practice tooling. It includes a pre-configured TypeScript compiler, ESLint, Prettier, Nodemon, a recommended .gitignore, multiple licenses to choose from, and optional Docker integration. This setup is intended for Unix-based systems only.

## Usage

1. Open the GitHub page of this repository: [https://github.com/Dominicdaniel86/ts-project-template](https://github.com/Dominicdaniel86/ts-project-template).
2. Select **Use this template** -> **Create a new repository**.
3. Give the repository a name and define the visbility.
4. Clone the repository (`git clone <URL>`) and open the project in your terminal (`cd <project-name>`).
5. Execute the setup.sh script (`./setup.sh`) and follow the setup instructions.

---

## Setup Options

### Backend

- **`Node.js`** - Node.js, the most common JavaScript/ TypeScript backend.
- **`None`** - Frontend project only.

More options will follow in the future.

### Module Type

- **`CommonJS (CJS)`** – Legacy Node.js modules with `require()`/`module.exports`. Best for older projects.
- **`ES Modules (ESM)`** – Modern `import`/`export` syntax. Recommended for new projects and tooling.

### Docker

- **`Yes - Docker-compose`** - This project will inlcude a Docker integration. This will add a `docker-compose` file, a `Dockerfile` for the backend and alter the Nodemon configuration to work with Docker.
- **`Yes - Dockerfile only`** - This will still add a `Dockerfile` and alter the Nodemon configuration, but not add a `docker-compose` file.
- **`No`** - This project will be pre-defined to be used for local development.

### Licence

- **`MIT`** - Fewest Strings Attached
- **`Apache-2.0`** - Permissive + Patent Protection
- **`GPL-3.0`** - Strong Copyleft (keep derivatives open)
- **`LGPL-3.0`** - Library-Friendly Copyleft
- **`MPL-2.0`** - Light/ File-Level Copyleft
- **`Custom Licence`** - Will create an empty `LICENCE` file, that needs to be filled with the content of your prefered licence model.
- **`No Licence`** - Will not create a `LICENCE` file.

### Provide more Information

During setup, you decide if you want to provide additional details for your `package.json` files:

- *`*Project-Name`**: The name of your project.
- **`Description`**: A short summary of your project.
- **`Author`**: Even if you select "No" for a license, you might still be asked for the author name, as some license models (e.g., MIT, Apache-2.0) require author attribution.
- **`Repository-URL`**: The URL of your GitHub repository.
- **`Keywords`**: Relevant keywords to improve discoverability.

### Commit Changes

You can choose whether to automatically create a commit after running the setup script:

- **`Yes`**: The setup script will create a new commit with a customizable commit message (default: `Initial commit`). You can edit the message before confirming.
- **`No`**: No commit will be created; you can review changes and commit manually.

This option helps you control your project's initial commit history.

---

## Configurations

### TypeScript-Compiler

#### Backend

- **`target: "ES2024"`** – Emit modern JavaScript with the latest language features.
- **`lib: ["ES2024", "DOM"]`** – Type definitions for ES2024 + DOM APIs *(remove `"DOM"` if backend-only)*.
- **`module: "NodeNext"`** – Native ESM output aligned with Node’s module system.
- **`moduleResolution: "nodenext"`** – Resolve imports using Node’s ESM/CJS rules and `exports` fields.
- **`rootDir: "./src"`** – Treat `src/` as the source root for compilation.
- **`outDir: "./dist"`** – Emit compiled files to `dist/`.
- **`baseUrl: "./"`** – Base directory for non-relative module imports.
- **`resolveJsonModule: true`** – Allow `import data from "./file.json"` with proper typing.
- **`sourceMap: true`** – Generate `.map` files so stack traces map back to `.ts`.
- **`esModuleInterop: true`** – Improve CJS ↔ ESM interop (enables default imports from CJS packages).
- **`allowSyntheticDefaultImports: true`** – Permit default-style imports when a module lacks a real default export.
- **`forceConsistentCasingInFileNames: true`** – Enforce correct path casing across the project.
- **`strict: true`** – Enable all strict type-checking options.
- **`noImplicitAny: true`** – Disallow implicit `any` types.
- **`noImplicitReturns: true`** – Require explicit returns in all code paths.
- **`skipLibCheck: true`** – Skip type-checking of `.d.ts` in dependencies for faster builds.
- **`include: ["src/**/*", "node_modules/@prisma/client"]`** – Compile project sources and Prisma client types.
- **`exclude: ["node_modules", "dist"]`** – Ignore external deps and build output during compilation.

#### Frontend

- **`target: "ES2024"`** – Emit modern JavaScript with the latest language features.
- **`lib: ["ES2024", "DOM"]`** – Include browser and modern ECMAScript type definitions.
- **`module: "ESNext"`** – Keep native ESM syntax for optimal bundler tree-shaking.
- **`moduleResolution: "bundler"`** – Resolve imports the same way modern bundlers (Vite/Webpack/Rspack) do.
- **`rootDir: "./src"`** – Treat `src/` as the source root for compilation.
- **`outDir: "./dist"`** – Emit compiled assets to `dist/`.
- **`baseUrl: "./"`** – Base directory for absolute (non-relative) imports.
- **`resolveJsonModule: true`** – Allow `import data from "./file.json"` with proper typing.
- **`allowJs: true`** – Include `.js` files alongside `.ts`/`.tsx` in the program.
- **`allowSyntheticDefaultImports: true`** – Permit default-style imports when a module lacks a real default export.
- **`esModuleInterop: true`** – Improve CJS ↔ ESM interop for smoother imports.
- **`forceConsistentCasingInFileNames: true`** – Enforce correct path casing across platforms.
- **`strict: true`** – Enable all strict type-checking options.
- **`noImplicitAny: true`** – Disallow implicit `any` types.
- **`noImplicitReturns: true`** – Require explicit returns in all code paths.
- **`skipLibCheck: true`** – Skip type-checking of dependency `.d.ts` files for faster builds.
- **`include: ["src"]`** – Compile project sources in `src/`.
- **`exclude: ["node_modules", "dist"]`** – Ignore external deps and build output during compilation.

### ESLint

#### Backend

- **`Flat config (ESLint v9)`** – Uses a flat `eslint.config.mjs` with per-file settings.
- **`files: ["**/*.ts"]`** – Lint all TypeScript source files.
- **`ignores: ["eslint.config.mjs"]`** – Skip the config file itself.
- **`parser: @typescript-eslint/parser`** – TypeScript-aware parsing.
- **`parserOptions.project: "./tsconfig.json"`** – Enable **type-aware** rules by pointing to the TS project.
- **`parserOptions.sourceType: "module"`** – ESM syntax.
- **`plugins: ["@typescript-eslint", "prettier", "unused-imports"]`** – TS rules, Prettier integration, and unused-imports utilities.
- **`extends (via spreads)`** – Merge:
  - **`typescript-eslint/configs/recommended`** – Core recommended TS rules.
  - **`typescript-eslint/configs/recommendedTypeChecked`** – Extra rules that require type info.
  - **`../shared/eslintRules.mjs`** – Your shared project rules.
- **`@typescript-eslint/no-unused-vars: "warn"`** – Warn on unused vars; allow `_`-prefixed args/vars:
  `{ argsIgnorePattern: "^_", varsIgnorePattern: "^_" }`.
- **`@typescript-eslint/strict-boolean-expressions: "error"`** – Enforce strict truthiness checks.
- **`no-process-exit: "error"`** – Forbid `process.exit()` (outside dedicated CLI code).
- **`no-sync: "warn"`** – Discourage blocking sync Node APIs (e.g., `fs.*Sync`).
- **`no-console: ["error", { allow: ["warn", "error"] }]`** – Block `console.log` but allow warnings/errors.
- **`prettier` plugin active** – Formatting issues can surface as ESLint problems (rule severity as defined in shared rules).

#### Frontend

- **`Flat config (ESLint v9)`** – Uses a flat `eslint.config.mjs`.
- **`files: ["**/*.ts"]`** – Lint all TypeScript files.
- **`ignores: ["eslint.config.mjs"]`** – Skip the config file itself.
- **`parser: @typescript-eslint/parser`** – TypeScript-aware parsing.
- **`parserOptions.project: "./tsconfig.json"`** – Enable **type-aware** rules using your TS project.
- **`parserOptions.sourceType: "module"`** – ESM syntax.
- **`plugins: ["@typescript-eslint", "prettier", "unused-imports"]`** – TS rules, Prettier integration, and unused-imports utilities.
- **`extends (via spreads)`** – Merge:
  - **`typescript-eslint/configs/recommended`**
  - **`typescript-eslint/configs/recommendedTypeChecked`**
  - **`../shared/eslintRules.mjs`** (shared rules)
- **`@typescript-eslint/no-unused-vars: ["warn", { argsIgnorePattern: "^_" }]`** – Warn on unused vars; allow `_`-prefixed parameters.
- **`no-alert: "error"`** – Forbid `alert`, `confirm`, and `prompt`.
- **`no-restricted-globals: ["error", "event", "fdescribe"]`** – Disallow problematic browser globals.
- **`no-console: ["warn", { allow: ["warn", "error"] }]`** – Allow `console.warn` / `console.error` only.
- **`no-implicit-globals: "error"`** – Prevent accidental globals in the browser.

### Prettier

- **`arrowParens: "always"`** – Always include parentheses around arrow function parameters, even if there’s only one.
- **`bracketSpacing: true`** - Print spaces between brackets in object literals (`{ foo: bar }`).
- **`embeddedLanguageFormatting: "auto"`** - Let Prettier automatically format code blocks within strings or templates.
- **`endOfLine: "lf"`** – Enforce Unix-style line endings (`\n`), ensuring consistency across environments.
- **`printWidth: 120`** – Enforces a wider maximum line length (*120 characters*) for better readability without excessive wrapping.
- **`semi: true`** – Always add semicolons at the end of statements.
- **`singleQuote: true`** – Use single quotes instead of double quotes for strings.
- **`tabWidth: 4`** – Indent with 4 spaces per level.
- **`trailingComma: "es5"`** – Add trailing commas where valid in ES5 (*objects, arrays, etc.*), but not in function arguments.
- **`useTabs: false`** - Use spaces for indentation, not hard tabs.

### Nodemon

Nodemon is set to restart the server whenever files in `src/` change (`watch: ["./src"]`) and to watch only TypeScript files (`ext: "ts"`). It runs the app without a build step using `ts-node`’s ESM loader and exposes the Node inspector on port **9229** (`exec: node --inspect=9229 --loader ts-node/esm ./src/index.ts`). For reliable reloads in Docker, WSL, or network filesystems, it uses polling (`legacy-watch: true`).

### .gitignore

This .gitignore file contains a basic, pre-defined list of file endings and directory names, that you usally don't want to push to the repository (such as .env files). It's a predefined file, that was taken from [https://github.com/github/gitignore](https://github.com/github/gitignore), a repository that contains multiple pre-defined `.gitignore` templates.
