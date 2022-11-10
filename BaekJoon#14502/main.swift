////
////  main.swift
////  BaekJoon#14502
////
////  Created by 김병엽 on 2022/11/10.
////
/// Reference: https://didu-story.tistory.com/294

let nm = readLine()!.split(separator: " ").map { Int(String($0))! }
var lab = [[Int]]()
var empty = [(Int, Int)]()
var virus = [(Int, Int)]()
var max = 0
let dx = [-1, 1, 0, 0]
let dy = [0, 0, -1, 1]

for _ in 0..<nm[0] {
    lab.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

for i in 0..<nm[0] {
    for j in 0..<nm[1] {
        if lab[i][j] == 0 {
            empty.append((i, j))
        } else if lab[i][j] == 2 {
            virus.append((i, j))
        }
    }
}

func bfs(copyLab: Array<Array<Int>>) {
    var bfsLab = copyLab
    var queue = [(Int, Int)]()
    var visited = Array(repeating: Array(repeating: false, count: nm[1]), count: nm[0])
    var cnt = 0

    for idx in 0..<virus.count {
        queue.append(virus[idx])
    }

    while !queue.isEmpty {
        let pop = queue.removeFirst()

        let x = pop.0
        let y = pop.1

        for i in 0..<4 {
            let nx = dx[i] + x
            let ny = dy[i] + y

            if nx >= 0 && nx < nm[0] && ny >= 0 && ny < nm[1] {
                if visited[nx][ny] == false && bfsLab[nx][ny] == 0 {
                    queue.append((nx, ny))
                    visited[nx][ny] = true
                    bfsLab[nx][ny] = 2
                }
            }
        }
    }

    for i in 0..<nm[0] {
        cnt += bfsLab[i].filter({ $0 == 0 }).count
    }

    if max < cnt { max = cnt }
}

for i in 0..<empty.count {
    for j in 0..<i {
        for k in 0..<j {
            let x1 = empty[i].0
            let y1 = empty[i].1
            let x2 = empty[j].0
            let y2 = empty[j].1
            let x3 = empty[k].0
            let y3 = empty[k].1

            lab[x1][y1] = 1
            lab[x2][y2] = 1
            lab[x3][y3] = 1

            let newLab = lab
            bfs(copyLab: newLab)

            lab[x1][y1] = 0
            lab[x2][y2] = 0
            lab[x3][y3] = 0
        }
    }
}


print(max)

