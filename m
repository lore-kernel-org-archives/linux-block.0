Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Tue, 8 Aug 2017 15:46:37 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, brking@linux.vnet.ibm.com,
	bart.vanassche@wdc.com
Subject: Re: [PATCH 4/6] blk-mq: provide internal in-flight variant
Message-ID: <20170808224637.GF4072@vader.DHCP.thefacebook.com>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
 <1501859062-11120-5-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501859062-11120-5-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 04, 2017 at 09:04:20AM -0600, Jens Axboe wrote:
> We don't have to inc/dec some counter, since we can just
> iterate the tags. That makes inc/dec a noop, but means we
> have to iterate busy tags to get an in-flight count.
>
> Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>

Barring performance numbers that show that percpu is much better (which
I doubt),

Reviewed-by: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c        | 31 +++++++++++++++++++++++++++++++
>  block/blk-mq.h        |  3 +++
>  block/genhd.c         | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/genhd.h | 34 ++++++----------------------------
>  4 files changed, 77 insertions(+), 28 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a5d369dc7622..fe1aa1f5f069 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -83,6 +83,37 @@ static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
>  	sbitmap_clear_bit(&hctx->ctx_map, ctx->index_hw);
>  }
>  
> +struct mq_inflight {
> +	struct hd_struct *part;
> +	unsigned int *inflight;
> +};
> +
> +static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
> +				  struct request *rq, void *priv,
> +				  bool reserved)
> +{
> +	struct mq_inflight *mi = priv;
> +
> +	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
> +		return;
> +
> +	/*
> +	 * Count as inflight if it either matches the partition we asked
> +	 * for, or if it's the root
> +	 */
> +	if (rq->part == mi->part || mi->part->partno)
> +		mi->inflight[0]++;
> +}
> +
> +void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
> +		      unsigned int inflight[2])
> +{
> +	struct mq_inflight mi = { .part = part, .inflight = inflight, };
> +
> +	inflight[0] = 0;
> +	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
> +}
> +
>  void blk_freeze_queue_start(struct request_queue *q)
>  {
>  	int freeze_depth;
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 60b01c0309bc..98252b79b80b 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -133,4 +133,7 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
>  	return hctx->nr_ctx && hctx->tags;
>  }
>  
> +void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
> +			unsigned int inflight[2]);
> +
>  #endif
> diff --git a/block/genhd.c b/block/genhd.c
> index 822f65f95e2a..3dc4d115480f 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -45,6 +45,43 @@ static void disk_add_events(struct gendisk *disk);
>  static void disk_del_events(struct gendisk *disk);
>  static void disk_release_events(struct gendisk *disk);
>  
> +void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
> +{
> +	if (q->mq_ops)
> +		return;
> +
> +	atomic_inc(&part->in_flight[rw]);
> +	if (part->partno)
> +		atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
> +}
> +
> +void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
> +{
> +	if (q->mq_ops)
> +		return;
> +
> +	atomic_dec(&part->in_flight[rw]);
> +	if (part->partno)
> +		atomic_dec(&part_to_disk(part)->part0.in_flight[rw]);
> +}
> +
> +void part_in_flight(struct request_queue *q, struct hd_struct *part,
> +		    unsigned int inflight[2])
> +{
> +	if (q->mq_ops) {
> +		blk_mq_in_flight(q, part, inflight);
> +		return;
> +	}
> +
> +	inflight[0] = atomic_read(&part->in_flight[0]) +
> +			atomic_read(&part->in_flight[1]);
> +	if (part->partno) {
> +		part = &part_to_disk(part)->part0;
> +		inflight[1] = atomic_read(&part->in_flight[0]) +
> +				atomic_read(&part->in_flight[1]);
> +	}
> +}
> +
>  /**
>   * disk_get_part - get partition
>   * @disk: disk to look partition from
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index a9c8ea632fdc..ea652bfcd675 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -362,34 +362,12 @@ static inline void free_part_stats(struct hd_struct *part)
>  #define part_stat_sub(cpu, gendiskp, field, subnd)			\
>  	part_stat_add(cpu, gendiskp, field, -subnd)
>  
> -static inline void part_inc_in_flight(struct request_queue *q,
> -				      struct hd_struct *part, int rw)
> -{
> -	atomic_inc(&part->in_flight[rw]);
> -	if (part->partno)
> -		atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
> -}
> -
> -static inline void part_dec_in_flight(struct request_queue *q,
> -				      struct hd_struct *part, int rw)
> -{
> -	atomic_dec(&part->in_flight[rw]);
> -	if (part->partno)
> -		atomic_dec(&part_to_disk(part)->part0.in_flight[rw]);
> -}
> -
> -static inline void part_in_flight(struct request_queue *q,
> -				  struct hd_struct *part,
> -				  unsigned int inflight[2])
> -{
> -	inflight[0] = atomic_read(&part->in_flight[0]) +
> -			atomic_read(&part->in_flight[1]);
> -	if (part->partno) {
> -		part = &part_to_disk(part)->part0;
> -		inflight[1] = atomic_read(&part->in_flight[0]) +
> -				atomic_read(&part->in_flight[1]);
> -	}
> -}
> +void part_in_flight(struct request_queue *q, struct hd_struct *part,
> +			unsigned int inflight[2]);
> +void part_dec_in_flight(struct request_queue *q, struct hd_struct *part,
> +			int rw);
> +void part_inc_in_flight(struct request_queue *q, struct hd_struct *part,
> +			int rw);
>  
>  static inline struct partition_meta_info *alloc_part_info(struct gendisk *disk)
>  {
> -- 
> 2.7.4
> 
