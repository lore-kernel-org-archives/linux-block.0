Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V2] blk-mq: fix race between complete and
 BLK_EH_RESET_TIMER
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
References: <20180411233812.18003-1-ming.lei@redhat.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <f63c9def-4fef-5032-814c-5dc142d5be5a@oracle.com>
Date: Thu, 12 Apr 2018 10:38:56 +0800
MIME-Version: 1.0
In-Reply-To: <20180411233812.18003-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 04/12/2018 07:38 AM, Ming Lei wrote:
> +	 *
> +	 * Cover complete vs BLK_EH_RESET_TIMER race in slow path with
> +	 * helding queue lock.
>  	 */
>  	hctx_lock(hctx, &srcu_idx);
>  	if (blk_mq_rq_aborted_gstate(rq) != rq->gstate)
>  		__blk_mq_complete_request(rq);
> +	else {
> +		unsigned long flags;
> +		bool need_complete = false;
> +
> +		spin_lock_irqsave(q->queue_lock, flags);
> +		if (!blk_mq_rq_aborted_gstate(rq))
> +			need_complete = true;
> +		else
> +			blk_mq_rq_update_state(rq, MQ_RQ_COMPLETE_IN_TIMEOUT);
> +		spin_unlock_irqrestore(q->queue_lock, flags);

What if the .timeout return BLK_EH_HANDLED during this ?
timeout context                     irq context
  .timeout()
                                     blk_mq_complete_request
                                       set state to MQ_RQ_COMPLETE_IN_TIMEOUT
  __blk_mq_complete_request
    WARN_ON_ONCE(blk_mq_rq_state(rq) 
     != MQ_RQ_IN_FLIGHT);

If further upon blk_mq_free_request, the final freed request maybe changed to MQ_RQ_COMPLETE_IN_TIMEOUT
instead of MQ_RQ_IDLE.

Thanks
Jianchao
