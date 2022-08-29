object dm: Tdm
  OldCreateOrder = False
  Height = 478
  Width = 442
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'D:\Delphi10\TesteWK\Win32\Debug\libmysql.dll'
    Left = 56
    Top = 80
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=root'
      'Password=root'
      'Database=wk'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 56
    Top = 8
  end
end
