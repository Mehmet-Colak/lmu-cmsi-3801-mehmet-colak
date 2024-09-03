from dataclasses import dataclass
from collections.abc import Callable
from typing import Optional, Generator, Union


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


# Write your Quaternion class here
