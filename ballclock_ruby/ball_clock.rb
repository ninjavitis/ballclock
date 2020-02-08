def ball_clock(ball_count, minutes)
  @tracks =[
    {name:"Main", queue:[], capacity:ball_count+1, fixed_balls:0}, 
    {name:"Min", queue:[], capacity:4, fixed_balls:0}, 
    {name:"FiveMin", queue:[], capacity:11, fixed_balls:0}, 
    {name:"Hour", queue:[], capacity:11, fixed_balls:0},
  ]

  # to enable day/week/month counting move the hashes below into the track array
  # and set the hour capacity to 23
  # {name:"Day", queue:[], capacity:6, fixed_balls:0},
  # {name:"Week", queue:[], capacity:3, fixed_balls:0},
  # {name:"Month", queue:[], capacity:11, fixed_balls:0},
  
  @initial_state = []
  @ball_count = ball_count

  def isFull(track_number)
    track = @tracks[track_number]
    track[:queue].length() >= track[:capacity]
  end

  # returns the next indicator track, or the main queue if the passed track is the last track
  def nextTrack(current_track)
    if current_track == @tracks.length() - 1
      return 0
    else 
      return current_track + 1
    end
  end

  # FILO Dump to main 
  def dump_track(track_number)
    track = @tracks[track_number]
    to_main = track[:queue].slice!(0,track[:capacity] - track[:fixed_balls]).reverse()
    to_main.map{ |ball| rackBall(ball,0)}
  end

  # used to place a ball on a track, handling rollover when tracks are full
  def rackBall(ball, track_number)
    if ball 
      if isFull(track_number)
        # #empty the track into the queue in reverse order
        dump_track(track_number)
        # #drop the ball into the next track
        rackBall(ball, nextTrack(track_number))
      else
        #add the ball to the track
        @tracks[track_number][:queue].push(ball)
      end
    end
  end

  # returns 
  def compare_array(queue)
    state_match = true
    state_match = queue.each.with_index do |v,i|
      # puts("#{v} #{@initial_state[i]}")
      return false if v != @initial_state[i]
    end
  end

  # converts minutes to days, rounding down
  def minutes_to_days(minutes)
    minutes_per_day = 1440
    return (minutes / minutes_per_day).to_i.floor
  end

  def simulate(minutes, ball_count)
    if minutes > 0
      #handle clock state mode
      (1..minutes).each do |minute|
        rackBall(@tracks[0][:queue].shift,1)
      end
      return @tracks.map{ |track| {track[:name] => track[:queue]}}
    else
      # handle clock days mode
      minute = 0
      state_match = false

      while !state_match
        rackBall(@tracks[0][:queue].shift,1)
        minute += 1
        state_match = compare_array(@tracks[0][:queue])
      end
      # puts("minutes: #{minute}")
      return "#{ball_count} balls cycle after #{minutes_to_days(minute)} days"
    end
  end

  # initialize
  (1..ball_count).each do |ball|
    rackBall(ball, 0)
  end

  # store the initial state of the main queue
  @initial_state = @tracks[0][:queue].dup

  # state = @tracks.map{ |track| {track[:name] => track[:queue]}}

  # run the simulation and return the outcome
  return simulate(minutes, ball_count)
end

# gets an input integer from the console
def getInput
  gets.strip.to_i
end

def getBallCount
  min_balls = 27
  max_balls = 127

  puts('How many balls? (27 - 127)')
  ball_count = getInput()

  if ball_count >= min_balls && ball_count <= max_balls
    return ball_count
  else
    getBallCount()
  end
end

def getMinutes
  puts('To report the clock state specify the number of minutes.')
  puts('Press enter to report the number of days before the clock returns to the initial state.')
  minutes = getInput()
end

# get inputs then run simulation and print outcome to the console
def main
  balls = getBallCount()
  minutes = getMinutes()

  puts(ball_clock(balls, minutes))
end

main()