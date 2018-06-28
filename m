Return-Path: <kashyap.desai@broadcom.com>
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <20180628031918.17694-1-ming.lei@redhat.com> <318a4d1724afae4dddbf39c55860278b@mail.gmail.com>
 <6683279e-7703-f8d3-bf97-67edcd6f2680@oracle.com> <20180628070801.GA20248@ming.t460p>
In-Reply-To: <20180628070801.GA20248@ming.t460p>
MIME-Version: 1.0
Date: Thu, 28 Jun 2018 13:10:50 +0530
Message-ID: <621ef8556c7e2ebade630c42bf8ea920@mail.gmail.com>
Subject: RE: [PATCH 0/3] blk-mq: improve IO perf in case of none io sched
To: Ming Lei <ming.lei@redhat.com>, "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>, Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

> Right.
>
> Kashyap, could you test the following patch?
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2f20c9e3efda..7d972b1c3153 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1567,7 +1567,7 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx
> *hctx, struct blk_mq_ctx *ctx,
>  	}
>
>  	spin_lock(&ctx->lock);
> -	list_splice_tail(list, &ctx->rq_list);
> +	list_splice_tail_init(list, &ctx->rq_list);
>  	blk_mq_hctx_mark_pending(hctx, ctx);
>  	spin_unlock(&ctx->lock);

I tested above mentioned change and kernel panic as posted in this
discussion is resolved.

Kashyap

>  }
>
> Thanks,
> Ming
