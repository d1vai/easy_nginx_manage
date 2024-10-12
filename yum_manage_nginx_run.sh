#!/bin/bash

# 检查 Docker 是否已安装
if ! command -v docker &> /dev/null
then
    echo "Docker 未安装，正在安装..."
    
    # 更新 yum 包索引
    sudo yum update -y
    
    # 安装依赖
    sudo yum install -y yum-utils ca-certificates curl gnupg2 device-mapper-persistent-data lvm2

    # 添加 Docker 仓库
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

    # 安装 Docker
    sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    echo "Docker 已成功安装！"
else
    echo "Docker 已安装，版本信息："
    docker --version
fi

# 检查 Docker 服务是否运行
if ! sudo systemctl is-active --quiet docker
then
    echo "Docker 未启动，正在启动..."
    sudo systemctl start docker
    
    if sudo systemctl is-active --quiet docker
    then
        echo "Docker 已成功启动。"
    else
        echo "错误：无法启动 Docker 服务，请检查系统日志。"
        exit 1
    fi
else
    echo "Docker 正在运行。"
fi

# 检查 Docker Compose 是否已安装
if ! command -v docker-compose &> /dev/null
then
    echo "Docker Compose 未安装，正在安装..."

    # 下载 Docker Compose 二进制文件
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    # 为 Docker Compose 二进制文件赋予执行权限
    sudo chmod +x /usr/local/bin/docker-compose

    # 验证是否安装成功
    if command -v docker-compose &> /dev/null
    then
        echo "Docker Compose 已成功安装，版本信息："
        docker-compose --version
    else
        echo "Docker Compose 安装失败。"
    fi
else
    echo "Docker Compose 已安装，版本信息："
    docker-compose --version
fi

# 检查 docker-compose.yml 文件是否存在
if [ -f "./docker-compose.yml" ]; then
    echo "找到 docker-compose.yml 文件，启动 Docker Compose..."
    if ! docker-compose up -d; then
        echo "错误：当前用户没有权限访问 Docker 守护进程。请尝试运行以下命令以解决此问题："
        echo "sudo usermod -aG docker $USER && newgrp docker"
        exit 1
    fi
else
    echo "错误：当前目录下没有找到 docker-compose.yml 文件。"
    exit 1
fi
