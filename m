Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq-debugfs: Show more request state information
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>
References: <20180316173111.2221-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e1249bf1-1793-c8e7-df81-0f665491389f@kernel.dk>
Date: Sat, 17 Mar 2018 13:41:39 -0700
MIME-Version: 1.0
In-Reply-To: <20180316173111.2221-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/16/18 10:31 AM, Bart Van Assche wrote:
> Since commit 634f9e4631a8 ("blk-mq: remove REQ_ATOM_COMPLETE usages
> from blk-mq") blk_rq_is_complete() only reports whether or not a
> request has completed for legacy queues. Hence modify the
> blk-mq-debugfs code such that it shows the blk-mq request state
> again.

Thanks, applied.

-- 
Jens Axboe
