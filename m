Return-Path: <hch@lst.de>
Date: Fri, 29 Jun 2018 10:39:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V2 3/3] blk-mq: dequeue request one by one from sw
	queue iff hctx is busy
Message-ID: <20180629083944.GE15870@lst.de>
References: <20180629081252.13836-1-ming.lei@redhat.com> <20180629081252.13836-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180629081252.13836-4-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

> +/* update queue busy with EWMA (7/8 * ewma(t)  + 1/8 * busy(t + 1)) */
> +static void blk_mq_update_hctx_busy(struct blk_mq_hw_ctx *hctx, unsigned int busy)

Overly long line.  Also busy really is a bool, so I think we should
pass it as such.

Also I think this needs a much better comment describing why we
are using this algorith.  Also expanding the EWMA acronym would help,
I had to look it up first.

> +	const unsigned weight = 8;
> +	const unsigned factor = 4;

Where do these magic constants come from?

> +	unsigned int ewma;
> +
> +	if (hctx->queue->elevator)
> +		return;
> +
> +	ewma = READ_ONCE(hctx->busy);
> +
> +	ewma *= weight - 1;
> +	ewma += busy << factor;

With the bool parameter and expanding the "factor" which really is
a shift value this would be:

	if (busy)
		ewma += 16;

which at least is a little more understandable, although still not
great.
