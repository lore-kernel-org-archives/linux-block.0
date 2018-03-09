Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-debugfs: Show more request state information
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>
References: <20180308232728.8810-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cfb65361-6599-d33c-0167-749b11901552@kernel.dk>
Date: Fri, 9 Mar 2018 08:24:40 -0700
MIME-Version: 1.0
In-Reply-To: <20180308232728.8810-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/8/18 4:27 PM, Bart Van Assche wrote:
> Since commit 634f9e4631a8 ("blk-mq: remove REQ_ATOM_COMPLETE usages
> from blk-mq") blk_rq_is_complete() only reports whether or not a
> request has completed for legacy queues. Hence modify the
> blk-mq-debugfs code such that it shows the blk-mq request state
> again.

I'd probably be more comfortable if you added a blk_mq_rq_state_name()
helper function and did the boundary check there.

-- 
Jens Axboe
