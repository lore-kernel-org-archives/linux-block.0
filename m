Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/4] blk-mq: streamline blk_mq_make_request
Date: Tue, 14 Mar 2017 15:40:44 +0000
Message-ID: <1489506031.2676.1.camel@sandisk.com>
References: <20170313154833.14165-1-hch@lst.de>
	 <20170313154833.14165-5-hch@lst.de>
In-Reply-To: <20170313154833.14165-5-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-03-13 at 09:48 -0600, Christoph Hellwig wrote:
> Turn the different ways of merging or issuing I/O into a series of if/els=
e
> statements instead of the current maze of gotos.  Note that this means we
> pin the CPU a little longer for some cases as the CTX put is moved to
> common code at the end of the function.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c | 67 +++++++++++++++++++++++-----------------------------=
------
>  1 file changed, 27 insertions(+), 40 deletions(-)
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 48748cb799ed..18e449cc832f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1534,16 +1534,17 @@ static blk_qc_t blk_mq_make_request(struct reques=
t_queue *q, struct bio *bio)
> =20
>  	cookie =3D request_to_qc_t(data.hctx, rq);
> =20
> +	plug =3D current->plug;
>  	if (unlikely(is_flush_fua)) {
> -		if (q->elevator)
> -			goto elv_insert;
>  		blk_mq_bio_to_request(rq, bio);
> -		blk_insert_flush(rq);
> -		goto run_queue;
> -	}
> -
> -	plug =3D current->plug;
> -	if (plug && q->nr_hw_queues =3D=3D 1) {
> +		if (q->elevator) {
> +			blk_mq_sched_insert_request(rq, false, true,
> +						!is_sync || is_flush_fua, true);
> +		} else {
> +			blk_insert_flush(rq);
> +			blk_mq_run_hw_queue(data.hctx, !is_sync || is_flush_fua);
> +		}
> +	} else if (plug && q->nr_hw_queues =3D=3D 1) {
>  		struct request *last =3D NULL;
> =20
>  		blk_mq_bio_to_request(rq, bio);

This change introduces the following construct:

if (is_flush_fua) {
	/* use is_flush_fua */
} else ...

Have you considered to simplify the code that uses is_flush_fua further?

> @@ -1562,8 +1563,6 @@ static blk_qc_t blk_mq_make_request(struct request_=
queue *q, struct bio *bio)
>  		else
>  			last =3D list_entry_rq(plug->mq_list.prev);
> =20
> -		blk_mq_put_ctx(data.ctx);
> -
>  		if (request_count >=3D BLK_MAX_REQUEST_COUNT || (last &&
>  		    blk_rq_bytes(last) >=3D BLK_PLUG_FLUSH_SIZE)) {
>  			blk_flush_plug_list(plug, false);
> @@ -1571,56 +1570,44 @@ static blk_qc_t blk_mq_make_request(struct reques=
t_queue *q, struct bio *bio)
>  		}
> =20
>  		list_add_tail(&rq->queuelist, &plug->mq_list);
> -		goto done;
> -	} else if (((plug && !blk_queue_nomerges(q)) || is_sync)) {
> -		struct request *old_rq =3D NULL;
> -
> +	} else if (plug && !blk_queue_nomerges(q)) {
>  		blk_mq_bio_to_request(rq, bio);
> =20
>  		/*
>  		 * We do limited plugging. If the bio can be merged, do that.
>  		 * Otherwise the existing request in the plug list will be
>  		 * issued. So the plug list will have one request at most
> +		 *
> +		 * The plug list might get flushed before this. If that happens,
> +		 * the plug list is emptry and same_queue_rq is invalid.
>  		 */

"emptry" looks like a typo?

> -		if (plug) {
> -			/*
> -			 * The plug list might get flushed before this. If that
> -			 * happens, same_queue_rq is invalid and plug list is
> -			 * empty
> -			 */
> -			if (same_queue_rq && !list_empty(&plug->mq_list)) {
> -				old_rq =3D same_queue_rq;
> -				list_del_init(&old_rq->queuelist);
> -			}
> -			list_add_tail(&rq->queuelist, &plug->mq_list);
> -		} else /* is_sync */
> -			old_rq =3D rq;
> -		blk_mq_put_ctx(data.ctx);
> -		if (old_rq)
> -			blk_mq_try_issue_directly(data.hctx, old_rq, &cookie);
> -		goto done;
> -	}
> +		if (!list_empty(&plug->mq_list))
> +			list_del_init(&same_queue_rq->queuelist);
> +		else
> +			same_queue_rq =3D NULL;
> =20
> -	if (q->elevator) {
> -elv_insert:
> -		blk_mq_put_ctx(data.ctx);
> +		list_add_tail(&rq->queuelist, &plug->mq_list);
> +		if (same_queue_rq)
> +			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
> +					&cookie);
> +	} else if (is_sync) {
> +		blk_mq_bio_to_request(rq, bio);
> +		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
> +	} else if (q->elevator) {
>  		blk_mq_bio_to_request(rq, bio);
>  		blk_mq_sched_insert_request(rq, false, true,
>  						!is_sync || is_flush_fua, true);
> -		goto done;
> -	}
> -	if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
> +	} else if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
>  		/*
>  		 * For a SYNC request, send it to the hardware immediately. For
>  		 * an ASYNC request, just ensure that we run it later on. The
>  		 * latter allows for merging opportunities and more efficient
>  		 * dispatching.
>  		 */
> -run_queue:
>  		blk_mq_run_hw_queue(data.hctx, !is_sync || is_flush_fua);
>  	}

Since this code occurs in the else branch of an if (is_flush_fua) statement=
,
can "|| is_flush_fua" be left out?

What I noticed while reviewing this patch is that there are multiple change=
s in
this patch: not only the goto statements have been eliminated but the old_r=
q
variable has been eliminated too. I think this patch would be easier to rev=
iew
if it would be split in three patches: one that removes the old_rq variable=
,
one that eliminates the goto statements and one that removes dead code.

Thanks,

Bart.=
