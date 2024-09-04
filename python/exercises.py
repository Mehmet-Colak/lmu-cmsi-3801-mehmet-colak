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
    # 'with' automatically opens and closes the file
    # once its code block ends, and can also raise
    # any relevant exceptions
    with open(filename, mode='r', encoding="utf-8") as file:
        for line in file.readlines():
            stripped = line.strip() # Removes all leading and trailing whitespace
            if stripped:
                if stripped[0] != '#': # Guaranteed since stripped cannot be empty here
                    line_count += 1
    return line_count


# Write your Quaternion class here

#Use a frozen dataclass NO IDEA
#Overload the operators (+, *, and ==) WORKING
#Require positional arguments DONE
#Make the conjugate and coefficients methods @propertys. NO IDEA
class Quaternion:
    def __init__(self, a: int, b: int, c: int, d: int, /) -> None:
        self.a = a
        self.b = b
        self.c = c
        self.d = d
    
    #are we overwriting our current powers?

    @overload
    def __add__(self, other: "Quaternion") -> "Quaternion":
        return Quaternion(self.a + other.a, self.b + other.b, self.c + other.c, self.d + other.d).__str__

    @overload
    def __mul__(self, other: "Quaternion") -> "Quaternion":
        return Quaternion(self.a * other.a, self.b * other.b, self.c * other.c, self.d * other.d)
    
    @overload
    def __eq__(self, other: "Quaternion") -> bool:
        return (self.a == other.a) and (self.b == other.b) and (self.c == other.c) and (self.d == other.d)

    @overload
    def __str__(self) -> str:
        quat_desc: str = ""
        if self.a < 0:
            quat_desc += "-"
            quat_desc += self.a
        elif self.a == 0:
            pass
        else:
            quat_desc += self.a
        
        if self.b < 0:
            quat_desc += "-"
            quat_desc += self.a + "i"
        elif self.b == 0:
            pass
        else:
            quat_desc += "+"
            quat_desc += self.a + "i"
        
        if self.c < 0:
            quat_desc += "-"
            quat_desc += self.c + "j"
        elif self.c == 0:
            pass
        else:
            quat_desc += "+"
            quat_desc += self.c + "j"

        if self.d < 0:
            quat_desc += "-"
            quat_desc += self.d + "k"
        elif self.d == 0:
            pass
        else:
            quat_desc += "+"
            quat_desc += self.d + "k"
        
        return quat_desc