unit UDamPedido;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Phys.MySQLDef, FireDAC.Comp.UI,
  FireDAC.Phys.MySQL, FireDAC.Comp.DataSet,IniFiles,Vcl.Dialogs;

type
  //Dados Produtos
  TProduto = record
    CodPro : Integer;
    DesPro : string;
    PreVen : double;
    QtdPed : Integer;
  end;

  //Dados Pedido
  TPedido = record
    CodPed : Integer;
    CodCli : string;
    VlrTot : double;
  end;

  //Dados item Pedido
  TItemPedido = record
    CodPro : Integer;
    cdItem : Integer;
    CodPed : Integer;
    VlrPro : double;
    VlrUni : double;
    QtdPed : Integer;
  end;

  TDMPedido = class(TDataModule)
    TabPedido: TFDQuery;
    DSPedidos: TDataSource;
    DsItemPedido: TDataSource;
    TabItemPedido: TFDQuery;
    qAux: TFDQuery;
    FDConnection1: TFDConnection;
    DRIVER: TFDPhysMySQLDriverLink;
    TabPedidoCodPed: TFDAutoIncField;
    TabPedidoCodCli: TIntegerField;
    TabPedidoVlrTot: TBCDField;
    TabPedidoDtEmi: TDateField;
    TabItemPedidoCditem: TIntegerField;
    TabItemPedidoCodPed: TIntegerField;
    TabItemPedidoCodPro: TIntegerField;
    TabItemPedidoDesPro: TStringField;
    TabItemPedidoVlrPro: TBCDField;
    TabItemPedidoQtdPed: TBCDField;
    TabItemPedidoVlrUni: TBCDField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
   VCodPed : Integer;
   function ValidaProduto (PProduto : Integer) : boolean;
   function ValidaPedido(PPedido: Integer): Boolean;
   function ValidaCliente(PCliente: Integer): Boolean;

   procedure CarregaDadosProdutos (PProduto : Integer);
   procedure CarregaDadosPedido(PPedido : Integer);
   procedure CarregaDadosItemPedido(PPedido : Integer);
   Procedure DeletaProduto(PCodPed,PCdItem : Integer);
   Procedure DeletaPedido(PCodPed: Integer);
   procedure GravaPedido(PCliente: Integer);
   procedure InsereItemPedido;
   procedure TotalizaPedido;
   procedure PreparaItemPedido;
    { Public declarations }
  end;

var
  DMPedido   : TDMPedido;
  Produto    : TProduto;
  Pedido     : TPedido;
  ItemPedido : TItemPedido;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMPedido }

function TDMPedido.ValidaProduto(PProduto: Integer): boolean;
begin
  result := false;
  with qaux.SQL do
  begin
    clear;
    qaux.close;
    add('SELECT 1');
    add('FROM Produtos P');
    add('WHERE P.CodPro = :CodPro');
    qaux.ParamByName('CodPro').Value := PProduto;
    qaux.open;

    result := not qAux.IsEmpty;

    if result then
      CarregaDadosProdutos(PProduto);
  end;
end;

procedure TDMPedido.CarregaDadosProdutos(PProduto : Integer);
begin
  with qaux.SQL do
  begin
    clear;
    qaux.close;
    add('SELECT DesPro,');
    add('       PreVen');
    add('FROM Produtos P');
    add('WHERE P.CodPro = :CodPro');
    qaux.ParamByName('CodPro').Value := PProduto;
    qaux.open;

    Produto.CodPro := PProduto;
    Produto.DesPro := qaux.FieldByName('DesPro').AsString;
    Produto.PreVen := qaux.FieldByName('PreVen').AsFloat;
  end;
end;
procedure TDMPedido.CarregaDadosItemPedido(PPedido : Integer);
begin
  with qaux.SQL do
  begin
    clear;
    qaux.close;
    add('SELECT CdItem,');
    add('       CodPro,');
    add('       VlrPro,');
    add('       VlrUni,');
    add('       Qtdped');
    add('FROM ItemPedidos PD ');
    add('WHERE PD.CodPed = :CodPed');
    qaux.ParamByName('CodPed').Value := PPedido;
    qaux.open;

    ItemPedido.CodPed := PPedido;
    ItemPedido.cdItem := qaux.FieldByName('CdItem').AsInteger;
    ItemPedido.Qtdped := qaux.FieldByName('Qtdped').AsInteger;
    ItemPedido.VlrPro :=  qaux.FieldByName('VlrPro').AsFloat;
    ItemPedido.VlrUni :=  qaux.FieldByName('VlrUni').AsFloat;
  end;
end;

procedure TDMPedido.CarregaDadosPedido(PPedido : Integer);
begin
  with qaux.SQL do
  begin
    clear;
    qaux.close;
    add('SELECT CodPed,');
    add('       CodCli,');
    add('       VlrTot');
    add('FROM Pedidos PD ');
    add('WHERE PD.CodPed = :CodPed');
    qaux.ParamByName('CodPed').Value := PPedido;
    qaux.open;

    Pedido.CodPed := PPedido;
    Pedido.CodCli := qaux.FieldByName('CodCli').AsString;
    Pedido.VlrTot := qaux.FieldByName('VlrTot').AsFloat;
  end;
end;


function TDMPedido.ValidaCliente(PCliente: Integer): Boolean;
begin
  with qaux.SQL do
  begin
    clear;
    qaux.close;
    add('SELECT 1');
    add('FROM Clientes C');
    add('WHERE C.CodCli = :CodCli');
    qaux.ParamByName('CodCli').Value := PCliente;
    qaux.open;

    result := not qaux.IsEmpty;
  end;
end;

function TDMPedido.ValidaPedido(PPedido: Integer): Boolean;
begin
  with qaux.SQL do
  begin
    clear;
    qaux.close;
    add('SELECT 1');
    add('FROM Pedidos PD');
    add('WHERE PD.CodCli = :CodPed');
    qaux.ParamByName('CodPed').Value := PPedido;
    qaux.open;

    result := not qaux.IsEmpty;
  end;
end;


procedure TDMPedido.GravaPedido(PCliente: Integer);
begin
  with qaux.SQL do
  begin
    clear;
    qaux.close;
    add('INSERT INTO Pedidos(CodCli,');
    add('                    DtEmi)');
    add('VALUES (:CodCli,');
    add('        curdate())');
    qaux.ParamByName('CodCli').Value := PCliente;
    qaux.ExecSQL;

    clear;
    qaux.close;
    add('SELECT MAX(Codped) AS Codped FROM Pedidos ');
    qaux.open;

    Pedido.CodPed :=  qaux.FieldByName('Codped').Value;
  end;
end;

procedure TDMPedido.PreparaItemPedido;
begin
  TabItemPedido.Close;
  TabItemPedido.ParamByName('CodPed').Value := Pedido.CodPed;
  TabItemPedido.open;
end;

procedure TDMPedido.TotalizaPedido;
begin
  with qaux.SQL do
  begin
    clear;
    qaux.close;
    add('Call SPTotalizaEAtualizaPedido(:CodPed);');
    qaux.ParamByName('CodPed').Value :=  Pedido.CodPed;
    qaux.ExecSQL;
  end;
end;

procedure TDMPedido.InsereItemPedido;
begin
  with qaux.SQL do
  begin
    clear;
    qaux.close;
    add('Call SPInsertOrUpdateItemPedido(:CodPed,:CdItem,:CodPro,:QtdPed,:VlrUni,:VlrPro);');
    qaux.ParamByName('CodPed').Value :=  Pedido.CodPed;
    qaux.ParamByName('CdItem').Value :=  ItemPedido.CdItem;
    qaux.ParamByName('CodPro').Value :=  ItemPedido.CodPro;
    qaux.ParamByName('VlrPro').Value :=  ItemPedido.VlrPro;
    qaux.ParamByName('VlrUni').Value :=  ItemPedido.VlrUni;
    qaux.ParamByName('QtdPed').Value :=  ItemPedido.QtdPed;
    qaux.ExecSQL;
  end;
  PreparaItemPedido;
  TotalizaPedido;
end;

procedure TDMPedido.DataModuleCreate(Sender: TObject);
var
  Ini: TIniFile;
  vServidor,
  vUsername,
  vPort,
  vPassword,
  vDatabase: String;
  vIdleTime: Integer;
begin
  Try
    Ini := TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.ini');
    vDatabase := Ini.ReadString('Login','Database','');
    vServidor := Ini.ReadString('Login','Server','');
    vUsername := Ini.ReadString('Login','Username','');
    vPort     := Ini.ReadString('Login','Port','');
    vPassword := Ini.ReadString('Login','Password','');

    vIdleTime := Ini.ReadInteger('Login', 'IdleTime', 60000); //Padrão é 1 minuto

    If (vServidor = '') OR (vDataBase = '') Then
    Begin
      Exit;
    End
    else
    begin
      FDConnection1.LoginPrompt := False;
      FDConnection1.Params.Clear;
      FDConnection1.Params.Add('DriverID=MySQL');
      FDConnection1.Params.Add('Server='+vServidor);
      FDConnection1.Params.Add('Database='+vDatabase);
      FDConnection1.Params.Add('User_Name='+vUsername);
      FDConnection1.Params.Add('Password='+vPassword);
      FDConnection1.Connected := True;
    end;
  Except
    ON E: Exception Do
     ShowMessage('Erro inicialização, erro: ' + E.Message);
  End;
end;

Procedure TDMPedido.DeletaPedido(PCodPed: Integer);
begin
  with qaux.SQL do
  begin
    clear;
    qaux.close;
    add('Call SPExcluiPedido(:CodPed);');
    qaux.ParamByName('CodPed').Value := PCodPed;
    qaux.ExecSQL;
  end;
end;

Procedure TDMPedido.DeletaProduto(PCodPed,PCdItem : Integer);
begin
  with qaux.SQL do
  begin
    clear;
    qaux.close;
    add('DELETE FROM ItemPedido');
    add('WHERE CdItem = :CdItem');
    add('AND CodPed = :CodPed');
    qaux.ParamByName('CdItem').Value := PCdItem;
    qaux.ParamByName('CodPed').Value := PCodPed;
    qaux.ExecSQL;
  end;
  PreparaItemPedido;
end;
end.
