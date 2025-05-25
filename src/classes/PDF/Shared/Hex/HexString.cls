block-level on error undo, throw.

class classes.PDF.Shared.Hex.HexString:
    def protected static property hexDigits as char init '0123456789ABCDEF' get.
    
    method public static longchar getHexString(pPointer as memptr):
        def var i as int no-undo.
        def var resultString as longchar no-undo.
        
        do i = 1 to get-size(pPointer):
            assign resultString = substitute('&1&2', resultString, getHexChar(get-byte(pPointer, i))).
        end.
        return resultString.
    end method.
    
    method public static longchar getHexString(pString as longchar):
        def var i as int no-undo.
        def var resultString as longchar no-undo.
        def var currentChar as char no-undo.
        
        do i = 1 to length(pString):
            assign
                currentChar = substring(pString, i, 1)
                resultString = substitute('&1&2', resultString, getHexChar(currentChar)).
        end.
        return resultString.
    end method.
    
    method public static char getHexChar(pChar as char):
        return getHexChar(asc(pChar)).
    end method.
    
    method public static char getHexChar(pValue as int):
        def var leftChar as char no-undo.
        def var rightChar as char no-undo.
        assign  
            rightChar = substring(hexDigits, pValue mod 16 + 1, 1)
            leftChar = substring(hexDigits, int(truncate(pValue / 16, 0)) + 1, 1).
        return leftChar + rightChar.    
    end method.
end class.
