# Welcome to Sonic Pi

tempo = 30

#sample :ambi_haunted_hum
cmaj = chord(:c, :major)
dmaj = chord(:d, :major)
amaj = chord(:a, :major)
amin = chord(:a, :minor)
gmaj = chord(:g, :major)
bmin = chord(:b, :minor)
fmaj = chord(:f, :major)

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

in_thread do
  loop do
    use_bpm tempo
    #sample :ambi_haunted_hum
    use_synth :dark_ambience
    4.times do
      play_inverted_sequence(dmaj, amaj, bmin, gmaj)
    end
    sleep(1)
    play_inverted_sequence(gmaj, amin, fmaj, cmaj)
    sleep(1)
    
  end
end

in_thread do
  loop do
    use_bpm tempo
    use_synth :dark_ambience
    sleep(10)
    # select from notes in cmajor scale
    play [:C5, :D5, :E5, :F5, :G5, :A5, :B5].choose, attack: 1, release: 5
    
  end
  
end

in_thread do
  loop do
    use_bpm tempo
    sample "/Users/adriennemiller/Downloads/lightrain.wav"
    sleep sample_duration("/Users/adriennemiller/Downloads/lightrain.wav")
  end
end

in_thread do
  loop do
    sleep(rrand(30, 80))
    sample "/Users/adriennemiller/Downloads/thunderclap.wav", amp: 0.5
  end
end
