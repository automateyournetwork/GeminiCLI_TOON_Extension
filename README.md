🎨 Gemini-CLI TOON Extension

Automatic JSON → TOON conversion for massive token savings
Stop sending huge JSON blobs into Gemini — let the extension compress, normalize, and optimize everything automatically.

Inspired by the TOON project: 

https://github.com/toon-format/toon

🧠 What It Does

The Gemini-CLI TOON Extension is a plug-in that transparently converts any JSON into TOON, a compact, token-efficient structured format designed for LLMs.

Whenever the user (or another extension) provides JSON:

pyATS output

network telemetry

configuration models

API payloads

inventory databases

raw JSON strings

nested dict/list structures

…the extension automatically:

Detects JSON

Normalizes it

Converts it to TOON via the TOON CLI

Reports exact token savings

Returns the TOON block as the canonical data source for Gemini reasoning

This saves users massive context window space, reduces cost, and greatly improves structured prompting.

You can also invoke it manually with slash commands.

⚙️ Install

gemini extensions install https://github.com/automateyournetwork/GeminiCLI_TOON_Extension.git


No additional manual setup is required—after installation, the TOON MCP server runs behind the scenes and all slash commands become available.

🚀 Core Features

✔ Automatic JSON Interception

If Gemini sees any JSON anywhere in the conversation, it will:

Extract it

Convert it to TOON

Replace the JSON with the TOON representation

Output a # Token Savings report every time

This is zero-effort optimization.

✔ Manual Slash Commands

Use these when you want explicit control:

Command	What it Does

/toon:json	Convert a structured JSON object (dict/list/etc.) into TOON

/toon:string	Convert a raw JSON string into TOON

Both return:

A fenced ```toon block with the converted content

A Token Savings section showing JSON tokens, TOON tokens, and % saved

✔ Always-On Token Reporting

Every TOON conversion includes:

# Token Savings

- JSON tokens: <N>

- TOON tokens: <M>

- Saved: <X%>


Even if the conversion fails, JSON token count is included.

🧩 MCP Tools Behind the Scenes

The extension exposes two MCP tools:

to_toon(data: any)

For structured objects the LLM already parsed.

to_toon_from_string(json_text: string)

For raw text that needs parsing.

Both tools:

Normalize → Convert → Count tokens → Emit TOON block + savings

Guarantee consistent formatting

Are automatically used when Gemini detects JSON in a conversation

💡 Example Workflows

Natural Language

“Here’s some JSON — what does it mean?”

Gemini automatically detects the JSON → calls TOON → reasons using TOON.

Slash Commands

Explicit user control:

/toon:json data=<parsed object>

/toon:string json_text="{\"interfaces\": [...]}"

Pipeline Usage

Other extensions (vision, subnetcalc, packet buddy, config copilot, etc.) can send their JSON output into the TOON extension to massively reduce tokens before further reasoning.

🧠 Why TOON?

TOON (Token-Oriented Object Notation) is:

More compact than JSON

Schema-friendly

Easier for LLMs to parse

Extremely token-efficient

Human-readable

This extension gives Gemini CLI users huge token savings, allowing far larger datasets to fit into prompts.

📦 Typical Flow
/toon:string json_text="{\"hostname\": \"R1\", \"interfaces\": [...]}"


Gemini outputs:

A ```toon block

A Token Savings report

You continue the conversation using TOON, not JSON

🛡️ Safety

Only structured normalization + TOON conversion is performed

No remote network calls

No unsafe shell execution

JSON contents are not modified beyond formatting

👤 Author

John Capobianco

Head of Developer Relations — Selector AI

Creator of the Gemini-CLI multimodal ecosystem:

/talk, /listen, /vision, /computeruse, /packet_buddy, /subnetcalculator, /file_search, now /toon

"The CLI is dead — long live the multimodal CLI."

🚀 Start Using It

Once installed, just run:

/toon


or simply drop JSON into the conversation — the extension handles the rest.
