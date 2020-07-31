# toast_with_icon
------
  A new toast package which can set icon as you want ,and allowed custom build.


------

## How to Use
```python
# add this line to your dependencies
toast_with_icon: ^1.0.0
```


```python
  ToastWithIcon.toast(context,
                    showTime: 4000,
                    axis: Axis.horizontal,
                    bgColor: Colors.black45,
                    textSize: 15.0,
                    textColor: Colors.white,
                    paddingHorizontal: 10.0,
                    paddingVertical: 10.0,
                    iconWidth: 15.0,
                    iconHeight: 15.0,
                    positionedLeft: MediaQuery.of(context).size.width * 3 / 10,
                    positionedRight: MediaQuery.of(context).size.width * 3 / 10,
                    elevation: 0,
                    gravity: ToastWithIconGravity.TOP,
                    icon: 'image/success.png',
                    msg: 'iconToast on top');
```
### API

| property        | description    | defaultValue
| :--------   | :-----  |:--------
|icon   | String(Nullable) |
| msg     | String (non-null)   |
| showTime     | int    | 2000
| axis        | Axis | Axis.horizontal
| bgColor        |Color | Colors.white |
| textSize        | double | 15.0 |
| textColor        | Color   | Colors.white
| paddingHorizontal| double | 10.0
|paddingVertical   | double | 10.0
|iconWidth   | double |  15.0
|iconHeight   | double | 15.0
|positionedLeft   | double | MediaQuery.of(context).size.width * 3 / 10
|positionedRight   | double | MediaQuery.of(context).size.width * 3 / 10
|elevation   | double | 1.0
|gravity   | ToastWithIconGravity | ToastWithIconGravity.CENTER




###  [GitHub](https://github.com/manburenshenglu)