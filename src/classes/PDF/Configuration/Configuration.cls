block-level on error undo, throw.
using classes.PDF.* from propath.
using classes.PDF.Configuration.Fonts.* from propath.

class classes.PDF.Configuration.Configuration:
    def public property PDFInstance as PDF no-undo get. protected set.
    
    constructor Configuration(pPDF as PDF):
        assign
            PDFInstance = pPDF.
    end constructor.
end class.
