unit Styles;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.StdCtrls, FMX.Layouts, FMX.Edit;

type
  TForm1 = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    cbStyles: TComboBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    Layout2: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    Button1: TButton;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    ScrollBar1: TScrollBar;
    Expander1: TExpander;
    TrackBar1: TTrackBar;
    Switch1: TSwitch;
    ListBox1: TListBox;
    Edit1: TEdit;
    ArcDial1: TArcDial;
    procedure cbStylesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses FMX.Styles;

procedure TForm1.cbStylesChange(Sender: TObject);
const
  tosName: array[0..3] of String = ('Win','OSX','iOS','Android');
var
  styleName: String;
begin
  if cbStyles.ItemIndex = 0 then
    TStyleManager.SetStyle(nil)
  else begin
    styleName := tosName[integer(TOSVersion.Platform)] + cbStyles.Selected.Text;
    TStyleManager.SetStyle(
      TStyleStreaming.LoadFromResource(
        HInstance, styleName, RT_RCDATA));
  end;

end;

end.
