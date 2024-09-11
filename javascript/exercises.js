import { count } from "node:console"
import { open } from "node:fs/promises"

export function change(amount) {
  if (!Number.isInteger(amount)) {
    throw new TypeError("Amount must be an integer")
  }
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let [counts, remaining] = [{}, amount]
  for (const denomination of [25, 10, 5, 1]) {
    counts[denomination] = Math.floor(remaining / denomination)
    remaining %= denomination
  }
  return counts
}

// Write your first then lower case function here
export function firstThenLowerCase( words, predicate) {
  for (let word of words) {
    const lower = word.toLowerCase();
    if (predicate?.(lower)) {
      return lower;
    }
  }
  return undefined;
}

// Write your powers generator here
export function* powersGenerator({ ofBase: base, upTo: limit }){
  let value = 1
  while (value <= limit) {
    yield value
    value *= base
  }
}

// Write your say function here
export function say(message) {
  if (message === undefined) {
    return ""
  }
  const addIt = secondMessage => secondMessage===undefined ? message : say(message + " " + secondMessage)
  return addIt
}

// Write your line count function here
export async function meaningfulLineCount(filename) {
  let counts = 0
  const file = await open(filename, 'r')
  for await (const line of file.readLines()) {
    const stripped = line.trim()
    if (stripped) {
      if (stripped[0] != '#'){
        counts += 1
      }
    }
  }
  if (counts == 0){
    throw new Error('No such line.')
  }
  return counts
}

// Write your Quaternion class here
