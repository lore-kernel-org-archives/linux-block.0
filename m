Return-Path: <hch@lst.de>
Date: Tue, 4 Apr 2017 08:40:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2 1/5] blk-mq: Export blk_mq_sched_restart_hctx()
Message-ID: <20170404064001.GA9168@lst.de>
References: <20170403232228.11208-1-bart.vanassche@sandisk.com> <20170403232228.11208-2-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170403232228.11208-2-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

> +void blk_mq_sched_restart_hctx(struct blk_mq_hw_ctx *hctx)
>  {
> +	clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
> +	if (blk_mq_hctx_has_pending(hctx))
> +		blk_mq_run_hw_queue(hctx, true);
>  }
> +EXPORT_SYMBOL(blk_mq_sched_restart_hctx);

_GPL export like the other _hctx functions, please.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
