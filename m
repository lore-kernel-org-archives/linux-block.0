Return-Path: <ming.lei@redhat.com>
Date: Tue, 22 May 2018 10:28:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [RFC PATCH 2/3] blk-mq: Fix timeout and state order
Message-ID: <20180522022813.GC20430@ming.t460p>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-3-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180521231131.6685-3-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 21, 2018 at 05:11:30PM -0600, Keith Busch wrote:
> The block layer had been setting the state to in-flight prior to updating
> the timer. This is the wrong order since the timeout handler could observe
> the in-flight state with the older timeout, believing the request had
> expired when in fact it is just getting started.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8b370ed75605..66e5c768803f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -713,8 +713,8 @@ void blk_mq_start_request(struct request *rq)
>  	preempt_disable();
>  	write_seqcount_begin(&rq->gstate_seq);
>  
> -	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
>  	blk_add_timer(rq);
> +	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
>  
>  	write_seqcount_end(&rq->gstate_seq);
>  	preempt_enable();
> -- 
> 2.14.3
> 

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
