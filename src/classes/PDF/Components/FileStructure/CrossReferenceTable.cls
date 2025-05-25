block-level on error undo, throw.
using classes.PDF.Components.* from propath.
using classes.PDF.Components.CharacterSets.* from propath.

class classes.PDF.Components.FileStructure.CrossReferenceTable:
    def public property fileStructureInstance as FileStructure no-undo get. protected set.
    
    constructor CrossReferenceTable(pFileStructure as FileStructure):
        assign fileStructureInstance = pFileStructure.
    end constructor.
    
    method public void writeCrossReferenceTable():
    end method.
end class.
