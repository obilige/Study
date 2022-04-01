# -*- coding: utf-8 -*-

###########################################################################
## Python code generated with wxFormBuilder (version Jun 17 2015)
## http://www.wxformbuilder.org/
##
## PLEASE DO "NOT" EDIT THIS FILE!
###########################################################################

import wx
import wx.xrc


###########################################################################
## Class MainFrame
###########################################################################

class MainFrame(wx.Frame):

    def __init__(self, parent):
        wx.Frame.__init__(self, parent, id=wx.ID_ANY, title=wx.EmptyString, pos=wx.DefaultPosition,
                          size=wx.Size(500, 300), style=wx.DEFAULT_FRAME_STYLE | wx.TAB_TRAVERSAL)

        self.SetSizeHintsSz(wx.DefaultSize, wx.DefaultSize)

        bSizer5 = wx.BoxSizer(wx.VERTICAL)

        self.m_panel4 = wx.Panel(self, wx.ID_ANY, wx.DefaultPosition, wx.DefaultSize, wx.TAB_TRAVERSAL)
        bSizer6 = wx.BoxSizer(wx.HORIZONTAL)

        self.m_staticText5 = wx.StaticText(self.m_panel4, wx.ID_ANY, u"거래처명 :", wx.DefaultPosition, wx.DefaultSize, 0)
        self.m_staticText5.Wrap(-1)
        bSizer6.Add(self.m_staticText5, 0, wx.ALL, 5)

        self.m_txtName = wx.TextCtrl(self.m_panel4, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer6.Add(self.m_txtName, 0, wx.ALL, 5)

        self.m_staticText6 = wx.StaticText(self.m_panel4, wx.ID_ANY, u"전화 :", wx.DefaultPosition, wx.DefaultSize, 0)
        self.m_staticText6.Wrap(-1)
        bSizer6.Add(self.m_staticText6, 0, wx.ALL, 5)

        self.m_txtTel = wx.TextCtrl(self.m_panel4, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer6.Add(self.m_txtTel, 0, wx.ALL, 5)

        self.m_btnInsert = wx.Button(self.m_panel4, wx.ID_ANY, u"등록", wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer6.Add(self.m_btnInsert, 0, wx.ALL, 5)

        self.m_panel4.SetSizer(bSizer6)
        self.m_panel4.Layout()
        bSizer6.Fit(self.m_panel4)
        bSizer5.Add(self.m_panel4, 0, wx.EXPAND | wx.ALL, 5)

        self.m_panel5 = wx.Panel(self, wx.ID_ANY, wx.DefaultPosition, wx.DefaultSize, wx.TAB_TRAVERSAL)
        bSizer8 = wx.BoxSizer(wx.VERTICAL)

        self.m_lstView = wx.ListCtrl(self.m_panel5, wx.ID_ANY, wx.DefaultPosition, wx.DefaultSize, wx.LC_REPORT)
        bSizer8.Add(self.m_lstView, 1, wx.ALL | wx.EXPAND, 5)

        # ListCtrl 필드명 작성
        self.m_lstView.InsertColumn(0, "거래처 이름", width=200)
        self.m_lstView.InsertColumn(1, "전화 번호", width=200)
        self.m_lstView.InsertColumn()

        self.m_panel5.SetSizer(bSizer8)
        self.m_panel5.Layout()
        bSizer8.Fit(self.m_panel5)
        bSizer5.Add(self.m_panel5, 1, wx.EXPAND | wx.ALL, 5)

        self.m_panel6 = wx.Panel(self, wx.ID_ANY, wx.DefaultPosition, wx.DefaultSize, wx.TAB_TRAVERSAL)
        bSizer7 = wx.BoxSizer(wx.HORIZONTAL)

        self.m_staticText9 = wx.StaticText(self.m_panel6, wx.ID_ANY, u"거래처 수 :", wx.DefaultPosition, wx.DefaultSize, 0)
        self.m_staticText9.Wrap(-1)
        bSizer7.Add(self.m_staticText9, 0, wx.ALL, 5)

        self.m_lblCount = wx.StaticText(self.m_panel6, wx.ID_ANY, u"0", wx.DefaultPosition, wx.DefaultSize, 0)
        self.m_lblCount.Wrap(-1)
        bSizer7.Add(self.m_lblCount, 0, wx.ALL, 5)

        self.m_panel6.SetSizer(bSizer7)
        self.m_panel6.Layout()
        bSizer7.Fit(self.m_panel6)
        bSizer5.Add(self.m_panel6, 0, wx.EXPAND | wx.ALL, 5)

        self.SetSizer(bSizer5)
        self.Layout()

        self.Centre(wx.BOTH)

        # Connect Events
        self.m_btnInsert.Bind(wx.EVT_BUTTON, self.onInsert)

    def __del__(self):
        pass

    # Virtual event handlers, overide them in your derived class
    def onInsert(self, event):
        name = self.m_txtName.GetValue()
        tel = self.m_txtTel.GetValue()

        i = self.m_lstView.InsertItem(1000, 0)
        # 첫번째 인자는 몇개까지 입력받을 것인지 나타냄. 여기선 1000개를 의미
        # 처음 입력되는 값을 어디에 위치시킬 것인지. 여기서 0은 첫번째 행을 의미
        # 이건 프레임이자 공간. 이제 입력값이 들어오게 만들어줘야 한다.
        self.m_lstView.SetItem(i, 0, name)
        self.m_lstView.SetItem(i, 1, tel)

        self.m_lblCount.SetLabelText(str(self.m_lstView.GetItemCount()))


if __name__ == "__main__":
    app = wx.App()
    frame = MainFrame(None)
    frame.Show(True)
    app.MainLoop()