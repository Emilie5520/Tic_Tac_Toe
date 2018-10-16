require 'colorize'

class Morpion
	attr_accessor :board, :joueur1, :joueur2

	def initialize_board #hash avec les cases du plateau de jeu
		@board = 
		{
		  a1: ' ',
		  a2: ' ',
		  a3: ' ',
		  b1: ' ',
		  b2: ' ',
		  b3: ' ',
		  c1: ' ',
		  c2: ' ',
		  c3: ' '
	  }
	end

	def match_nul?
	  i = 0
      board.each do |key, val|
	    i = i + 1 if val == ' ' 
	  end
	  if i == 0
	  	return true
	  else
	  	return false
	  end
	end

    def check_victoire #combinaisons gagnantes 
      if ((board[:a1] == board[:a2]) && (board[:a1] == board[:a3]) && (board[:a1] != ' ')) ||
         ((board[:b1] == board[:b2]) && (board[:b1] == board[:b3]) && (board[:b1] != ' ')) ||
         ((board[:c1] == board[:c2]) && (board[:c1] == board[:c3]) && (board[:c1] != ' ')) ||
         ((board[:a1] == board[:b1]) && (board[:a1] == board[:c1]) && (board[:a1] != ' ')) ||
         ((board[:a2] == board[:b2]) && (board[:a2] == board[:c2]) && (board[:a2] != ' ')) ||
         ((board[:a3] == board[:b3]) && (board[:a3] == board[:c3]) && (board[:a3] != ' ')) ||
         ((board[:a1] == board[:b2]) && (board[:a1] == board[:c3]) && (board[:a1] != ' ')) ||
         ((board[:a3] == board[:b2]) && (board[:a3] == board[:c1]) && (board[:a3] != ' '))           
              return true
      else
              return false
      end        
    end

	def choix_possibles #afficher les choix possibles 
	  puts "Choix possibles : "
		board.each do |key, val|
		  puts key unless val != ' '
	  end
	end

	def display_board # afficher le plateau de jeu
		puts "\t    a | b | c ".colorize(:red)
    puts "\t ------------".colorize(:red)
    puts "\t1 | #{@board[:a1]} | #{@board[:b1]} | #{@board[:c1]} ".colorize(:red)
    puts "\t--------------".colorize(:red)
    puts "\t2 | #{@board[:a2]} | #{@board[:b2]} | #{@board[:c2]} ".colorize(:red)
    puts "\t--------------".colorize(:red)
    puts "\t3 | #{@board[:a3]} | #{@board[:b3]} | #{@board[:c3]} ".colorize(:red)
	end

	def phase2
		puts ' '
		puts "#{joueur2} c'est à toi !".colorize(:green)
    	choix_possibles
		puts "Quel est ton choix ?".colorize(:green)
		choix = gets.chomp
		place_choixj2(choix)
		phase_intermediaire(2)
	end

	def phase_courante
		puts ' '
		puts "#{joueur1} c'est à toi !".colorize(:green)
		choix_possibles
		puts "Quel est ton choix ?".colorize(:green)
		choix = gets.chomp
		place_choixj1(choix)
		phase_intermediaire(1)
	end

	def choix_du_vainqueur(phase) #Jouer au tour par tour 
		if phase == 1
			joueur = joueur1
		else
			joueur = joueur2
		end
	end

	def phase_intermediaire(phase)
		puts "Bien joué !".colorize(:green)
		puts ''
		puts "Voici le plateau de jeu".colorize(:green)
		puts ' '
		display_board
		if check_victoire
			gagnant = choix_du_vainqueur(phase)
			puts ' '
			puts " ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ "
			puts "Bravo #{gagnant}, tu as gagné ♡. La partie est terminée, relance le programme si tu veux rejouer !".colorize(:green)
			return
		end
		if x = match_nul?
			puts ' '
			puts " ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ ✴ "
			puts "MATCH NUL ♡. La partie est terminée, si tu veux rejouer relance le programme !".colorize(:green)
			return
		end
		if phase == 1
			phase2
		else
		  phase_courante
		end
	end

	def place_choixj1(choix)
		board[:"#{choix}"] = 'X' if board[:"#{choix}"] == ' '
	end

	def place_choixj2(choix)
		board[:"#{choix}"] = 'O' if board[:"#{choix}"] == ' '
	end

	def phase1
		puts ' '
		puts "#{joueur1} sera X et #{joueur2} sera O.".colorize(:green)
		puts " • • • • • • • • •".colorize(:green)
		puts "#{joueur1} commence la partie".colorize(:green)
		choix_possibles
		puts "Quel est ton choix ?".colorize(:green)
		choix = gets.chomp
		place_choixj1(choix)
		phase_intermediaire(1)
	end

	def Bienvenue#récupérer les noms des joueurs 
		puts ' '
		puts "Donnez moi le nom des deux joueurs :".colorize(:green)
		puts "Joueur 1 :".colorize(:green)
		@joueur1 = gets.chomp
		puts "Joueur 2 :".colorize(:green)
		@joueur2 = gets.chomp
		phase1
	end

	def initialize
		initialize_board
		puts ' '
		puts "❁ ❁ ❁ Bienvenue dans ce jeu de tic tac toe ! ❁ ❁ ❁ ".upcase.colorize(:red)
		puts ' '
		puts "Le but du jeu est de réussir à aligner 3 pions à la suite :
				• à la verticale
				• à l'horizontale
				• ou à la diagonale." .colorize(:yellow)
		puts "Il faut donc être attentif pour bloquer son adversaire avant qu'il n'aligne ses trois pions.".colorize(:yellow)
		puts "Il peut y avoir un gagnant ou match nul. ".colorize(:yellow)
		puts ' '
		puts "\tVoici le plateau de jeu :".colorize(:green)
		puts "\t↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓".colorize(:green)
		puts ''
		display_board
	end
end

game = Morpion.new
game.Bienvenue