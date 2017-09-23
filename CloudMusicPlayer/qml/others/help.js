
// 比较两个浮点数是否相等
function fuzzyCompare(val1, val2) {
    if (Math.abs(val1 - val2) < 0.00001)
        return true
    else
        return false
}

// 添加前置0
function preZero(t) {
    if (t < 10)
        return '0' + t.toString()
    else
        return t.toString()
}

// 格式化时间
function formatTime(time, isSecond){
    var t = parseInt(time)
    var min
    var sec
    if (!isSecond)
        t /= 1000

    min = parseInt(t / 60)
    sec = parseInt(t % 60)
    return preZero(min) + ':' + preZero(sec)
}

// 格式化文件大小或者速度
function formatSize(size, isSpeed) {
    var s = parseInt(size)
    var unit
    if (s < 1024 * 1024) {
        s = parseInt(s / 1024)
        unit = 'KB'
    }
    else if (s < 1024 * 1024 * 1024) {
        s = (s / (1024 * 1024)).toFixed(1)

        unit = 'MB'
    }
    else {
        s = (s / (1024 * 1024 * 1024)).toFixed(1)
        unit = 'G'
    }

    if (isSpeed) unit += '/s'
    return s + unit
}

// 获取随机数
function playRandom(count) {
    if (count <= 0)
        return -1;
    return Math.round(Math.random() * (count - 1))
}

// 顺序播放
function playInorder(current, count) {
    if (count <= 0 || current >= count || current + 1 === count)
        return -1
    if (current < 0)
        return 0

    return current + 1
}

// 列表循环
function playList(current, count) {
    if (count <= 0 || current >= count)
        return -1
    if (current < 0)
        return 0

    return (current + 1) % count
}

// parse banner json
function parseBanner(json, model) {
    json = json.banners
    if (json) {
        model.clear()
        for (var i = 0; i < json.length; ++i)
            model.append({
                         'picUrl': json[i].pic,
                             'titleColor': json[i].titleColor,
                             'typeTitle': json[i].typeTitle,
                             'url': json[i].url
                         })
    }
}

// 解析推荐歌单
function parsePersonalized(json, model) {
    json = json.result
    if (json) {
        model.clear()
        for (var i = 0; i < json.length; ++i)
            model.append({
                             'copywriter': json[i].copywriter,
                             'name': json[i].name,
                             'picUrl': json[i].picUrl,
                             'playCount': json[i].playCount
                         })

    }
}

// 解析独家放送
function parsePrivatecontent(json, model) {
    json = json.result
    if (json) {
        model.clear()
        for (var i = 0; i < json.length; ++i)
            model.append({
                             'copywriter': json[i].copywriter,
                             'name': json[i].name,
                             'picUrl': json[i].sPicUrl
                         })
    }
}

// 解析最新音乐
function parseNewmusic(json, model) {
    json = json.result
    if (json) {
        model.clear()
        for (var i = 0;i < json.length; ++i)
            model.append({
                             'name': json[i].name,
                             'artist': json[i]['song']['artists'][0].name,
                             'aliasInfo': json[i]['song']['alias'][0],
                             'picUrl': json[i]['song']['album'].blurPicUrl
                         })
    }
}

// 解析推荐MV
function parseMV(json, model) {
    json = json.result
    if (json) {
        model.clear()
        for (var i = 0; i < json.length; ++i)
            model.append({
                             'name': json[i].name,
                             'picUrl': json[i].picUrl,
                             'playCount': json[i].playCount,
                             'copywriter': json[i].copywriter
                         })
    }
}

// 解析主播电台
function parseDJ(json, model) {
    json = json.result
    if (json) {
        model.clear()
        for (var i = 0; i < json.length; ++i)
            model.append({
                             'name': json[i].name,
                             'brand': json[i]['program']['dj'].brand,
                             'picUrl': json[i]['program']['mainSong']['album'].blurPicUrl
                         })
    }
}

function readFile(url, model) {
    var http = new XMLHttpRequest;

    console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState === XMLHttpRequest.DONE) {
            var readText = http.responseText
            var json = JSON.parse(readText)
            if (json) {
                if (url.indexOf('banner') !== -1)
                    parseBanner(json, model)
                else if (url.indexOf('推荐歌单') !== -1)
                    parsePersonalized(json, model)
                else if (url.indexOf('独家放送') !== -1)
                    parsePrivatecontent(json, model)
                else if (url.indexOf('最新音乐') !== -1)
                    parseNewmusic(json, model)
                else if (url.indexOf('推荐MV') !== -1)
                    parseMV(json, model)
                else if (url.indexOf('推荐电台') !== -1)
                    parseDJ(json, model)
            }
        }
    }

    http.open("GET", url, true)
    http.send(null)
}

function route(json, type, model) {
    console.log(type)
    json = JSON.parse(json)
    if (type === '/banner')
        parseBanner(json, model)
    else if (type === '/personalized')
        parsePersonalized(json, model)
    else if (type === '/personalized/privatecontent')
        parsePrivatecontent(json, model)
    else if (type === '/personalized/newsong')
        parseNewmusic (json, model)
    else if (type === '/personalized/mv')
        parseMV(json, model)
    else if (type === '/personalized/djprogram')
         parseDJ(json, model)

}
