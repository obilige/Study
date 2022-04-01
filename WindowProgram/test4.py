import wx
from test3 import LoginFrame
class MainFrame(wx.Frame):
    def __init__(self):
        super().__init__(None, title='대화상자', size=(800, 600)) #윈도우 프로그램 재료엔 첫번째 인자가 어디에 붙여서, 즉 부모의 주소가 어딘지 명시하게 되어있다.
        self.design()

    def design(self):
        menubar = wx.MenuBar()
        menu = wx.Menu()

        item1 = wx.MenuItem(menu, 100, "MessageDialog", "메시지 대화상자 보이기")
        item2 = wx.MenuItem(menu, 101, "ColorDialog",  "색상 대화상자 보이기")
        item3 = wx.MenuItem(menu, 102, "FileDialog", "파일 대화상자 보이기")
        item4 = wx.MenuItem(menu, 103, "LoginDialog", "로그인 대화상자 보이기")

        menu.Append(item1)
        menu.Append(item2)
        menu.Append(item3)
        menu.Append(item4)

        menubar.Append(menu, "다이얼로그")


        self.Bind(wx.EVT_MENU, self.onMessage, item1)
        self.Bind(wx.EVT_MENU, self.onColor, item2)
        self.Bind(wx.EVT_MENU, self.onFile, item3)
        self.Bind(wx.EVT_MENU, self.onLogin, item4)

        self.setMenubar(menubar)
        self.CreateStatusBar()


    def onMessage(self, evt):
        self.SetStatusText("메시지 대화 상자")
        dlg = wx.MessageDialog(self, "오늘 하루도 열심히 하세요", "메시지 박스", wx.OK|wx.ICON_WARNING)
        dlg.ShowModal()

    def onColor(self, evt):
        self.SetStatusText("색상 대화 상자")
        dlg = wx.ColourDialog(self)

        if dlg.ShowModal() == wx.ID_OK:
            color = dlg.GetColourData()
            self.SetStatusText("당신이 선택한 색상은" + str(color.GetColour().Get()))
        
    def onFile(self, evt):
        self.SetStatusText("파일 대화 상자")
        dlg = wx.FileDialog(self, "파일 불러오기", "c:\\", "", "*.*", style=wx.ID_OPEN)

        if dlg.ShowModal() == wx.ID_OK:
            selectedFile = dlg.GetColourData()
            
        f = open(selectedFile, "r")
        data = f.read()
        self.txtArea.SetLabelText(data)
        f.close()

    def onLogin(self, evt):
        self.SetStatusText('로그인 대화 상자')
        dlg = LoginFrame(self)
        dlg.ShowModal()






if __name__ == '__main__' :
    app = wx.App() # 윈도우 프로그램 램공간 만들기
    frame = wx.Frame(None, title="처음 만드는 윈도우 어플리케이션") #뼈대 세우기. 메뉴바와 사각형 프레임 만드는 것
    frame.Show(True)
    app.MainLoop() #show가 꺼지지 않고 계속 시행되도록 무한반복시키는 것




#### exe로 만들기
# 1. pip install pyinstaller
# 2. 경로 이동 :: py 파일이 있는 곳으로
# 3. 터미널에 pyinstaller -F --noconsole test4.py --hidden-import wx
