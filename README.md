# xgo
基于 github.com/techknowlogick/xgo 进行修改的交叉编译工具。  
- 支持 Android。
- 针对 go mod 的修改。

# 使用
## 准备
构建docker镜像
```
docker build . -f Dockerfile -t xgo
```

构建xgo工具
```
go build xgo.go
```

## 设置环境变量
```
export GOPATH=~/go
export GOPROXY=https://goproxy.cn,direct
```

## 编译
```
./xgo --image=xgo --targets=./. --pkg=$PKG_DIR $PROJECT_DIR
```

# 支持的编译目标
- linux
  - amd64
  - 386
  - arm-5
  - arm-6
  - arm-7
  - arm64
  - mips64
  - mips64le
  - mips
  - s390x
  - ppc64le
  - mipsle
- windows
  - amd64
  - 386
- darwin
  - amd64
  - arm64
- android
  - arm
  - arm64
  - 386
  - amd64