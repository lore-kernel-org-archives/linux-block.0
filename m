Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:53583 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbdAMHjx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 02:39:53 -0500
Date: Fri, 13 Jan 2017 08:39:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dexuan Cui <decui@microsoft.com>
Cc: Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "Chris Valean (Cloudbase Solutions SRL)" <v-chvale@microsoft.com>
Subject: Re: [Regression] fstrim hangs on Hyper-V: caused by "block:
        improve handling of the magic discard payload"
Message-ID: <20170113073950.GA25746@lst.de>
References: <MWHPR03MB26693D8327D27CA1CFDA50A8BF790@MWHPR03MB2669.namprd03.prod.outlook.com> <20170112134412.GB15178@lst.de> <MWHPR03MB26695378D0512A7C840A0A30BF790@MWHPR03MB2669.namprd03.prod.outlook.com> <20170112155241.GA18147@lst.de> <MWHPR03MB26694FAE82E6D0FAEA02BE04BF790@MWHPR03MB2669.namprd03.prod.outlook.com> <20170112181834.GA8808@lst.de> <MWHPR03MB2669B1BD87F79243F17ADB23BF780@MWHPR03MB2669.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MWHPR03MB2669B1BD87F79243F17ADB23BF780@MWHPR03MB2669.namprd03.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 13, 2017 at 06:16:02AM +0000, Dexuan Cui wrote:
> IMO this means not only SCSI Unmap command is affected, but
> some other SCSI commands can be affected too? 
> And it looks the bare metal can be affected too?

This affects all drivers looking at the sdb.length field for the
total I/O length - many drivers don't need it but just the SGL, including
both that I tested d this change on - one being virtualized and one
bare metal.

It also only affects commands where the data transfer length is different
from the length of the written blocks, so only affects WRITE SAME and
UNMAP commands, used for discard or zeroing.

I'll submit a cleaned up version with a proper block layer helper today.
Thanks for reporting and debugging this issue!
