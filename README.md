# tgimg
适用于claw cloud部署的tgsearch、tgsou镜像

存储可选，挂载存储的好处就是使用命令行扫码后的session文件不会丢失，即使重启容器也不用重新获取session了。动画演示中的重启步骤不是必须的，只是演示下不会丢失session文件。
tgsearch挂载目录建议/tmp

可以使用环境变量方式设置session，可以使用在线TG Session获取工具 https://tgs.252035.xyz

# 动画演示
利用CLAWCLOUD RUN部署tgsou  
![利用CLAWCLOUD RUN部署tgsou](https://github.com/fish2018/tgimg/blob/main/利用CLAWCLOUDRUN部署tgsou.gif)  

利用CLAWCLOUDRUN部署tgsearch:  
![利用CLAWCLOUDRUN部署tgsearch](https://github.com/fish2018/tgimg/blob/main/利用CLAWCLOUDRUN部署tgsearch.gif)  
