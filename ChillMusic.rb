
# initial tempo
tempo = 40

# define chords used in piece
cmaj = chord(:c, :major)
dmaj = chord(:d, :major)
amaj = chord(:a, :major)
amin = chord(:a, :minor)
gmaj = chord(:g, :major)
bmin = chord(:b, :minor)
fmaj = chord(:f, :major)


# function that plays a four chord sequence with the chords c1, c2,c3, c4
# plays each chord and its inverted chord
define :play_inverted_sequence do |c1, c2, c3, c4|
  play c1, attack: 1, release: 2
  sleep(1)
  play invert_chord(c1,1), attack: 1, release: 1
  sleep(1)
  play c2, attack: 1, release: 2
  sleep(1)
  play invert_chord(c2,1), attack: 1, release: 1
  sleep(1)
  play c3, attack: 1, release: 2
  sleep(1)
  play invert_chord(c3,1), attack: 1, release: 1
  sleep(1)
  play c4, attack: 1, release: 2
  sleep(1)
  play invert_chord(c4,1), attack: 1, release: 1
  sleep(1)
end

# this thread plays music
in_thread do
  
  sleep(10)
  use_bpm tempo
  #sample :ambi_haunted_hum
  use_synth :dark_ambience
  
  # 'pessemistic' four chord sequence
  4.times do
    play_inverted_sequence(amin, fmaj, cmaj, gmaj)
  end
  tempo += 1
  use_bpm tempo
  # axis of awesome four chord sequence
  8.times do
    play_inverted_sequence(dmaj, amaj, bmin, gmaj)
  end
  tempo += 2
  use_bpm tempo
  sleep(1)
  
  # altered four chord sequence
  play_inverted_sequence(gmaj, amin, fmaj, cmaj)
  sleep(1)
  
  tempo +=1
  use_bpm tempo
  
  # axis of awesome four chord sequence
  6.times do
    play_inverted_sequence(dmaj, amaj, bmin, gmaj)
    
  end
  tempo += 2
  use_bpm tempo
  sleep(1)
  
  # altered four chord sequence
  play_inverted_sequence(gmaj, amin, fmaj, cmaj)
  sleep(1)
  
  
  tempo -=2
  use_bpm tempo
  
  # axis of awesome four chord sequence
  6.times do
    play_inverted_sequence(dmaj, amaj, bmin, gmaj)
  end
  tempo -= 4
  use_bpm tempo
  sleep(1)
  
  # altered four chord sequence
  play_inverted_sequence(gmaj, amin, fmaj, cmaj)
  sleep(1)
  tempo -= 4
  use_bpm tempo
  
  # 'pessemistic' four chord sequence
  4.times do
    play_inverted_sequence(amin, fmaj, cmaj, gmaj)
  end
  sleep(1)
  puts "song complete"
end


# this thread incoorporates random notes into music
in_thread do
  loop do
    use_bpm tempo
    use_synth :dark_ambience
    sleep(10)
    # select random note from cmajor scale and play
    play [:C5, :D5, :E5, :F5, :G5, :A5, :B5].choose, attack: 1, release: 5
    
  end
  
end


# this thread plays rain
in_thread do
  loop do
    use_bpm tempo
    # play sample of light rain and have loop stop for duration of sample
    sample "/Users/adriennemiller/Downloads/lightrain.wav"
    sleep sample_duration("/Users/adriennemiller/Downloads/lightrain.wav")
  end
end

# this thread plays thunder at random intervals
in_thread do
  loop do
    # play loud thunderclap on random intervals
    sleep(rrand(30, 80))
    sample "/Users/adriennemiller/Downloads/thunderclap.wav", amp: 0.5
  end
end
