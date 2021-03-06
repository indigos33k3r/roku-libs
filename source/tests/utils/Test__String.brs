'----------------------------------------------------------------
' String Test Suite
'
' @return A configured TestSuite object.
'----------------------------------------------------------------
function TestSuite__String() as Object
    ' Inherite your test suite from BaseTestSuite
    this = BaseTestSuite()

    ' Test suite name for log statistics
    this.Name = "String Utilities"

    this.SetUp = StringTestSuite__SetUp
    this.TearDown = StringTestSuite__TearDown

    ' Add tests to suite's tests collection
    this.addTest("should create object with expected functions", TestCase__String_Functions)
    this.addTest("charAt should return character at the specified index", TestCase__String_CharAt)
    this.addTest("contains should check whether or not the string contains given substring", TestCase__String_Contains)
    this.addTest("indexOf should return first index of given substring in the string", TestCase__String_IndexOf)
    this.addTest("match should retrieve matching substrings against a regular expression", TestCase__String_Match)
    this.addTest("replace should substitute matched substring with new substring", TestCase__String_Replace)
    this.addTest("truncate should truncate string to given length and append ellipsis", TestCase__String_Truncate)
    this.addTest("hash functions should generate correct hashes", TestCase__String_ToHash)

    return this
end function

sub StringTestSuite__SetUp()
    m.testObject = StringUtil()
end sub

sub StringTestSuite__TearDown()
    m.testObject = invalid
    m.delete("testObject")
end sub


function TestCase__String_Functions()
    expectedFunctions = ["charAt", "contains", "indexOf", "match", "replace", "truncate", "toMD5", "toSHA1", "toSHA256", "toSHA512"]
    return m.assertAAHasKeys(m.testObject, expectedFunctions)
end function

function TestCase__String_CharAt()
    str = "Hello World!"
    result = m.assertEqual(m.testObject.charAt(str, 1), "e")
    result += m.assertEqual(m.testObject.charAt(str, 12), "")
    result += m.assertEqual(m.testObject.charAt(str, -1), "H")
    return result
end function

function TestCase__String_Contains()
    str = "Hello World!"
    result = m.assertEqual(m.testObject.contains(str, "Hell"), true)
    result += m.assertEqual(m.testObject.contains(str, "Hell", 2), false)
    result += m.assertEqual(m.testObject.contains(str, "Bye"), false)
    return result
end function

function TestCase__String_IndexOf()
    str = "Hello World!"
    result = m.assertEqual(m.testObject.indexOf(str, "Hell"), 0)
    result += m.assertEqual(m.testObject.indexOf(str, "Hell", 2), -1)
    result += m.assertEqual(m.testObject.indexOf(str, "Bye"), -1)
    return result
end function

function TestCase__String_Match()
    str = "AbraCadabra"
    result = m.assertEqual(m.testObject.match(str, "cad"), [])
    result += m.assertEqual(m.testObject.match(str, "cad", "i"), ["Cad"])
    result += m.assertEqual(m.testObject.match(str, "(ab)(ra)", "i"), ["Abra","Ab","ra"])
    return result
end function

function TestCase__String_Replace()
    str = "Hello World!"
    result = m.assertEqual(m.testObject.replace(str, "Hello", "Bye"), "Bye World!")
    result += m.assertEqual(m.testObject.replace(str, "!", "?"), "Hello World?")
    result += m.assertEqual(m.testObject.replace(str, "Hi", "Bye"), "Hello World!")
    return result
end function

function TestCase__String_Truncate()
    str = "Hello World!"
    result = m.assertEqual(m.testObject.truncate(str, 5), "Hello")
    result += m.assertEqual(m.testObject.truncate(str, 5, "..."), "Hello...")
    result += m.assertEqual(m.testObject.truncate(str, 13, "..."), "Hello World!")
    return result
end function

function TestCase__String_ToHash()
    str = "Hello World!"
    result = m.assertEqual(m.testObject.toMD5(str), "ed076287532e86365e841e92bfc50d8c")
    result += m.assertEqual(m.testObject.toSHA1(str), "2ef7bde608ce5404e97d5f042f95f89f1c232871")
    result += m.assertEqual(m.testObject.toSHA256(str), "7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069")
    result += m.assertEqual(m.testObject.toSHA512(str), "861844d6704e8573fec34d967e20bcfef3d424cf48be04e6dc08f2bd58c729743371015ead891cc3cf1c9d34b49264b510751b1ff9e537937bc46b5d6ff4ecc8")
    return result
end function
