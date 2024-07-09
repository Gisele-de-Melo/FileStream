//------------------------------------------------------------------------------------------------------------
//********* Sobre ************
//Autor: Gisele de Melo
//Esse código foi desenvolvido com o intuito de aprendizado para o blog codedelphi.com, portanto não me
//responsabilizo pelo uso do mesmo.
//
//********* About ************
//Author: Gisele de Melo
//This code was developed for learning purposes for the codedelphi.com blog, therefore I am not responsible for
//its use.
//------------------------------------------------------------------------------------------------------------

unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
  private
    procedure ReadBinaryFile(const FileName: string);
    procedure WriteBinaryFile(const FileName: string; const Data: array of Byte);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.WriteBinaryFile(const FileName: string; const Data: array of Byte);
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmCreate);
  try
    FileStream.WriteBuffer(Data[0], Length(Data));
  finally
    FileStream.Free;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  try
    WriteBinaryFile('example.bin', [1, 2, 3, 4, 5]);  //Escreve no arquivo binário
    ReadBinaryFile('example.bin'); //Lê do arquivo Binário
  except
    on E: Exception do
      ShowMessage(E.ClassName+ ': '+ E.Message);
  end;
end;

procedure TForm1.ReadBinaryFile(const FileName: string);
var
  FileStream: TFileStream;
  Buffer: array of Byte;
  I: Integer;
begin
  FileStream := TFileStream.Create(FileName, fmOpenRead);
  try
    SetLength(Buffer, FileStream.Size);
    FileStream.ReadBuffer(Buffer[0], FileStream.Size);
    for I := 0 to Length(Buffer) - 1 do
      Memo1.Lines.Add(IntToStr(Integer(Buffer[I]))); //Adiciona cada linha do arquivo binário armazenada na variável Buffer no Memo1
  finally
    FileStream.Free;
  end;
end;

end.
