require './shared.rb'

class Meta
  def self.table(format: :latex)
    return '' unless format == :latex
    output = ['\begin{tabular}{| c | c |}', "\t \\hline", "\topcode & meta \\\\ \\hline"]
    output += self.constants.map.with_index { |c, i| "\t\\texttt{#{c.to_s}} & 0x#{i.to_s(16)} \\\\ \\hline" }
    output << '\end{tabular}'
    output.join "\n"
  end
end
