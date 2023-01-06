function main()

  sel_midi = get_sel_midi_item()
  grid = reaper.MIDI_GetGrid(sel_midi)
  num_step = get_num_step(grid)
  seq_euclid(num_step, 4, sel_midi)
  
end

--_______Seq func_______________________________
function seq_euclid(num_step, num_beat, sel_midi)

  for i = 0, num_step - 1 do
    
    multiplied = num_step * i
    
    index = multiplied / num_beat
    note_start = get_note_start(index)
    
    if multiplied % num_beat then 
      if index == 0 then --If note in zero step
        
        reaper.MIDI_InsertNote(sel_midi,0,0,0,50,0,72,30)
        index = index + 1
        
      end
      
      note_start = get_note_start(index)
      reaper.MIDI_InsertNote(sel_midi,0,0,0,50,0,72,30)
      index = index + i 
      
    end
    
  end
  
end    


--_________________Addiction funct___________________
function get_sel_midi_item()

  if reaper.CountSelectedMediaItems(0) ~= 0 then
  
    for i = 0, reaper.CountSelectedMediaItems(0)-1 do 
    
      item = reaper.GetSelectedMediaItem(0, i)
      take_midi = reaper.GetActiveTake(item)
      
    end
    
    if reaper.TakeIsMIDI(take_midi)then 
    
      return take_midi
      
    else 
    
      reaper.ShowMessageBox("Bro, select MIDI ITEM", "WTF???", 0)
      
    end
    
  end
  
end  


function get_num_step(grid)

  num_step = 1 / grid * 4
  return num_step
  
end


function get_note_start(index)

  note_start = reaper.BR_GetMidiSourceLenPPQ(sel_midi)/16 * index
  
  return note_start
  
end


main()
