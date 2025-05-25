class classes.PDF.Types.NumberType:
    def public property number as dec no-undo get. protected set.
    def protected property numberType as char no-undo get. set.
    
    constructor NumberType(pNumber as int64):
        assign 
            number = pNumber
            numberType = 'integer'.
    end method.
    
    constructor NumberType(pNumber as dec):
        assign
            number = pNumber
            numberType = 'real'.
    end constructor.
    
    method public log isInteger():
        return numberType = 'integer'.
    end method.
    
    method public log isReal():
        return numberType = 'real'.
    end method.
    
    method public char toInteger():
        def var resultNumber as int64 no-undo.
        assign resultNumber = int64(truncate(number, 0)).
        return string(resultNumber).
    end method.
    
    method public char toReal():
        def var resultNumber as char no-undo.
        assign 
            resultNumber = string(number)
            resultNumber = replace(resultNumber, ',', '.').
        return resultNumber.    
    end method.
end class.
