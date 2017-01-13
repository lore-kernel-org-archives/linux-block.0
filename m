Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 13 Jan 2017 15:18:29 -0700
To: Christoph Hellwig <hch@lst.de>
Cc: eguan@redhat.com, Chaitanya.Kulkarni@wdc.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: don't try to discard from __blkdev_issue_zeroout
Message-ID: <20170113221829.GB16425@kernel.dk>
References: <1484316977-2474-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484316977-2474-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jan 13 2017, Christoph Hellwig wrote:
> Discard can return -EIO asynchronously if the alignment for the request
> isn't suitable for the driver, which makes a proper fallback to other
> methods in __blkdev_issue_zeroout impossible.  Thus only issue a sync
> discard from blkdev_issue_zeroout an don't try discard at all from
> __blkdev_issue_zeroout as a non-invasive workaround.
> 
> One more reason why abusing discard for zeroing must die..

Added for 4.10, thanks.

-- 
Jens Axboe
