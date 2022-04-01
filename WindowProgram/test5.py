import wx
from wx.core import Choice
class MainFrame(wx.Frame):
    def __init__(self):
        super().__init__(None, title='Login', size=(800, 600))

    def design(self):
        self.panel = wx.Panel(self)
        # 변수에 self를 붙여주는 이유는 클래스 내 어디에서든 쓸 수 있게 하기 위해
        # self를 안붙이면 함수 내에서만 사용 가능하다.
        wx.StaticText(self.panel, label='----- 다양한 컨트롤 위젯 -----', pos=(20, 5))

        #### Textctrl
        wx.StaticText(self.panel, label="너의 이름은", pos=(20, 70))
        self.txtname = wx.TextCtrl(self.panel, value="이름을 입력하세요.", pos=(100, 70))
        self.txtname.Bind(wx.EVT_TEXT, self.onText)
        self.txtname.Bind(wx.EVT_KEY_DOWN, self.onKeydown) #키보드를 누를 때마다 함수를 발생
        # 같은 곳에서 이벤트를 중복하면 우선순위에 따라 하나는 시행이 안됨
        # 이건 심화 과정

        #### Check
        self.ckMarried = wx.CheckBox(self.panel, label='결혼은?', pos=(20, 120))
        self.ckMarried.Bind(wx.EVT_CHECKBOX, self.onCheck)

        #### Radiobox
        cbodata = ['빨강', "초록", "파랑", "노랑"]
        self.rbcolor = wx.RadioBox(self.panel, label="좋아하는 색상은?", pos=(20, 170), choices=cbodata)
        self.rbcolor.Bind(wx.EVT_RADIOBOX, self.onRadio)

        #### combobox
        self.cboColor = wx.ComboBox(self.panel, pos=(20, 220), choices=cbodata)
        self.cboColor.Bind(wx.EVT_COMBOBOX, self.onCombo)

        #### 결과값 출력
        # StaticText 대신 TextCtrl을 쓰는 이유 : 1. 테두리
        # 대신 옵션을 여러 개 넣어줘야한다 : 1. 입력 X // 2. 여러 줄 사용할 수 있게(style = ...)
        self.txtshow = wx.TextCtrl(self.panel, pos=(20, 400), size=(320, 150), style = wx.TE_MULTILINE|wx.TE_READONLY)


    def onText(self, evt):
        self.txtshow.AppendText("TextCtrl에서 이벤트 발생 : {}\n".format(evt.GetString()))

    def onCheck(self, evt):
        self.txtshow.AppendText("Checkbox에서 이벤트 발생 : {}\n".format(evt.IsChecked()))

    def onRadio(self, evt):
        self.txtshow.AppendText("Radiobox에서 이벤트 발생 : {}, {}\n".format(evt.GetInt(), evt.GetString()))

    def onCombo(self, evt):
        self.txtshow.AppendText("Combobox에서 이벤트 발생 : {}, {}\n".format(evt.GetInt(), evt.GetString()))
    
    def onKeydown(self, evt):
        if evt.GetKeyCode() == wx.WXK_ESCAPE:
            self.txtname.Clear()
        
        evt.Skip()
            # 프로그램 단축키가 이런 원리로 만들어짐
















if __name__ == '__main__' :
    app = wx.App() # 윈도우 프로그램 램공간 만들기
    frame = wx.Frame(None, title="1")
    frame.Show(True)
    app.MainLoop() #show가 꺼지지 않고 계속 시행되도록 무한반복시키는 것