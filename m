Return-Path: <hch@lst.de>
Date: Mon, 2 Jul 2018 15:17:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V3 3/3] blk-mq: dequeue request one by one from sw
	queue iff hctx is busy
Message-ID: <20180702131738.GG4624@lst.de>
References: <20180702093600.10315-1-ming.lei@redhat.com> <20180702093600.10315-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180702093600.10315-4-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

> +/*
> + * Update dispatch busy with EWMA:

Please expand the EWMA acronym.

> +static void blk_mq_update_hctx_busy(struct blk_mq_hw_ctx *hctx, bool busy)
> +{
> +	const unsigned weight = 8;
> +	unsigned int ewma;
> +
> +	if (hctx->queue->elevator)
> +		return;
> +
> +	ewma = READ_ONCE(hctx->dispatch_busy);
> +
> +	ewma *= weight - 1;
> +	if (busy)
> +		ewma += 16;

plese use descriptive all upper case #defines for the WEIGHT and FACTOR
so that they stick out.
