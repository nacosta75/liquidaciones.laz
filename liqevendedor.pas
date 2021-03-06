unit liqEVendedor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ComCtrls, ExtCtrls, DBGrids, StdCtrls, Buttons, DbCtrls, LR_DBSet,
  LR_Class,  LCLType, ExtDlgs, MaskEdit, EditBtn, IBQuery,
  IBCustomDataSet, RTTICtrls;

type

  { TliqEVendedorfrm }

  TliqEVendedorfrm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    DGuardar: TSaveDialog;
    FECHA1: TDateEdit;
    FECHA2: TDateEdit;
    HistDS: TDatasource;
    DBGrid3: TDBGrid;
    edtProd: TEdit;
    frDBDataSet1: TfrDBDataSet;
    HistQRY: TIBQuery;
    HistQRYENTRADA: TFloatField;
    HistQRYFECHA: TDateField;
    HistQRYREFERENCIA: TIBStringField;
    HistQRYSALIDA: TFloatField;
    HistQRYTIPO: TIBStringField;
    vexistenciaQRY: TIBQuery;
    VendQRY: TIBQuery;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lrpt: TfrReport;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    TabSheet3: TTabSheet;
    vEXISTEds: TDatasource;
    DBText1: TDBText;
    venDS: TDatasource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    edtcodigo: TEdit;
    edtNombre: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    VendQRYCODIGO: TStringField;
    VendQRYNOMBRE: TStringField;
    VendQRYPLUEMPLEADOS: TLongintField;
    vexistenciaQRYCODIGO: TStringField;
    vexistenciaQRYDESCRIPCION: TStringField;
    vexistenciaQRYEMPRESA1: TStringField;
    vexistenciaQRYEXISTENCIA: TFloatField;
    vexistenciaQRYNOMBRE: TStringField;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure edtcodigoChange(Sender: TObject);
    procedure edtcodigoKeyPress(Sender: TObject; var Key: char);
    procedure edtNombreChange(Sender: TObject);
    procedure edtNombreKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtNombreKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure PageControl1Enter(Sender: TObject);
    procedure PopupCalBtn1Click(Sender: TObject);
    procedure PopupCalBtnClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure venDSDataChange(Sender: TObject; Field: TField);
    procedure vexistenciaQRYCalcFields(DataSet: TDataSet);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  liqEVendedorfrm: TliqEVendedorfrm;

implementation

uses liqDM,
Pickdate,
liqbprodform,claseaexcel;

{ TliqEVendedorfrm }

procedure TliqEVendedorfrm.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TliqEVendedorfrm.BitBtn3Click(Sender: TObject);
begin

    if  vexistenciaqry.IsEmpty then
    exit;
    lrpt.ShowReport;

end;

procedure TliqEVendedorfrm.BitBtn4Click(Sender: TObject);
begin

  if vendqry.IsEmpty then
  exit;

  vexistenciaqry.Close;
  vexistenciaqry.Open;

end;

procedure TliqEVendedorfrm.BitBtn5Click(Sender: TObject);
var
exportar: TAExcel;
begin

         if HistQry.IsEmpty then exit;

         exportar := TAExcel.Create();
          exportar.mDataset := HistQry;
          if Dguardar.Execute then
          exportar.nombre:=Dguardar.FileName
          else
          exportar.nombre:=  ExtractFilePath( Application.ExeName ) + 'rptLiquidaciones.xls' ;
          exportar.exportar;

          exportar.Free;

          showmessage('Archivo en Excel Generado!!!');

end;

procedure TliqEVendedorfrm.BitBtn6Click(Sender: TObject);
VAR
LSQL : STRING;
begin

   ShortDateFormat := 'MM/DD/YY';

   LSQL :='select inv_reservas.FECHA,INV_RESERVAS.REFERENCIA,INV_RESERVAS.TIPO,'+
   'INV_RESERVAS.ENTRADA, INV_RESERVAS.SALIDA from inv_reservas'+
   ' inner join producto on (inv_reservas.pluproducto=producto.pluproducto)'+
   ' where plubodegas='+vendqrypluempleados.asstring+' AND upper(producto.codigo) like '''+
    edtprod.Text+'%'' AND INV_RESERVAS.fecha between '''+datetostr(fecha1.date)+''' and '''+datetostr(fecha2.date)+''''+
   '  ORDER BY FECHA ASC'  ;


    HistQry.close;
    HistQRY.SQL.Clear;
    HistQry.SQL.Add(lsql);
    HistQry.Open;

    ShortDateFormat := 'dd/mm/YY';

end;

procedure TliqEVendedorfrm.BitBtn7Click(Sender: TObject);
begin
  close;
end;

procedure TliqEVendedorfrm.BitBtn1Click(Sender: TObject);
begin

  vendqry.close;
  vendqry.SQL.Clear;
  vendqry.SQL.Add('select pluempleados,codigo,nombre from empleados ');
  vendqry.SQL.Add(' where activo=''T''  AND PLUEMPRESAS=:PLUEMPRESA order by codigo asc ');
  vendqry.ParamByName('PLUEMPRESA').value := DM.EMPRESAQRYPLUEMPRESA.VALUE;
  vendqry.Open;

end;

procedure TliqEVendedorfrm.edtcodigoChange(Sender: TObject);
var
lsql :string;
begin

  lsql := 'select pluempleados,codigo,nombre from empleados '+
  ' where activo=''T''  AND PLUEMPRESAS='+DM.EMPRESAQRYPLUEMPRESA.asstring+
  ' and upper(codigo) like '''+edtcodigo.Text+'%'' order by codigo asc ';

  vendqry.close;
  vendqry.SQL.Clear;
  vendqry.SQL.Add(lsql);
  vendqry.Open;


end;

procedure TliqEVendedorfrm.edtcodigoKeyPress(Sender: TObject; var Key: char);
begin
      if ( key = Char(VK_RETURN) ) then
    begin

        vendqry.close;
        vendqry.SQL.Clear;
        vendqry.SQL.Add('select pluempleados,codigo,nombre from empleados ');
        vendqry.SQL.Add(' where activo=''T'' and upper(codigo) like :codigo order by codigo asc ');
        vendqry.ParamByName('codigo').value := edtcodigo.Text+'%';
        vendqry.Open;


    end;
end;

procedure TliqEVendedorfrm.edtNombreChange(Sender: TObject);
var
lsql :string;
begin

  lsql := 'select pluempleados,codigo,nombre from empleados '+
  ' where activo=''T''  AND PLUEMPRESAS='+DM.EMPRESAQRYPLUEMPRESA.asstring+
  ' and upper(nombre) like '''+edtnombre.Text+'%'' order by nombre asc ';

  vendqry.close;
  vendqry.SQL.Clear;
  vendqry.SQL.Add(lsql);
 // vendqry.ParamByName('nombre').value := edtnombre.Text+'%';
 // vendqry.ParamByName('PLUEMPRESA').value := DM.EMPRESAQRYPLUEMPRESA.VALUE;
  vendqry.Open;

end;

procedure TliqEVendedorfrm.edtNombreKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TliqEVendedorfrm.edtNombreKeyPress(Sender: TObject; var Key: char);
begin
    if ( key = Char(VK_RETURN) ) then
    begin

        vendqry.close;
        vendqry.SQL.Clear;
        vendqry.SQL.Add('select pluempleados,codigo,nombre from empleados ');
        vendqry.SQL.Add(' where activo=''T'' and upper(nombre) like :nombre  '+
        ' AND PLUEMPRESAS=:PLUEMPRESA order by nombre asc ');
        vendqry.ParamByName('PLUEMPRESA').value := DM.EMPRESAQRYPLUEMPRESA.VALUE;
        vendqry.ParamByName('nombre').value := edtnombre.Text+'%';
        vendqry.Open;


    end;
end;

procedure TliqEVendedorfrm.FormCreate(Sender: TObject);
begin

   fecha1.Date := now;
   fecha2.Date := now;
end;

procedure TliqEVendedorfrm.PageControl1Enter(Sender: TObject);
begin

end;

procedure TliqEVendedorfrm.PopupCalBtn1Click(Sender: TObject);
begin

end;

procedure TliqEVendedorfrm.PopupCalBtnClick(Sender: TObject);
begin



end;

procedure TliqEVendedorfrm.SpeedButton1Click(Sender: TObject);
begin


   application.createform(Tbprodfrm,bprodfrm) ;
   BPRODFRM.edttipo.TEXT := 'VEN';
   bprodfrm.showmodal;

   //edtProd.text := prodqrycodigo.asstring;

end;

procedure TliqEVendedorfrm.venDSDataChange(Sender: TObject; Field: TField);
begin
  vexistenciaqry.Close;
end;

procedure TliqEVendedorfrm.vexistenciaQRYCalcFields(DataSet: TDataSet);
begin
  VEXISTENCIAQRYEMPRESA1.Value := DM.EmpresaQRYNOMBRE.AsString;
end;

initialization
  {$I liqevendedor.lrs}

end.

