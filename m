Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:62935 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967336AbdD1SJp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 14:09:45 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 3/4] blk-mq: use hw tag for scheduling if hw tag space is
 big enough
Date: Fri, 28 Apr 2017 18:09:40 +0000
Message-ID: <1493402979.2767.10.camel@sandisk.com>
References: <20170428151539.25514-1-ming.lei@redhat.com>
         <20170428151539.25514-4-ming.lei@redhat.com>
In-Reply-To: <20170428151539.25514-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-04-28 at 23:15 +0800, Ming Lei wrote:
> +static inline bool blk_mq_sched_may_use_hw_tag(struct request_queue *q)
> +{
> +	if (q->tag_set->flags & BLK_MQ_F_TAG_SHARED)
> +		return false;
> +
> +	if (blk_mq_get_queue_depth(q) < q->nr_requests)
> +		return false;
> +
> +	return true;
> +}

The only user of shared tag sets I know of is scsi-mq. I think it's really
unfortunate that this patch systematically disables BLK_MQ_F_SCHED_USE_HW_T=
AG
for scsi-mq.

>  int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>  {
>  	struct blk_mq_tag_set *set =3D q->tag_set;
> @@ -2681,9 +2694,12 @@ int blk_mq_update_nr_requests(struct request_queue=
 *q, unsigned int nr)
>  			break;
>  	}
> =20
> -	if (!ret)
> +	if (!ret) {
>  		q->nr_requests =3D nr;
> =20
> +		blk_mq_update_sched_flag(q);
> +	}
> +
>  	blk_mq_unfreeze_queue(q);
>  	blk_mq_start_stopped_hw_queues(q, true);

If a queue is created with a low value of nr_requests that will cause
blk_mq_sched_alloc_tags() to skip allocation of .sched_tags. If nr_requests
is increased, can that cause this function to clear BLK_MQ_F_SCHED_USE_HW_T=
AG
while keeping hctx->sched_tags =3D=3D NULL and hence trigger a NULL pointer
dereference?

Bart.
