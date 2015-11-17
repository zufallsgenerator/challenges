import java.security.MessageDigest

object Challenge extends App {

  val sha1sum = MessageDigest.getInstance("SHA1")
  val allowedCharacters = (('a' to 'z') ++ ('0' to '9')).toArray

  def emails(prefix: String): Unit = {
    if (prefix.length > 5) return

    for (x ← allowedCharacters) {
      checkHash(prefix + x + "@digitalstep.de")
    }
    for (x ← allowedCharacters) {
      emails(prefix + x)
    }

  }

  implicit class CoffeeByteArray(x: Array[Byte]) {
    private[this] final val c0ffee: Array[Byte] = Seq(0xc0, 0xff, 0xee).map(_.toByte).toArray

    def isCoffee = (0 to 2) map (i ⇒ c0ffee(i) == x(i)) reduce (_ && _)

    def printable = x map (_ & 0xff) map Integer.toHexString mkString
  }

  def checkHash(s: String): Unit = {
    val digest = sha1sum.digest(s.getBytes)
    if (digest.isCoffee) {
      println(s"$s ${digest.printable}")
      sys.exit(0)
    }
  }

  //  checkHash("example+1899634@example.com")

  emails("")
}
