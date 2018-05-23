Return-Path: <hare@suse.de>
Subject: Re: [PATCH 12/14] blk-mq: Fix timeout and state order
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Ming Lei <ming.lei@redhat.com>,
 Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20180523121941.8632-1-hch@lst.de>
 <20180523121941.8632-13-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b0c773e3-a6e1-34be-55f2-9718ade1e7d1@suse.de>
Date: Wed, 23 May 2018 15:37:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180523121941.8632-13-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/23/2018 02:19 PM, Christoph Hellwig wrote:
> From: Keith Busch <keith.busch@intel.com>
> 
> The block layer had been setting the state to in-flight prior to updating
> the timer. This is the wrong order since the timeout handler could observe
> the in-flight state with the older timeout, believing the request had
> expired when in fact it is just getting started.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>   block/blk-mq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 22ab2a148a9b..614cb03732ed 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -697,8 +697,8 @@ void blk_mq_start_request(struct request *rq)
>   	preempt_disable();
>   	write_seqcount_begin(&rq->gstate_seq);
>   
> -	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
>   	blk_add_timer(rq);
> +	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
>   
>   	write_seqcount_end(&rq->gstate_seq);
>   	preempt_enable();
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
