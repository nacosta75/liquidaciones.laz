unit liqprogresoform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ComCtrls, ExtCtrls, RTTICtrls;

type

  { Tprogresofrm }

  Tprogresofrm = class(TForm)
    ProgressBar1: TProgressBar;
    procedure ProgressBar1Enter(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  progresofrm: Tprogresofrm;

implementation

{ Tprogresofrm }

procedure Tprogresofrm.ProgressBar1Enter(Sender: TObject);
begin

end;

procedure Tprogresofrm.Timer1Timer(Sender: TObject);
begin

  refresh;
  ProgressBar1.Refresh;

end;

initialization
  {$I liqprogresoform.lrs}

end.

