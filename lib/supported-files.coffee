module.exports =
class SupportedFiles
  @types =
    'js':
      regExpStr: 'function\\s*REPLACE\\s*\\(|REPLACE\\s*(=|:)\\s*\
        function\\s*\\('
      isTabBased: false
    'ts':
      regExpStr: 'function\\s*REPLACE\\s*\\(|REPLACE\\s*=\\s*'
      isTabBased: false
    # 'coffee':
    #   regExpStr: ''
    #   isTabBased: true
    # 'py':
    #   regExpStr: ''
    #   isTabBased: true
    'java':
      regExpStr: '(public|private|protected)\\s*[\\w\\s\\S]*\\s*REPLACE\\s*\\('
      isTabBased: false
    # 'c':
    #   regExpStr: ''
    #   isTabBased: false
    # 'cpp':
    #   regExpStr: ''
    #   isTabBased: false
    'cs':
      regExpStr: '(public|private|protected)\\s*[\\w\\s\\S]*\\s*REPLACE\\s*\\('
      isTabBased: false

  @isSupported: (fileType) ->
    if @types[fileType]? then return true else return false

  @isTabBased: (fileType) ->
    if @types[fileType]? then return @types[fileType].isTabBased

  @getFunctionRegExpForFileType: (fileType, functionName) ->
    if not @types[fileType] then throw new Error "File type #{fileType} is not \
      supported"

    regExpStr = @types[fileType].regExpStr
    return new RegExp(regExpStr.replace /REPLACE/g, functionName)
