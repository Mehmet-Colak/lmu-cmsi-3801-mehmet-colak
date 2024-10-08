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

    static Optional<String> firstThenLowerCase(List<String> a, Predicate<String> p) {
        return a.stream()
                    .filter(p)
                    .findFirst()
                    .map(x -> x.toLowerCase());
    }

    public static sayer say(){
        return new sayer("");
    }

    public static sayer say(String phrase){
        return new sayer(phrase);
    }

    public static record sayer(String phrase){
        public sayer and(String message){
            return new sayer(phrase + " " + message);
        }
    }

    public static int meaningfulLineCount(String filename) throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            return (int) reader.lines()
                    .filter(line -> !line.trim().isEmpty())
                    .filter(line -> line.trim().charAt(0) != '#')
                    .count();
        } catch (IOException e){
            throw e;
        }
    }
}

record Quaternion(double a, double b, double c, double d) {
    public final static Quaternion ZERO = new Quaternion(0.0, 0.0, 0.0, 0.0);
    public final static Quaternion I = new Quaternion(0.0, 1.0, 0.0, 0.0);
    public final static Quaternion J = new Quaternion(0.0, 0.0, 1.0, 0.0);
    public final static Quaternion K = new Quaternion(0.0, 0.0, 0.0, 1.0);

    public Quaternion {
        if (Double.isNaN(a) || Double.isNaN(b) || Double.isNaN(c) || Double.isNaN(d)) {
            throw new IllegalArgumentException("Coefficients cannot be NaN");
        }
    }

    Quaternion plus(Quaternion other) {
        return new Quaternion(a + other.a(), b + other.b(), c + other.c(), d + other.d());
    }

    Quaternion times(Quaternion other) {
        return new Quaternion(a * other.a() - b * other.b() - c * other.c() - d * other.d(),
                          b * other.a() + a * other.b() + c * other.d() - d * other.c(),
                          a * other.c() - b * other.d() + c * other.a() + d * other.b(),
                          a * other.d() + b * other.c() - c * other.b() + d * other.a());
    }

    List<Double> coefficients() {
        return List.copyOf(List.of(a, b, c, d));
    }

    Quaternion conjugate() {
        return new Quaternion(a, -b, -c, -d);
    }

    private String plusOrMinus(Double coeff) {
        if (Math.abs(coeff) == 1.0) return ((coeff > 0) ? ("+") : ("-"));
        return ((coeff > 0) ? ("+") : (""));
    }

    @Override
    public String toString() {
        List<Double> coeffs = this.coefficients();
        List<String> dims = List.of("","i","j","k");
        String coeffStr = "";
        int zeroCounter = 0;
        for (int i = 0; i < coeffs.size(); i++){
            if (coeffs.get(i) == 0) {
                zeroCounter += 1;
                continue;
            } else if (i == 0) {
                coeffStr += Double.toString(coeffs.get(i));
            } else if (Math.abs(coeffs.get(i)) == 1.0) {
                coeffStr += (plusOrMinus(coeffs.get(i)) + dims.get(i));
            } else {
                coeffStr += (plusOrMinus(coeffs.get(i)) + Double.toString(coeffs.get(i)) + dims.get(i));
            }
        }
        if (zeroCounter == 4) {
            return "0";
        } else {
            if (coeffStr.charAt(0) == '+') {
                coeffStr = coeffStr.substring(1);
            }
            return coeffStr;
        }
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Quaternion)) {
            return false;
        }
        Quaternion other = (Quaternion) o;
        return ((a == other.a()) && (b == other.b()) && (c == other.c()) && (d == other.d()));
    }
}

sealed interface BinarySearchTree permits Empty, Node {
    int size();
    boolean contains(String value);
    BinarySearchTree insert(String value);
}

final record Empty() implements BinarySearchTree {
    @Override
    public int size() {
        return 0;
    }
    @Override
    public boolean contains(String item) {
        return false;
    }
    @Override
    public BinarySearchTree insert(String value) {
        return new Node(value, this, this);
    }

    @Override
    public String toString() {
        return "()";
    }
}

final class Node implements BinarySearchTree {
    private final String value;
    private final BinarySearchTree left;
    private final BinarySearchTree right;
    
    Node(String value, BinarySearchTree left, BinarySearchTree right) {
        this.value = value;
        this.left = left;
        this.right = right;
    }
    
    @Override
    public int size() {
        return 1 + this.right.size() + this.left.size();
    }

    @Override
    public boolean contains(String value) {
        return this.value.equals(value) || this.left.contains(value) || this.right.contains(value);
    }

    @Override
    public BinarySearchTree insert(String newVal) {
        if (newVal.compareTo(this.value) < 0) {
            return new Node(this.value, this.left.insert(newVal), this.right);
        } else if (newVal.compareTo(this.value) > 0) {
            return new Node(this.value, this.left, this.right.insert(newVal));
        } else {
            return this;
        }
    }

    private String emptyOrNot(BinarySearchTree node) {
        return (node instanceof Empty) ? "" : node.toString();
    }

    @Override
    public String toString() {
        return "(" + emptyOrNot(left) + value + emptyOrNot(right) + ")";
    }
}