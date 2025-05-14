unit Paint;

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, RzPanel,
  ExtCtrls, pngimage, RzSplit, ColorGrd;

type
  TForm1 = class(TForm)
    RzSizePanel1: TRzSizePanel;
    image: TImage;
    setColorText: TStaticText;
    setLineText: TStaticText;
    setLineBox: TListBox;
    saveButton: TButton;
    SaveDialog: TSaveDialog;
    setColorGrid: TColorGrid;
    StaticText1: TStaticText;
    clearBtn: TBitBtn;
    fillBtn: TBitBtn;
    procedure SaveBtnClick(Sender: TObject);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure clearBtnClick(Sender: TObject);
    procedure fillBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

// [Save] 버튼 클릭
procedure TForm1.SaveBtnClick(Sender: TObject);
begin

  // saveDialog가 활성화되면 파일 저장
  if SaveDialog.Execute then
    image.Picture.Bitmap.SaveToFile(SaveDialog.FileName);

end;
     
// 이미지에 [마우스 다운]
procedure TForm1.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  // 마우스 위치 설정
  image.Picture.Bitmap.Canvas.MoveTo(X, Y);

end;

// 마우스 이동 [그림 그리기]
procedure TForm1.ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin

  // 마우스 왼쪽 클릭 시 실행
  if ssLeft in Shift then
  begin
    image.Picture.Bitmap.Canvas.Pen.Color := setColorGrid.ForegroundColor;  // 그림을 그릴 선의 색상 설정
    image.Picture.Bitmap.Canvas.Pen.Width := setLineBox.ItemIndex + 1;      // 그림을 그릴 선의 두께 설정

    image.Picture.Bitmap.Canvas.LineTo(X, Y);                               // 마우스의 위치에 따라 그림 그리기
  end;

end;

// 프로그램 실행 시
procedure TForm1.FormCreate(Sender: TObject);
begin

  // 이미지의 넓이와 높이 설정
  image.Picture.Bitmap.Width := image.Width;
  image.Picture.Bitmap.Height := image.Height;

  // 이미지 초기화
  image.Picture.Bitmap.Canvas.FillRect(Rect(0, 0, image.Width, image.Height));

  // 최초 itemIndex 초기화
  setLineBox.ItemIndex := 0;

  // 저장할 확장자명 초기화 (기본 설정: bmp)
  SaveDialog.Filter := 'Bitmap Files (*.bmp)|*.bmp|All Files (*.*)|*.*';
  SaveDialog.DefaultExt := 'bmp';
end;

// 지우기 버튼 클릭
procedure TForm1.clearBtnClick(Sender: TObject);

begin

  // 이미지를 하얀색으로 초기화
  image.Picture.Bitmap.Canvas.Brush.Color := clWhite;
  image.Picture.Bitmap.Canvas.FillRect(Rect(0, 0, image.Width, image.Height));

end;

// 채우기 버튼 클릭
procedure TForm1.fillBtnClick(Sender: TObject);

begin

  // 이미지를 현재 설정한 BG색으로 초기화 
  image.Picture.Bitmap.Canvas.Brush.Color := setColorGrid.BackgroundColor;
  image.Picture.Bitmap.Canvas.FillRect(Rect(0, 0, image.Width, image.Height));

end;

end.
