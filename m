Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: don't try Write Same from __blkdev_issue_zeroout
To: Christoph Hellwig <hch@lst.de>
References: <20170205171035.5993-1-hch@lst.de>
Cc: j-nomura@ce.jp.nec.com, chaitanya.kulkarni@hgst.com,
 linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <913ee131-32ac-3ad0-fdd4-437de438b8b4@kernel.dk>
Date: Mon, 6 Feb 2017 09:35:03 -0700
MIME-Version: 1.0
In-Reply-To: <20170205171035.5993-1-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/05/2017 10:10 AM, Christoph Hellwig wrote:
> Write Same can return an error asynchronously if it turns out the
> underlying SCSI device does not support Write Same, which makes a
> proper fallback to other methods in __blkdev_issue_zeroout impossible.
> Thus only issue a Write Same from blkdev_issue_zeroout an don't try it
> at all from __blkdev_issue_zeroout as a non-invasive workaround.

Thanks, added for 4.10.

-- 
Jens Axboe
