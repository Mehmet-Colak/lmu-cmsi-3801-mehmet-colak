import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Optional;
import java.util.function.Predicate;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Exercises {
    static Map<Integer, Long> change(long amount) {
        if (amount < 0) {
            throw new IllegalArgumentException("Amount cannot be negative");
        }
        var counts = new HashMap<Integer, Long>();
        for (var denomination : List.of(25, 10, 5, 1)) {
            counts.put(denomination, amount / denomination);
            amount %= denomination;
        }
        return counts;
    }

    // Write your first then lower case function here
    //
    static Optional<String> firstThenLowerCase(List<String> a, Predicate<String> p) {
        return a.stream()
                    .filter(p)
                    .findFirst()
                    .map(x -> x.toLowerCase());
    }
    // Write your say function here

    // Write your line count function here
}

// Write your Quaternion record class here

// public record Quaternion(double ZERO, double I, double J, double K) {}

// Write your BinarySearchTree sealed interface and its implementations here

// UNFINISHED UNFINISHED
sealed interface BinarySearchTree permits Empty, Node {
    int size();
    boolean contains();
    BinarySearchTree insert();
}

final class Empty implements BinarySearchTree {
    public int size() {
        return 0;
    }
    public boolean contains(String item) {
        return false;
    }
}

final class Node implements BinarySearchTree {
    final String head;
    final BinarySearchTree tail;
    
    Node(String head, BinarySearchTree tail) {
        this.head = head;
        this.tail = tail;
    }
    
    public int size() {}

    public BinarySearchTree insert(String item) {}

    public boolean contains(String item) {}
}
// UNFINISHED UNFINISHED