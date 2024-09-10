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
    return "";
  }

  function sayer(message) {
    this.message = message;
  }

  sayer.prototype.call = function(next) {
    if (typeof next === 'string' && typeof this.message === 'string') {
      return new sayer(this.message + " " + next);
    } else {
      return this.message;
    }
  };

  return new sayer(message);
}

// Write your line count function here

// Write your Quaternion class here
