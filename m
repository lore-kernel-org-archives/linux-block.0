Return-Path: <kashyap.desai@broadcom.com>
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <20180628031918.17694-1-ming.lei@redhat.com> <318a4d1724afae4dddbf39c55860278b@mail.gmail.com>
 <6683279e-7703-f8d3-bf97-67edcd6f2680@oracle.com>
In-Reply-To: <6683279e-7703-f8d3-bf97-67edcd6f2680@oracle.com>
MIME-Version: 1.0
Date: Thu, 28 Jun 2018 12:05:09 +0530
Message-ID: <4a646f076f03e328fadc648931fd297b@mail.gmail.com>
Subject: RE: [PATCH 0/3] blk-mq: improve IO perf in case of none io sched
To: "jianchao.wang" <jianchao.w.wang@oracle.com>, Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

>
> I guess we need to clean list after list_splice_tail in the 1/1 patch as
> following
> @@ -1533,19 +1533,19 @@ void blk_mq_insert_requests(struct
> blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
>  			    struct list_head *list)
>
>  {
> ...
> +
> +	spin_lock(&ctx->lock);
> +	list_splice_tail(list, &ctx->rq_list);
> +       INIT_LIST_HEAD(list);          // ---> HERE !

I will try replacing " list_splice_tail" with " list_splice_tail_init"

Kashyap

>  	blk_mq_hctx_mark_pending(hctx, ctx);
>  	spin_unlock(&ctx->lock);
>
> Thanks
> Jianchao
