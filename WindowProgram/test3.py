import wx

class LoginFrame(wx.Dialog):
    def __init__(self, parent):
        super().__init__(parent, title='Login', size=(300, 200)) #윈도우 프로그램 재료엔 첫번째 인자가 어디에 붙여서, 즉 부모의 주소가 어딘지 명시하게 되어있다.
        self.design()

    def design(self):
        self.panel = wx.Panel(self)

        wx.StaticText(self.panel, label="ID", pos=(10, 5))
        wx.StaticText(self.panel, label="PASSWORD", pos=(10, 40))

        # 아이디와 패스워드 입력할 수 있는 텍스트 박스
        self.m_id = wx.TextCtrl(self.panel, pos=(60, 5), size=(200, -1))
        self.m_pw = wx.TextCtrl(self.panel, pos=(60, 40), size=(200, -1))

        btn1 = wx.Button(self.panel, label="Log-In", pos=(10, 100))
        btn2 = wx.ToggleButton(self.panel, label="Toggle", pos=(100, 100))
        btn3 = wx.Button(self.panel, label="Close", pos=(190, 100))

        btn1.Bind(wx.EVT_BUTTON, self.onBtn1)
        btn2.Bind(wx.EVT_TOGGLEBUTTON, self.onBtn2)
        btn3.Bind(wx.EVT_BUTTON, self.onBtn3)

    def onBtn1(self, evt):
        id = self.m_id.GetValue()
        pw = self.m_pw.GetValue()

        if id == 'tiger' and pw == '1111':
            msg = "Success to LOGIN"
        else:
            msg = "Wrong ID or Wrong PASSWORD"
        
        wx.MessageDialog(self, msg, "LOGIN", wx.OK).ShowModal()

    def onBtn2(self, evt):
        # print(evt.GetEvenetObject().GetValue())
        if evt.GetEventObject().GetValue():
            self.panel.SetBackgroundColour((wx.colour(255, 0 ,0)))
            self.panel.Refresh()
        else:
            self.panel.SetBackgroundColour((wx.colour(255, 255 ,255)))
            self.panel.Refresh()

    def onBtn3(self, evt):
        self.Close(True)










    #     btn1.Bind(wx.EVT_BUTTON, self.onHandler)
    #     btn2.Bind(wx.EVT_TOGGLEBUTTON, self.onHandler)
    #     btn3.Bind(wx.EVT_BUTTON, self.onHandler)

    #     btn1.id, btn2.id, btn3.id = 1, 2, 3

    # def onHandler(self, evt):
    #     if evt.GetEventObject().id == 1 :
    #         id = self.m_id.GetValue()
    #         pw = self.m_pw.GetValue()

    #         if id == 'tiger' and pw == '1111':
    #             msg = "Success to LOGIN"
    #         else:
    #             msg = "Wrong ID or Wrong PASSWORD"
        
    #         wx.MessageDialog(self, msg, "LOGIN", wx.OK).ShowModal()

    #     elif evt.GetEvenetObject().id == 2 :






if __name__ == "__main__":
    app = wx.App() # 윈도우 프로그램 램공간 만들기
    frame = wx.Frame(None) #뼈대 세우기. 메뉴바와 사각형 프레임 만드는 것
    frame.Show(True)
    app.MainLoop() #show가 꺼지지 않고 계속 시행되도록 무한반복시키는 것