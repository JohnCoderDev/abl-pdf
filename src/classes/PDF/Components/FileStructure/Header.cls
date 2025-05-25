block-level on error undo, throw.
using classes.PDF.Components.* from propath.

class classes.PDF.Components.FileStructure.Header:
    def public property fileStructureInstance as FileStructure no-undo get. protected set.
    
    def public property version as int init 2 no-undo get.
        set(pValue as int):
            if pValue < 0 then do:
                assign version = 0.
            end.
            else if pValue > 7 then do:
                assign version = 7.
            end.
            else do:
                assign version = pValue.
            end.
        end.
    
    constructor Header(pFileStructure as FileStructure):
        assign fileStructureInstance = pFileStructure.
    end constructor.
    
    method public void writeHeader():
        fileStructureInstance:PDFInstance:writer:output:putString(getHeader()).
    end method.
    
    method public char getHeader():
        return substitute('%PDF-1.&1', version).
    end method.
    
    method public void setVersion(pInt as int):
        assign version = pInt.
    end method.
end class.
