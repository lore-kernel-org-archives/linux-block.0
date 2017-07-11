Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46350 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932750AbdGKUSz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2017 16:18:55 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 3/6] blk-mq: send the request to dispatch list if direct
 issue returns busy
Date: Tue, 11 Jul 2017 20:18:51 +0000
Message-ID: <1499804330.2586.32.camel@wdc.com>
References: <20170711182103.11461-1-ming.lei@redhat.com>
         <20170711182103.11461-4-ming.lei@redhat.com>
In-Reply-To: <20170711182103.11461-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-07-12 at 02:21 +0800, Ming Lei wrote:
> Before mq IO scheduler is in, we always send the request to
> dispatch list if .queue_rq() return busy. After mq IO scheduler
> is introduced, we only do this way when scheduler is used in
> case of direct issue. Actually we can do that when scheduler
> isn't used too.
>=20
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 041f7b7fa0d6..6e0fc80aa151 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1463,6 +1463,16 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_c=
tx *hctx, struct request *rq)
>  	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
>  }
> =20
> +static void blk_mq_direct_dispatch(struct blk_mq_hw_ctx *hctx,
> +				   struct request *rq)
> +{
> +	spin_lock(&hctx->lock);
> +	list_add(&rq->queuelist, &hctx->dispatch);
> +	spin_unlock(&hctx->lock);
> +
> +	blk_mq_run_hw_queue(hctx, false);
> +}
> +
>  static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  					struct request *rq,
>  					blk_qc_t *cookie, bool may_sleep)
> @@ -1499,15 +1509,17 @@ static void __blk_mq_try_issue_directly(struct bl=
k_mq_hw_ctx *hctx,
>  	switch (ret) {
>  	case BLK_STS_OK:
>  		*cookie =3D new_cookie;
> -		return;
> +		break;
>  	case BLK_STS_RESOURCE:
>  		__blk_mq_requeue_request(rq);
> -		goto insert;
> +		blk_mq_direct_dispatch(hctx, rq);
> +		break;
>  	default:
>  		*cookie =3D BLK_QC_T_NONE;
>  		blk_mq_end_request(rq, ret);
> -		return;
> +		break;
>  	}
> +	return;
> =20
>  insert:
>  	blk_mq_sched_insert_request(rq, false, run_queue, false, may_sleep);

Hello Ming,

This patch changes the behavior of blk_mq_try_issue_directly() if a schedul=
er
has been configured and .queue_rq() returns BLK_STS_RESOURCE, namely by ski=
pping
the e->type->ops.mq.insert_requests() call. Sorry but I don't think this is=
 what
we want.

Bart.=
