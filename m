Return-Path: <axboe@kernel.dk>
Subject: Re: [REGRESSION v4.10-rc1] blkdev_issue_zeroout() returns -EREMOTEIO
 on the first call for SCSI device that doesn't support WRITE SAME
To: Christoph Hellwig <hch@lst.de>
References: <cc14c28a-0f0a-640a-b576-cdfbaee75dc5@ce.jp.nec.com>
 <d360a634-2c95-2de5-8647-4e740e92e10a@kernel.dk>
 <20170203161239.GA3880@lst.de>
Cc: Junichi Nomura <j-nomura@ce.jp.nec.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1e819f0d-ecdc-e54a-bd3d-17de2f71c8a7@kernel.dk>
Date: Fri, 3 Feb 2017 09:14:11 -0700
MIME-Version: 1.0
In-Reply-To: <20170203161239.GA3880@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/03/2017 09:12 AM, Christoph Hellwig wrote:
> On Fri, Feb 03, 2017 at 08:21:31AM -0700, Jens Axboe wrote:
>>> Error 121 (EREMOTEIO) was returned from blkdev_issue_zeroout().
>>> That came from sd driver because WRITE SAME was sent to the device
>>> which didn't support it.
>>>
>>> The problem was introduced by commit e73c23ff736e ("block: add async
>>> variant of blkdev_issue_zeroout"). Before the commit, blkdev_issue_zeroout
>>> fell back to normal zero writing when WRITE SAME failed and it seems
>>> sd driver's heuristics depends on that behaviour.
>>
>> CC Christoph and Chaitanya.
> 
> And adding Martin as the sd.c Write Same code is his.
> 
> I suspect we'll have to restore the old way this works for 4.10 as it's
> too late in the cycle, but that whole idea of trying Write Same first
> and just disabling it if it doesn't work is a receipe for desaster -
> it kinda works for a synchronous blkdev_issue_zeroout, but if we want
> to be able to submit it asynchronously it's getting too hairy to handle.

I agree, the current approach is a hot and ugly mess.

> I think we should fix sd.c to only send WRITE SAME if either of the
> variants are explicitly listed as supported through
> REPORT SUPPORTED OPERATION CODES, or maybe through a whitelist if
> there are important enough devices.

Yep

-- 
Jens Axboe
