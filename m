Return-Path: <BATV+790fc1df0de68f83423e+4778+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 22 Sep 2016 07:56:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, jbacik@fb.com
Subject: Re: [PATCH 1/2] blk-mq: get rid of manual run of queue with
 __blk_mq_run_hw_queue()
Message-ID: <20160922145657.GA1800@infradead.org>
References: <1474555980-2787-1-git-send-email-axboe@fb.com>
 <1474555980-2787-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474555980-2787-2-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 22, 2016 at 08:52:59AM -0600, Jens Axboe wrote:
> Two cases:
> 
> 1) blk_mq_alloc_request() needlessly re-runs the queue, after
>    calling into the tag allocation without NOWAIT set. We don't
>    need to do that.
> 
> 2) blk_mq_map_request() should just use blk_mq_run_hw_queue() with
>    the async flag set to false.

I had some very similar patches in my queue but never got around
benchmarking them in enough setups to feel safe enough to post them.

Assuming you found no reaosn to keep the odd old scheme either:

Reviewed-by: Christoph Hellwig <hch@lst.de>
