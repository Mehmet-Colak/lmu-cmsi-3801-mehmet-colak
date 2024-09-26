import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException

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

// Write your first then lower case function here

// Write your say function here

// Write your meaningfulLineCount function here

// PROPERTY OF AARON MEARNS
data class Quaternion(val a: Double, val b: Double, val c: Double, val d: Double) {
    // This takes the place of static member variables
    companion object {
        val ZERO = Quaternion(0.0,0.0,0.0,0.0)
        val I = Quaternion(0.0,1.0,0.0,0.0)
        val J = Quaternion(0.0,0.0,1.0,0.0)
        val K = Quaternion(0.0,0.0,0.0,1.0)
    }
    
    operator fun plus(other: Quaternion): Quaternion {
        return Quaternion(this.a + other.a, this.b + other.b, this.c + other.c, this.d + other.d)
    }
    
    // Shamelessly pasted from the Python code
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
    
    // Translated from the original Python
    override fun toString(): String {
        fun coefToString(coef: Double, comp: String): String {
            val sign: String = if (coef >= 0) "+" else "-"
            val scalar: String = if (abs(coef) != 1.0 || comp.isEmpty()) "${abs(coef)}" else ""
            return "$sign$scalar$comp"
        }
        val components: List<Pair<Double, String>> = listOf(Pair(this.a, ""), Pair(this.b, "i"), Pair(this.c, "j"), Pair(this.d, "k"))
        val coefFiltered: List<Pair<Double, String>> = components.filter({(coef, comp): Pair<Double, String> -> coef != 0.0})
        val coefStrings: List<String> = coefFiltered.map({(coef, comp): Pair<Double, String> -> coefToString(coef, comp)})
        if (coefStrings.isEmpty()) {
            return "0"
        }
        else {
            val coefString: String = coefStrings.joinToString(separator="")
        	return if (coefString[0] == '+') coefString.substring(1) else coefString
        }
    }
}

// Write your Binary Search Tree interface and implementing classes here
