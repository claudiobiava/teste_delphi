unit uFPedidosDeVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, udm,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin, Vcl.Mask, System.UITypes,
  Vcl.Imaging.pngimage, uProdutoModel, uPedidosDeVendaModel;

type
  TFPedidosDeVenda = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    DBLookupComboBoxCliente: TDBLookupComboBox;
    lblCliente: TLabel;
    btnInserirProduto: TButton;
    edtCodigoProduto: TLabeledEdit;
    edtQuantideProduto: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtValorUnitarioProduto: TEdit;
    Image1: TImage;
    Splitter1: TSplitter;
    btnGravarPedido: TButton;
    sgItensDoPedido: TStringGrid;
    lblTitulo: TLabel;
    btnCarregarPedidos: TButton;
    btnCancelarPedido: TButton;
    lblValorTotal: TLabel;
    btnLimpar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure btnInserirProdutoClick(Sender: TObject);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure sgItensDoPedidoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLookupComboBoxClienteCloseUp(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure btnCarregarPedidosClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    goProdutoModel: TProdutoModel;
    goPedidosDeVendaModel: TPedidosDeVendaModel;
    goItemPedidoSendoAlterado: TItemPedidoModel;


    procedure atualizarViewPedido;
    procedure inicializarTela;
  public
    { Public declarations }
  end;

var
  FPedidosDeVenda: TFPedidosDeVenda;

implementation

uses
  uClienteDAO, uProdutoDAO, uClienteModel, uPedidosDeVendaDAO;

{$R *.dfm}

procedure TFPedidosDeVenda.btnCancelarPedidoClick(Sender: TObject);
var
  oPedidosDeVendaDAO: TPedidosDeVendaDAO;
  oPedidosDeVendaModel: TPedidosDeVendaModel;
  sNumeroPedido: string;
begin
  sNumeroPedido := InputBox('Cancelar pedido', 'Informe o número do pedido:', '');

  if sNumeroPedido <> '' then
  begin
    oPedidosDeVendaDAO := TPedidosDeVendaDAO.criar(dm.FDConnection1);
    oPedidosDeVendaModel := oPedidosDeVendaDAO.getPedidosDeVendasByNumeroPedido(StrToIntDef(sNumeroPedido, -1), false);
    if oPedidosDeVendaModel = nil then
      ShowMessage('Número do pedido não encontrado!')
    else
    begin
      oPedidosDeVendaDAO.excluirPedidosDeVendas(oPedidosDeVendaModel);
      oPedidosDeVendaModel.Free;
      btnLimpar.Click();
    end;
    oPedidosDeVendaDAO.Free;
  end;
end;

procedure TFPedidosDeVenda.btnCarregarPedidosClick(Sender: TObject);
var
  oPedidosDeVendaDAO: TPedidosDeVendaDAO;
  oPedidosDeVendaModel: TPedidosDeVendaModel;
  sNumeroPedido: string;
begin
  sNumeroPedido := InputBox('Carregar pedido', 'Informe o número do pedido:', '');

  if sNumeroPedido <> '' then
  begin
    oPedidosDeVendaDAO := TPedidosDeVendaDAO.criar(dm.FDConnection1);
    oPedidosDeVendaModel := oPedidosDeVendaDAO.getPedidosDeVendasByNumeroPedido(StrToIntDef(sNumeroPedido, -1), true);
    if oPedidosDeVendaModel = nil then
      ShowMessage('Número do pedido não encontrado!')
    else
    begin
      goPedidosDeVendaModel := oPedidosDeVendaModel;
      DBLookupComboBoxCliente.KeyValue := oPedidosDeVendaModel.nCodigoCliente;
      atualizarViewPedido();
    end;
    oPedidosDeVendaDAO.Free;
  end;

end;

procedure TFPedidosDeVenda.btnGravarPedidoClick(Sender: TObject);
var
  oPedidosDeVendaDAO: TPedidosDeVendaDAO;
begin
  if DBLookupComboBoxCliente.Text = '' then
  begin
     DBLookupComboBoxCliente.SetFocus;
     ShowMessage('Selecione um cliente!');
  end
  else
  begin
    oPedidosDeVendaDAO := TPedidosDeVendaDAO.criar(dm.FDConnection1);
    goPedidosDeVendaModel.nCodigoCliente := DBLookupComboBoxCliente.ListSource.DataSet.FieldByName('codigo_cliente').AsInteger;
    if oPedidosDeVendaDAO.persistirPedidosDeVendas(goPedidosDeVendaModel) then
    begin
      ShowMessage('Pedido gravado com sucesso! O número do seu pedido é ' + IntToStr(goPedidosDeVendaModel.nNumeroPedido) + '.');
      btnLimpar.Click();
    end;

  end;
end;

procedure TFPedidosDeVenda.btnInserirProdutoClick(Sender: TObject);
var
 oItemPedido: TItemPedidoModel;

begin
  if not edtCodigoProduto.Enabled then
  begin
    edtCodigoProduto.Enabled := true;
    goItemPedidoSendoAlterado.nQuantidade := edtQuantideProduto.Value;
    goItemPedidoSendoAlterado.nValorUnitario := StrToFloatDef(edtValorUnitarioProduto.Text, 0);
    atualizarViewPedido();

    goProdutoModel := nil;
    edtQuantideProduto.Value := 1;
    edtValorUnitarioProduto.Text := '0';
    edtCodigoProduto.Text := '';
  end
  else
  if goProdutoModel = nil then
  begin
     edtCodigoProduto.SetFocus();
     ShowMessage('Código do Produto não encontrado!');
  end
  else
  if StrToFloatDef(edtValorUnitarioProduto.text, 0) = 0 then
  begin
     edtValorUnitarioProduto.SetFocus();
     ShowMessage('Valor Unitário deve ser maior que zero!');
  end
  else
  begin
    oItemPedido := TItemPedidoModel.criar();
    oItemPedido.oProduto := goProdutoModel;
    oItemPedido.nCodigoItemPedido := random(MaxInt);
    oItemPedido.nQuantidade := edtQuantideProduto.Value;
    oItemPedido.nValorUnitario := StrToFloatDef(edtValorUnitarioProduto.Text, 0);
    goPedidosDeVendaModel.goListaItensPedido.Add(oItemPedido);

    atualizarViewPedido();
    goProdutoModel := nil;
    edtQuantideProduto.Value := 1;
    edtValorUnitarioProduto.Text := '0';
    edtCodigoProduto.Text := '';
  end;

end;

procedure TFPedidosDeVenda.btnLimparClick(Sender: TObject);
begin
  goPedidosDeVendaModel.destruir();
  DBLookupComboBoxCliente.KeyValue := -1;
  edtQuantideProduto.Value := 1;
  edtValorUnitarioProduto.Text := '0';
  edtCodigoProduto.Text := '';

  inicializarTela();
end;

procedure TFPedidosDeVenda.DBLookupComboBoxClienteCloseUp(Sender: TObject);
begin
  btnCarregarPedidos.Visible := DBLookupComboBoxCliente.Text = '';
  btnCancelarPedido.Visible := DBLookupComboBoxCliente.Text = '';
end;

procedure TFPedidosDeVenda.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', ',']) then
  begin
     Key := #0;
  end
  else
  if (Key = ',') and (Pos(Key, edtValorUnitarioProduto.Text) > 0) then
  begin
    Key := #0;
  end;
end;

procedure TFPedidosDeVenda.edtCodigoProdutoExit(Sender: TObject);
var
  oProdutoDAO: TProdutoDAO;
begin
  if edtCodigoProduto.Text = '' then
    exit;

  oProdutoDAO := TProdutoDAO.criar(dm.FDConnection1);
  goProdutoModel := oProdutoDAO.getProdutoByCodigoProduto(StrToIntDef( edtCodigoProduto.Text, -1));
  oProdutoDAO.destroy();

  if goProdutoModel = nil then
    ShowMessage('Código do Produto não encontrado: ' + edtCodigoProduto.Text)
  else
  begin
     edtValorUnitarioProduto.Text := FloatToStr(goProdutoModel.nPrecoVenda);
  end;

end;

procedure TFPedidosDeVenda.inicializarTela;
var
  oClienteDAO: TClienteDAO;
begin
  goPedidosDeVendaModel := TPedidosDeVendaModel.criar();
  goProdutoModel := nil;
  oClienteDAO := TClienteDAO.criar(dm.FDConnection1);
  DBLookupComboBoxCliente.ListSource :=  oClienteDAO.getClientes();
  oClienteDAO.destroy();
  atualizarViewPedido();
  DBLookupComboBoxClienteCloseUp(nil);
  edtCodigoProduto.Enabled := true;
end;

procedure TFPedidosDeVenda.FormCreate(Sender: TObject);
begin
  //usuário = root senha=root
  dm.FDPhysMySQLDriverLink1.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql.dll';
  dm.FDConnection1.Connected := true;

  inicializarTela();
end;

procedure TFPedidosDeVenda.sgItensDoPedidoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sCodigo: string;
begin
  if key = VK_RETURN then
  begin
    sCodigo := sgItensDoPedido.Cells[5, sgItensDoPedido.Row];
    if sCodigo = '' then
      exit;

    edtCodigoProduto.Enabled := false;
    goItemPedidoSendoAlterado := goPedidosDeVendaModel.getItemPedidoByCodigoItemPedido(StrToInt(sCodigo));
    edtCodigoProduto.Text := IntToStr(goItemPedidoSendoAlterado.oProduto.nCodigo);
    edtQuantideProduto.Value := goItemPedidoSendoAlterado.nQuantidade;
    edtValorUnitarioProduto.Text := FloatToStr(goItemPedidoSendoAlterado.nValorUnitario);
  end
  else
  if key = VK_DELETE then
  begin
     sCodigo := sgItensDoPedido.Cells[5, sgItensDoPedido.Row];
     if sCodigo = '' then
      exit;

     if MessageDlg('Deseja realmente apagar o item de pedido?',
        mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
     begin
        goPedidosDeVendaModel.deleteItemPedidoByCodigoItemPedido(StrToInt(sCodigo));
        atualizarViewPedido();
     end;

  end;
end;

procedure TFPedidosDeVenda.atualizarViewPedido;
var
  i: integer;

  function f0Casa(r : real) : string;
  begin
    result := FormatFloat('#,##0', r);
  end;

  function f2Casas(r : real) : string;
  begin
    result := FormatFloat('R$ #,##0.00', r);
  end;

  procedure limparDadosGrid();
  var
    i,j : integer;
  begin
    for j := 1 to sgItensDoPedido.RowCount-1 do
      for i := 0 to sgItensDoPedido.ColCount-1 do
        sgItensDoPedido.Cells[i, j] := '';
    sgItensDoPedido.RowCount := 2;
  end;


begin
  limparDadosGrid();

  sgItensDoPedido.Cells[0, 0] := 'Código do produto';
  sgItensDoPedido.Cells[1, 0] := 'Descrição do produto';
  sgItensDoPedido.Cells[2, 0] := 'Quantidade';
  sgItensDoPedido.Cells[3, 0] := 'Valor Unitário';
  sgItensDoPedido.Cells[4, 0] := 'Valor Total';
  sgItensDoPedido.Cells[5, 0] := 'Código do item de pedido';
  sgItensDoPedido.ColWidths[5] := -1;

  for i := 0 to goPedidosDeVendaModel.goListaItensPedido.Count-1 do
  begin
    sgItensDoPedido.RowCount := i+2;
    sgItensDoPedido.Cells[0, i+1] := IntToStr( goPedidosDeVendaModel.goListaItensPedido[i].oProduto.nCodigo);
    sgItensDoPedido.Cells[1, i+1] := goPedidosDeVendaModel.goListaItensPedido[i].oProduto.sDescricao;
    sgItensDoPedido.Cells[2, i+1] := f0Casa( goPedidosDeVendaModel.goListaItensPedido[i].nQuantidade);
    sgItensDoPedido.Cells[3, i+1] := f2Casas( goPedidosDeVendaModel.goListaItensPedido[i].nValorUnitario);
    sgItensDoPedido.Cells[4, i+1] := f2Casas( goPedidosDeVendaModel.goListaItensPedido[i].getValorTotal());
    sgItensDoPedido.Cells[5, i+1] := IntToStr( goPedidosDeVendaModel.goListaItensPedido[i].nCodigoItemPedido);
  end;

  lblValorTotal.Caption := 'Valor total do pedido: ' + f2Casas(goPedidosDeVendaModel.getValorTotal());

  btnGravarPedido.Visible := goPedidosDeVendaModel.nNumeroPedido = 0;
  btnInserirProduto.Visible := btnGravarPedido.Visible;


end;

end.
