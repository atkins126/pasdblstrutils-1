program testcase;
{$ifdef fpc}
 {$mode delphi}
{$endif}
{$if defined(Windows) or defined(Win32) or defined(Win64)}
 {$apptype console}
{$ifend}

uses SysUtils,Classes,Math,PasDblStrUtils in '..\PasDblStrUtils.pas';

var TestDataPath:string;

procedure TestParser;
var Path,FileName:string;
    SearchRec:TSearchRec;
    Stream:TStream;
    InputData,Part0,Part1,Part2,Part3:RawByteString;
    InputPos,InputLen,SavedInputPos:Int32;
    InputUI64:UInt64;
    InputF64:Double absolute InputUI64;
    OutputUI64:UInt64;
    OutputF64:Double absolute OutputUI64;
    OK:TPasDblStrUtilsBoolean;
begin

 Path:=IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(TestDataPath)+'parser');

 if FindFirst(Path+'*.txt',faAnyFile and not faDirectory,SearchRec)=0 then begin

  repeat

   FileName:=Path+SearchRec.Name;

   if (SearchRec.Name<>'..') or (SearchRec.Name<>'.') and FileExists(FileName) then begin

    writeln(FileName);

    InputData:='';
    try

     Stream:=TFileStream.Create(FileName,fmOpenRead or fmShareDenyRead);
     try
      Stream.Seek(0,soBeginning);
      SetLength(InputData,Stream.Size);
      Stream.ReadBuffer(InputData[1],Stream.Size);
     finally
      FreeAndNil(Stream);
     end;

     InputPos:=1;
     InputLen:=length(InputData);

     while InputPos<=InputLen do begin

      while (InputPos<=InputLen) and (InputData[InputPos] in [#0..#9,#11..#12,#14..#32]) do begin
       inc(InputPos);
      end;

      SavedInputPos:=InputPos;
      while (InputPos<=InputLen) and (InputData[InputPos] in ['0'..'9','A'..'Z','a'..'z','-','+']) do begin
       inc(InputPos);
      end;
      if SavedInputPos<InputPos then begin
       Part0:=copy(InputData,SavedInputPos,InputPos-SavedInputPos);
      end else begin
       break;
      end;

      while (InputPos<=InputLen) and (InputData[InputPos] in [#0..#9,#11..#12,#14..#32]) do begin
       inc(InputPos);
      end;

      SavedInputPos:=InputPos;
      while (InputPos<=InputLen) and (InputData[InputPos] in ['0'..'9','A'..'Z','a'..'z','-','+']) do begin
       inc(InputPos);
      end;
      if SavedInputPos<InputPos then begin
       Part1:=copy(InputData,SavedInputPos,InputPos-SavedInputPos);
      end else begin
       break;
      end;

      while (InputPos<=InputLen) and (InputData[InputPos] in [#0..#9,#11..#12,#14..#32]) do begin
       inc(InputPos);
      end;

      SavedInputPos:=InputPos;
      while (InputPos<=InputLen) and (InputData[InputPos] in ['0'..'9','A'..'Z','a'..'z','-','+']) do begin
       inc(InputPos);
      end;
      if SavedInputPos<InputPos then begin
       Part2:=copy(InputData,SavedInputPos,InputPos-SavedInputPos);
      end else begin
       break;
      end;

      while (InputPos<=InputLen) and (InputData[InputPos] in [#0..#9,#11..#12,#14..#32]) do begin
       inc(InputPos);
      end;

      SavedInputPos:=InputPos;
      while (InputPos<=InputLen) and (InputData[InputPos] in ['0'..'9','A'..'Z','a'..'z','-','+','.']) do begin
       inc(InputPos);
      end;
      if SavedInputPos<InputPos then begin
       Part3:=copy(InputData,SavedInputPos,InputPos-SavedInputPos);
      end else begin
       break;
      end;

      while (InputPos<=InputLen) and (InputData[InputPos] in [#0..#32]) do begin
       inc(InputPos);
      end;

      if TryStrToUInt64('$'+Part2,InputUI64) then begin
       OK:=false;
       OutputF64:=ConvertStringToDouble(Part3,rmNearest,@OK);
       if OK and (InputUI64=OutputUI64) then begin
        // Nothing
       end else begin
        writeln('Failed: ',Part2,' <> ',UpperCase(IntToHex(OutputUI64)),' ',Part3);
        ConvertStringToDouble(Part3,rmNearest,@OK); // For codetrace debugging
       end;
      end;

     end;

    finally
     InputData:='';
    end;

   end;

  until FindNext(SearchRec)<>0;

 end;

end;

procedure TestConverter;
var Path,FileName:string;
    SearchRec:TSearchRec;
    Stream:TStream;
    InputData,Part0,Part1,Part2,Part3,OutputString:RawByteString;
    InputPos,InputLen,SavedInputPos:Int32;
    InputUI64:UInt64;
    InputF64:Double absolute InputUI64;
    OutputUI64:UInt64;
    OutputF64:Double absolute OutputUI64;
    OK:TPasDblStrUtilsBoolean;
begin

 Path:=IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(TestDataPath)+'parser');

 if FindFirst(Path+'*.txt',faAnyFile and not faDirectory,SearchRec)=0 then begin

  repeat

   FileName:=Path+SearchRec.Name;

   if (SearchRec.Name<>'..') or (SearchRec.Name<>'.') and FileExists(FileName) then begin

    writeln(FileName);

    InputData:='';
    try

     Stream:=TFileStream.Create(FileName,fmOpenRead or fmShareDenyRead);
     try
      Stream.Seek(0,soBeginning);
      SetLength(InputData,Stream.Size);
      Stream.ReadBuffer(InputData[1],Stream.Size);
     finally
      FreeAndNil(Stream);
     end;

     InputPos:=1;
     InputLen:=length(InputData);

     while InputPos<=InputLen do begin

      while (InputPos<=InputLen) and (InputData[InputPos] in [#0..#9,#11..#12,#14..#32]) do begin
       inc(InputPos);
      end;

      SavedInputPos:=InputPos;
      while (InputPos<=InputLen) and (InputData[InputPos] in ['0'..'9','A'..'Z','a'..'z','-','+']) do begin
       inc(InputPos);
      end;
      if SavedInputPos<InputPos then begin
       Part0:=copy(InputData,SavedInputPos,InputPos-SavedInputPos);
      end else begin
       break;
      end;

      while (InputPos<=InputLen) and (InputData[InputPos] in [#0..#9,#11..#12,#14..#32]) do begin
       inc(InputPos);
      end;

      SavedInputPos:=InputPos;
      while (InputPos<=InputLen) and (InputData[InputPos] in ['0'..'9','A'..'Z','a'..'z','-','+']) do begin
       inc(InputPos);
      end;
      if SavedInputPos<InputPos then begin
       Part1:=copy(InputData,SavedInputPos,InputPos-SavedInputPos);
      end else begin
       break;
      end;

      while (InputPos<=InputLen) and (InputData[InputPos] in [#0..#9,#11..#12,#14..#32]) do begin
       inc(InputPos);
      end;

      SavedInputPos:=InputPos;
      while (InputPos<=InputLen) and (InputData[InputPos] in ['0'..'9','A'..'Z','a'..'z','-','+']) do begin
       inc(InputPos);
      end;
      if SavedInputPos<InputPos then begin
       Part2:=copy(InputData,SavedInputPos,InputPos-SavedInputPos);
      end else begin
       break;
      end;

      while (InputPos<=InputLen) and (InputData[InputPos] in [#0..#9,#11..#12,#14..#32]) do begin
       inc(InputPos);
      end;

      SavedInputPos:=InputPos;
      while (InputPos<=InputLen) and (InputData[InputPos] in ['0'..'9','A'..'Z','a'..'z','-','+','.']) do begin
       inc(InputPos);
      end;
      if SavedInputPos<InputPos then begin
       Part3:=copy(InputData,SavedInputPos,InputPos-SavedInputPos);
      end else begin
       break;
      end;

      while (InputPos<=InputLen) and (InputData[InputPos] in [#0..#32]) do begin
       inc(InputPos);
      end;

      if TryStrToUInt64('$'+Part0+Part1+Part2,InputUI64) then begin
       OK:=false;
       OutputF64:=ConvertStringToDouble(Part3,rmNearest,@OK);
       if OK {and (InputUI64=OutputUI64)} then begin
        OutputString:=ConvertDoubleToString(OutputF64,omStandard);
        OK:=false;
        OutputF64:=ConvertStringToDouble(OutputString,rmNearest,@OK);
        if OK and (InputUI64=OutputUI64) then begin
         // Nothing
        end else begin
         writeln('Failed: ',Part2,' <> ',UpperCase(IntToHex(OutputUI64)),' ',Part3,' ',OutputString);
         ConvertStringToDouble(OutputString,rmNearest,@OK); // For codetrace debugging
        end;
       end else begin
        writeln('Failed: ',Part2,' ',Part3);
       end;
      end;

     end;

    finally
     InputData:='';
    end;

   end;

  until FindNext(SearchRec)<>0;

 end;

end;

begin

{writeln(RyuStringtoDouble('-333463636363636.3'):1:15);
 readln;
 exit;}

 TestDataPath:=IncludeTrailingPathDelimiter(ExpandFileName(IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'..')+'..')+'testdata')));
 writeln('Test data path: ',TestDataPath);
 writeln;

 try

  writeln('Running parsing test . . .');
  TestParser;
  writeln('Done!');
  writeln;

  writeln('Running converting test . . .');
  TestConverter;
  writeln('Done!');
  writeln;

 except
  on e:Exception do begin
   writeln('[',e.Message,']: '+e.ClassName);
  end;
 end;

 readln;
end.
