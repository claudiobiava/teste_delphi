unit uProdutoDAO;


interface

uses FireDAC.Comp.Client,

  Dialogs, SysUtils,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.UI, uProdutoModel;

type

  TProdutoDAO = class

  private
    foFDConnection: TFDConnection;

  public

    constructor criar(poFDConnection: TFDConnection);
    function getProdutoByCodigoProduto(pnCodigoProduto: cardinal): TProdutoModel;

 end;


implementation

constructor TProdutoDAO.criar(poFDConnection: TFDConnection);
begin
  self.foFDConnection := poFDConnection;
end;

function TProdutoDAO.getProdutoByCodigoProduto(
  pnCodigoProduto: cardinal): TProdutoModel;
var
  oFDQuery: TFDQuery;
begin
   oFDQuery := TFDQuery.Create(nil);
   oFDQuery.Connection := self.foFDConnection;
   oFDQuery.SQL.Add('select * from produto where codigo_produto = :codigo_produto');
   oFDQuery.ParamByName('codigo_produto').AsInteger := pnCodigoProduto;
   oFDQuery.Open();

   if oFDQuery.RecordCount = 1 then
   begin
      result := TProdutoModel.criar();
      result.nCodigo := oFDQuery.FieldByName('codigo_produto').AsInteger;
      result.sDescricao := oFDQuery.FieldByName('descricao_produto').AsString;
      result.nPrecoVenda := oFDQuery.FieldByName('preco_venda_produto').AsFloat;
   end
   else
    result := nil;

  oFDQuery.Close;
  oFDQuery.Free;

end;


end.

