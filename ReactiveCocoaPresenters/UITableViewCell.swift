//
//  UITableViewCell.swift
//  ReactivePresenters
//
//  Created by Ilya Laryionau on 06/06/16.
//  Copyright © 2016 Ilya Laryionau. All rights reserved.
//

import UIKit
import ReactiveCocoa
import enum Result.NoError

public class TableViewCell: UITableViewCell {

    private let prepareForReusePipe = Signal<Void, NoError>.pipe()

    public var rxp_prepareForReuse: Signal<Void, NoError> {
        return prepareForReusePipe.0
    }

    //

    public override func prepareForReuse() {
        prepareForReusePipe.1.sendNext()
        
        super.prepareForReuse()
    }
}
