TOON Extension (JSON → TOON → Token Savings)

This extension adds a TOON MCP server that automatically or manually converts JSON into TOON format to significantly reduce token usage.
The primary purpose of this extension is:

Whenever JSON appears in a prompt, a reply, a tool response, or any data structure → convert it to TOON before reasoning about it or passing it forward.

This applies to:

pyATS output

network configuration structures

inventories and topology models

telemetry documents

nested or large dictionaries/lists

API payloads

raw JSON strings in quotes

structured objects returned from other tools

TOON is the canonical representation. Raw JSON should not be used for internal reasoning unless explicitly required.

Commands

These high-level Gemini-CLI commands wrap the MCP tools:

/toon — quick reference.

/toon:json — convert structured JSON data (object/dict/list) into TOON.

/toon:string — convert a raw JSON string into TOON.

Both commands return the same output structure:

A fenced ```toon block containing the TOON representation

A # Token Savings section that must always be returned, showing:

JSON token count

TOON token count

Percentage saved

MCP Tools

The MCP server exposes two tools used by the extension and by the LLM automatically:

1. to_toon(data: any) -> string

Use when JSON is already parsed into a structured object.

Behavior:

Normalizes the object into JSON-safe form

Converts it to TOON format

Computes token usage for:

Original JSON

Resulting TOON

Returns TOON + token savings

2. to_toon_from_string(json_text: string) -> string

Use when handling raw JSON text.

Behavior:

Parses the text as JSON

Performs the same conversion and token comparison as to_toon

Automatic Behavior (Critical LLM Instruction)

The LLM MUST ALWAYS do the following:

1. If any JSON is present anywhere → intercept it and convert it to TOON.

This includes:

User input containing JSON

Tool responses returning JSON

Files or strings that look like JSON

Internal chain-of-thought structures involving JSON-like data

2. The LLM should prefer TOON for all reasoning.

DO:

Interpret TOON as the authoritative, compact representation

Answer questions directly using the TOON block

DO NOT:

Reason over raw JSON

Pass JSON directly into the context

Return large JSON objects

3. When invoking the TOON MCP tools, ALWAYS include the token savings in the final output.

Token savings report is mandatory and should never be omitted, even if:

The JSON is tiny

The gain is negligible

Token counting fails (in which case: report "unavailable")

4. TOON should be used wherever JSON would otherwise appear.

This includes:

Summaries

Diffs

Merged datasets

Configuration comparisons

Multi-step agent workflows

Minimal Example (Behavior Only, No Real Data)
Example A — Structured JSON
/toon:json data=<your object>


Returns:

```toon … ```

Token Savings section

Example B — Raw JSON string
/toon:string json_text="<json_here>"


Returns:

```toon … ```

Token Savings section

Operational Summary (LLM Rules)
ALWAYS

Detect JSON automatically

Convert JSON → TOON immediately

Use the TOON block for all reasoning

Return token savings every time

Use MCP tools to perform the conversion

NEVER

Process or return raw JSON without conversion

Reason using large JSON blocks directly

Omit the token savings section