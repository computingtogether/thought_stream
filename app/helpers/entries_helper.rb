module EntriesHelper

  def get_red(entries, thought, time)
    thought_count = create_prior_word_count_hash(entries, time)[thought]
    unless thought_count.nil?
      thought_count = thought_count *= 20
    else
      thought_count = 0
    end
    thought_count > 255 ? 255 : thought_count
  end

  def create_prior_word_count_hash(entries, time)
    thoughts_tally = {}
    _entries_prior_to_current_time(entries, time).each do |entry|
      _sanitize_thoughts(entry).each do |thought|
        if(thoughts_tally.include?(thought))
          thoughts_tally[thought] += 1
        else
          thoughts_tally[thought] = 1
        end
      end
    end
    thoughts_tally = thoughts_tally.sort_by{|k,v| -v}
    thoughts_tally.to_h
  end


  def create_all_time_word_count_hash(entries)
    thoughts_tally = {}
    entries.each do |entry|
      thoughts_array = entry.thoughts.split(',').map(&:strip).map(&:downcase)
      thoughts_array.each do |thought|
        thought = thought.lstrip
        thought = thought.rstrip
        if(thoughts_tally.include?(thought))
          thoughts_tally[thought] += 1
        else
          thoughts_tally[thought] = 1
        end
      end
    end
    thoughts_tally = thoughts_tally.sort_by{|k,v| -v}
    thoughts_tally.to_h
  end

  private
  def _entries_prior_to_current_time(entries,time)
    entries.select do |single_entry| 
      single_entry.created_at.to_i <= time
    end
  end
  
  def _sanitize_thoughts(entry)
    entry.thoughts.split(',').map(&:strip).map(&:downcase)
  end
  

end