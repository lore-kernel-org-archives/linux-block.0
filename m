Return-Path: <hch@lst.de>
Date: Wed, 26 Sep 2018 16:27:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v10 7/8] block: Make blk_get_request() block for non-PM
 requests while suspended
Message-ID: <20180926142740.GE8604@lst.de>
References: <20180921203122.49743-1-bvanassche@acm.org> <20180921203122.49743-8-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180921203122.49743-8-bvanassche@acm.org>
List-ID: <linux-block@vger.kernel.org>

>  		list_for_each_entry(rq, &q->queue_head, queuelist) {
> -			if (blk_pm_allow_request(rq))
> -				return rq;
> -
> -			if (rq->rq_flags & RQF_SOFTBARRIER)
> -				break;
> +#ifdef CONFIG_PM
> +			/*
> +			 * If a request gets queued in state RPM_SUSPENDED
> +			 * then that's a kernel bug.
> +			 */
> +			WARN_ON_ONCE(q->rpm_status == RPM_SUSPENDED);
> +#endif

I hate this ifdef, but it probably isnt worth adding a helper for this
assert, so I guess we'll have to live with it..

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
