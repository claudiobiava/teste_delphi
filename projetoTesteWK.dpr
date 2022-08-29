program projetoTesteWK;

uses
  Vcl.Forms,
  uDM in 'model\uDM.pas' {dm: TDataModule},
  uFPedidosDeVenda in 'view\uFPedidosDeVenda.pas' {FPedidosDeVenda},
  uClienteModel in 'model\uClienteModel.pas',
  uClienteDAO in 'dao\uClienteDAO.pas',
  uPedidosDeVendaDAO in 'dao\uPedidosDeVendaDAO.pas',
  uProdutoDAO in 'dao\uProdutoDAO.pas',
  uProdutoModel in 'model\uProdutoModel.pas',
  uPedidosDeVendaModel in 'model\uPedidosDeVendaModel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'WK - Pedidos de Venda';
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFPedidosDeVenda, FPedidosDeVenda);
  Application.Run;
end.
