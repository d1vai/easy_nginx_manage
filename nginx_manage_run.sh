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
