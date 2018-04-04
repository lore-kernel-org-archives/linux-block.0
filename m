Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: order getting budget and driver tag
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@wdc.com>, Omar Sandoval <osandov@fb.com>
References: <20180404163521.11346-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cfbb9751-ce1b-6265-f259-983f403f8500@kernel.dk>
Date: Wed, 4 Apr 2018 14:56:26 -0600
MIME-Version: 1.0
In-Reply-To: <20180404163521.11346-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/4/18 10:35 AM, Ming Lei wrote:
> This patch orders getting budget and driver tag by making sure to acquire
> driver tag after budget is got, this way can help to avoid the following
> race:
> 
> 1) before dispatch request from scheduler queue, get one budget first, then
> dequeue a request, call it request A.
> 
> 2) in another IO path for dispatching request B which is from hctx->dispatch,
> driver tag is got, then try to get budget in blk_mq_dispatch_rq_list(),
> unfortunately the budget is held by request A.
> 
> 3) meantime blk_mq_dispatch_rq_list() is called for dispatching request
> A, and try to get driver tag first, unfortunately no driver tag is
> available because the driver tag is held by request B
> 
> 4) both two IO pathes can't move on, and IO stall is caused.
> 
> This issue can be observed when running dbench on USB storage.

Good catch, this can trigger on anything potentially, but of course more
likely with limited budget and/or tag space. Classic ABBA deadlock.

-- 
Jens Axboe
