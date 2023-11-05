//
//  EggTimerViewController.swift
//  Egg Timer
//
//  Created by Liz-Mary on 02.11.2023.
//

import UIKit
import AVFoundation

final class EggTimerViewController: UIViewController {

    let eggTimerView = EggTimerView()
    var audioPlayer: AVAudioPlayer?
    
    var totalTimer = 0
    var secondTimer = 0
    var timer = Timer()
    var nameSoundTimer = "alarm_sound"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        eggTimerView.delegate = self
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(eggTimerView.mainStack)
        eggTimerView.timerView.addSubview(eggTimerView.progressBar)
        
        NSLayoutConstraint.activate([
        eggTimerView.mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        eggTimerView.mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        eggTimerView.mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        eggTimerView.mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
        eggTimerView.progressBar.centerYAnchor.constraint(equalTo: eggTimerView.timerView.centerYAnchor),
        eggTimerView.progressBar.leadingAnchor.constraint(equalTo: eggTimerView.timerView.leadingAnchor),
        eggTimerView.progressBar.trailingAnchor.constraint(equalTo: eggTimerView.timerView.trailingAnchor)
        
        ])
    }
}

//MARK: - Logic
extension EggTimerViewController {
    
    func playSound(_ name: String) {
        // Получаем URL звукового файла
        if let soundURL = Bundle.main.url(forResource: name, withExtension: "mp3") {
            do {
                // Создаем и воспроизводим аудиоплеер
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Ошибка при воспроизведении звука: \(error.localizedDescription)")
            }
        } else {
            print("Звуковой файл не найден.")
        }
    }
    
   // функция для запуска таймера на основе выбранной варки яйц
   private func startTimerWithHardness(_ hardness: String) {
        //получаем время варки из словаря
       if let time = EggModel.eggTimes[hardness] {
            timer.invalidate()
            eggTimerView.progressBar.setProgress(0, animated: true)
            secondTimer = 0
            totalTimer = time
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateTimer() {
        if secondTimer < totalTimer {
            secondTimer += 1
            let percentageProgress = Float(secondTimer) / Float(totalTimer)
            eggTimerView.progressBar.setProgress(percentageProgress, animated: true)
        } else {
            playSound(nameSoundTimer)
            timer.invalidate()
            secondTimer = 0
            eggTimerView.titleLabel.text = "That's done! Let's go repeats?"
            eggTimerView.progressBar.setProgress(1, animated: true)
        }
    }
}

extension EggTimerViewController: EggTimerDelegate {
    
    func softEggTapped(_ sender: UIButton) {
        startTimerWithHardness("Soft")
        
    }
    
    func mediumEggTapped(_ sender: UIButton) {
        startTimerWithHardness("Medium")
    }
    
    func hardEggTapped(_ sender: UIButton) {
        startTimerWithHardness("Hard")
    }
}

