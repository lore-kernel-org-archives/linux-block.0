Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V3] block: fix the DISCARD request merge
To: axboe@kernel.dk
Cc: martin.petersen@oracle.com, Ming Lei <ming.lei@redhat.com>, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540350450-15208-1-git-send-email-jianchao.w.wang@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <52d2e36c-ed62-151d-e070-7edd06bfc24d@oracle.com>
Date: Fri, 26 Oct 2018 16:05:00 +0800
MIME-Version: 1.0
In-Reply-To: <1540350450-15208-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Would anyone please take a look at this ?

Thanks in advance.
Jianchao

On 10/24/18 11:07 AM, Jianchao Wang wrote:
> There are two cases when handle DISCARD merge.
> If max_discard_segments == 1, the bios/requests need to be contiguous
> to merge. If max_discard_segments > 1, it takes every bio as a range
> and different range needn't to be contiguous.
> 
> But now, attempt_merge screws this up. It always consider contiguity
> for DISCARD for the case max_discard_segments > 1 and cannot merge
> contiguous DISCARD for the case max_discard_segments == 1, because
> rq_attempt_discard_merge always returns false in this case.
> This patch fixes both of the two cases above.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
> 
> V3:
>  - Introduce blk_discard_mergable into attempt_merge and
>    blk_try_merge.
>  - Some comment changes.
> 
> V2:
>  - Add max_discard_segments > 1 checking in attempt_merge.
>  - Change patch title and comment.
>  - Add more comment in attempt_merge
> 
>  block/blk-merge.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 42a4674..b258de0 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -714,6 +714,22 @@ static void blk_account_io_merge(struct request *req)
>  		part_stat_unlock();
>  	}
>  }
> +/*
> + * Two cases of handling DISCARD merge:
> + * If max_discard_segments > 1, the driver takes every bio
> + * as a range and send them to controller together. The ranges
> + * needn't to be contiguous.
> + * Otherwise, the bios/requests will be handled as same as
> + * others which should be contiguous.
> + */
> +static inline bool blk_discard_mergable(struct request *req)
> +{
> +	if (req_op(req) == REQ_OP_DISCARD &&
> +	    queue_max_discard_segments(req->q) > 1)
> +		return true;
> +	else
> +		return false;
> +}
>  
>  /*
>   * For non-mq, this has to be called with the request spinlock acquired.
> @@ -731,12 +747,6 @@ static struct request *attempt_merge(struct request_queue *q,
>  	if (req_op(req) != req_op(next))
>  		return NULL;
>  
> -	/*
> -	 * not contiguous
> -	 */
> -	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
> -		return NULL;
> -
>  	if (rq_data_dir(req) != rq_data_dir(next)
>  	    || req->rq_disk != next->rq_disk
>  	    || req_no_special_merge(next))
> @@ -760,11 +770,16 @@ static struct request *attempt_merge(struct request_queue *q,
>  	 * counts here. Handle DISCARDs separately, as they
>  	 * have separate settings.
>  	 */
> -	if (req_op(req) == REQ_OP_DISCARD) {
> +
> +	if (blk_discard_mergable(req)) {
>  		if (!req_attempt_discard_merge(q, req, next))
>  			return NULL;
> -	} else if (!ll_merge_requests_fn(q, req, next))
> +	} else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next)) {
> +		if (!ll_merge_requests_fn(q, req, next))
> +			return NULL;
> +	} else {
>  		return NULL;
> +	}
>  
>  	/*
>  	 * If failfast settings disagree or any of the two is already
> @@ -888,8 +903,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
>  
>  enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
>  {
> -	if (req_op(rq) == REQ_OP_DISCARD &&
> -	    queue_max_discard_segments(rq->q) > 1)
> +	if (blk_discard_mergable(rq))
>  		return ELEVATOR_DISCARD_MERGE;
>  	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
>  		return ELEVATOR_BACK_MERGE;
> 
