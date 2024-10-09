# 检查 Docker Compose 是否已安装
if ! command -v docker-compose &> /dev/null
then
    echo "Docker Compose 未安装，正在安装..."
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker Compose 已成功安装！版本信息："
    docker-compose --version
else
    echo "Docker Compose 已安装，版本信息："
    docker-compose --version
fi

# 检查 Docker 服务是否正在运行
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

# 检查 docker-compose.yml 文件是否存在
if [ -f "./docker-compose.yml" ]; then
    echo "找到 docker-compose.yml 文件，启动 Docker Compose..."
    docker-compose up -d
else
    echo "错误：当前目录下没有找到 docker-compose.yml 文件。"
    exit 1
fi
