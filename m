Return-Path: <hch@lst.de>
Date: Tue, 22 May 2018 18:17:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180522161704.GA20000@lst.de>
References: <20180521231131.6685-1-keith.busch@intel.com> <20180521231131.6685-4-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180521231131.6685-4-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

Hi Keith,

I like this series a lot.  One comment that is probably close
to the big discussion in the thread:

>  	switch (ret) {
>  	case BLK_EH_HANDLED:
>  		/*
> +		 * If the request is still in flight, the driver is requesting
> +		 * blk-mq complete it.
>  		 */
> +		if (blk_mq_rq_state(req) == MQ_RQ_IN_FLIGHT)
> +			__blk_mq_complete_request(req);
> +		break;

The state check here really irked me, and from the thread it seems like
I'm not the only one.  At least for the NVMe case I think it is perfectly
safe, although I agree I'd rather audit what other drivers do carefully.

That being said I think BLK_EH_HANDLED seems like a fundamentally broken
idea, and I'd actually prefer to get rid of it over adding things like
the MQ_RQ_IN_FLIGHT check above.

E.g. if we look at the cases where nvme-pci returns it:

 - if we did call nvme_dev_disable, we already canceled all requests,
   so we might as well just return BLK_EH_NOT_HANDLED
 - the poll for completion case already completed the command,
   so we should return BLK_EH_NOT_HANDLED

So I think we need to fix up nvme and if needed any other driver
to return the right value and then assert that the request is
still in in-flight status for the BLK_EH_HANDLED case.

> @@ -124,16 +119,7 @@ static inline int blk_mq_rq_state(struct request *rq)
>  static inline void blk_mq_rq_update_state(struct request *rq,
>  					  enum mq_rq_state state)
>  {
> +	WRITE_ONCE(rq->state, state);
>  }

I think this helper can go away now.  But we should have a comment
near the state field documenting the concurrency implications.



> +	u64 state;

This should probably be a mq_rq_state instead.  Which means it needs
to be moved to blkdev.h, but that should be ok.
