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
export class Quaternion {
  constructor(a, b, c, d) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;
    Object.freeze(this);
  }

  // Getter for coefficients
  get coefficients() {
    return [this.a, this.b, this.c, this.d];
  }

  // Getter for conjugate
  get conjugate() {
    return new Quaternion(this.a, -this.b, -this.c, -this.d);
  }

  // Addition method
  plus(other) {
    return new Quaternion(
      this.a + other.a,
      this.b + other.b,
      this.c + other.c,
      this.d + other.d
    );
  }

  // Multiplication method
  times(other) {
    const a = this.a * other.a - this.b * other.b - this.c * other.c - this.d * other.d;
    const b = this.a * other.b + this.b * other.a + this.c * other.d - this.d * other.c;
    const c = this.a * other.c - this.b * other.d + this.c * other.a + this.d * other.b;
    const d = this.a * other.d + this.b * other.c - this.c * other.b + this.d * other.a;
    return new Quaternion(a, b, c, d);
  }

  // Equality check method
  equals(other) {
    return other instanceof Quaternion &&
      this.a === other.a &&
      this.b === other.b &&
      this.c === other.c &&
      this.d === other.d;
  }

  // String representation of the quaternion
  toString() {
    const components = [];

    if (this.a !== 0) components.push(`${this.a}`);

    if (this.b !== 0) {
      let iComponent = '';
      if (this.b === 1) {
        iComponent = 'i';
      } else if (this.b === -1) {
        iComponent = '-i';
      } else {
        iComponent = `${this.b}i`;
      }

      if (this.b > 0 && components.length > 0) {
        components.push(`+${iComponent}`);
      } else {
        components.push(`${iComponent}`);
      }
    }

    if (this.c !== 0) {
      let jComponent = '';
      if (this.c === 1) {
        jComponent = 'j';
      } else if (this.c === -1) {
        jComponent = '-j';
      } else {
        jComponent = `${this.c}j`;
      }

      if (this.c > 0 && components.length > 0) {
        components.push(`+${jComponent}`);
      } else {
        components.push(`${jComponent}`);
      }
    }

    if (this.d !== 0) {
      let kComponent = '';
      if (this.d === 1) {
        kComponent = 'k';
      } else if (this.d === -1) {
        kComponent = '-k';
      } else {
        kComponent = `${this.d}k`;
      }

      if (this.d > 0 && components.length > 0) {
        components.push(`+${kComponent}`);
      } else {
        components.push(`${kComponent}`);
      }
    }

    return components.length > 0 ? components.join('') : '0';
  }
}