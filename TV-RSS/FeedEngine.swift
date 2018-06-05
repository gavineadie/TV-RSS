/*╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
 ║ FeedModel.swift                                                                          TV-RSS ║
 ║                                                                                                  ║
 ║ Created by Gavin Eadie on Jan03/16.           Copyright © 2016 Gavin Eadie. All rights reserved. ║
 ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝*/

import UIKit

class FeedEngine : NSObject, XMLParserDelegate {
    
    var     feedItems = [(itemTitle: String, itemWords: String, itemStory: String)]()
    var     feedTitle = ""
    
    fileprivate var itemTitle = ""
    fileprivate var itemWords = ""
    fileprivate var itemStory = ""
    
    fileprivate var itemActive = false
    fileprivate var parsedItem = ""
    fileprivate var foundCharacters = ""
    
    
    func readFeed(_ feedLink:String) {
        
        guard let parser = XMLParser(contentsOf: URL(string: feedLink)!) else {
            Swift.print("### XMLParser(\(feedLink)) failure")
            return
        }
        
        parser.delegate = self
        
        if parser.parse() {
            Swift.print("### parser.parse(\(feedLink)) success")
        }
        else {
            Swift.print("### parser.parse(\(feedLink)) failure")
        }
        
    }
    
    open func parser(_ parser: XMLParser,
                     didStartElement elementName: String,
                     namespaceURI: String?,
                     qualifiedName qName: String?,
                     attributes attributeDict: [String : String] = [:])  {
        
        parsedItem = elementName.lowercased()
        
        itemActive = (itemActive || parsedItem == "item")
        
    }
    
    open func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        guard string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0 else { return }
        
        foundCharacters += string
        
    }
    
    open func parser(_ parser: XMLParser, didEndElement elementName: String,
                     namespaceURI: String?, qualifiedName qName: String?) {
        
        switch elementName.lowercased() {
            
        case "title":
            if itemActive {
                itemTitle = foundCharacters
            }
            else {
                if feedTitle.count == 0 {
                    feedTitle = foundCharacters
                }
            }
            
        case "description":
            if itemActive {
                itemWords = foundCharacters
            }
            
        case "link":
            if itemActive {
                itemStory = foundCharacters
            }
            
        case "item":
            feedItems.append((itemTitle, itemWords, itemStory))
            
        default:
            break
        }
        
        foundCharacters = ""
        
    }
    
    open func parserDidEndDocument(_ parser: XMLParser) {
        
        Swift.print("### parserDidEndDocument: \(parser.description)")
        
    }
    
    open func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        
        Swift.print("### parseErrorOccurred: \(parseError)")
        
    }
    
    
    //---------------------------------------------------------------------------------------------------------------------
    //
    //    public func parserDidStartDocument(_ parser: XMLParser) {
    //        Swift.print("### parserDidStartDocument: \(parser.description)")
    //    }
    //
    //    public func parser(_ parser: XMLParser, foundNotationDeclarationWithName name: String, publicID: String?, systemID: String?) {
    //        Swift.print("### foundNotationDeclarationWithName: \(name)")
    //    }
    //
    //    public func parser(_ parser: XMLParser, foundUnparsedEntityDeclarationWithName name: String, 
    //                       publicID: String?, systemID: String?, notationName: String?) {
    //        Swift.print("### foundUnparsedEntityDeclarationWithName: \(name)")
    //    }
    //
    //    public func parser(_ parser: XMLParser, foundAttributeDeclarationWithName attributeName: String, 
    //                       forElement elementName: String, type: String?, defaultValue: String?) {
    //        Swift.print("### foundAttributeDeclarationWithName: \(parser.description)")
    //    }
    //
    //    public func parser(_ parser: XMLParser, foundElementDeclarationWithName elementName: String, model: String) {
    //        Swift.print("### foundElementDeclarationWithName: \(parser.description)")
    //    }
    //
    //    public func parser(_ parser: XMLParser, foundInternalEntityDeclarationWithName name: String, value: String?) {
    //        Swift.print("### foundInternalEntityDeclarationWithName: \(parser.description)")
    //    }
    //
    //    public func parser(_ parser: XMLParser, foundExternalEntityDeclarationWithName name: String, publicID: String?, systemID: String?) {
    //        Swift.print("### foundExternalEntityDeclarationWithName: \(parser.description)")
    //    }
    //
    //    public func parser(_ parser: XMLParser, didStartMappingPrefix prefix: String, toURI namespaceURI: String) {
    //        Swift.print("### didStartMappingPrefix: \(prefix)")
    //    }
    //
    //    public func parser(_ parser: XMLParser, didEndMappingPrefix prefix: String) {
    //        Swift.print("### didEndMappingPrefix: \(prefix)")
    //    }
    //
    //    public func parser(_ parser: XMLParser, foundIgnorableWhitespace whitespaceString: String) {
    //        Swift.print("### foundIgnorableWhitespace: \(parser.description)")
    //    }
    //
    //    public func parser(_ parser: XMLParser, foundProcessingInstructionWithTarget target: String, data: String?) {
    //        Swift.print("### foundProcessingInstructionWithTarget: \(target); data \(data)")
    //    }
    //
    //    public func parser(_ parser: XMLParser, foundComment comment: String) {
    //        Swift.print("### foundComment: \(comment)")
    //    }
    //
    //    public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
    //        Swift.print("### foundCDATA: \(CDATABlock.base64EncodedString())")
    //    }
    //
    //    public func parser(_ parser: XMLParser, resolveExternalEntityName name: String, systemID: String?) -> Data? {
    //        Swift.print("### resolveExternalEntityName: \(name)")
    //        return Data()
    //    }
    //
    //    public func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
    //        Swift.print("### validationErrorOccurred: \(validationError)")
    //    }
    
    
    func zeroFeed() {
        
        Swift.print("### zeroFeed")
        
        feedTitle = ""
        
        itemActive = false
        parsedItem = ""
        feedItems = []
        
    }
    
    //    func refreshPodcasts() {
    //        let urlString = URL(string: "http://www.blubrry.com/feeds/onorte.xml")
    //        let rssUrlRequest = URLRequest(url:urlString!)
    //        let queue = OperationQueue()
    //
    //        let dataTask = URLSession.dataTask(wi)
    //        NSURLConnection.sendAsynchronousRequest(rssUrlRequest, queue: queue) {
    //            (response, data, error) -> Void in
    //            self.xmlParser = XMLParser(data: data)
    //            self.xmlParser.delegate = self
    //            self.xmlParser.parse()
    //        }
    //    }
    
}
