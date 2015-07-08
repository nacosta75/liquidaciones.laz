unit ufrmBVendedor;

{$mode objfpc}

interface

uses
  Classes, SysUtils, db, FileUtil, ZDataset, LResources, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons, DBGrids, IBQuery, IBDatabase;

type

  { TfrmBVendedor }

  TfrmBVendedor = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBGrid1: TDBGrid;
    edt1: TEdit;
    edtcodigo: TEdit;
    edtnombre: TEdit;
    vendQRY: TIBQuery;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    VendDS: TDatasource;
    procedure BitBtn1Click(Sender: TObject);
    procedure edtcodigoChange(Sender: TObject);
    procedure edtnombreChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmBVendedor: TfrmBVendedor;

implementation

uses liqdm;

{ TfrmBVendedor }

procedure TfrmBVendedor.edtcodigoChange(Sender: TObject);
begin
  if EDT1.Text='1' then
  begin

   vendqry.Close;
   vendqry.SQL.Clear;
   vendqry.SQL.Add('select codigo,nombre from tel_empleados '+
   ' where codigo like '''+edtcodigo.Text+'%''  ');
   vendqry.Open;

  end
  else
  begin

   vendqry.Close;
   vendqry.SQL.Clear;
   vendqry.SQL.Add('select codigo,nombre from empleados '+
   ' where codigo like '''+edtcodigo.Text+'%''  and '+
   ' PLUEMPRESAS=:PLUEMPRESA ');
   vendQRY.Params[0].Value := dm.empresaqrypluempresa.value;
   vendqry.Open;

  end;
end;

procedure TfrmBVendedor.BitBtn1Click(Sender: TObject);
begin

end;

procedure TfrmBVendedor.edtnombreChange(Sender: TObject);
begin
      if edt1.Text='1' then
        begin

                vendqry.Close;
                vendqry.SQL.Clear;
                vendqry.SQL.Add('select codigo,nombre from tel_empleados '+
                ' where nombre like '''+edtnombre.Text+'%''   ');
                vendqry.Open;

        end
        else
        begin
                vendqry.Close;
                vendqry.SQL.Clear;
                vendqry.SQL.Add('select codigo,nombre from empleados '+
                ' where nombre like '''+edtnombre.Text+'%''  and '+
                ' PLUEMPRESAS=:PLUEMPRESA ');
                vendQRY.Params[0].Value := dm.empresaqrypluempresa.value;
                vendqry.Open;

        end;
end;

procedure TfrmBVendedor.FormShow(Sender: TObject);
begin
    vendqry.Database := dm.fbdb;
    vendqry.Close;
    vendqry.Open;
end;

procedure TfrmBVendedor.Panel1Click(Sender: TObject);
begin

end;

initialization
  {$I ufrmbvendedor.lrs}

end.

