block-level on error undo, throw.
using Progress.Lang.* from propath.
using classes.PDF.Types.* from propath.

class classes.PDF.Types.StreamType:
    def public static property streamStartIndicator as char init 'stream' get.
    def public static property streamEndIndicator as char init 'endstream' get.
    def public static property streamStartLength as int get: return length(streamStartIndicator). end.
    def public static property streamEndLength as int get: return length(streamEndIndicator). end.
    
    def public property pointer as memptr no-undo get. protected set.
    def public property streamDictionary as DictionaryType no-undo get. protected set.
    
    constructor StreamType(pPointer as memptr):
        assign 
            pointer = pPointer
            streamDictionary = new DictionaryType().
        streamDictionary:add('Length', get-size(pointer)).    
    end constructor.
    
    constructor StreamType(pPath as char):
        assign streamDictionary = new DictionaryType().
        loadFile(pPath).
    end constructor.
    
    method public void loadFile(pPath as char):
        copy-lob from file pPath to pointer.
        streamDictionary:add('Length', get-size(pointer)).
    end method.
    
    method public longchar toStream():
        def var streamString as longchar no-undo.
        copy-lob from pointer to streamString.
        return substitute('&1&2&3&4',
            streamDictionary:toDictionary(),
            streamStartIndicator,
            streamString,
            streamEndIndicator
        ).    
    end method.
    
    method public memptr toStreamPointer():
        def var resultStream as memptr no-undo.
        def var streamDictionaryString as longchar no-undo.
        def var streamDictionaryLength as int no-undo.
        def var pointerLength as int no-undo.
        def var i as int64 no-undo.
        
        assign 
            streamDictionaryString = streamDictionary:toDictionary()
            streamDictionaryLength = length(streamDictionaryString)
            pointerLength = get-size(pointer)
            set-size(resultStream) = streamDictionaryLength + streamStartLength + pointerLength + streamEndLength.
        
        assign
            put-string(resultStream, 1, streamDictionaryLength) = streamDictionaryString.
            put-string(resultStream, streamDictionaryLength + 1, streamStartLength) = streamStartIndicator.
        
        do i = 1 to pointerLength:
            put-byte(resultStream, i + streamDictionaryLength + streamStartLength) = get-byte(pointer, i).
        end.
        
        assign
            put-string(resultStream, streamDictionaryLength + streamStartLength + pointerLength + 1, streamEndLength) = streamEndIndicator.
        
        return resultStream.
    end method.
end class.
