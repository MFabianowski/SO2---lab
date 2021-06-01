import random


def drawBoard(board):
    print(' ___________')
    print('| ' + board[7] + ' | ' + board[8] + ' | ' + board[9] + ' | ')
    print('|-----------|')
    print('| ' + board[4] + ' | ' + board[5] + ' | ' + board[6] + ' | ')
    print('|-----------|')
    print('| ' + board[1] + ' | ' + board[2] + ' | ' + board[3] + ' | ')
    print('|___________|')


def chooseLetter():
    player_marker = ''

    while not (player_marker == 'X' or player_marker == 'O'):
        player_marker = input("Please choose a marker 'X' or 'O' ").upper()

    if player_marker == 'X':
        comp_marker = 'O'
        return player_marker, comp_marker
    else:
        comp_marker = 'X'
        return player_marker, comp_marker


def whoFirst():
    if random.randint(0, 1) == 0:
        return 'computer'
    else:
        return 'player'


def playAgain():
    answer = input("Do you want to play again? (yes or no) ").lower()
    if answer == "yes":
        return True
    else:
        return False


def makeMove(board, marker, move):
    board[move] = marker


def isSpaceFree(board, move):
    return board[move] == ' '


def copyBoard(board):
    dupli_board = []

    for move in board:
        dupli_board.append(move)
    return dupli_board


def checkWinner(board, marker):
    wo = ((board[7] == marker and board[8] == marker and board[9] == marker) or
          (board[4] == marker and board[5] == marker and board[6] == marker) or
          (board[1] == marker and board[2] == marker and board[3] == marker) or
          (board[7] == marker and board[4] == marker and board[1] == marker) or
          (board[8] == marker and board[5] == marker and board[2] == marker) or
          (board[9] == marker and board[6] == marker and board[3] == marker) or
          (board[7] == marker and board[5] == marker and board[3] == marker) or
          (board[9] == marker and board[5] == marker and board[1] == marker))

    return wo


def playerMove(board):
    move = ' '
    while True:
        move = input('Where do you want to place your marker? ')
        free = isSpaceFree(board, int(move))
        if move in ['1', '2', '3', '4', '5', '6', '7', '8', '9'] and free:
            break
    return int(move)


def chooseRandomMove(board, moves_list):
    possible_moves = []
    for i in moves_list:
        if isSpaceFree(board, i):
            possible_moves.append(i)

    if len(possible_moves) != 0:
        return random.choice(possible_moves)
    else:
        return None


def getCompMove(board, marker):
    if marker == 'X':
        player = 'O'
    else:
        player = 'X'

    for i in range(1, 10):
        copy = copyBoard(board)
        if isSpaceFree(copy, i):
            makeMove(copy, marker, i)
            if checkWinner(copy, marker):
                return i

    for i in range(1, 10):
        copy = copyBoard(board)
        if isSpaceFree(copy, i):
            makeMove(copy, player, i)
            if checkWinner(copy, player):
                return i

    move = chooseRandomMove(board, [1, 3, 7, 9])
    if move is not None:
        return move

    if isSpaceFree(board, 5):
        return 5

    return chooseRandomMove(board, [2, 4, 6, 8])


def isBoardFull(board):
    for i in range(1, 10):
        if isSpaceFree(board, i):
            return False
    return True


while True:
    the_board = [' '] * 10
    player_marker, comp_marker = chooseLetter()
    turn = whoFirst()
    print('The ' + turn + ' will go first.')
    gameOn = True

    while gameOn:
        if turn == 'player':
            drawBoard(the_board)
            move = playerMove(the_board)
            makeMove(the_board, player_marker, move)

            if checkWinner(the_board, player_marker):
                drawBoard(the_board)
                print('You won!')
                gameOn = False
            else:
                if isBoardFull(the_board):
                    drawBoard(the_board)
                    print('The game is a tie!')
                    break
                else:
                    turn = 'computer'
        else:
            move = getCompMove(the_board, comp_marker)
            makeMove(the_board, comp_marker, move)

            if checkWinner(the_board, comp_marker):
                drawBoard(the_board)
                print('The computer has won!')
                gameOn = False
            else:
                if isBoardFull(the_board):
                    drawBoard(the_board)
                    print("It's a tie!")
                    break
                else:
                    turn = 'player'

    if not playAgain():
        break
