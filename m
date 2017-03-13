Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/4] blk-mq: merge mq and sq make_request instances
Date: Mon, 13 Mar 2017 21:01:08 +0000
Message-ID: <1489438828.2658.23.camel@sandisk.com>
References: <20170313154833.14165-1-hch@lst.de>
	 <20170313154833.14165-3-hch@lst.de>
In-Reply-To: <20170313154833.14165-3-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-03-13 at 09:48 -0600, Christoph Hellwig wrote:
> @@ -1534,7 +1529,36 @@ static blk_qc_t blk_mq_make_request(struct request=
_queue *q, struct bio *bio)
>  	}
> =20
>  	plug =3D current->plug;
> -	if (((plug && !blk_queue_nomerges(q)) || is_sync)) {
> +	if (plug && q->nr_hw_queues =3D=3D 1) {
> +		struct request *last =3D NULL;
> +
> +		blk_mq_bio_to_request(rq, bio);
> +
> +		/*
> +		 * @request_count may become stale because of schedule
> +		 * out, so check the list again.
> +		 */

The above comment was relevant as long as there was a request_count assignm=
ent
above blk_mq_sched_get_request(). This patch moves that assignment inside i=
f
(plug && q->nr_hw_queues =3D=3D 1). Does that mean that the above comment s=
hould be
removed entirely?

> +		if (list_empty(&plug->mq_list))
> +			request_count =3D 0;
> +		else if (blk_queue_nomerges(q))
> +			request_count =3D blk_plug_queued_count(q);
> +
> +		if (!request_count)
> +			trace_block_plug(q);
> +		else
> +			last =3D list_entry_rq(plug->mq_list.prev);
> +
> +		blk_mq_put_ctx(data.ctx);
> +
> +		if (request_count >=3D BLK_MAX_REQUEST_COUNT || (last &&
> +		    blk_rq_bytes(last) >=3D BLK_PLUG_FLUSH_SIZE)) {
> +			blk_flush_plug_list(plug, false);
> +			trace_block_plug(q);
> +		}
> +
> +		list_add_tail(&rq->queuelist, &plug->mq_list);
> +		goto done;
> +	} else if (((plug && !blk_queue_nomerges(q)) || is_sync)) {
>  		struct request *old_rq =3D NULL;
> =20
>  		blk_mq_bio_to_request(rq, bio);

Bart.=
