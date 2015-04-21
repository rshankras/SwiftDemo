//
//  Authenticator.swift
//  SwiftDemo
//
//  Created by Ravi Shankar on 14/04/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import Foundation

protocol TwitterFollowerDelegate{
    func finishedDownloading(results:[TwitterFollower])
}

public class TwitterServiceWrapper:NSObject {
    
    var delegate:TwitterFollowerDelegate?
    
    let consumerKey = "<consumer_key>" // replace consumer key
    let consumerSecret = "consumer_secret" // replace consumer secret
    let authURL = "https://api.twitter.com/oauth2/token"
    
    // MARK:- Bearer Token
    
    func getBearerToken(completion:(bearerToken: String) ->Void) {
        var request = NSMutableURLRequest(URL: NSURL(string: authURL)!)
        
        request.HTTPMethod = "POST"
        request.addValue("Basic " + getBase64EncodeString(), forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        var grantType =  "grant_type=client_credentials"
        
        request.HTTPBody = grantType.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        NSURLSession.sharedSession() .dataTaskWithRequest(request, completionHandler: { (data: NSData!, response:NSURLResponse!, error: NSError!) -> Void in
            var errorPointer : NSErrorPointer = nil
            
            if let results: NSDictionary = NSJSONSerialization .JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments  , error: errorPointer) as? NSDictionary {
                if let token = results["access_token"] as? String {
                    completion(bearerToken: token)
                } else {
                    println(results["errors"])
                }
            }
        }).resume()
    }
    
    // MARK:- base64Encode String
    
    func getBase64EncodeString() -> String {
        
        let consumerKeyRFC1738 = consumerKey.stringByAddingPercentEscapesUsingEncoding(NSASCIIStringEncoding)
        let consumerSecretRFC1738 = consumerSecret.stringByAddingPercentEscapesUsingEncoding(NSASCIIStringEncoding)
        
        let concatenateKeyAndSecret = consumerKeyRFC1738! + ":" + consumerSecretRFC1738!
        
        let secretAndKeyData = concatenateKeyAndSecret.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        
        let base64EncodeKeyAndSecret = secretAndKeyData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.allZeros)
        
        return base64EncodeKeyAndSecret!
    }
    
    // MARK:- Service Call
    
    func getResponseForRequest(url:String) {
        
        var results:NSDictionary
        
        getBearerToken({ (bearerToken) -> Void in
    
            var request = NSMutableURLRequest(URL: NSURL(string: url)!)
            request.HTTPMethod = "GET"
            
            let token = "Bearer " + bearerToken
            
            request.addValue(token, forHTTPHeaderField: "Authorization")
            
            NSURLSession.sharedSession() .dataTaskWithRequest(request, completionHandler: { (data: NSData!, response:NSURLResponse!, error: NSError!) -> Void in
                
                self.processResult(data, response: response, error: error)
                
            }).resume()
        })
        
    }
    
    // MARK:- Process results
    
    func processResult(data: NSData, response:NSURLResponse, error: NSError?) {
        
        var errorPointer : NSErrorPointer = nil
        
        if let results: NSDictionary = NSJSONSerialization .JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments  , error: errorPointer) as? NSDictionary {
            
            var followers: Array = [TwitterFollower]()
            
            if var users = results["users"] as? NSMutableArray {
                for user in users {
                    let follower = TwitterFollower(name: user["name"] as! String, url: user["profile_image_url"] as! String)
                    followers.append(follower)
                }
                self.delegate?.finishedDownloading(followers)
            } else {
                println(results["errors"])
            }
        }
    }
}