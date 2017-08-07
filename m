Return-Path: <hare@suse.de>
Subject: Re: [PATCH 3/4] scsi: add Mylex RAID controller
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <jth@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.com>
References: <1501683208-5240-1-git-send-email-hare@suse.de>
 <1501683208-5240-4-git-send-email-hare@suse.de>
 <20170805113932.GF16313@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <17589cb4-9f0c-7d15-8c3a-79bd9b14fdef@suse.de>
Date: Mon, 7 Aug 2017 08:09:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170805113932.GF16313@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/05/2017 01:39 PM, Christoph Hellwig wrote:
> Can you use normal linux style for the code instead of copy and
> pasting the weird naming and capitalization from the DAC960 driver?
> 
Yes; already planned for v2. But first wanted to get some general
feedback (like: is anyone interested in that at all?)

> Also please use the driver name as prefix for the functions.
> 
Ok.

> Maybe myraid instead of mylex?
> 
Nah; I'd rather stick with mylex.
(Especially as it says 'Mylex' in big fat letters on the board :-)

> I'll take a more detailed look at the actual driver in a bit.
> 
THX.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
