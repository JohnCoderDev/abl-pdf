class classes.PDF.Types.BooleanType:
    def public property booleanValue as log no-undo get. protected set.
    
    constructor BooleanType(pValue as log):
        assign booleanValue = pValue.
    end constructor.
    
    method public char toBoolean():
        return string(booleanValue, 'true/false').
    end method.    
end class.
