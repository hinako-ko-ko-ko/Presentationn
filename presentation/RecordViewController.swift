//
//  RecordViewController.swift
//  presentation
//
//  Created by 中井日向子 on 2022/05/22.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController,UITextViewDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    @IBOutlet var tileTextField: UITextField!
    @IBOutlet var targettimeTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var label: UILabel!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var playButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var isRecording = false
    var isPlaying = false
    
    
    var detailArray = [[String]]()//配列
   
    
    var startTime: TimeInterval? = nil
    var timer = Timer()
    
   
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(detailArray, forKey: "detail")
        
        getDate()
        
       }
    func getDate(){
        let getArray:[[String]] = UserDefaults.standard.array(forKey: "detail") as![[String]]//引き出し
    
    
        // 枠のカラー
                textView.layer.borderColor = UIColor.lightGray.cgColor
        // 枠の幅
        textView.layer.borderWidth = 0.5
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)//キーボード閉じる
        }
  
    
    @IBAction func saveWord() {
        UserDefaults.standard.set(tileTextField.text, forKey: "title")
                                  
            let etext:String  = (tileTextField.text)!
            let jtext:String = (targettimeTextField.text)!
            
        
        if !etext.isEmpty && !jtext.isEmpty{
            detailArray = UserDefaults.standard.object(forKey: "detail") as! [[String]]
                detailArray.append([tileTextField.text!,targettimeTextField.text!,textView.text!,timerLabel.text!])
            UserDefaults.standard.set(detailArray,forKey: "detail")//UDに配列保存　あとで詳しく書く
           
            let alert = UIAlertController(
                title: "保存完了",
                message: "登録が完了しました",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            ))
            present(alert, animated: true, completion: nil)
                tileTextField.text = ""
                targettimeTextField.text = ""
                targettimeTextField.text = ""
                timerLabel.text = ""
                
            } else {
            let nalert = UIAlertController(
                title: "保存できません",
                message: "入力してください",
                preferredStyle: .alert
            )
            nalert.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            ))
            present(nalert, animated: true, completion: nil)
            }
        
        }

    
     
    
    @IBAction func startButtonAction(_ sender: Any) {
        timer.invalidate()
        self.startTime = Date.timeIntervalSinceReferenceDate
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
    
    @objc func timerCounter() {
        guard let startTime = self.startTime else { return }
        let time = Date.timeIntervalSinceReferenceDate - startTime
        let min = Int(time / 60)
        let sec = Int(time) % 60
        let msec = Int((time - Double(sec)) * 100.0)
        self.timerLabel.text = String(format: "%02d:%02d:%02d", min, sec, msec)
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func resetButtonAction(_ sender: Any) {
        self.startTime = nil
        self.timerLabel.text = "00:00:00"
    }
    @IBAction func record(){
        if !isRecording {

            let session = AVAudioSession.sharedInstance()
            try! session.setCategory(AVAudioSession.Category.playAndRecord)
            try! session.setActive(true)

            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]

            audioRecorder = try! AVAudioRecorder(url: getURL(), settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()

            isRecording = true

            label.text = "録音中"
            recordButton.setTitle("STOP", for: .normal)
            playButton.isEnabled = false

        }else{

            audioRecorder.stop()
            isRecording = false

            label.text = "待機中"
            recordButton.setTitle("RECORD", for: .normal)
            playButton.isEnabled = true

        }
    }
    func getURL() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let url = docsDirect.appendingPathComponent("recording.m4a")
        return url
    }
    @IBAction func play(){
        if !isPlaying {

            audioPlayer = try! AVAudioPlayer(contentsOf: getURL())
            audioPlayer.delegate = self
            audioPlayer.play()

            isPlaying = true

            label.text = "再生中"
            playButton.setTitle("STOP", for: .normal)
            recordButton.isEnabled = false

        }else{

            audioPlayer.stop()
            isPlaying = false

            label.text = "待機中"
            playButton.setTitle("PLAY", for: .normal)
            recordButton.isEnabled = true

        }
    }
}

    

