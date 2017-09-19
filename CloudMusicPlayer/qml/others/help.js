function fuzzyCompare(val1, val2) {
    if (Math.abs(val1 - val2) < 0.00001)
        return true
    else
        return false
}

function preZero(t) {
    if (t < 10)
        return '0' + t.toString()
    else
        return t.toString()
}

function formatTime(time, isSecond)
{
    var t = parseInt(time)
    var min
    var sec
    if (!isSecond)
        t /= 1000

    min = parseInt(t / 60)
    sec = parseInt(t % 60)
    return preZero(min) + ':' + preZero(sec)
}

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

function playRandom(count) {
    if (count <= 0)
        return -1;
    return Math.round(Math.random() * count)
}

function playInorder(current, count) {
    if (count <= 0 || current >= count || current + 1 === count)
        return -1
    if (current < 0)
        return 0

    return current + 1
}

function playList(current, count) {
    if (count <= 0 || current >= count)
        return -1
    if (current < 0)
        return 0

    return (current + 1) % count
}
