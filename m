Return-Path: <hch@lst.de>
Date: Fri, 4 Nov 2016 15:44:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 3/5] block: move poll code to blk-mq
Message-ID: <20161104144410.GA29203@lst.de>
References: <1478202307-1947-1-git-send-email-axboe@fb.com> <1478202307-1947-4-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478202307-1947-4-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 03, 2016 at 01:45:05PM -0600, Jens Axboe wrote:
> The poll code is blk-mq specific, let's move it to blk-mq.c. This
> is a prep patch for improving the polling code.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

So I gave my ok earlier, but I spent some more time looking at this
this morning and now I wonder why we even bother to keep some
code in blk-core.c.  How about just renaming the whole damn thing
to blk_mq_poll and move it to blk-mq.c instead of that split?
