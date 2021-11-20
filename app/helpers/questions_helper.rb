module QuestionsHelper
  
  def questions_number(number, vopros, voprosa, voprosov)
    ostatok100 = number % 100
    if ostatok100 >= 11 && ostatok100 <= 14
      return voprosov
    end
    ostatok = number % 10
    if ostatok == 1
      return vopros
    end
    if (2..4).include?(ostatok)
      return voprosa
    end
    voprosov
  end
end
