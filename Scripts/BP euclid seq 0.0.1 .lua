function main()

  sel_midi = get_sel_midi_take()
  num_step = get_num_step(sel_midi)
  seq_euclid(sel_midi, num_step, 4)
  
end

--_______Seq func_______________________________
function seq_euclid(sel_midi, num_step, num_beat)

  for i = 0, num_step - 1 do
    
    multiplied = num_step * i
    
    index = multiplied / num_beat
    note_start = get_note_start(sel_midi, num_step,index)
    
    if multiplied % num_beat then 
    
      if index == 0 then --If note in zero step
        
        reaper.MIDI_InsertNote(sel_midi,0,0,0,50,0,72,30)
        index = index + 1
      end
      
    end
    
    reaper.MIDI_InsertNote(sel_midi,0,0,note_start,600,0,72,30)
    index = index + 1
    
  end
    
end


--_________________Addiction funct___________________
function get_sel_midi_take()

  if reaper.CountSelectedMediaItems(0) ~= 0 then
    
    item = reaper.GetSelectedMediaItem(0, 0)
    take = reaper.GetActiveTake(item)
    
    if reaper.TakeIsMIDI(take)then 
    
      return take
      
    else 
    
      reaper.ShowMessageBox("Bro, select MIDI ITEM", "WTF???", 0)
      
    end
    
  end
  
end  


function get_num_step(sel_midi)

  grid = reaper.MIDI_GetGrid(sel_midi)
  num_step = 1 / grid * 4
  return num_step
  
end


function get_note_start(sel_midi, num_step, index)
  
  note_start = reaper.BR_GetMidiSourceLenPPQ(sel_midi)/num_step * index
  
  return note_start
  
end


main()
