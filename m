Return-Path: <ming.lei@redhat.com>
Date: Mon, 22 Oct 2018 17:06:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, tom.leiming@gmail.com,
	hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] block: fix the DISCARD request merge
Message-ID: <20181022090601.GA21171@ming.t460p>
References: <1540045777-10290-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1540045777-10290-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, Oct 20, 2018 at 10:29:37PM +0800, Jianchao Wang wrote:
> There are two cases when handle DISCARD merge
>  - max_discard_segments == 1
>    bios need to be contiguous
>  - max_discard_segments > 1
>    Only nvme right now. It takes every bio as a range and different
>    range needn't to be contiguous.
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
> V2:
>   - Add max_discard_segments > 1 checking in attempt_merge
>   - Change patch title and comment
>   - Add more comment in attempt_merge
> 
>  block/blk-merge.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 42a4674..8f22374 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -734,8 +734,15 @@ static struct request *attempt_merge(struct request_queue *q,
>  	/*
>  	 * not contiguous
>  	 */
> -	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
> -		return NULL;
> +	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next)) {
> +		/*
> +		 * When max_discard_segments is bigger than 1 (only nvme right
> +		 * now), needn't consider the contiguity.
> +		 */
> +		if (!(req_op(req) == REQ_OP_DISCARD &&
> +		      queue_max_discard_segments(q) > 1))
> +			return NULL;
> +	}
>  
>  	if (rq_data_dir(req) != rq_data_dir(next)
>  	    || req->rq_disk != next->rq_disk
> @@ -757,10 +764,17 @@ static struct request *attempt_merge(struct request_queue *q,
>  	 * If we are allowed to merge, then append bio list
>  	 * from next to rq and release next. merge_requests_fn
>  	 * will have updated segment counts, update sector
> -	 * counts here. Handle DISCARDs separately, as they
> -	 * have separate settings.
> +	 * counts here.
> +	 * Two cases of Handling DISCARD:
> +	 *  - max_discard_segments == 1
> +	 *    The bios need to be contiguous.
> +	 *  - max_discard_segments > 1
> +	 *    Only nvme right now. It takes every bio as a
> +	 *    range and send them to controller together. The ranges
> +	 *    needn't to be contiguous.
>  	 */
> -	if (req_op(req) == REQ_OP_DISCARD) {
> +	if (req_op(req) == REQ_OP_DISCARD &&
> +	    queue_max_discard_segments(q) > 1) {
>  		if (!req_attempt_discard_merge(q, req, next))
>  			return NULL;

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

The above may be changed to 'if (blk_try_merge(req) == ELEVATOR_DISCARD_MERGE)'
or sort of in future, which may has document benefit at least, since
ELEVATOR_DISCARD_MERGE means multi-segment discard merge.


Thanks,
Ming
