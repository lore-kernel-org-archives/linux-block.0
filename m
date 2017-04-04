Return-Path: <hch@lst.de>
Date: Tue, 4 Apr 2017 08:42:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2 4/5] scsi: Add scsi_restart_hctx()
Message-ID: <20170404064252.GD9168@lst.de>
References: <20170403232228.11208-1-bart.vanassche@sandisk.com> <20170403232228.11208-5-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170403232228.11208-5-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

> +static void scsi_restart_hctx(struct request_queue *q,
> +			      struct blk_mq_hw_ctx *hctx)
> +{
> +	struct blk_mq_tags *tags = hctx->tags;
> +	struct blk_mq_tag_set *set = q->tag_set;
> +	int i;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list)
> +		queue_for_each_hw_ctx(q, hctx, i)
> +			if (hctx->tags == tags)
> +				blk_mq_sched_restart_hctx(hctx);
> +	rcu_read_unlock();
> +}

This looks like generic block layer code, why is it in SCSI?
