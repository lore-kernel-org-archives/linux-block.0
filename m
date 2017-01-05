Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "axboe@fb.com"
	<axboe@fb.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "marc@merlins.org" <marc@merlins.org>
Subject: Re: [PATCH 5/6] blk-mq: Fix queue freeze deadlock
Date: Thu, 5 Jan 2017 07:33:22 +0000
Message-ID: <1483601585.2811.5.camel@sandisk.com>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
	 <1483569671-1462-6-git-send-email-keith.busch@intel.com>
In-Reply-To: <1483569671-1462-6-git-send-email-keith.busch@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-01-04 at 17:41 -0500, Keith Busch wrote:
> +static void blk_mq_abandon_stopped_requests(struct request_queue *q)
> +{
> +	int i;
> +	struct request *rq, *next;
> +	struct blk_mq_hw_ctx *hctx;
> +	LIST_HEAD(rq_list);
> +
> +	blk_mq_sync_queue(q);
> +
> +	spin_lock(&q->requeue_lock);
> +	list_for_each_entry_safe(rq, next, &q->requeue_list, queuelist) {
> +		struct blk_mq_ctx *ctx;
> +
> +		ctx =3D rq->mq_ctx;
> +		hctx =3D blk_mq_map_queue(q, ctx->cpu);
> +		if (blk_mq_hctx_stopped(hctx)) {
> +			list_del_init(&rq->queuelist);
> +
> +			spin_lock(&hctx->lock);
> +			list_add_tail(&rq->queuelist, &rq_list);
> +			spin_unlock(&hctx->lock);
> +		}
> +	}
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		if (!blk_mq_hctx_stopped(hctx))
> +			continue;
> +
> +		flush_busy_ctxs(hctx, &rq_list);
> +
> +		spin_lock(&hctx->lock);
> +		if (!list_empty(&hctx->dispatch))
> +			list_splice_init(&hctx->dispatch, &rq_list);
> +		spin_unlock(&hctx->lock);
> +	}
> +	spin_unlock(&q->requeue_lock);
> +
> +	while (!list_empty(&rq_list)) {
> +		rq =3D list_first_entry(&rq_list, struct request, queuelist);
> +		list_del_init(&rq->queuelist);
> +		rq->errors =3D -EAGAIN;
> +		blk_mq_end_request(rq, rq->errors);
> +	}
> +}

Hello Keith,

This patch adds a second code path to the blk-mq core for running queues an=
d
hence will make the blk-mq core harder to maintain. Have you considered to
implement this functionality by introducing a new "fail all requests" flag
for hctx queues such that blk_mq_abandon_stopped_requests() can reuse the
existing mechanism for running a queue?

Bart.
