block-level on error undo, throw.
using classes.PDF.Shared.Binary.* from propath.
using classes.PDF.Components.* from propath.

class classes.PDF.PDF:
    def public property writer as BinaryWriter no-undo get. protected set.
    def public property fileStructure as FileStructure no-undo get. protected set.
    
    constructor PDF():
        assign
            writer = new BinaryWriter()
            fileStructure = new FileStructure(this-object).
    end constructor.
    
    method public memptr getMemoryFile():
        return writer:getPointer().
    end method.
    
    method public void renderFile(pPath as char):
        if not pPath matches '*.pdf' then do:
            assign pPath = substitute('&1.pdf', pPath).
        end.
        writer:writeFile(pPath).
    end method.
    
    method public void prepare():
        fileStructure:writeStructure().
    end method.
end class.
