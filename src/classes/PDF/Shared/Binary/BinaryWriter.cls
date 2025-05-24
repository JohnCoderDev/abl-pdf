block-level on error undo, throw.
using classes.PDF.Shared.Binary.Abstract.* from propath.
using classes.PDF.Shared.Binary.Output.* from propath.

class classes.PDF.Shared.Binary.BinaryWriter:
    def public property output as BinaryOutput no-undo get. protected set.
    
    constructor BinaryWriter():
        assign this-object:output = new Memory().
    end constructor.
    
    method public memptr getPointer():
        return output:getPointer().
    end method.
    
    method public void writeFile(pPath as char):
        def var resultPointer as memptr no-undo.
        assign resultPointer = getPointer().
        copy-lob from resultPointer to file pPath.
        assign set-size(resultPointer) = 0.
    end method.
    
    destructor BinaryWriter():
        delete object this-object:output.
    end destructor.
end class.
