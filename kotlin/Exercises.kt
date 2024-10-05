import java.io.BufferedReader
import java.io.File
import java.io.IOException
import kotlin.math.abs

fun change(amount: Long): Map<Int, Long> {
    require(amount >= 0) { "Amount cannot be negative" }

    val counts = mutableMapOf<Int, Long>()
    var remaining = amount
    for (denomination in listOf(25, 10, 5, 1)) {
        counts[denomination] = remaining / denomination
        remaining %= denomination
    }
    return counts
}

fun firstThenLowerCase(of: List<String>, predicate: (String) -> Boolean): String? {
    val filtered: List<String> = of.filter(predicate)
    return (if (!filtered.isEmpty()) filtered[0] else null)?.lowercase()
}

class say (new_phrase: String = "") {
    val phrase: String = new_phrase

    fun and(next_phrase: String): say {
        return say(phrase + " " + next_phrase)
    }
}

@Throws(IOException::class)
fun meaningfulLineCount(filename: String): Long {
File(filename).bufferedReader().use {
    return it.readLines().map { 
        it.trim() 
    }.filter{ 
        !it.isNullOrBlank() 
    }.filter { 
        it.elementAtOrNull(0) != '#'
    }.count().toLong()
    }
}

data class Quaternion(val a: Double, val b: Double, val c: Double, val d: Double) {
    // This takes the place of static member variables
    companion object {
        val ZERO = Quaternion(0.0,0.0,0.0,0.0)
        val I = Quaternion(0.0,1.0,0.0,0.0)
        val J = Quaternion(0.0,0.0,1.0,0.0)
        val K = Quaternion(0.0,0.0,0.0,1.0)
    }

    init {
        require(!a.isNaN() && !b.isNaN() && !c.isNaN() && !d.isNaN()) {
            "Coordinates can not be NaN"
        }
    }

    operator fun plus(other: Quaternion): Quaternion {
        return Quaternion(this.a + other.a, this.b + other.b, this.c + other.c, this.d + other.d)
    }

    operator fun times(other: Quaternion): Quaternion {
        val mul_a: Double = this.a * other.a - this.b * other.b - this.c * other.c - this.d * other.d
        val mul_b: Double = this.a * other.b + this.b * other.a + this.c * other.d - this.d * other.c
        val mul_c: Double = this.a * other.c - this.b * other.d + this.c * other.a + this.d * other.b
        val mul_d: Double = this.a * other.d + this.b * other.c - this.c * other.b + this.d * other.a
        return Quaternion(mul_a, mul_b, mul_c, mul_d)
    }

    fun coefficients(): List<Double> {
        return listOf(this.a, this.b, this.c, this.d)
    }

    fun conjugate(): Quaternion {
        return Quaternion(this.a, -this.b, -this.c, -this.d)
    }

    override fun toString(): String {
        fun coefToString(coef: Double, comp: String): String {
            val sign: String = if (coef >= 0) "+" else "-"
            val scalar: String = if (abs(coef) != 1.0 || comp.isEmpty()) "${abs(coef)}" else ""
            return "$sign$scalar$comp"
        }
        
        val components: List<Pair<Double, String>> = listOf(Pair(this.a, ""), Pair(this.b, "i"), Pair(this.c, "j"), Pair(this.d, "k"))
        val coefStrings: List<String> = components.filter {
            (coef, _): Pair<Double, String> -> coef != 0.0
        }.map {
            (coef, comp): Pair<Double, String> -> coefToString(coef, comp)
        }
        if (coefStrings.isEmpty()) {
            return "0"
        }
        else {
            val coefString: String = coefStrings.joinToString(separator="")
            return if (coefString[0] == '+') coefString.substring(1) else coefString
        }
    }
}

sealed interface BinarySearchTree {
    fun size(): Int
    fun contains(value: String): Boolean
    fun insert(value: String): BinarySearchTree

    object Empty : BinarySearchTree {
        override fun size(): Int = 0
        override fun contains(value: String): Boolean = false
        override fun insert(value: String): BinarySearchTree = Node(value, Empty, Empty)
        override fun toString(): String = "()"
    }

    data class Node(
        val value: String,
        val left: BinarySearchTree = Empty,
        val right: BinarySearchTree = Empty
    ) : BinarySearchTree {
        override fun size(): Int = 1 + left.size() + right.size()

        override fun contains(value: String): Boolean {
            return when {
                value == this.value -> true
                value < this.value -> left.contains(value)
                else -> right.contains(value)
            }
        }

        override fun insert(newVal: String): BinarySearchTree {
            return when {
                newVal == this.value -> this
              newVal < this.value -> Node(this.value, left.insert(newVal), right)
                else -> Node(this.value, left, right.insert(newVal))
            }
        }

        override fun toString(): String {
            val leftStr = if (left == Empty) "" else left.toString()
            val rightStr = if (right == Empty) "" else right.toString()
            return "($leftStr$value$rightStr)"
        }
    }
}
