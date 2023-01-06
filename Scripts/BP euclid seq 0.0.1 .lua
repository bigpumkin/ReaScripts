function main()

  sel_midi = get_sel_midi_take()
  num_step = get_num_step(sel_midi)
  seq_euclid(sel_midi, num_step, 4)
  
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
