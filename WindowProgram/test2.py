import wx
from wx.core import EVT_MENU

class MemoFrame(wx.Frame):
    def __init__(self):
        super().__init__(None, title='메모장 프로그램', size=(800, 600)) #윈도우 프로그램 재료엔 첫번째 인자가 어디에 붙여서, 즉 부모의 주소가 어딘지 명시하게 되어있다.
        self.design()
    
    def design(self):
        # 메뉴 : 고정식 메뉴(pull down), 이동식 메뉴(pop up) - 마우스 오른쪽 버튼을 누르면 나오는 메뉴들, 
        # MenuBar, Menu, MenuItem // 이 세가지를 조립해서 만든다.
        menubar = wx.MenuBar()
        menufile = wx.Menu()
        menuedit = wx.Menu()

        menufile_new = wx.MenuItem(menufile, wx.ID_NEW, "New", "New Document")
        menufile_open = wx.MenuItem(menufile, wx.ID_OPEN, "Open", "Open CSV File")
        menufile_save = wx.MenuItem(menufile, wx.ID_SAVE, "Save", "Save the CSV File")
        menufile_exit = wx.MenuItem(menufile, wx.ID_EXIT, "Exit", "Close the Program")

        menufile.Append(menufile_new)
        menufile.Append(menufile_open)
        menufile.Append(menufile_save)
        menufile.Append(menufile_exit)

        # 메뉴바에 메뉴들을 붙여줘야한다. 그리고 이 메뉴바를 다시 기본 뼈대에 붙여줘야한다.
        menubar.Append(menufile, "File")
        menubar.Append(menuedit, "Edit")

        self.SetMenuBar(menubar)
        
        self.txtArea = wx.TextCtrl(self, style=wx.TE_MULTILINE)

        self.CreateStatusBar()

        self.Bind(EVT_MENU, self.onNew, menufile_new) # 이벤트에 대한 정보를 자식들에게 넘겨주는 역할. 예) 메뉴바에 new를 선택했을 때, 선택되었단 정보를 넘겨주는 
        #(연결방법 인자, 처리방법 코드 담긴 함수 인자, 클릭받은 곳 디자인 위치 인자)
        self.Bind(EVT_MENU, self.onExit, menufile_exit)
        self.Bind(EVT_MENU, self.onOpen, menufile_exit)
        # 이벤트 핸들러엔 on을 붙이는 것이 관례, 암묵적인 약속


        #self.Move(100, 100)
        self.Center()
    
    def onNew(self, evt):
        self.txtArea.SetLabelText("New page")

    def onExit(self, evt):
        self.Close(True)

    def onOpen(self, evt):
        f = open('/Users/hoon/Desktop/Data/vscode/AI/data/crime.csv')
        data = f.read()
        self.txtArea.SetLabelText(data)
        f.close()

if __name__ == "__main__":
    app = wx.App()
    frame = MemoFrame()
    frame.Show(True)
    app.MainLoop()


### 윈도우 만들 때 알아야할 3대 요소
# 1. 컨트롤(이벤트 소스 = 사건이 발생하는 장소) : textbox, radiobutton과 같은 재료들을 알아야 한다.
# 2. Layout : 원하는 위치에 재료들을 배치
# 3. 이벤트 : 키보드, 마우스로 무엇이 입력되면 동작하게끔 만들어야한다.
