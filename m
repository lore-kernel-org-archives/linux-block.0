Return-Path: <axboe@kernel.dk>
Date: Fri, 18 Aug 2017 08:34:47 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 03/12] blk-mq: Explain when 'active_queues' is decremented
Message-ID: <20170818143446.GA20707@kernel.dk>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
 <20170817232311.25948-4-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170817232311.25948-4-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 17 2017, Bart Van Assche wrote:
> It is nontrivial to derive from the blk-mq source code when
> blk_mq_tags.active_queues is decremented. Hence add a comment that
> explains this.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-mq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f84d145490bf..b86d2cafc355 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -834,6 +834,10 @@ static void blk_mq_timeout_work(struct work_struct *work)
>  	} else {
>  		struct blk_mq_hw_ctx *hctx;
>  
> +		/*
> +		 * All requests finished (latest request timeout) seconds ago,
> +		 * so mark each hctx as idle.
> +		 */
>  		queue_for_each_hw_ctx(q, hctx, i) {

I don't think that's a great comment, what does 'latest request timeout'
refer to? We hit this case when the device has gone idle, I think a more
useful comment would be something about how blk-mq implements timeouts.
How about something ala:

/*
 * Request timeouts are handled as a forward rolling timer. If we
 * end up here, there are no more requests pending, and there hasn't
 * been for a while. Mark each hctx as idle.
 */

-- 
Jens Axboe
