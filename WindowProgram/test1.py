# # 메모장 - 코드
# # 파이썬 - 번역
# # 라이브러리 : TKinter(파이썬 내장, 내용 부실), wxPython, PyQt

import wx
class LoginFrame(wx.Frame):
    def __init__(self):
        super().__init__(None, title='Login', size=(300, 200)) #윈도우 프로그램 재료엔 첫번째 인자가 어디에 붙여서, 즉 부모의 주소가 어딘지 명시하게 되어있다.
        self.design()



if __name__ == '__main__' :
    app = wx.App() # 윈도우 프로그램 램공간 만들기
    frame = wx.Frame(None, title="처음 만드는 윈도우 어플리케이션") #뼈대 세우기. 메뉴바와 사각형 프레임 만드는 것
    frame.Show(True)
    app.MainLoop() #show가 꺼지지 않고 계속 시행되도록 무한반복시키는 것

import test2