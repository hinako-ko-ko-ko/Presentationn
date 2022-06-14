//
//  RecordViewController.swift
//  presentation
//
//  Created by 中井日向子 on 2022/05/22.
//

import UIKit
import AVFoundation

enum BorderPosition {
    case top
    case left
    case right
    case bottom
}

extension UIView {
    /// 特定の場所にborderをつける
    ///
    /// - Parameters:
    ///   - width: 線の幅
    ///   - color: 線の色
    ///   - position: 上下左右どこにborderをつけるか
    func addBorder(width: CGFloat, color: UIColor, position: BorderPosition) {

        let border = CALayer()

        switch position {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: width)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        case .right:
            print(self.frame.width)

            border.frame = CGRect(x: self.frame.width - width, y: 0, width: width, height: self.frame.height)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        }
    }
}
extension UITextField {
    func addBorderBottom(height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height - height, width: self.frame.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}

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
        
     
        tileTextField.addBorderBottom(height: 0.5, color: UIColor.lightGray)
        targettimeTextField.addBorderBottom(height: 0.5, color: UIColor.lightGray)
      
      
        getDate()
        
       }
    override func viewDidLayoutSubviews() {
            self.textView.addBorder(width: 0.0, color: UIColor.black, position: .right)
        self.textView.addBorder(width: 0.5, color: UIColor.lightGray, position: .bottom)
            self.textView.addBorder(width: 0.0, color: UIColor.black, position: .top)
            self.textView.addBorder(width: 0.0, color: UIColor.black, position: .left)
        }
    func getDate(){
        let getArray:[[String]] = UserDefaults.standard.array(forKey: "detail") as![[String]]//引き出し
    
    
       
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)//キーボード閉じる
        }
  
    
    @IBAction func saveWord() {
     
                                  
            let etext:String  = (tileTextField.text)!
            let jtext:String = (targettimeTextField.text)!
        
            
        
        if !etext.isEmpty && !jtext.isEmpty{
            detailArray = UserDefaults.standard.object(forKey: "detail") as! [[String]]
                detailArray.append([tileTextField.text!,targettimeTextField.text!,textView.text!,timerLabel.text!])
            UserDefaults.standard.set(detailArray,forKey: "detail")//UDに配列保存　あとで詳しく書く
           
            let alert = UIAlertController(
                title: "SAVE COMPLETED",
                message: "Registration has been completed",
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
                title: "CANNOT SAVE",
                message: "Please enter",
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
       
        self.timerLabel.text = String(format: "%02d:%02d", min, sec)
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

            label.text = "Recording"
            recordButton.setTitle("⚪︎Stop", for: .normal)
            playButton.isEnabled = false

        }else{

            audioRecorder.stop()
            isRecording = false

            label.text = "Stopping"
            recordButton.setTitle("⚫︎Record", for: .normal)
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

            label.text = "Playing"
            playButton.setTitle("⚪︎Stop", for: .normal)
            recordButton.isEnabled = false

        }else{

            audioPlayer.stop()
            isPlaying = false

            label.text = "Stopping"
            playButton.setTitle("▶︎Play", for: .normal)
            recordButton.isEnabled = true

        }
    }
}
