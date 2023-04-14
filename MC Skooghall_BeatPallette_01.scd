//BEATZ FOR DAVE
//MC Skooghall
//Synths and patterns created by Ash Sagar unless otherwise stated.
//
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
//    //    //     //   /   /.    //    //     //     //  /   /    // /    //
//   ///   ///   /  /  / /  //   //    ////   ////   /  / /   /   /// /    //
//  // // // // /   / /   / //  //    /    / /    / /   / /   /  //// /    //
// //   //   // /   / /     // //     /    / /    / /   / /   / //  / /    //
// //   //   // /      /    ////      /    / /    / /     /   / //  / /    //
// //   //   // /       /   ///       /    / /    / /     ///// ///// /    //
// //   //   // /        /  ////      /    / /    / / /// ///// ///// /    //
// //        // /   /     / //////    /    / /    / /   / /   / /   / /    //
// //        // /   / /    ///  ///   /    / /    / /   / /   / /   / /    //
// //        // /  /   /  / //  ////  /////  /////  /   / /   / /   / /    //
// //        //  //     //  //  /////  ///   ///     ///  /   / /   / ///  //
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

(
//
(//evaluate buffer by clicking anywhere inbetWeen the brackets and then repetedly  press Shift + command + b repetedly until everything between the parenthesis is highlighted. Once highlighted press Shift + Enter
s.boot;
s.meter;
s.scope(2);
s.makeWindow;
);


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// /////////  //     /// ///     ///  ////////////  ///   ///   //////////   //
// ////////    //   ///  /////   ///  ////////////  ///   ///  //////////    //
//  ////        // ///   /// //  ///      ///       ///   ///       ////     //
//   ////        ////    ///  // ///      ///       /////////      ////      //
//    ////      ////     ///   /////      ///       /////////     ////       //
//     ////    ////      ///    ////      ///       ///   ///    ////        //
// /////////  ////       ///     ///      ///       ///   ///  //////////    //
// ////////  ////        ///     ///      ///       ///   /// //////////     //
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
(
//Ash Sagar synth
SynthDef(\synthOne,
	{arg // amp1 amp2 amp3 wna cut rez atk sus rel pan vol
		out=0, freq=440, detune1=0.0, amp1=0, amp2=0,amp3=0, wna=0, cut=1000, rez=0.1,  atk=0.1, sus=0.1,rel=0.1,pan=0, vol=0.5;

		var osc1, osc2, osc3, noise, filt, env;
		osc1 = LFSaw.ar(freq, 0, amp1);
		osc2 = LFPulse.ar(freq,0, 0.5,amp2 );
		osc3 = SinOsc.ar(freq,0,amp3)+SinOsc.ar(freq+detune1, 0,amp3);

		noise = WhiteNoise.ar(wna);

		filt = RLPF.ar(osc1+osc2+osc3+noise,cut,rez);
		env = EnvGen.kr(Env.linen(atk,sus,rel),doneAction:2);
		Out.ar(out, Pan2.ar(filt*env,pan, vol))
	}).add;


//not sure where I got this kik drum from, maybe an inbuilt example?
SynthDef(\kik,{|basefreq=60,ratio=7,sweeptime=0.05,preamp=0.4,amp=1,decay1=0.42,decay1L=0.1,decay2=0.1, pan =0, out=0|
    var    fcurve = EnvGen.kr(Env([basefreq * ratio, basefreq], [sweeptime], \exp)),
        env = EnvGen.kr(Env([1, decay1L, 0], [decay1, decay2], -4), doneAction: 2),
        sig = SinOsc.ar(fcurve, 0.5pi, preamp).distort * env * amp;

	Out.ar(out, Pan2.ar(sig*env,pan))
}).add;


SynthDef(\noise,
	//amp1, amp2, amp3, cut, rez, atk, sus, rel, pan, vol
	{arg out=0, basefreq=100, amp1=0, amp2=0, amp3=0, amp4=0, cut=1000, rez=0.1, atk=0.01, sus= 0.01, rel=0.01, pan=0, vol=0.5;

		var white, pink, brown, osc, filt, env;
		white = WhiteNoise.ar(amp1);
		pink = PinkNoise.ar(amp2);
		brown = BrownNoise.ar(amp3);
		osc = LFTri.ar(basefreq, 0, amp4);


		filt = RLPF.ar(white+pink+brown+osc,cut,rez);
		env = EnvGen.kr(Env.linen(atk, sus, rel), doneAction:2);
		Out.ar(out, Pan2.ar(filt*env, pan, vol))
}).add;

);

(

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//  /////////    ///// //////////// //////////// /////     ///    /////////// //
//  //    ///   /// // //////////// //////////// //////    ///   ///////////  //
//  //     //  ///  //     ///          ///      /// ///   ///        /////   //
//  ////////  ////////     ///          ///      ///  ///  ///      //////    //
//  //       ///    //     ///          ///      ///   /// ///     //////     //
//  //      ///     //     ///          ///      ///    //////    //////////  //
//  //     ///      //     ///          ///      ///     /////   //////////   //
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

(
//Beat_01 patterns
~kik_01=Pbind(\instrument, \synthOne,
	\dur, Pseq([1],4),
	\note, -20,
	\cut, 200,
	\rez, 0.2,
	// \amp1, 0.2,
	\amp3, 1,
	\rez, 0.1,
	\atk, 0.01,
	\sus, 0.01,
	\rel, 0.01,
	\pan, 0,
	\vol,Pseq([1,0,1,0]),

);



~sn_01=Pbind(\instrument, \synthOne,
	\dur, 1,
	\note, 1,
	\cut, 1500,
	\rez, 0.2,
	\amp2, 0.1,
	\wna, 1,
	\rez, 0.5,
	\atk, 0.01,
	\sus, 0.01,
	\rel, 0.1,
	\pan, 0,
	\vol,Pseq([0, 0.6, 0, 0.6])
);



~hat_01=Pbind(\instrument, \synthOne,
	\dur, 0.5,
	\note, 1,
	\cut, 9500,
	\rez, 0.2,
	\wna, 1,
	\rez, 0.9,
	\atk, 0.01,
	\sus, 0.01,
	\rel, 0.01,
	\pan, 0,
	\vol,Pseq([0.2, 0.3, 0.15, 0.3]-0.1,2)
);
);

/////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////


(
///Beat 2 pattern
//basefreq=60,ratio=7,sweeptime=0.05,preamp=0.4,amp=1,decay1=0.42,decay1L=0.1,decay2=0.1, pan =0, out=0|
~kik_02=Pbind(\instrument, \kik,
	\dur, 0.25,
	\ratio, 7,
	////////////1 e + a 2 e + a 3 e + a 4 e + a
	\amp, Pseq([1,0,0,1,0,1,0,0,1,0,0,0,0,1,0,1]),
	\rez, 0.1,
	\atk, 0.01,
	\sus, 0.01,
	\rel, 0.01,
	\pan, 0,
	\out, 0,

);

~sn_02=Pbind(\instrument, \synthOne,
	\dur, 1,
	\note, 1,
	\cut, 1500,
	\rez, 0.2,
	\amp2, 0.1,
	\wna, 1,
	\rez, 0.5,
	\atk, 0.01,
	\sus, 0.01,
	\rel, 0.1,
	\pan, 0,
	\vol,Pseq([0, 0.6, 0, 0.6])
);


~hat_02=Pbind(\instrument, \synthOne,
	\dur, 0.25,
	\note, 1,
	\cut, 9500,
	\rez, 0.2,
	\wna, 1,
	\rez, 0.9,
	\atk, 0.01,
	\sus, 0.01,
	\rel, 0.01,
	\pan, 0,
	\vol,Pseq([0.2, 0.3, 0.15, 0.3]-0.1,2)
);
~hat_02_2=Pbind(\instrument, \synthOne,
	\dur, 0.5,
	\note, 1,
	\cut, 9500,
	\rez, 0.2,
	\wna, 1,
	\rez, 0.9,
	\atk, 0.01,
	\sus, 0.01,
	\rel, Pseq([0.01,0.1, 0.01, 0.1]),
	\pan, 0,
	\vol,Pseq([0.2, 0.3, 0.15, 0.3]-0.1)
);
);

/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
(
//Beat 3 patterns
//basefreq=60,ratio=7,sweeptime=0.05,preamp=0.4,amp=1,decay1=0.42,decay1L=0.1,decay2=0.1, pan =0, out=0|
~kik_03=Pbind(\instrument, \kik,
	\dur, 0.25,
	\basefreq, 60,
	\ratio, 7,
	\sweeptime, 0.05,
	\preamp, 0.4,
	////////////1 e + a 2 e + a 3 e + a 4 e + a
	\amp, Pseq([1,1,1,1,0,0,1,0,0,1,0,1,0,0,1,0],4),
	\decay1, 1.02,
	\decay1L, 0.1,
	\decay2, 0.1,
	\pan, 0,
	\out, 0,

);

~sn_03=Pbind(\instrument, \synthOne,
	\dur, Pseq([Rest(1), 1, Rest(1), 1, Rest(1), 1, Rest(1), 1],2),
	\note, 1,
	\cut, Pseq([2000,2000,1500,1500,1000,1000,800,800,700,700,500,500,300,300,100,100]),
	\rez, 0.2,
	\amp2, 0.1,
	\wna, 1,
	\rez, 0.5,
	\atk, 0.01,
	\sus, 0.01,
	\rel, 0.1,
	\pan, 0,
	\vol,0.5,
);

~bazz_03=Pbind(\instrument, \synthOne,
	\dur, Pseq([1.5, 0.5, 1.5, 0.5],4),
	\midinote, Pseq([57, 64, 55, 60]-12,4),
	\cut, 1000,
	\rez, 0.1,
	\amp3, 1,
	\atk, 0.01,
	\sus, 0.5,
	\rel, 0.1,
	\pan, 0,
	\vol, 0.2,
);
);

/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
(
//Beat 04
//basefreq=60,ratio=7,sweeptime=0.05,preamp=0.4,amp=1,decay1=0.42,decay1L=0.1,decay2=0.1, pan =0, out=0|
~kik_04=Pbind(\instrument, \kik,
	\dur, 0.25,
	\basefreq, 60,
	\ratio, 7,
	\sweeptime, 0.05,
	\preamp, 0.4,
	////////////1 e + a 2 e + a 3 e + a 4 e + a
	\amp, Pseq([1,0,0,1,0,0,1,0,0,1,0,0,0,1,0,0],4, ),
	\decay1, 1.02,
	\decay1L, 0.1,
	\decay2, 0.1,
	\pan, 0,
	\out, 0,

);

~sn_04=Pbind(\instrument, \synthOne,
	\dur, Pseq([Rest(1), 1, Rest(1), 1, Rest(1), 1, Rest(1), 1],2, 12),
	\note, 1,
	\cut, 1000,
	\rez, 0.2,
	\amp2, 0.1,
	\wna, 1,
	\rez, 0.5,
	\atk, 0.01,
	\sus, 0.01,
	\rel, 0.1,
	\pan, 0,
	\vol,0.5,
);

~hat_04=Pbind(\instrument, \synthOne,
	\dur, 0.25,
	\note, 1,
	\cut, 9500,
	\rez, 0.2,
	\wna, 1,
	\rez, 0.9,
	\atk, 0.01,
	\sus, 0.01,
	\rel, Pseq([0.01,0.05, 0.01, 0.07],16),
	\pan, 0,
	\vol,Pseq([0.2, 0.3, 0.15, 0.3]-0.2,16)
);
);
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
(
//Beat 05
//basefreq=60,ratio=7,sweeptime=0.05,preamp=0.4,amp=1,decay1=0.42,decay1L=0.1,decay2=0.1, pan =0, out=0|
~kik_05=Pbind(\instrument, \kik,
	\dur, 0.25,
	\basefreq, 40,
	\ratio, 7,
	\sweeptime, 0.05,
	\preamp, 0.4,
	////////////1 e + a 2 e + a 3 e + a 4 e + a 2 e + a 2 e + a 3 e + a 4 e + a
	\amp, Pseq([1,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0,1,0,0,1,0,1,0,1],2, ),
	\decay1, 0.5,
	\decay1L, 0.1,
	\decay2, 1,
	\pan, 0,
	\out, 0,

);

~sn_05=Pbind(\instrument, \synthOne,
	\dur, Pseq([Rest(1), 1, Rest(1), 1, Rest(1), 1, Rest(1), 1],2, 12),
	\note, 1,
	\cut, 1000,
	\rez, 0.2,
	\amp2, 0.1,
	\wna, 1,
	\rez, 0.5,
	\atk, 0.01,
	\sus, 0.01,
	\rel, 0.15,
	\pan, 0,
	\vol,0.5,
);

~hat_05=Pbind(\instrument, \synthOne,
	\dur, 0.125,
	\note, 1,
	\cut, 9500,
	\rez, 0.2,
	\wna, 1,
	\rez, 0.9,
	\atk, 0.01,
	\sus, 0.01,
	\rel, Pseq([0.01,0.05, 0.01, 0.07]-1,32),
	\pan, 0,
	\vol,Pseq([0.2, 0.3, 0.15, 0.3]-0.3,32)
);

// amp1 amp2 amp3 wna cut rez atk sus rel pan vol
~bazz_05=Pbind(\instrument, \synthOne,
	\dur, 2,
	\midinote, Pseq([64, 62]-36,4),
	\cut, 350,
	\rez, 0.9,
	\amp1, 1,
	\amp2, 0.5,
	\amp3, 0.2,
	\wna, 0.3,
	\atk, 0.01,
	\sus, 1.3,
	\rel, 0.1,
	\pan, 0,
	\vol, 0.2,
);
);
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
(
//Beat 06
//basefreq=60,ratio=7,sweeptime=0.05,preamp=0.4,amp=1,decay1=0.42,decay1L=0.1,decay2=0.1, pan =0, out=0|
~kik_06=Pbind(\instrument, \kik,
	\dur, 0.25,
	\basefreq, 40,
	\ratio, 7,
	\sweeptime, 0.05,
	\preamp, 0.4,
	////////////1 e + a 2 e + a 3 e + a 4 e + a
	\amp, Pseq([1,0,0,0,0,0,0,1,1,0,1,0,0,0,0,0],2, ),
	\decay1, 0.5,
	\decay1L, 0.3,
	\decay2, 1,
	\pan, 0,
	\out, 0,
);

~sn_06=Pbind(\instrument, \noise,
	\dur, Pseq([Rest(1), 1, Rest(1), 1],2),
	\amp1, 0.6,
	\amp2, 0.3,
	\cut, 1000,
	\rez, 0.2,
	\rez, 0.5,
	\atk, 0.01,
	\sus, 0.01,
	\rel, 0.15,
	\pan, 0,
	\vol,1,
);

~hat_06=Pbind(\instrument, \noise,
		//amp1, amp2, amp3, cut, rez, atk, sus, rel, pan, vol
	\dur, Pseq([0.5, 0.5, 0.5, 0.25, 0.25, 0.5, 0.5, 0.5, 0.5],2),
	\amp1, 0.1,
	\amp2, 0.2,
	\amp3, 0.2,
	\cut, 9500,
	\rez, 0.9,
	\atk, 0.01,
	\sus, 0.01,
	\rel, 0.01,
	\pan, 0.5,
	\vol, 0.1,
);

~ride_06=Pbind(\instrument, \noise,
		//amp1, amp2, amp3, cut, rez, atk, sus, rel, pan, vol
	\dur, Pseq([0.5, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5, 0.25, 0.25],2),
	\basefreq, 6000,
	\amp1, 0.05,
	\amp2, 0.05,
	\amp3, 0.01,
	\amp4, 2,
	\cut, 1500,
	\rez, 0.01,
	\atk, 0.01,
	\sus, 0.1,
	\rel, 0.8,
	\pan, -0.5,
	\vol, 0.05,
);
);
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
(//Beat 07
//Beat 06
//basefreq=60,ratio=7,sweeptime=0.05,preamp=0.4,amp=1,decay1=0.42,decay1L=0.1,decay2=0.1, pan =0, out=0|
~kik_07=Pbind(\instrument, \kik,
	\dur, 0.25,
	\basefreq, 40,
	\ratio, 7,
	\sweeptime, 0.05,
	\preamp, 0.4,
	////////////1 e + a 2 e + a 3 e + a 4 e + a
	\amp, Pseq([1,0,1,0,0,0,1,1,0,1,1,0,0,1,1,0],2, ),
	\decay1, 0.5,
	\decay1L, 0.3,
	\decay2, 1,
	\pan, 0,
	\out, 0,
);

~sn_07=Pbind(\instrument, \noise,
	\dur, Pseq([Rest(1), 1, Rest(1), 1],2),
	\amp1, 0.6,
	\amp2, 0.3,
	\cut, 1000,
	\rez, 0.2,
	\rez, 0.5,
	\atk, 0.01,
	\sus, 0.01,
	\rel, 0.15,
	\pan, 0,
	\vol,Pseq([0, 1, 0, 0.5],2),
);

// amp1 amp2 amp3 wna cut rez atk sus rel pan vol
~bazz_07=Pbind(\instrument, \synthOne,
	\dur, Pseq([0.5, Rest(1),0.5,Rest(1),0.5,Rest(0.5)],2),
	\midinote, Pseq([57, 57, 55, 55, 51, 51, 48,48, 51,51, 48,48]-12),
	\detune1, 5,
	\cut, 1250,
	\rez, 0.9,
	\amp1, 0.04,
	\amp2, 0,
	\amp3, 1,
	\wna, 0,
	\atk, 0.01,
	\sus, 0.3,
	\rel, 0.7,
	\pan, 0,
	\vol, 0.2,
);

//p.clock= TempoClock.default.tempo_(95/60);
);
);

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
//   /////   ///////    /////  ////////  ////////     //
//   /// //  ///       /// //    ///    ////////      //
//   /////   /////    ///  //    ///       ////       //
//   /// //  ///     ////////    ///      /////////   //
//   /////   //////////    //    ///     /////////    //
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////




(
(
//beat_01
//p.clock=TempoClock.default.tempo_(80/60);
Ndef(\beat_01,
 Ppar([Pseq([~kik_01]), Pseq([~sn_01]), Pseq([~hat_01])],inf))
);
(//beat02
//p.clock=TempoClock.default.tempo_(75/60);
Ndef(\beat_02,
Ppar([Pseq([~kik_02]), Pseq([~sn_02]), Pseq([~hat_02, ~hat_02_2])],inf);
);
);
(//beat03
//p.clock=TempoClock.default.tempo_(70/60)
Ndef(\beat_03,
Ppar([Pseq([~kik_03]), Pseq([~sn_03]), Pseq([~bazz_03])],inf);
);
);
(//beat04
//p.clock=TempoClock.default.tempo_(57/60);
Ndef(\beat_04,
Ppar([Pseq([~kik_04]), Pseq([~sn_04]), Pseq([~hat_04])],inf);
);
);
(//beat05
//p.clock=TempoClock.default.tempo_(90/60);
Ndef(\beat_05,
Ppar([Pseq([~kik_05]), Pseq([~sn_05]), Pseq([~hat_05]), Pseq([~bazz_05])],inf);
);
);
(//Beat06
//p.clock= TempoClock.default.tempo_(95/60);
Ndef(\beat_06,
Ppar([Pseq([~kik_06]), Pseq([~sn_06]), Pseq([~hat_06]), Pseq([~ride_06])],inf);
);
);

(//Beat_07 new code
//p.clock=TempoClock.default.tempo_(100/60);
Ndef(\beat_07,
Ppar([Pseq([~kik_07]), Pseq([~sn_07]), Pseq([~bazz_07])],inf);
);
);
);
);

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
//            //////////////  //            //   ///////////////////     //
//           //          //   //            //   ///////////////////     //
//          //          //    //            //           //              //
//         //                 //            //           //              //
//        //                  //            //           //              //
//       //                   //            //           //              //
//       //                   //            //           //              //
//       //         //////    //            //           //              //
//       //             //     //           //           //              //
//        //           //       //         //            //              //
//         //         //         //       //             //              //
//          //       //           //     //     ////////////////////     //
//           /////////             ///////      ////////////////////     //
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

( //GUI code


//////////////////////////////////////////////////////////////////////////////////
//               Bugs and features to add??
////////////////////////////////////////////////////////////////////////////////////
//                   BUGS
//  BUG: for some reason it takes a couple of button presses to get the loop to work????
//  BUG: Tempo clock isnt reacting to being called in the ndef
/////////////////////////////////////////////////////////////////////////////////////
//                 Features to add
// *Visualiser that responds when a loop is pressed
// *Output meters
// *Scope -- Cannot seem to get this to read from the server???
//
// * volume faders for parts
// add in a working quantiser to the Tempo clock so that the loops end on a bar sequence
/////////////////////////////////////////////////////////////////////////////////////////////


var w;
var id;
var sz = 123;
var width = 3840; // change this according to your projected screen size
var height = 2160; // change this according to your projected screen size
var win;
var usr;
//var win = Window("beat01 viz", Rect(10, 10, width, height), false);
var xfader, scope, freqScope;
var beat01, beat02, beat03, beat04, beat05, beat06, beat07, beat08, beat09, beat10;
w = Window("The MC Skooghall Sound n Sight Pallate", Rect(1200, 200, 1280, 720)); //make our gui wndow
w.view.decorator = FlowLayout(w.view.bounds);
id = s.nextNodeID;

// add a button
// code taken and adapted from SuperCollider GUI examples2 (bundled with SuperCollider)
//"/Users/yourname/Music/SuperCollider/examples/GUI examples/GUI_examples2.scd"

/*
This is boilerplate code for inserting into more button presses
///////////////////////

insert into the 1 if statment below the p.clock line of code

(//open a visualizer when button pressed
		win = Window("beat01 viz", Rect(1680, 10, width, height), false);

		win.fullScreen;
		usr = UserView(win,Rect(0, 0, width, height));
		usr.background = Color.insert -color-of-choice-for-background
		);

/////////
win.close; // insert this line into the 0 if statement below the Ndef.free

*/

//button1
beat01 = Button(w, sz@sz);
//make it start and stop
beat01.states = [
	["beat01start", Color.black, Color.blue],
	["beat01stop", Color.black, Color.magenta],
];
//assign action to the buttons
beat01.action = {|view|
	if(view.value == 1){
		//start loop
		Ndef(\beat_01).play; //plays beat on button pressed
		p.clock=TempoClock.default.tempo_(80/60); //tempoclock code
	(//open a visualizer when button pressed
		win = Window("beat01 viz", Rect(1680, 10, width, height), false);

		win.fullScreen; //fullscreen mode
		usr = UserView(win,Rect(0, 0, width, height));
		usr.background = Color.rand;
			usr.drawFunc={

			}

		);



	};
	if(view.value == 0){
		Ndef(\beat_01).free; //stop loop
		win.close; //close visualiser window
};
};

//button02
beat02 = Button(w, sz@sz);
//make it start/stop
beat02.states = [
	["beat02start", Color.black, Color.blue],
	["beat02stop", Color.black, Color.magenta],
];
// assign action to the buttons
beat02.action = {|view|
	if(view.value == 1){
		//start loop
		Ndef(\beat_02).play;
		p.clock=TempoClock.default.tempo_(75/60); //tempoclock code

	};
	if(view.value == 0){
		//stop loop
		Ndef(\beat_02).free
	};
};

//button03
beat03 = Button(w, sz@sz);
//make it start/stop
beat03.states = [
	["beat03start", Color.black, Color.blue],
	["beat03stop", Color.black, Color.magenta],
];
// assign action to the buttons
beat03.action = {|view|
	if(view.value == 1){
		//start loop
		Ndef(\beat_03).play;
		p.clock=TempoClock.default.tempo_(70/60); //tempoclock code

	};
	if(view.value == 0){
		//stop loop
		Ndef(\beat_03).free
	};
};

//button04
beat04 = Button(w, sz@sz);
//make it start/stop
beat04.states = [
	["beat04start", Color.black, Color.blue],
	["beat04stop", Color.black, Color.magenta],
];
// assign action to the buttons
beat04.action = {|view|
	if(view.value == 1){
		//start loop
		Ndef(\beat_04).play;
		p.clock=TempoClock.default.tempo_(57/60); //tempoclock code


	};
	if(view.value == 0){
		//stop loop
		Ndef(\beat_04).free
	};
};

//button05
beat05 = Button(w, sz@sz);
//make it start/stop
beat05.states = [
	["beat05start", Color.black, Color.blue],
	["beat05stop", Color.black, Color.magenta],
];
// assign action to the buttons
beat05.action = {|view|
	if(view.value == 1){
		//start loop
		Ndef(\beat_05).play;
		p.clock=TempoClock.default.tempo_(90/60); //tempoclock code

	};
	if(view.value == 0){
		//stop loop
		Ndef(\beat_05).free
	};
};

//button06
beat06 = Button(w, sz@sz);
//make it start/stop
beat06.states = [
	["beat06start", Color.black, Color.blue],
	["beat06stop", Color.black, Color.magenta],
];
// assign action to the buttons
beat06.action = {|view|
	if(view.value == 1){
		//start loop
		Ndef(\beat_06).play;
		p.clock= TempoClock.default.tempo_(95/60); //tempoclock code

	};
	if(view.value == 0){
		//stop loop
		Ndef(\beat_06).free
	};
};

//button07
beat07 = Button(w, sz@sz);
//make it start/stop
beat07.states = [
	["beat07start", Color.black, Color.blue],
	["beat07stop", Color.black, Color.magenta],
];
// assign action to the buttons
beat07.action = {|view|
	if(view.value == 1){
		//start loop
		Ndef(\beat_07).play;
		p.clock=TempoClock.default.tempo_(100/60); //tempoclock code

	};
	if(view.value == 0){
		//stop loop
		Ndef(\beat_07).free
	};
};
//button08
beat08 = Button(w, sz@sz);
//make it start/stop
beat08.states = [
	["beat08start", Color.black, Color.blue],
	["beat08stop", Color.black, Color.magenta],
];
// assign action to the buttons
beat08.action = {|view|
	if(view.value == 1){
		//start loop
		Ndef(\beat_08).play;
	};
	if(view.value == 0){
		//stop loop
		Ndef(\beat_08).free
	};
};

//button09
beat09 = Button(w, sz@sz);
//make it start/stop
beat09.states = [
	["beat09start", Color.black, Color.blue],
	["beat09stop", Color.black, Color.magenta],
];
// assign action to the buttons
beat09.action = {|view|
	if(view.value == 1){
		//start loop
		Ndef(\beat_09).play;
	};
	if(view.value == 0){
		//stop loop
		Ndef(\beat_09).free
	};
};

//button10
beat10 = Button(w, sz@sz);
//make it start/stop
beat10.states = [
	["beat10start", Color.black, Color.blue],
	["beat10stop", Color.black, Color.magenta],
];
// assign action to the buttons
beat10.action = {|view|
	if(view.value == 1){
		//start loop
		Ndef(\beat_10).play;
	};
	if(view.value == 0){
		//stop loop
		Ndef(\beat_10).free
	};
};


//Add xfade
xfader=Slider(w, Rect(100, 600, 1100, 40)); // make a crossfader, maybe the slider isnt the right thing for a xfader?????
xfader.action_({xfader.value.postln};);


//Look into this????
//scope=ScopeView(s);
//scope
//freqScope = FreqScopeView(w,Rect(1000, 1000, 700, 400),s);


w.front; // make the window appear
CmdPeriod.doOnce({w.close}); //closes all on cmd + period


);
);
);







s.record
s.stopRecording