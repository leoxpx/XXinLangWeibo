//
//  NetworkTools.swift
//  213-AFNetworking的封装
//
//  Created by 薪王iOS1 on 2017/7/3.
//  Copyright © 2017年 XTeam. All rights reserved.
//

import AFNetworking

// 定义枚举类型
enum RequestType : String{
    case GET = "GET"
    case POST = "POST"
}


class NetworkTools: AFHTTPSessionManager {
    // let 是线程安全的
    static let shareInstance : NetworkTools = {
        let tools = NetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    }()
}

// MARK: - 封装请求方法
extension NetworkTools {
    
    func request(methodType : RequestType, urlString : String, parameters : [String : Any], finished : @escaping (_ result : AnyObject?, _  error : Error?) -> ()) {
        
        // 定义成功的回调闭包
        let successCallBack = { (task : URLSessionDataTask, result : Any) in
            finished(result as AnyObject, nil)
        }
        // 定义失败的回调闭包
        let faileCallBack = { (task : URLSessionDataTask?, error : Error) in
            finished(nil, error)
        }
        
        if methodType == .GET {
            get(urlString, parameters: parameters, progress: nil, success: successCallBack, failure : faileCallBack)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: successCallBack, failure : faileCallBack)
        }
    }
}
