from dataclasses import dataclass
from collections.abc import Callable
from typing import Optional, Generator, Union, overload


def change(amount: int) -> dict[int, int]:
    if not isinstance(amount, int):
        raise TypeError('Amount must be an integer')
    if amount < 0:
        raise ValueError('Amount cannot be negative')
    counts, remaining = {}, amount
    for denomination in (25, 10, 5, 1):
        counts[denomination], remaining = divmod(remaining, denomination)
    return counts


# Write your first then lower case function here
def first_then_lower_case(strings: list[str], predicate: Callable, /) -> Optional[str]     :
    for i in range(len(strings)):
        strings[i] = strings[i].lower()
        if predicate(strings[i]) == True:
            return strings[i]
    return None

# Write your powers generator here
def powers_generator(*, limit: int, base: int) -> Generator[int, None, None]:
    power = 0
    while True:
        result = base ** power
        if result > limit:
            break
        yield result
        power += 1

# Write your say function here
def say(message = None, /) -> Union[str, Callable]:
    if message == None:
        return ""
    else:
        # This effectively allows the function to instantiate a
        # new function that maintains the state of the message
        # being created
        class sayer:
            def __init__(self, message: Optional[str] = None):
                self.message = message
            def __call__(self, next: Optional[str] = None) -> Optional[Union[str, "sayer"]]:
                if type(next) is str and type(self.message) is str:
                    return sayer(self.message + " " + next)
                else:
                    return self.message
        return sayer(message)

# Write your line count function here
def meaningful_line_count(filename: str, /) -> int:
    line_count: int = 0
    with open(filename, mode='r', encoding="utf-8") as file:
        for line in file.readlines():
            stripped = line.strip()
            if stripped:
                if stripped[0] != '#':
                    line_count += 1
    return line_count


# Write your Quaternion class here

#Use a frozen dataclass DONE
#Overload the operators (+, *, and ==) DONE
#Require positional arguments DONE
#Make the conjugate and coefficients methods @propertys. NO IDEA
@dataclass(frozen=True)
class Quaternion:
    a: int
    b: int
    c: int
    d: int
    
    @property
    def coefficients(self):
        return (self.a, self.b, self.c, self.d)
    
    @property
    def conjugate(self):
        return Quaternion(self.a, -self.b, -self.c, -self.d)

    def __add__(self, other: "Quaternion") -> "Quaternion":
        return Quaternion(self.a + other.a, self.b + other.b, self.c + other.c, self.d + other.d)

    def __mul__(self, other: "Quaternion") -> "Quaternion": 
        mul_a: int = self.a * other.a - self.b * other.b - self.c * other.c - self.d * other.d
        mul_b: int = self.a * other.b + self.b * other.a + self.c * other.d - self.d * other.c
        mul_c: int = self.a * other.c - self.b * other.d + self.c * other.a + self.d * other.b
        mul_d: int = self.a * other.d + self.b * other.c - self.c * other.b + self.d * other.a
        return Quaternion(mul_a, mul_b, mul_c, mul_d)
    
    def __eq__(self, other: object) -> bool:
        if not isinstance(other, Quaternion):
            return NotImplemented
        return (self.a == other.a) and (self.b == other.b) and (self.c == other.c) and (self.d == other.d)

    def __str__(self) -> str:
        # Forms the stringified number, including its sign and direction, if applicable, for each coefficient of the quaternion
        def coef_to_str(coef, comp, /):
            return ("+" if coef >= 0 else "-") + (str(abs(coef)) if abs(coef) != 1 or not comp else "") + comp

        components = ("", "i", "j", "k")
        coef_strings: list[str] = [coef_to_str(c, components[i]) for i, c in enumerate(self.coefficients) if c != 0]
        if not coef_strings:
            return "0"
        else:
            coef_string = "".join(coef_strings)
            return coef_string[1:] if coef_string[0] == '+' else coef_string
