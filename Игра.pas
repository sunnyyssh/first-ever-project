uses graphabc;
const g=7; 
      Vy0=50;/// поменяй!!!!!!!!!!!!!!
      JFtime=100; ///change!!!!!!!!!!!!!!!  Vx/jFtime = 40/character.steptime
type character = record
  characterNumber:integer;
  hitpoints:integer;
  steptime:integer; ///Должно быть кратно количеству кадров на один шаг
  AttackTime:integer;
  MainDamage1:integer;
  DamageCost1:integer;
  MainDamage2:integer;
  DamageCost2:integer;
  Energy:integer;
  Mana:integer;
  SuperCost:integer;
  SuperTime:integer;
  ShotTime:integer;
end;
var 
    startButton,startButton1,InfoButton,InfoButton1,GoHomeButton,GoHomeButton1,PlayButton,PlayButton1,
      FirstChooseWarriorButton,SecondChooseWarriorButton,FirstChooseWizardButton,SecondChooseWizardButton,FirstChooseRogueButton,SecondChooseRogueButton,
      FirstChooseWarriorButton1,SecondChooseWarriorButton1,FirstChooseWizardButton1,SecondChooseWizardButton1,FirstChooseRogueButton1,SecondChooseRogueButton1,
    menuChange,infoChange,sizeChange,choiseChange,
    firstCharacterChosen,SecondCharacterChosen,
    step1,step2,shot1,shot2,AddShot1,AddShot2,super1,super2,jump1,jump2,FirstChangeKoo1,secondChangeKoo1,FirstChangeKoo2,secondChangeKoo2,
    keyA,keyW,keyD,keyC,keyV,keyUp,keyLeft,keyRight,keyO,keyP,
    WallDown1,WallUp1,WallRight1,WallLft1,
    menu,choise,beforegame,game,info,shop:boolean;
    x1,y1,x2,y2,xx1,yy1,xx2,yy2,timeFromStep1,timeFromStep2,timeFromShot1,timeFromShot2,JumpTime1,Jumptime2,way1,way2,HPnow1,HPnow2,EMnow1,EMnow2,Vx1,Vy1,Vx2,Vy2,timeFromSuper1,timeFromSuper2,
    forCycles,forCycles1,forCycles2,
    timeForFPS,timeForFPS1,timeForFPS2,
    game1score1,game1Score2,game2score1,game2Score2,game3score1,game3Score2:integer;
    pictNumeral0,pictNumeral1,pictNumeral2,pictNumeral3,pictNumeral4,pictNumeral5,pictNumeral6,pictNumeral7,pictNumeral8,pictNumeral9,pictEM,pictHP,
    pictHat1,pictBoots1,pictArmor1,pictHat2,pictBoots2,pictArmor2,pict1Left1,pict2Left1,pict3Left1,pict1Left2,pict2Left2,pict3Left2,
      pict1Right1,pict2Right1,pict3Right1,pict1Right2,pict2Right2,pict3Right2,
      pict1Left1Add,pict2Left1Add,pict3Left1Add,pict1Left2Add,pict2Left2Add,pict3Left2Add,
      pict1Right1Add,pict2Right1Add,pict3Right1Add,pict1Right2Add,pict2Right2Add,pict3Right2Add,  /// Add - кинжал у разбойника
    pictLegs,pictLegsLeft1,pictLegsLeft2,pictLegsLeft3,pictLegsRight1,pictLegsRight2,pictLegsRight3,
    pictWarriorStandartHat,pictWarriorStandartRight1,pictWarriorStandartRight2,pictWarriorStandartRight3,pictWarriorStandartLeft1,pictWarriorStandartLeft2,pictWarriorStandartLeft3,
    pictRogueStBowLeft1,pictRogueStBowLeft2,pictRogueStBowLeft3,pictRogueStBowRight1,pictRogueStBowRight2,pictRogueStBowRight3,
    pictRogueStDaggerLeft1,pictRogueStDaggerLeft2,pictRogueStDaggerLeft3,pictRogueStDaggerRight1,pictRogueStDaggerRight2,pictRogueStDaggerRight3,
    pictWizardStHat,pictWizardStLeft1,pictWizardStLeft2,pictWizardStLeft3,pictWizardStRight1,pictWizardStRight2,pictWizardStRight3,
    pictBackground,pictInformation,pictBackgroundChoise,pictGameBackground1,pictGameBackground2,pictGameBackground3,pictLoading,
    pictStartButton,pictStartButton1,pictInfoButton,pictInfoButton1,pictGoHome,pictGoHome1,pictPlay,pictPlay1,pictChooseWarrior,pictChooseWizard,
      pictChooseRogue,pictChooseWarrior1,pictChooseWizard1,pictChooseRogue1:Picture;
    wizard,warrior,rogue,FirstPlayer,SecondPlayer:character;
label gamepoint1,gamepoint2,gamepoint3,shoppoint,menupoint,choisepoint,infopoint,BeforeGamePoint;
function findX(x: integer): integer;
begin
  if Window.Width/Window.Height>1366/706 then
  begin
    Result:=Round((Window.Width-Window.Height*1366/706)/2+window.height * x / 706);
  end;
  if Window.Width/window.Height<=1366/706 then
  begin
    Result:=round(window.Width * x / 1366);
  end;
end;
function findY(y: integer): integer;
begin
  if Window.Width/Window.Height<1366/706 then
  begin
    Result:=Round((Window.height-Window.width*706/1366)/2+window.width * y / 1366);
  end;
  if Window.Width/window.Height>=1366/706 then
  begin
    Result:=round(window.Height*y / 706);
  end;
end;
function longX(x:integer):integer;
begin
  if Window.Width/Window.Height>1366/706 then
  begin
    Result:=round(window.Height * x / 706);
  end;
  if Window.Width/window.Height<=1366/706 then
  begin
    Result:=round(window.Width * x / 1366);
  end;
end;
function longY(y:integer):integer;
begin
  if Window.Width/Window.Height<1366/706 then
  begin
    Result:=round(window.Width*y / 1366);
  end;
  if Window.Width/window.Height>=1366/706 then
  begin
    Result:=round(window.Height*y / 706);
  end;
end;
function stepen(Number,pokazatel:integer):integer;
begin
  result:=1;
  for forCycles1:integer:=1 to pokazatel do begin
    result*=Number;
  end;
end;
procedure writeNumber(x,y,Number,size,long:integer);
begin
  for forCycles:integer:=long downto 1 do
  begin
    case (Number div (stepen(10,forCycles-1)))-(Number div (stepen(10,forCycles)))*10 of 
      0:
        begin
          pictNumeral0.Draw(findX(x),findY(y),longX(size),longY(size));
        end;
      1:
        begin
          pictNumeral1.Draw(findX(x),findY(y),longX(size),longY(size));
        end;
      2:
        begin
          pictNumeral2.Draw(findX(x),findY(y),longX(size),longY(size));
        end;
      3:
        begin
          pictNumeral3.Draw(findX(x),findY(y),longX(size),longY(size));
        end;
      4:
        begin
          pictNumeral4.Draw(findX(x),findY(y),longX(size),longY(size));
        end;
      5:
        begin
          pictNumeral5.Draw(findX(x),findY(y),longX(size),longY(size));
        end;
      6:
        begin
          pictNumeral6.Draw(findX(x),findY(y),longX(size),longY(size));
        end;
      7:
        begin
          pictNumeral7.Draw(findX(x),findY(y),longX(size),longY(size));
        end;
      8:
        begin
          pictNumeral8.Draw(findX(x),findY(y),longX(size),longY(size));
        end;
      9:
        begin
          pictNumeral9.Draw(findX(x),findY(y),longX(size),longY(size));
        end;
    end;
    x+=size;
  end;
end;
procedure keysDown(Key:integer);
begin
  case Key of
    VK_A:
      begin
        if not keyD then
        begin
          keyA:=true;
        end;
      end;
    VK_W:
      begin
        keyW:=true;
      end;
    VK_D:
      begin
        if not keyA then
        begin
          keyD:=true;
        end;
      end;
    VK_C:
      begin
        if not keyV then
        begin
          keyC:=true;
        end;
      end;
    VK_V:
      begin
        if not keyC then
        begin
          keyV:=true;
        end;
      end;
    VK_Left:
      begin
        if not keyRight then
        begin
          keyLeft:=true;
        end;
      end;
    VK_Up:
      begin
        keyUp:=true;
      end;
    VK_Right:
      begin
        if not keyLeft then
        begin
          keyRight:=true;
        end;
      end;
    VK_O:
      begin
        if not keyP then
        begin
          keyO:=true;
        end;
      end;
    VK_P:
      begin
        if not keyO then
        begin
          keyP:=true;
        end;
      end;
  end;
end;
procedure keysUp(Key:integer);
begin
  case Key of
    VK_A:
      begin
        keyA:=false;
      end;
    VK_W:
      begin
        keyW:=false;
      end;
    VK_D:
      begin
        keyD:=false;
      end;
    VK_C:
      begin
        keyC:=false;
      end;
    VK_V:
      begin
        keyV:=false;
      end;
    VK_Left:
      begin
        keyLeft:=false;
      end;
    VK_Up:
      begin
        keyUp:=false;
      end;
    VK_Right:
      begin
        keyRight:=false;
      end;
    VK_O:
      begin
        keyO:=false;
      end;
    VK_P:
      begin
        keyP:=false;
      end;
  end;
end;
procedure mouseMove(x,y,mb:integer);
begin
  if menu then
  begin
    if (x>findX(1000))and(x<findX(1300))and(y>findY(200))and(y<findY(300))and startButton then
    begin
      startButton:=false;
      startButton1:=true;
      menuchange:=true;
    end;
    if ((x<findX(1000))or(x>findX(1300))or(y<findY(200))or(y>findY(300)))and startButton1 then
    begin
      startButton1:=false;
      startButton:=true;
      menuchange:=true;
    end;
    if (sqr(x-findX(1275))+sqr(y-findY(575))<=longX(625))and InfoButton then
    begin
      InfoButton:=false;
      menuchange:=true;
      InfoButton1:=true;
    end;
    if (sqr(x-findX(1275))+sqr(y-findY(575))>longX(625))and InfoButton1 then
    begin
      InfoButton1:=false;
      menuchange:=true;
      InfoButton:=true;
    end;    
  end;
  if info then
  begin
    if (sqr(x-findX(65))+sqr(y-findY(65))<=longX(625))and GoHomeButton then
    begin
      GoHomeButton:=false;
      infochange:=true;
      GoHomeButton1:=true;
    end;
    if (sqr(x-findX(65))+sqr(y-findY(65))>longX(625))and GoHomeButton1 then
    begin
      GoHomeButton1:=false;
      infochange:=true;
      GoHomeButton:=true;
    end;
  end;
  if choise then
  begin
    if (sqr(x-findX(65))+sqr(y-findY(65))<=longX(625))and GoHomeButton then
    begin
      GoHomeButton:=false;
      choisechange:=true;
      GoHomeButton1:=true;
    end;
    if (sqr(x-findX(65))+sqr(y-findY(65))>longX(625))and GoHomeButton1 then
    begin
      GoHomeButton1:=false;
      choisechange:=true;
      GoHomeButton:=true;
    end;
    
    if (x>findX(1150))and(x<findX(1350))and(y>findY(40))and(y<findY(90))and playButton then
    begin
      playButton:=false;
      playButton1:=true;
      choisechange:=true;
    end;
    if ((x<findX(1150))or(x>findX(1350))or(y<findY(40))or(y>findY(90)))and playButton1 then
    begin
      playButton1:=false;
      playButton:=true;
      choisechange:=true;
    end;
    
    if (x>findX(40))and(x<findX(640))and(y>findY(100))and(y<findY(250))and FirstChooseWarriorButton and not FirstCharacterChosen then
    begin
      FirstChooseWarriorButton:=false;
      FirstChooseWarriorButton1:=true;
      choisechange:=true;
    end;
    if ((x<findX(40))or(x>findX(640))or(y<findY(100))or(y>findY(250)))and FirstChooseWarriorButton1 and not FirstCharacterChosen then
    begin
      FirstChooseWarriorButton1:=false;
      FirstChooseWarriorButton:=true;
      choisechange:=true;
    end;
    
    if (x>findX(40))and(x<findX(640))and(y>findY(300))and(y<findY(450))and FirstChooseRogueButton and not FirstCharacterChosen then
    begin
      FirstChooseRogueButton:=false;
      FirstChooseRogueButton1:=true;
      choisechange:=true;
    end;
    if ((x<findX(40))or(x>findX(640))or(y<findY(300))or(y>findY(450)))and FirstChooseRogueButton1 and not FirstCharacterChosen then
    begin
      FirstChooseRogueButton1:=false;
      FirstChooseRogueButton:=true;
      choisechange:=true;
    end;
    
    if (x>findX(40))and(x<findX(640))and(y>findY(500))and(y<findY(650))and FirstChooseWizardButton and not FirstCharacterChosen then
    begin
      FirstChooseWizardButton:=false;
      FirstChoosewizardButton1:=true;
      choisechange:=true;
    end;
    if ((x<findX(40))or(x>findX(640))or(y<findY(500))or(y>findY(650)))and FirstChooseWizardButton1 and not FirstCharacterChosen then
    begin
      FirstChooseWizardButton1:=false;
      FirstChooseWizardButton:=true;
      choisechange:=true;
    end;
    
    
    if (x>findX(726))and(x<findX(1326))and(y>findY(100))and(y<findY(250))and SecondChooseWarriorButton and not SecondCharacterChosen then
    begin
      SecondChooseWarriorButton:=false;
      SecondChooseWarriorButton1:=true;
      choisechange:=true;
    end;
    if ((x<findX(726))or(x>findX(1326))or(y<findY(100))or(y>findY(250)))and SecondChooseWarriorButton1 and not SecondCharacterChosen then
    begin
      SecondChooseWarriorButton1:=false;
      SecondChooseWarriorButton:=true;
      choisechange:=true;
    end;
    
    if (x>findX(726))and(x<findX(1326))and(y>findY(300))and(y<findY(450))and SecondChooseRogueButton and not SecondCharacterChosen then
    begin
      SecondChooseRogueButton:=false;
      SecondChooseRogueButton1:=true;
      choisechange:=true;
    end;
    if ((x<findX(726))or(x>findX(1326))or(y<findY(300))or(y>findY(450)))and SecondChooseRogueButton1 and not SecondCharacterChosen then
    begin
      SecondChooseRogueButton1:=false;
      SecondChooseRogueButton:=true;
      choisechange:=true;
    end;
    
    if (x>findX(726))and(x<findX(1326))and(y>findY(500))and(y<findY(650))and SecondChooseWizardButton and not SecondCharacterChosen then
    begin
      SecondChooseWizardButton:=false;
      SecondChoosewizardButton1:=true;
      choisechange:=true;
    end;
    if ((x<findX(726))or(x>findX(1326))or(y<findY(500))or(y>findY(650)))and SecondChooseWizardButton1 and not SecondCharacterChosen then
    begin
      SecondChooseWizardButton1:=false;
      SecondChooseWizardButton:=true;
      choisechange:=true;
    end;
    
  end;
end;
procedure mouseDown(x,y,mb:integer);
begin
  
  if choise then
  begin
    if (sqr(x-findX(65))+sqr(y-findY(65))<=longX(625))and GoHomeButton1 then
    begin
      GoHomeButton1:=false;
      choise:=false;
      menu:=true;
    end;
    if (x>findX(1150))and(x<findX(1350))and(y>findY(40))and(y<findY(90))and playButton1 and firstCharacterChosen and SecondCharacterChosen then
    begin
      playButton1:=false;
      choise:=false;
      beforegame:=true;
    end;
    
    if (x>findX(40))and(x<findX(640))and(y>findY(100))and(y<findY(250)) then
    begin
      FirstChooseWarriorButton1:=true;
      FirstChooseRogueButton:=true;
      FirstChooseRogueButton1:=false;
      FirstChooseWizardButton:=true;
      FirstChooseWizardButton1:=false;
      FirstCharacterChosen:=true;
      choisechange:=true;
      FirstPlayer:=warrior;
    end;
    if (x>findX(40))and(x<findX(640))and(y>findY(300))and(y<findY(450)) then
    begin
      FirstChooseRogueButton1:=true;
      FirstChooseWarriorButton:=true;
      FirstChooseWarriorButton1:=false;
      FirstChooseWizardButton:=true;
      FirstChooseWizardButton1:=false;
      FirstCharacterChosen:=true;
      choisechange:=true;
      FirstPlayer:=rogue;
    end;
    if (x>findX(40))and(x<findX(640))and(y>findY(500))and(y<findY(650)) then
    begin
      FirstChooseWizardButton1:=true;
      FirstChooseRogueButton:=true;
      FirstChooseRogueButton1:=false;
      FirstChooseWarriorButton:=true;
      FirstChooseWarriorButton1:=false;
      FirstCharacterChosen:=true;
      choisechange:=true;
      FirstPlayer:=wizard;
    end;
    if (x>findX(726))and(x<findX(1326))and(y>findY(100))and(y<findY(250)) then
    begin
      SecondChooseWarriorButton1:=true;
      SecondChooseRogueButton:=true;
      SecondChooseRogueButton1:=false;
      SecondChooseWizardButton:=true;
      SecondChooseWizardButton1:=false;
      SecondCharacterChosen:=true;
      choisechange:=true;
      SecondPlayer:=warrior;
    end;
    if (x>findX(726))and(x<findX(1326))and(y>findY(300))and(y<findY(450)) then
    begin
      SecondChooseRogueButton1:=true;
      SecondChooseWarriorButton:=true;
      SecondChooseWarriorButton1:=false;
      SecondChooseWizardButton:=true;
      SecondChooseWizardButton1:=false;
      SecondCharacterChosen:=true;
      choisechange:=true;
      SecondPlayer:=rogue;
    end;
    if (x>findX(726))and(x<findX(1326))and(y>findY(500))and(y<findY(650)) then
    begin
      SecondChooseWizardButton1:=true;
      SecondChooseRogueButton:=true;
      SecondChooseRogueButton1:=false;
      SecondChooseWarriorButton:=true;
      SecondChooseWarriorButton1:=false;
      SecondCharacterChosen:=true;
      choisechange:=true;
      SecondPlayer:=wizard;
    end;
  end;
  if menu then
  begin
    if (x>findX(1000))and(x<findX(1300))and(y>findY(200))and(y<findY(300))and startButton1  then
    begin
      startButton1:=false;
      menu:=false;
      choise:=true;
    end;
    if (sqr(x-findX(1275))+sqr(y-findY(575))<=longX(625))and InfoButton1 then
    begin
      InfoButton1:=false;
      menu:=false;
      info:=true;
    end;
  end;
  if info then
  begin
    if (sqr(x-findX(65))+sqr(y-findY(65))<=longX(625))and GoHomeButton1 then
    begin
      GoHomeButton1:=false;
      info:=false;
      menu:=true;
    end;
  end;
end;
procedure resize;
begin
  sizechange:=true;
end;
procedure firstPlayerDraw;
begin
  if (Milliseconds-timeFromStep1>FirstPlayer.steptime/4)and(Milliseconds-timeFromStep1<=FirstPlayer.steptime/2)and firstChangekoo1 then
  begin
    case way1 of 
      2:
        begin
          x1-=25;
        end;
      4:
        begin
          x1+=25;
        end;
    end;
    FirstChangeKoo1:=false;
  end;
  if (Milliseconds-timeFromStep1>FirstPlayer.steptime/2)and(Milliseconds-timeFromStep1<=FirstPlayer.steptime*3/4)and SecondChangekoo1 then
  begin
    case way1 of 
      2:
        begin
          x1-=15;
        end;
      4:
        begin
          x1+=15;
        end;
    end;
    SecondChangeKoo1:=false;
  end;
  case way1 of
    1:
       begin
         pictLegs.Draw(findX(x1),findY(y1),longX(150),longY(150));
       end;
    2:
       begin
         if (Milliseconds-timeFromStep1<=FirstPlayer.steptime/4)and step1 then
          begin
             pictLegsLeft1.Draw(findX(x1),findY(y1),longX(150),longY(150));
          end
          else
          begin
             if (Milliseconds-timeFromStep1<=FirstPlayer.steptime/2)and step1 then
             begin
                pictLegsLeft2.Draw(findX(x1),findY(y1),longX(150),longY(150));
             end
             else
             begin
               if (Milliseconds-timefromStep1<=FirstPlayer.steptime*3/4)and step1 then
               begin
                  pictLegsLeft3.Draw(findX(x1),findY(y1),longX(150),longY(150));
               end
               else
               begin
                  pictLegs.Draw(findX(x1),findY(y1),longX(150),longY(150));
                  way1:=1;
               end;
             end;
           end;
        end;
     3:
        begin
           pictLegs.Draw(findX(x1),findY(y1),longX(150),longY(150));
        end;
     4:
        begin
          begin
            if (Milliseconds-timeFromStep1<=FirstPlayer.steptime/4)and step1 then
            begin
              pictLegsRight1.Draw(findX(x1),findY(y1),longX(150),longY(150));
            end
            else
            begin
              if (Milliseconds-timeFromStep1<=FirstPlayer.steptime/2)and step1 then
              begin
                pictLegsRight2.Draw(findX(x1),findY(y1),longX(150),longY(150));
              end
              else
              begin
               if (Milliseconds-timefromStep1<=FirstPlayer.steptime*3/4)and step1 then
               begin
                  pictLegsRight3.Draw(findX(x1),findY(y1),longX(150),longY(150));
               end
               else
               begin
                  pictLegs.Draw(findX(x1),findY(y1),longX(150),longY(150));
                  way1:=3;
               end;
              end;
            end;
          end;
        end;
  end;
  case FirstPlayer.characterNumber of
    1:
      begin
        if Milliseconds-timeFromShot1<=FirstPlayer.shottime/4 then
        begin
          case way1 of
            1,2:
              begin
                pict2Left1.Draw(findX(x1),findY(y1),longX(150),longY(150));
              end;
            3,4:
              begin
                pict2Right1.Draw(findX(x1),findY(y1),longX(150),longY(150));
              end;
          end;
        end
        else
        begin
          if Milliseconds-timeFromShot1<=FirstPlayer.shottime/2 then
          begin
            case way1 of
              1,2:
                begin
                 pict3Left1.Draw(findX(x1),findY(y1),longX(150),longY(150));
                end;
              3,4:
                begin
                  pict3Right1.Draw(findX(x1),findY(y1),longX(150),longY(150));
                end;
            end;
          end
           else
           begin
              if Milliseconds-timeFromShot1<=FirstPlayer.shottime*3/4 then
              begin
                case way1 of
                1,2:
                  begin
                    pict2Left1.Draw(findX(x1),findY(y1),longX(150),longY(150));
                  end;
                3,4:
                  begin
                    pict2Right1.Draw(findX(x1),findY(y1),longX(150),longY(150));
                  end;
                end;
              end
              else
              begin
                case way1 of
                1,2:
                  begin
                    pict1Left1.Draw(findX(x1),findY(y1),longX(150),longY(150));
                  end;
                3,4:
                  begin
                    pict1Right1.Draw(findX(x1),findY(y1),longX(150),longY(150));
                  end;
                end;
              end;
           end;
        end;
        pictHat1.Draw(findX(x1),findY(y1),longX(150),longY(150));
      end;
    2:
      begin
        if Milliseconds-timeFromShot1<=FirstPlayer.shottime/3 then
        begin
          case way1 of
            1,2:
              begin
                pict2Left1.Draw(findX(x1),findY(y1),longX(150),longY(150));
              end;
            3,4:
              begin
                pict2Right1.Draw(findX(x1),findY(y1),longX(150),longY(150));
              end;
          end;
        end
        else
        begin
          if Milliseconds-timeFromShot1<=FirstPlayer.shottime*2/3 then
          begin
            case way1 of
              1,2:
                begin
                 pict3Left1.Draw(findX(x1),findY(y1),longX(150),longY(150));
                end;
              3,4:
                begin
                  pict3Right1.Draw(findX(x1),findY(y1),longX(150),longY(150));
                end;
            end;
          end
          else
          begin
              case way1 of
                1,2:
                  begin
                    pict1Left1.Draw(findX(x1),findY(y1),longX(150),longY(150));
                  end;
                3,4:
                  begin
                    pict1Right1.Draw(findX(x1),findY(y1),longX(150),longY(150));
                  end;
              end;
          end;
        end;
      end;
    3:
      begin
        if Milliseconds-timeFromShot1<=FirstPlayer.shottime/3 then
        begin
          case way1 of
            1,2:
              begin
                pict2Left1.Draw(findX(x1),findY(y1),longX(150),longY(150));
              end;
            3,4:
              begin
                pict2Right1.Draw(findX(x1),findY(y1),longX(150),longY(150));
              end;
          end;
        end
        else
        begin
          if Milliseconds-timeFromShot1<=FirstPlayer.shottime*2/3 then
          begin
            case way1 of
              1,2:
                begin
                 pict3Left1.Draw(findX(x1),findY(y1),longX(150),longY(150));
                end;
              3,4:
                begin
                  pict3Right1.Draw(findX(x1),findY(y1),longX(150),longY(150));
                end;
            end;
          end
           else
           begin
              case way1 of
                1,2:
                  begin
                    pict1Left1.Draw(findX(x1),findY(y1),longX(150),longY(150));
                  end;
                3,4:
                  begin
                    pict1Right1.Draw(findX(x1),findY(y1),longX(150),longY(150));
                  end;
                end;
           end;
        end;
        pictHat1.Draw(findX(x1),findY(y1),longX(150),longY(150));
      end;
  end;
  if (Milliseconds-timeFromStep1>=FirstPlayer.steptime)and step1 then
  begin
    step1:=false;
  end;
  if (Milliseconds-timeFromShot1>=FirstPlayer.ShotTime)and shot1 then
  begin
    shot1:=false;
  end;
end;
procedure SecondPlayerDraw;
begin
  if (Milliseconds-timeFromStep2>secondPlayer.steptime/4)and(Milliseconds-timeFromStep2<=secondPlayer.steptime/2)and FirstChangekoo2 then
  begin
    case way2 of 
      2:
        begin
          x2-=25;
        end;
      4:
        begin
          x2+=25;
        end;
    end;
    FirstChangeKoo2:=false;
  end;
  if (Milliseconds-timeFromStep2>secondPlayer.steptime/2)and(Milliseconds-timeFromStep2<=secondPlayer.steptime*3/4)and SecondChangekoo2 then
  begin
    case way2 of 
      2:
        begin
          x2-=15;
        end;
      4:
        begin
          x2+=15;
        end;
    end;
    SecondChangeKoo2:=false;
  end;
  case way2 of
    1:
       begin
         pictLegs.Draw(findX(x2),findY(y2),longX(150),longY(150));
       end;
    2:
       begin
         if (Milliseconds-timeFromStep2<=SecondPlayer.steptime/4)and step2 then
          begin
             pictLegsLeft1.Draw(findX(x2),findY(y2),longX(150),longY(150));
          end
          else
          begin
             if (Milliseconds-timeFromStep2<=SecondPlayer.steptime/2)and step2 then
             begin
                pictLegsLeft2.Draw(findX(x2),findY(y2),longX(150),longY(150));
             end
             else
             begin
               if (Milliseconds-timefromStep2<=SecondPlayer.steptime*3/4)and step2 then
               begin
                  pictLegsLeft3.Draw(findX(x2),findY(y2),longX(150),longY(150));
               end
               else
               begin
                  pictLegs.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  way2:=1;
               end;
             end;
           end;
        end;
     3:
        begin
           pictLegs.Draw(findX(x2),findY(y2),longX(150),longY(150));
        end;
     4:
        begin
          begin
            if (Milliseconds-timeFromStep2<=SecondPlayer.steptime/4)and step2 then
            begin
              pictLegsRight1.Draw(findX(x2),findY(y2),longX(150),longY(150));
            end
            else
            begin
              if (Milliseconds-timeFromStep2<=SecondPlayer.steptime/2)and step2 then
              begin
                pictLegsRight2.Draw(findX(x2),findY(y2),longX(150),longY(150));
              end
              else
              begin
               if (Milliseconds-timefromStep2<=SecondPlayer.steptime*3/4)and step2 then
               begin
                  pictLegsRight3.Draw(findX(x2),findY(y2),longX(150),longY(150));
               end
               else
               begin
                  pictLegs.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  way2:=3;
               end;
              end;
            end;
          end;
        end;
  end;
  case SecondPlayer.characterNumber of
    1:
      begin
        if Milliseconds-timeFromShot2<=SecondPlayer.shottime/4 then
        begin
          case way2 of
            1,2:
              begin
                pict2Left2.Draw(findX(x2),findY(y2),longX(150),longY(150));
              end;
            3,4:
              begin
                pict2Right2.Draw(findX(x2),findY(y2),longX(150),longY(150));
              end;
          end;
        end
        else
        begin
          if Milliseconds-timeFromShot2<=SecondPlayer.shottime/2 then
          begin
            case way2 of
              1,2:
                begin
                 pict3Left2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                end;
              3,4:
                begin
                  pict3Right2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                end;
            end;
          end
           else
           begin
              if Milliseconds-timeFromShot2<=SecondPlayer.shottime*3/4 then
              begin
                case way2 of
                1,2:
                  begin
                    pict2Left2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  end;
                3,4:
                  begin
                    pict2Right2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  end;
                end;
              end
              else
              begin
                case way2 of
                1,2:
                  begin
                    pict1Left2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  end;
                3,4:
                  begin
                    pict1Right2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  end;
                end;
              end;
           end;
        end;
        pictHat2.Draw(findX(x2),findY(y2),longX(150),longY(150));
      end;
    2:
      begin
        if shot1 then
        begin
          if Milliseconds-timeFromShot2<=SecondPlayer.shottime/3 then
          begin
            case way2 of
              1,2:
                begin
                  pict2Left2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                end;
              3,4:
                begin
                  pict2Right2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                end;
            end;
          end
          else
          begin
            if Milliseconds-timeFromShot2<=SecondPlayer.shottime*2/3 then
            begin
              case way2 of
                1,2:
                  begin
                    pict3Left2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  end;
                3,4:
                  begin
                    pict3Right2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  end;
              end;
            end
            else
            begin
              case way2 of
                1,2:
                  begin
                    pict1Left2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  end;
                3,4:
                  begin
                    pict1Right2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  end;
               end;
            end;
          end;
        end
        else
        begin
          if AddShot2 then 
          begin
            if Milliseconds-timeFromShot2<=SecondPlayer.shottime/3 then
            begin
              case way2 of
                1,2:
                  begin
                    pict2Left2Add.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  end;
                3,4:
                  begin
                    pict2Right2Add.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  end;
              end;
            end
            else
            begin
              if Milliseconds-timeFromShot2<=SecondPlayer.shottime*2/3 then
              begin
                case way2 of
                  1,2:
                    begin
                      pict3Left2Add.Draw(findX(x2),findY(y2),longX(150),longY(150));
                    end;
                  3,4:
                    begin
                      pict3Right2Add.Draw(findX(x2),findY(y2),longX(150),longY(150));
                    end;
                end;
              end
              else
              begin
                case way2 of
                  1,2:
                    begin
                      pict1Left2Add.Draw(findX(x2),findY(y2),longX(150),longY(150));
                    end;
                  3,4:
                    begin
                      pict1Right2Add.Draw(findX(x2),findY(y2),longX(150),longY(150));
                    end;
                end;
              end;
            end;
          end
          else
          begin
            if Sqrt(Sqr(x2-x1)+Sqr(y2-y1))>100 then
            begin
              case way2 of
                1,2:
                  begin
                     pict1Left2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  end;
                3,4:
                  begin
                     pict1Right2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  end;
              end;
            end;
            if Sqrt(Sqr(x2-x1)+Sqr(y2-y1))<=100 then
            begin
              case way2 of
                1,2:
                  begin
                     pict1Left2Add.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  end;
                3,4:
                  begin
                     pict1Right2Add.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  end;
              end;
            end;
          end;
        end;
      end;
    3:
      begin
        if Milliseconds-timeFromShot2<=SecondPlayer.shottime/3 then
        begin
          case way2 of
            1,2:
              begin
                pict2Left2.Draw(findX(x2),findY(y2),longX(150),longY(150));
              end;
            3,4:
              begin
                pict2Right2.Draw(findX(x2),findY(y2),longX(150),longY(150));
              end;
          end;
        end
        else
        begin
          if Milliseconds-timeFromShot2<=SecondPlayer.shottime*2/3 then
          begin
            case way1 of
              1,2:
                begin
                 pict3Left2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                end;
              3,4:
                begin
                  pict3Right2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                end;
            end;
          end
           else
           begin
              case way2 of
                1,2:
                  begin
                    pict1Left2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  end;
                3,4:
                  begin
                    pict1Right2.Draw(findX(x2),findY(y2),longX(150),longY(150));
                  end;
                end;
           end;
        end;
        pictHat2.Draw(findX(x2),findY(y2),longX(150),longY(150));
      end;
  end;
  if (Milliseconds-timeFromStep2>=SecondPlayer.steptime)and step2 then
  begin
    step2:=false;
  end;
  if (Milliseconds-timeFromShot2>=SecondPlayer.ShotTime)and (shot2 or addshot2) then
  begin
    shot2:=false;
    AddShot2:=false;
  end;
  if (Milliseconds-timeFromSuper2>=SecondPlayer.SuperTime) and (super2) then
  begin
    super2:=false;
  end;
end;
procedure pokazatelDraw(pict:Picture;now,full,x,y,size:integer);
begin
  for forCycles2:integer:=1 to Trunc(now*10/full) do
  begin
    pict.Draw(findX(x+(forCycles2-1)*size),findY(y),longX(size),longY(size));
  end;
end;
procedure KeyReading;
begin
  if keyA and not step1 and not jump1 then
  begin
    if way1=3 then
    begin
      way1:=1;
    end
    else
    begin
      way1:=2;
      step1:=true;
      FirstChangeKoo1:=true;
      secondChangeKoo1:=true;
      timeFromStep1:=Milliseconds;
    end;
  end;
  if keyD and not step1 and not jump1 then
  begin
    if way1=1 then
    begin
      way1:=3;
    end
    else
    begin
      way1:=4;
      step1:=true;
      FirstChangeKoo1:=true;
      secondChangeKoo1:=true;
      timeFromStep1:=Milliseconds;
    end;
  end;
  if keyLeft and not step2 and not jump2 then
  begin
    if way2=3 then
    begin
      way2:=1;
    end
    else
    begin
      way2:=2;
      step2:=true;
      FirstChangeKoo2:=true;
      secondChangeKoo2:=true;
      timeFromStep2:=Milliseconds;
    end;
  end;
  if keyRight and not step2 and not jump2 then
  begin
    if way2=1 then
    begin
      way2:=3;
    end
    else
    begin
      way2:=4;
      step2:=true;
      FirstChangeKoo2:=true;
      secondChangeKoo2:=true;
      timeFromStep2:=Milliseconds;
    end;
  end;
  if keyC and not shot1 and not AddShot1 and not super1 then
  begin
    if FirstPlayer.characterNumber=2 then
    begin
      if (EMnow1>=FirstPlayer.DamageCost1) and (Sqrt(sqr(x2-x1)+Sqr(y2-y1))>100) then
      begin
        shot1:=true;
        timeFromShot1:=Milliseconds;
        EMnow1-=FirstPlayer.DamageCost1;
      end;
      if (EMnow1>=FirstPlayer.DamageCost2) and (Sqrt(sqr(x2-x1)+Sqr(y2-y1))<100) then
      begin
        AddShot1:=true;
        timeFromShot1:=Milliseconds;
        EMnow1-=FirstPlayer.DamageCost2;
      end;
      if super1 then
      begin
        super1:=false;
      end;
    end
    else
    begin
      if (EMnow1>=FirstPlayer.DamageCost1) then
      begin
        shot1:=true;
        timeFromShot1:=Milliseconds;
        EMnow1-=FirstPlayer.DamageCost1;
      end;
    end;
  end;
  if keyV and not shot1 and not AddShot1 and not super1 and (EMnow1>=FirstPlayer.SuperCost) then
  begin
    super1:=true;
    timeFromSuper1:=Milliseconds;
  end;
  if keyO and not shot2 and not AddShot2 and not super2 then
  begin
    if SecondPlayer.characterNumber=2 then
    begin
      if (EMnow2>=SecondPlayer.DamageCost1) and (Sqrt(sqr(x2-x1)+Sqr(y2-y1))>100) then
      begin
        shot2:=true;
        timeFromShot2:=Milliseconds;
        EMnow2-=SecondPlayer.DamageCost1;
      end;
      if (EMnow2>=SecondPlayer.DamageCost2) and (Sqrt(sqr(x2-x1)+Sqr(y2-y1))<100) then
      begin
        AddShot2:=true;
        timeFromShot2:=Milliseconds;
        EMnow2-=SecondPlayer.DamageCost2;
      end;
      if super2 then
      begin
        super2:=false;
      end;
    end
    else
    begin
      if (EMnow2>=SecondPlayer.DamageCost1) then
      begin
        shot2:=true;
        timeFromShot2:=Milliseconds;
        EMnow2-=SecondPlayer.DamageCost1;
      end;
    end;
  end;
  if keyP and not shot2 and not AddShot2 and not super2 and (EMnow2>=SecondPlayer.SuperCost) then
  begin
    super2:=true;
    timeFromSuper2:=Milliseconds;
  end;
  if keyW then 
  begin
    if not jump1 then
    begin
      case way1 of
      2:
        begin
          Vx1:=-round(40*JFtime/firstplayer.steptime);
        end;
      4:
        begin
          Vx1:=round(40*JFtime/firstplayer.steptime);
        end;
      1,3:
        begin
          Vx1:=0;
        end;
      end;
      jump1:=true;
      Vy1:=Vy0;
    end;
  end;
  if keyUp then 
  begin
    if not jump2 then 
    begin
      case way2 of
      2:
        begin
          Vx2:=-round(40*JFtime/Secondplayer.steptime);
        end;
      4:
        begin
          Vx2:=round(40*JFtime/Secondplayer.steptime);
        end;
      1,3:
        begin
          Vx2:=0;
        end;
      end;
      jump2:=true;
      Vy2:=Vy0;
    end;
  end;
end;
begin
/// ///////////////////////////// ниже описание почти всех переменных
  LockDrawing;
  window.Maximize;
  SetWindowCaption('Игра ...');
  pictLoading:=Picture.Create('Игра\Загрузка.png');
  ClearWindow(clBlack);
  pictLoading.Draw(findX(0),findY(0),longX(1366),longX(706));
  Redraw;
  pictBackground:=Picture.Create('Игра\Фон.png');
  pictGameBackground1:=Picture.Create('Игра\Поле1.png');
  pictStartButton:=Picture.Create('Игра\начать игру.png');
  pictStartButton1:=Picture.Create('Игра\начать игру нажатая.png');
  pictInfoButton:=Picture.Create('Игра\Инфа прозрачная.png');
  pictInfoButton1:=Picture.Create('Игра\Инфа нажатая прозрачная.png');
  pictGoHome:=Picture.Create('Игра\домой прозрачная.png');
  pictGoHome1:=Picture.Create('Игра\домой нажатая прозрачная.png');
  pictInformation:=Picture.Create('Игра\описание игры.png');
  pictBackgroundChoise:=Picture.Create('Игра\Выбор перса.png');
  pictNumeral0:=Picture.create('Игра\Цифры\цифра 0.png');
  pictNumeral1:=Picture.create('Игра\Цифры\цифра 1.png');
  pictNumeral2:=Picture.create('Игра\Цифры\цифра 2.png');
  pictNumeral3:=Picture.create('Игра\Цифры\цифра 3.png');
  pictNumeral4:=Picture.create('Игра\Цифры\цифра 4.png');
  pictNumeral5:=Picture.create('Игра\Цифры\цифра 5.png');
  pictNumeral6:=Picture.create('Игра\Цифры\цифра 6.png');
  pictNumeral7:=Picture.create('Игра\Цифры\цифра 7.png');
  pictNumeral8:=Picture.create('Игра\Цифры\цифра 8.png');
  pictNumeral9:=Picture.create('Игра\Цифры\цифра 9.png');
  pictPlay:=Picture.Create('Игра\Играть.png');
  pictPlay1:=Picture.Create('Игра\Играть нажатая.png');
  pictChooseRogue:=Picture.Create('Игра\кнопка выбора разбойника.png');
  pictChooseWarrior:=Picture.Create('Игра\кнопка выбора воина.png');
  pictChooseWizard:=Picture.Create('Игра\кнопка выбора мага.png');
  pictChooseRogue1:=Picture.Create('Игра\кнопка выбора разбойника нажатая.png');
  pictChooseWarrior1:=Picture.Create('Игра\кнопка выбора воина нажатая.png');
  pictChooseWizard1:=Picture.Create('Игра\кнопка выбора мага нажатая.png');
  pictWarriorStandartHat:=Picture.Create('Игра\человечек\Воин\Стандартный шлем.png');
  pictWarriorStandartLeft1:=Picture.Create('Игра\человечек\Воин\Обычный меч\воин влево.png');
  pictWarriorStandartLeft2:=Picture.Create('Игра\человечек\Воин\Обычный меч\воин влево приподнятая рука.png');
  pictWarriorStandartLeft3:=Picture.Create('Игра\человечек\Воин\Обычный меч\воин влево замах.png');
  pictWarriorStandartRight1:=Picture.Create('Игра\человечек\Воин\Обычный меч\воин вправо.png');
  pictWarriorStandartRight2:=Picture.Create('Игра\человечек\Воин\Обычный меч\воин вправо приподнятая рука.png');
  pictWarriorStandartRight3:=Picture.Create('Игра\человечек\Воин\Обычный меч\воин вправо замах.png');
  pictLegs:=Picture.Create('Игра\человечек\Обычное положение.png');
  pictLegsLeft1:=Picture.Create('Игра\человечек\Влево\Влево1.png');
  pictLegsLeft2:=Picture.Create('Игра\человечек\Влево\Влево2.png');
  pictLegsLeft3:=Picture.Create('Игра\человечек\Влево\Влево3.png');
  pictLegsRight1:=Picture.Create('Игра\человечек\Вправо\Вправо1.png');
  pictLegsRight2:=Picture.Create('Игра\человечек\Вправо\Вправо2.png');
  pictLegsRight3:=Picture.Create('Игра\человечек\Вправо\Вправо3.png');
  pictRogueStBowLeft1:=Picture.Create('Игра\человечек\Разбойник\Стандартный лук\Разбойник влево с луком.png');
  pictRogueStBowLeft2:=Picture.Create('Игра\человечек\Разбойник\Стандартный лук\Разбойник влево с луком натягивает тетиву.png');
  pictRogueStBowLeft3:=Picture.Create('Игра\человечек\Разбойник\Стандартный лук\Разбойник влево с луком натянул тетиву.png');
  pictRogueStBowRight1:=Picture.Create('Игра\человечек\Разбойник\Стандартный лук\Разбойник вправо с луком.png');
  pictRogueStBowRight2:=Picture.Create('Игра\человечек\Разбойник\Стандартный лук\Разбойник вправо с луком натягивает тетиву.png');
  pictRogueStBowRight3:=Picture.Create('Игра\человечек\Разбойник\Стандартный лук\Разбойник вправо с луком натянул тетиву.png');
  pictRogueStDaggerLeft1:=Picture.Create('Игра\человечек\Разбойник\Стандартный кинжал\Разбойник влево с кинжалом.png');
  pictRogueStDaggerLeft2:=Picture.Create('Игра\человечек\Разбойник\Стандартный кинжал\Разбойник влево с кинжалом впереди.png');
  pictRogueStDaggerLeft3:=Picture.Create('Игра\человечек\Разбойник\Стандартный кинжал\Разбойник влево с кинжалом занес.png');
  pictRogueStDaggerRight1:=Picture.Create('Игра\человечек\Разбойник\Стандартный кинжал\Разбойник вправо с кинжалом.png');
  pictRogueStDaggerRight2:=Picture.Create('Игра\человечек\Разбойник\Стандартный кинжал\Разбойник вправо с кинжалом впереди.png');
  pictRogueStDaggerRight3:=Picture.Create('Игра\человечек\Разбойник\Стандартный кинжал\Разбойник вправо с кинжалом занес.png');
  pictWizardStLeft1:=Picture.Create('Игра\человечек\маг\без посоха\маг влево.png');
  pictWizardStLeft2:=Picture.Create('Игра\человечек\маг\без посоха\маг влево поднимает руки.png');
  pictWizardStLeft3:=Picture.Create('Игра\человечек\маг\без посоха\маг влево поднял руки.png');
  pictWizardStRight1:=Picture.Create('Игра\человечек\маг\без посоха\маг вправо.png');
  pictWizardStRight2:=Picture.Create('Игра\человечек\маг\без посоха\маг вправо поднимает руки.png');
  pictWizardStRight3:=Picture.Create('Игра\человечек\маг\без посоха\маг вправо поднял руки.png');
  pictWizardStHat:=Picture.Create('Игра\человечек\маг\Стандартный колпак.png');
  pictHP:=Picture.Create('Игра\10 процентов здоровья.png');
  pictEM:=Picture.Create('Игра\10 процентов энергии или маны.png');
  wizard.hitpoints:=500; ///описание характеристик мага
  wizard.steptime:=250;
  wizard.AttackTime:=2000;
  wizard.MainDamage1:=75;
  wizard.DamageCost1:=10;
  wizard.SuperCost:=90;
  wizard.Mana:=100;
  wizard.ShotTime:=2000;
  wizard.SuperTime:=4000;
  wizard.characterNumber:=3;     /// wizard 3
  warrior.hitpoints:=1000; ///описание характеристик воина
  warrior.steptime:=200;
  warrior.AttackTime:=1500;
  warrior.MainDamage1:=75;
  warrior.DamageCost1:=5;
  warrior.SuperCost:=30;
  warrior.Energy:=100;
  warrior.ShotTime:=1500;
  warrior.SuperTime:=1500;
  warrior.characterNumber:=1;    /// warrior 1
  rogue.hitpoints:=700; ///описание характеристик разбойника
  rogue.steptime:=220;
  rogue.AttackTime:=1500;
  rogue.MainDamage1:=40;
  rogue.MainDamage2:=50;
  rogue.DamageCost1:=3;
  rogue.DamageCost2:=5;
  rogue.SuperCost:=60;
  rogue.Energy:=70;
  rogue.ShotTime:=1500;
  rogue.SuperTime:=3000;
  rogue.characterNumber:=2;   /// rogue 2
  x1:=0;
  y1:=500;
  x2:=1200;
  y2:=500;
  way1:=3;
  way2:=1;
  game1score1:=0;
  game1Score2:=0;
  game2score1:=0;
  game2Score2:=0;
  game3score1:=0;
  game3Score2:=0;
  menu:=true;
  startButton:=true;
  InfoButton:=true;
  menuchange:=true;
/// ////////////////////////////////////////// ниже меню
menupoint:
  onresize:=resize;
  OnMouseMove:=mouseMove;
  OnMouseDown:=MouseDown;
  if menuchange or sizechange then
  begin
    Window.Clear(clBlack);  /// !!!!!!!!!!!!!!!!!!!!!!!!!
    pictBackground.Draw(findX(0),findY(0),longX(1366),longY(706));
    if startButton then
    begin
      pictStartButton.Draw(findX(1000),findY(200),longX(300),longY(100));
    end;
    if startButton1 then
    begin
      pictStartButton1.draw(findX(990),findY(190),longX(320),longY(120));
    end;
    if infoButton then 
    begin
      pictInfoButton.Draw(findX(1250),findY(550),longX(50),longY(50));
    end;
    if infoButton1 then 
    begin
      pictInfoButton1.Draw(findX(1245),findY(545),longX(60),longY(60));
    end;
    Redraw;
    if menuchange then
    begin
      menuchange:=false;
    end;
    if sizechange then
    begin
      sizechange:=false;
    end;
  end;
  if menu then
  begin
    goto menupoint;
  end;
  if info then
  begin
    infochange:=true;
    GoHomeButton:=true;
    goto infopoint;
  end;
  if choise then
  begin
    FirstChooseWarriorButton:=true;
    FirstChooseRogueButton:=true;
    FirstChooseWizardButton:=true;
    SecondChooseWarriorButton:=true;
    SecondChooseRogueButton:=true;
    SecondChooseWizardButton:=true;
    PlayButton:=true;
    choiseChange:=true;
    GoHomeButton:=true;
    goto choisepoint;
  end;
/// ////////////////////////////////////////////  Ниже информация по игре
infopoint:
  if infochange or sizechange then 
  begin
    ClearWindow(clBlack);
    pictBackground.Draw(findX(0),findY(0),longX(1366),longY(706));
    pictInformation.draw(findX(500),findY(50),longX(700),longY(600));
    if GoHomeButton then 
    begin
      pictGoHome.Draw(findX(40),findY(40),longX(50),longY(50));
    end;
    if GoHomeButton1 then 
    begin
      pictGoHome1.Draw(findX(35),findY(35),longX(60),longY(60));
    end;
    Redraw;
    if infochange then
    begin
      infochange:=false;
    end;
    if sizechange then
    begin
      sizechange:=false;
    end;
  end;
  if info then
  begin
    goto infopoint;
  end;
  if menu then
  begin
    menuchange:=true;
    InfoButton:=true;
    startButton:=true;
    goto menupoint;
  end;
/// //////////////////////////////////////////// ниже окно выбора перса
choisepoint:
  if choiseChange or sizeChange then 
  begin
    ClearWindow(clblack);
    pictBackgroundChoise.Draw(findX(0),findY(0),longX(1366),longY(706));
    if GoHomeButton then 
    begin
      pictGoHome.Draw(findX(40),findY(40),longX(50),longY(50));
    end;
    if GoHomeButton1 then 
    begin
      pictGoHome1.Draw(findX(35),findY(35),longX(60),longY(60));
    end;
    if PlayButton then 
    begin
      pictPlay.Draw(findX(1150),findY(40),longX(200),longY(50));
    end;
    if PlayButton1 then 
    begin
      pictPlay1.Draw(findX(1145),findY(35),longX(210),longY(60));
    end;
    if FirstChooseWarriorButton then 
    begin
      pictChooseWarrior.draw(findX(40),findY(100),longX(600),longY(150));
    end;
    if FirstChooseRogueButton then
    begin
      pictChooseRogue.draw(findX(40),findY(300),longX(600),longY(150));
    end;
    if FirstChooseWizardButton then
    begin
      pictChooseWizard.draw(findX(40),findY(500),longX(600),longY(150));
    end;
    if FirstChooseWarriorButton1 then 
    begin
      pictChooseWarrior1.draw(findX(35),findY(95),longX(610),longY(160));
    end;
    if FirstChooseRogueButton1 then
    begin
      pictChooseRogue1.draw(findX(35),findY(295),longX(610),longY(160));
    end;
    if FirstChooseWizardButton1 then
    begin
      pictChooseWizard1.draw(findX(35),findY(495),longX(610),longY(160));
    end;
    if SecondChooseWarriorButton then 
    begin
      pictChooseWarrior.draw(findX(726),findY(100),longX(600),longY(150));
    end;
    if SecondChooseRogueButton then
    begin
      pictChooseRogue.draw(findX(726),findY(300),longX(600),longY(150));
    end;
    if SecondChooseWizardButton then
    begin
      pictChooseWizard.draw(findX(726),findY(500),longX(600),longY(150));
    end;
    if SecondChooseWarriorButton1 then 
    begin
      pictChooseWarrior1.draw(findX(721),findY(95),longX(610),longY(160));
    end;
    if SecondChooseRogueButton1 then
    begin
      pictChooseRogue1.draw(findX(721),findY(295),longX(610),longY(160));
    end;
    if SecondChooseWizardButton1 then
    begin
      pictChooseWizard1.draw(findX(721),findY(495),longX(610),longY(160));
    end;
    Redraw;
    if Choisechange then
    begin
      Choisechange:=false;
    end;
    if sizechange then
    begin
      sizechange:=false;
    end;
  end;
  if choise then
  begin
    goto choisepoint;
  end;
  if menu then
  begin
    menuChange:=true;
    startButton:=true;
    InfoButton:=true;
    goto menupoint;
  end;
  if beforegame then
  begin
    goto BeforeGamePoint;
  end;
/// //////////////////////////////////////////// ниже присваивание перед игрой
BeforeGamePoint:
  case SecondPlayer.characterNumber of
    1:
      begin
        pictHat2:=pictWarriorStandartHat;
        pict1Left2:=pictWarriorStandartLeft1;
        pict2Left2:=pictWarriorStandartLeft2;
        pict3Left2:=pictWarriorStandartLeft3;
        pict1Right2:=pictWarriorStandartRight1;
        pict2Right2:=pictWarriorStandartRight2;
        pict3Right2:=pictWarriorStandartRight3;
        EMnow2:=SecondPlayer.Energy;
      end;
    2:
      begin
        pict1Left2:=pictRogueStBowLeft1;
        pict2Left2:=pictRogueStBowLeft2;
        pict3Left2:=pictRogueStBowLeft3;
        pict1Right2:=pictRogueStBowRight1;
        pict2Right2:=pictRogueStBowRight2;
        pict3Right2:=pictRogueStBowRight3;
        pict1Left2Add:=pictRogueStDaggerLeft1;
        pict2Left2Add:=pictRogueStDaggerLeft2;
        pict3Left2Add:=pictRogueStDaggerLeft3;
        pict1Right2Add:=pictRogueStDaggerRight1;
        pict2Right2Add:=pictRogueStDaggerRight2;
        pict3Right2Add:=pictRogueStDaggerRight3;
        EMnow2:=SecondPlayer.Energy;
      end;
    3:
      begin
        pictHat2:=pictWizardStHat;
        pict1Left2:=pictWizardStLeft1;
        pict2Left2:=pictWizardStLeft2;
        pict3Left2:=pictWizardStLeft3;
        pict1Right2:=pictWizardStRight1;
        pict2Right2:=pictWizardStRight2;
        pict3Right2:=pictWizardStRight3;
        EMnow2:=SecondPlayer.Mana;
      end;
  end;
  case FirstPlayer.characterNumber of
    1:
      begin
        pictHat1:=pictWarriorStandartHat;
        pict1Left1:=pictWarriorStandartLeft1;
        pict2Left1:=pictWarriorStandartLeft2;
        pict3Left1:=pictWarriorStandartLeft3;
        pict1Right1:=pictWarriorStandartRight1;
        pict2Right1:=pictWarriorStandartRight2;
        pict3Right1:=pictWarriorStandartRight3;
        EMnow1:=FirstPlayer.Energy;
      end;
    2:
      begin
        pict1Left1:=pictRogueStBowLeft1;
        pict2Left1:=pictRogueStBowLeft2;
        pict3Left1:=pictRogueStBowLeft3;
        pict1Right1:=pictRogueStBowRight1;
        pict2Right1:=pictRogueStBowRight2;
        pict3Right1:=pictRogueStBowRight3;
        pict1Left1Add:=pictRogueStDaggerLeft1;
        pict2Left1Add:=pictRogueStDaggerLeft2;
        pict3Left1Add:=pictRogueStDaggerLeft3;
        pict1Right1Add:=pictRogueStDaggerRight1;
        pict2Right1Add:=pictRogueStDaggerRight2;
        pict3Right1Add:=pictRogueStDaggerRight3;
        EMnow1:=FirstPlayer.Energy;
      end;
    3:
      begin
        pictHat1:=pictWizardStHat;
        pict1Left1:=pictWizardStLeft1;
        pict2Left1:=pictWizardStLeft2;
        pict3Left1:=pictWizardStLeft3;
        pict1Right1:=pictWizardStRight1;
        pict2Right1:=pictWizardStRight2;
        pict3Right1:=pictWizardStRight3;
        EMnow1:=FirstPlayer.Mana;
      end;
  end;
  HPnow1:=FirstPlayer.hitpoints;
  HPnow2:=SecondPlayer.hitpoints;
  game:=true;
  goto gamepoint1;
/// //////////////////////////////////////////// ниже сама игра
gamepoint1:
  timeForFPS1:=Milliseconds;
  OnKeyDown:=keysDown;
  OnKeyUp:=keysUp;
  Clearwindow(clBlack);
  pictGameBackground1.Draw(findX(0),findY(0),longX(1366),longY(706));
  writeNumber(650,40,game1score1,40,1);
  writeNumber(700,40,game1score2,40,1);
  writeNumber(200,70,EMnow1,20,4);
  writeNumber(750,70,EMnow2,20,4);
  writeNumber(440,70,HPnow1,20,4);
  writeNumber(990,70,HPnow2,20,4);
  writeNumber(540,70,firstplayer.hitpoints,20,4);
  writeNumber(1090,70,secondplayer.hitpoints,20,4);
  if timeForFPS<>0 then 
  begin
    setbrushstyle(bsclear);
    TextOut(findX(0),findY(0),'fps:'+(1000 div timeForFPS));
    setbrushstyle(bsSolid);
  end;
  case FirstPlayer.characterNumber of
    1,2:
      begin
        writeNumber(300,70,FirstPlayer.Energy,20,4);
        pokazatelDraw(pictEM,EMnow1,firstplayer.Energy,200,40,20); 
      end;
    3:
      begin
        writeNumber(300,70,FirstPlayer.Mana,20,4);
        pokazatelDraw(pictEM,EMnow1,firstplayer.Mana,200,40,20); 
      end;
  end;
  case SecondPlayer.characterNumber of
    1,2:
      begin
        writeNumber(850,70,SecondPlayer.Energy,20,4);
        pokazatelDraw(pictEM,EMnow2,Secondplayer.Energy,749,40,20);
      end;
    3:
      begin
        writeNumber(850,70,SecondPlayer.Mana,20,4);
        pokazatelDraw(pictEM,EMnow2,Secondplayer.Mana,749,40,20);
      end;
  end;
  pokazatelDraw(pictHP,HPnow1,firstplayer.Hitpoints,440,40,20);
  pokazatelDraw(pictHP,HPnow2,Secondplayer.Hitpoints,989,40,20);
  KeyReading;
  if not step1 and jump1 and (Milliseconds-jumpTime1>=JFtime) then
  begin
    xx1:=x1;
    yy1:=y1;
    x1+=Vx1;
    y1-=Vy1;
    Vy1-=g;
    JumpTime1:=Milliseconds;
    if (y1>500) then
    begin
      y1:=500;
      Vy1:=0;
      jump1:=false;
    end
    else 
    begin
      if (y1>300)and(y1<500)and ((x1<150) or (x1>200)and(x1<1000) or (x1>1116)) and (Vy1<0) then 
      begin
        y1:=300;
        Vy1:=0;
        jump1:=false;
      end
      else
      begin
        if (y1>100)and(y1<250) and (Vy1<0) and ((x1<400)or(x1>866)) then 
        begin
          y1:=100;
          Vy1:=0;
          jump1:=false;
        end;
      end;
    end;
    if (y1<50) then
    begin
        y1:=50;
        Vy1:=0;
    end
    else
    begin
        if (y1>300)and(y1<450) and (x1<100) and (Vy1>0) then
        begin
          y1:=450;
          Vy1:=0;
        end
        else
        begin
          if (x1>200)and(x1<1000) and (y1>300)and(y1<450) and (Vy1>0) then
          begin
            y1:=450;
            Vy1:=0;
          end
          else
          begin
            if (x1>1116) and (y1>300)and(y1<450) and (Vy1>0) then
            begin
              y1:=450;
              Vy1:=0;
            end
            else
            begin
              if (x1<400) and (y1>100)and(y1<250) and (Vy1>0) then
              begin
                y1:=250;
                Vy1:=0;
              end
              else
              begin
                if (x1>816) and (y1>100)and(y1<250) and (Vy1>0) then
                begin
                  y1:=250;
                  Vy1:=0;
                end;
              end;
            end;
          end;
        end;
    end;
    if (way1=1) and (x1<-50) then 
    begin
      x1:=50;
      Vx1:=0;
    end
    else
    begin
      if (way1=1) and (x1<100) and (y1>300)and(y1<450) then
      begin
        x1:=100;
        Vx1:=0;
      end
      else
      begin
        if (way1=1) and (x1<400) and (y1>100)and(y1<250) then
        begin
          x1:=400;
          Vx1:=0;
        end
        else
        begin
          if (way1=1) and (x1<1000)and(x1>200) and (y1>300)and(y1<450) then
          begin
            x1:=1000;
            Vx1:=0;
          end;
        end;
      end;
    end;
    if (way1=3) and (x1>1266) then
    begin
      x1:=1316;
      Vx1:=0;
    end
    else
    begin
      if (way1=3) and (x1>1116) and (y1>300)and(y1<450) then
      begin
        x1:=1116;
        Vx1:=0;
      end
      else
      begin
        if (way1=3) and (x1>816) and (y1>100)and(y1<250) then
        begin
          x1:=816;
          Vx1:=0;
        end
        else
        begin
          if (way1=3) and (x1>200)and(x1<1000) and (y1>300)and(y1<450) then
          begin
            x1:=200;
            Vx1:=0;
          end;
        end;
      end;
    end;
  end;
  if not step2 and jump2 and (Milliseconds-jumpTime2>=JFtime) then
  begin
    x2+=Vx2;
    y2-=Vy2;
    Vy2-=g;
    Jumptime2:=Milliseconds;
  end;
  firstPlayerDraw;
  SecondPlayerDraw;
  Redraw;
  timeForFPS2:=Milliseconds;
  timeForFPS:=timeForFPS2-timeForFPS1;
  if game then 
  begin
    goto gamepoint1;
  end;
  if shop then 
  begin
    goto shoppoint;
  end;
gamepoint2:
  clearwindow(clblack);
gamepoint3:
/// ////////////////////////////////////////////// ниже магазин
shoppoint:
end.