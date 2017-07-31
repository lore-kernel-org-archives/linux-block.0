Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:38379 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdGaXKZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2017 19:10:25 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH 03/14] blk-mq: introduce blk_mq_dispatch_rq_from_ctxs()
Date: Mon, 31 Jul 2017 23:09:38 +0000
Message-ID: <1501542577.2466.26.camel@wdc.com>
References: <20170731165111.11536-1-ming.lei@redhat.com>
         <20170731165111.11536-5-ming.lei@redhat.com>
In-Reply-To: <20170731165111.11536-5-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2017-08-01 at 00:51 +0800, Ming Lei wrote:
> @@ -810,7 +810,11 @@ static void blk_mq_timeout_work(struct work_struct *=
work)
> =20
>  struct ctx_iter_data {
>  	struct blk_mq_hw_ctx *hctx;
> -	struct list_head *list;
> +
> +	union {
> +		struct list_head *list;
> +		struct request *rq;
> +	};
>  };

Hello Ming,

Please introduce a new data structure for dispatch_rq_from_ctx() /
blk_mq_dispatch_rq_from_ctxs() instead of introducing a union in struct
ctx_iter_data. That will avoid that .list can be used in a context where
a struct request * pointer has been stored in the structure and vice versa.
=20
>  static bool flush_busy_ctx(struct sbitmap *sb, unsigned int bitnr, void =
*data)
> @@ -826,6 +830,26 @@ static bool flush_busy_ctx(struct sbitmap *sb, unsig=
ned int bitnr, void *data)
>  	return true;
>  }
> =20
> +static bool dispatch_rq_from_ctx(struct sbitmap *sb, unsigned int bitnr,=
 void *data)
> +{
> +	struct ctx_iter_data *dispatch_data =3D data;
> +	struct blk_mq_hw_ctx *hctx =3D dispatch_data->hctx;
> +	struct blk_mq_ctx *ctx =3D hctx->ctxs[bitnr];
> +	bool empty =3D true;
> +
> +	spin_lock(&ctx->lock);
> +	if (unlikely(!list_empty(&ctx->rq_list))) {
> +		dispatch_data->rq =3D list_entry_rq(ctx->rq_list.next);
> +		list_del_init(&dispatch_data->rq->queuelist);
> +		empty =3D list_empty(&ctx->rq_list);
> +	}
> +	spin_unlock(&ctx->lock);
> +	if (empty)
> +		sbitmap_clear_bit(sb, bitnr);

This sbitmap_clear_bit() occurs without holding blk_mq_ctx.lock. Sorry but
I don't think this is safe. Please either remove this sbitmap_clear_bit() c=
all
or make sure that it happens with blk_mq_ctx.lock held.

Thanks,

Bart.=
