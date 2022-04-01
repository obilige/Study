# sizer 클래스 : 이 클래스에 위치만 대략 던져주면 크기부터 세부 위치까지 레이아웃 관련 모든걸 자동화
    # wx.BoxSizer() : 가로 또는 세로로 컨트롤을 배치
    # wx.GridSizer() : 그리드와 같은 구조로 컨트롤을 배치
    # wx.FlexSizer()

#wx.FormBuilder
#---------------
#https://sourceforge.net





import wx
from wx.core import BoxSizer, Choice
class MainFrame(wx.Frame):
    def __init__(self):
        super().__init__(None, title='Sizer', size=(400, 600))

        panel1 = wx.Panel(self, style=wx.SUNKEN_BORDER)
        panel1.SetBackgroundColour("BLUE")
        panel2 = wx.Panel(self, style=wx.SUNKEN_BORDER)
        panel2.SetBackgroundColour("RED")

        box = wx.BoxSizer(wx.HORIZONTAL)
        box.add(panel1, 1, wx.EXPAND)
        box.add(panel2, 1, wx.EXPAND)
        # 중간 숫자는 비율을 의미한다. 전체 크기를 1:1로
        # 만약 panel1에 3, panel2에 1을 주면 각각 3/4, 1/4

        self.SetSizer(box)

