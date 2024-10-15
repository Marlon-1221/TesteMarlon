program TesteMarlon;

uses
  Vcl.Forms,
  UMenu in 'UMenu.pas' {Menu},
  UCadPedido in 'UCadPedido.pas' {CadPedido},
  UDamPedido in 'UDamPedido.pas' {DMPedido: TDataModule},
  USelCarregaPedido in 'USelCarregaPedido.pas' {SelCarregaPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMenu, Menu);
  Application.Run;
end.
