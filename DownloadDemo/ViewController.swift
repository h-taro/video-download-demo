//
//  ViewController.swift
//  DownloadDemo
//
//  Created by taro.hiraishi on 2023/05/23.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
    var progressView: UIProgressView!
    
    private let videoURL = URL(string: "https://www.home-movie.biz/mov/hts-samp001.mp4")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.center = view.center
        progressView.progress = .zero
        view.addSubview(progressView)
        
        startDownload()
    }
    
    private func startDownload() {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let downloadTask = session.downloadTask(with: videoURL)
        downloadTask.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        DispatchQueue.main.async {
            self.progressView.progress = 1.0
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        
        DispatchQueue.main.async {
            self.progressView.progress = progress
        }
    }
}

