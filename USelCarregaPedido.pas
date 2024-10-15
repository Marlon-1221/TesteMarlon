unit USelCarregaPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TSelCarregaPedido = class(TForm)
    Panel1: TPanel;
    BtnGrava: TButton;
    BtnFechar: TButton;
    EdtPedido: TEdit;
    Label2: TLabel;
    procedure BtnFecharClick(Sender: TObject);
    procedure EdtPedidoExit(Sender: TObject);
    procedure BtnGravaClick(Sender: TObject);
  private
    { Private declarations }
  public
    VInDelete : Boolean;
    { Public declarations }
  end;

var
  SelCarregaPedido: TSelCarregaPedido;

implementation

 uses UDamPedido;

{$R *.dfm}

procedure TSelCarregaPedido.BtnFecharClick(Sender: TObject);
begin
  self.Close;
end;

procedure TSelCarregaPedido.BtnGravaClick(Sender: TObject);
begin
  if EdtPedido.Text = '' then
    ShowMessage('Atenção! Favor informar o numero do Pedido.');

  with DMPedido do
  begin
    if VInDelete then
    begin
      DeletaPedido(StrToInt(EdtPedido.Text));
    end;
  end;
end;

procedure TSelCarregaPedido.EdtPedidoExit(Sender: TObject);
begin
  if EdtPedido.Text = '' then
    exit;

  with DMPedido do
  begin
    if ValidaPedido(StrToInt(EdtPedido.Text)) then
    begin
      ShowMessage('Atenção! Esse Pedido não existe.');
      EdtPedido.Clear;
      EdtPedido.SetFocus;
    end;
    CarregaDadosPedido(StrToInt(EdtPedido.Text));
  end;
end;
end.
