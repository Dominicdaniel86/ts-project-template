# TypeScript Project Template

This repository offers a ready-to-use TypeScript template with sensible defaults and best-practice tooling. It includes a pre-configured TypeScript compiler, ESLint, Prettier, Nodemon, a recommended .gitignore, multiple licenses to choose from, and optional Docker integration. This setup is intended for Unix-based systems only.

## Usage

1. Open the GitHub page of this repository: [https://github.com/Dominicdaniel86/ts-project-template](https://github.com/Dominicdaniel86/ts-project-template).
2. Select **Use this template** -> **Create a new repository**.
3. Give the repository a name and define the visbility.
4. Clone the repository (`git clone <URL>`) and open the project in your terminal (`cd <project-name>`).
5. Execute the setup.sh script (`./setup.sh`) and follow the setup instructions.
6. Adjust the `package.json` file(s) to match your project (fields like *repository*, *author*, ..).

---

## Setup Options

### Backend

- **`Node.js`** - Node.js, the most common JavaScript/ TypeScript backend.
- **`None`** - Frontend project only.

More options will follow in the future.

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

---

## Configurations

### TypeScript-Compiler

...

### ESLint

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


### Prettier

...

### Nodemon

...

### .gitignore

This .gitignore file contains a basic, pre-defined list of file endings and directory names, that you usally don't want to push to the repository (such as .env files). It's a predefined file, that was taken from URL.
