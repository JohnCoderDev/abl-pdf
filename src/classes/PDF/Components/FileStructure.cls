block-level on error undo, throw.
using classes.PDF.* from propath.
using classes.PDF.Components.FileStructure.* from propath.

class classes.PDF.Components.FileStructure:
    def public property PDFInstance AS PDF no-undo get. protected set.
    def public property headerInstance as Header no-undo get. protected set.
    def public property bodyInstance as Body no-undo get. protected set.
    def public property crftInstance as CrossReferenceTable no-undo get. protected set.
    def public property trailerInstance as Trailer no-undo get. protected set.
    
    constructor FileStructure(pPDF as PDF):
        assign 
            PDFInstance = pPDF
            headerInstance = new Header(this-object)
            bodyInstance = new Body(this-object)
            crftInstance = new CrossReferenceTable(this-object)
            trailerInstance = new Trailer(this-object).
    end constructor.
    
    method public void writeStructure():
        headerInstance:writeHeader().
        bodyInstance:writeBody().
        crftInstance:writeCrossReferenceTable().
        trailerInstance:writeTrailer().
    end method.
end class.
