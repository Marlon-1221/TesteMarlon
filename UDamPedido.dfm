object DMPedido: TDMPedido
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object TabPedido: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM Pedidos')
    Left = 24
    Top = 24
    object TabPedidoCodPed: TFDAutoIncField
      FieldName = 'CodPed'
      Origin = 'CodPed'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object TabPedidoCodCli: TIntegerField
      FieldName = 'CodCli'
      Origin = 'CodCli'
      Required = True
    end
    object TabPedidoVlrTot: TBCDField
      FieldName = 'VlrTot'
      Origin = 'VlrTot'
      Required = True
      Precision = 10
      Size = 2
    end
    object TabPedidoDtEmi: TDateField
      FieldName = 'DtEmi'
      Origin = 'DtEmi'
      Required = True
    end
  end
  object DSPedidos: TDataSource
    DataSet = TabPedido
    Left = 112
    Top = 24
  end
  object DsItemPedido: TDataSource
    DataSet = TabItemPedido
    Left = 112
    Top = 88
  end
  object TabItemPedido: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT I.Cditem,'
      '       I.CodPed,'
      '       I.CodPro,'
      '       P.DesPro,'
      '       I.VlrPro,'
      '       I.QtdPed,'
      '       I.VlrUni  '
      'FROM ItemPedido I'
      '     INNER JOIN Produtos P ON P.CodPro = i.CodPro'
      'WHERE I.CodPed = :CodPed        ')
    Left = 24
    Top = 88
    ParamData = <
      item
        Name = 'CODPED'
        ParamType = ptInput
      end>
    object TabItemPedidoCditem: TIntegerField
      DisplayLabel = 'Cod.Item'
      FieldName = 'Cditem'
      Origin = 'CdItem'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TabItemPedidoCodPed: TIntegerField
      DisplayLabel = 'Cod.Pedido'
      FieldName = 'CodPed'
      Origin = 'CodPed'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object TabItemPedidoCodPro: TIntegerField
      DisplayLabel = 'Cod.Produto'
      FieldName = 'CodPro'
      Origin = 'CodPro'
      Required = True
    end
    object TabItemPedidoDesPro: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Produto'
      DisplayWidth = 60
      FieldName = 'DesPro'
      Origin = 'DesPro'
      ProviderFlags = []
      ReadOnly = True
      Size = 255
    end
    object TabItemPedidoVlrUni: TBCDField
      DisplayLabel = 'Vlr.Unitario'
      DisplayWidth = 8
      FieldName = 'VlrUni'
      Precision = 10
      Size = 2
    end
    object TabItemPedidoVlrPro: TBCDField
      DisplayLabel = 'Vlr.Produto'
      FieldName = 'VlrPro'
      Origin = 'VlrPro'
      Required = True
      Precision = 10
      Size = 2
    end
    object TabItemPedidoQtdPed: TBCDField
      FieldName = 'QtdPed'
      Precision = 10
      Size = 2
    end
  end
  object qAux: TFDQuery
    Connection = FDConnection1
    Left = 24
    Top = 144
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=marlon'
      'User_Name=root'
      'Password=Marlone@1221'
      'Server=localhost'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 544
    Top = 56
  end
  object DRIVER: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\stolf\OneDrive\'#193'rea de Trabalho\Pedidos\Win32\Debug\LIB' +
      '\libmySQL.dll'
    Left = 544
    Top = 128
  end
end
