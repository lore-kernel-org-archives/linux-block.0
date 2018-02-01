Return-Path: <keith.busch@intel.com>
Date: Thu, 1 Feb 2018 11:12:09 -0700
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: WARNING: CPU: 2 PID: 207 at drivers/nvme/host/core.c:527
 nvme_setup_cmd+0x3d3
Message-ID: <20180201181208.GB24417@localhost.localdomain>
References: <45f93661-da0d-94c5-1740-85242df8776e@kernel.dk>
 <0872b361-157b-a876-20af-3d7a4ee7ff31@kernel.dk>
 <8fd916ab-42d7-c654-5a01-8f1eb4be730e@oracle.com>
 <0b7686b3-f716-49ba-c7c4-929d84905569@kernel.dk>
 <7459ffed-c63c-38a9-84f5-456c2a5c4fe0@oracle.com>
 <0f6c248b-eb67-9b02-a4b9-0366d476e70d@kernel.dk>
 <20180201045645.GF27735@localhost.localdomain>
 <576ba7dc-78cf-b5d2-d1de-446d1f4b2732@kernel.dk>
 <7ec361a3-8900-d259-6842-e0b0b14a253a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7ec361a3-8900-d259-6842-e0b0b14a253a@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Feb 01, 2018 at 10:58:23AM -0700, Jens Axboe wrote:
> I was able to reproduce on a test box, pretty trivially in fact:
> 
> # echo mq-deadline > /sys/block/nvme2n1/queue/scheduler
> # mkfs.ext4 /dev/nvme2n1
> # mount /dev/nvme2n1 /data -o discard
> # dd if=/dev/zero of=/data/10g bs=1M count=10k
> # sync
> # rm /data/10g
> # sync <- triggered

Nice! Thanks, this recipe works for me too.
 
> Your patch still doesn't work, but mainly because we init the segments
> to 0 when setting up a discard. The below works for me, and cleans up
> the merge path a bit, since your patch was missing various adjustments
> on both the merged and freed request.

Yep, your update is very similiar to my real patch, but I'm missing one
thing (elv_merge_requests). If you're already testing successfully with
your patch, I don't mind if you want to move forward with yours.

 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index a2005a485335..e4561c95fc23 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -3282,6 +3282,8 @@ void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
>  {
>  	if (bio_has_data(bio))
>  		rq->nr_phys_segments = bio_phys_segments(q, bio);
> +	else if (bio_op(bio) == REQ_OP_DISCARD)
> +		rq->nr_phys_segments = 1;
>  
>  	rq->__data_len = bio->bi_iter.bi_size;
>  	rq->bio = rq->biotail = bio;
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 8452fc7164cc..782940c65d8a 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -550,6 +550,24 @@ static bool req_no_special_merge(struct request *req)
>  	return !q->mq_ops && req->special;
>  }
>  
> +static bool req_attempt_discard_merge(struct request_queue *q, struct request *req,
> +		struct request *next)
> +{
> +	unsigned short segments = blk_rq_nr_discard_segments(req);
> +
> +	if (segments >= queue_max_discard_segments(q))
> +		goto no_merge;
> +	if (blk_rq_sectors(req) + bio_sectors(next->bio) >
> +	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
> +		goto no_merge;
> +
> +	req->nr_phys_segments = segments + blk_rq_nr_discard_segments(next);
> +	return true;
> +no_merge:
> +	req_set_nomerge(q, req);
> +	return false;
> +}
> +
>  static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
>  				struct request *next)
>  {
> @@ -683,9 +701,13 @@ static struct request *attempt_merge(struct request_queue *q,
>  	 * If we are allowed to merge, then append bio list
>  	 * from next to rq and release next. merge_requests_fn
>  	 * will have updated segment counts, update sector
> -	 * counts here.
> +	 * counts here. Handle DISCARDs separately, as they
> +	 * have separate settings.
>  	 */
> -	if (!ll_merge_requests_fn(q, req, next))
> +	if (req_op(req) == REQ_OP_DISCARD) {
> +		if (!req_attempt_discard_merge(q, req, next))
> +			return NULL;
> +	} else if (!ll_merge_requests_fn(q, req, next))
>  		return NULL;
>  
>  	/*
> @@ -715,7 +737,8 @@ static struct request *attempt_merge(struct request_queue *q,
>  
>  	req->__data_len += blk_rq_bytes(next);
>  
> -	elv_merge_requests(q, req, next);
> +	if (req_op(req) != REQ_OP_DISCARD)
> +		elv_merge_requests(q, req, next);
>  
>  	/*
>  	 * 'next' is going away, so update stats accordingly
> 
> -- 
> Jens Axboe
> 
