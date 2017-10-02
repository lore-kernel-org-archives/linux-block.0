Return-Path: <hch@lst.de>
Date: Mon, 2 Oct 2017 15:47:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v4 4/7] block: Add the QUEUE_FLAG_PREEMPT_ONLY request
	queue flag
Message-ID: <20171002134755.GA7571@lst.de>
References: <20170925202924.16603-1-bart.vanassche@wdc.com> <20170925202924.16603-5-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170925202924.16603-5-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

> +void blk_set_preempt_only(struct request_queue *q, bool preempt_only)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(q->queue_lock, flags);
> +	if (preempt_only)
> +		queue_flag_set(QUEUE_FLAG_PREEMPT_ONLY, q);
> +	else
> +		queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
> +	spin_unlock_irqrestore(q->queue_lock, flags);
> +}
> +EXPORT_SYMBOL(blk_set_preempt_only);

Why do we even need this helper?  The lock doesn't make sense to me,
and it would just much easier to set/clear the flag from the driver.
