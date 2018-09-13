Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 12 Sep 2018 17:04:55 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [PATCH] null_blk: fix zoned support for non-rq based operation
Message-ID: <20180913000455.GC6052@vader>
References: <5be22cec-2a80-9e07-6fe6-d5886295e848@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5be22cec-2a80-9e07-6fe6-d5886295e848@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 12, 2018 at 04:15:28PM -0600, Jens Axboe wrote:
> The supported added for zones in null_blk seem to assume that
> only rq based operation is possible. But this depends on the
> queue_mode setting, if this is set to 0, then cmd->bio is what
> we need to be operating on. Right now any attempt to load null_blk
> with queue_mode=0 will insta-crash, since cmd->rq is NULL and
> null_handle_cmd() assumes it to always be set.
> 
> Make the zoned code deal with bio's instead, or pass in the
> appropriate sector/nr_sectors instead.
> 
> Fixes: ca4b2a011948 ("null_blk: add zone support")

I just added block/023 to blktests for this, so

Tested-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
> index d81781f22dba..34e0030f0592 100644
> --- a/drivers/block/null_blk.h
> +++ b/drivers/block/null_blk.h
> @@ -87,10 +87,10 @@ struct nullb {
>  #ifdef CONFIG_BLK_DEV_ZONED
>  int null_zone_init(struct nullb_device *dev);
>  void null_zone_exit(struct nullb_device *dev);
> -blk_status_t null_zone_report(struct nullb *nullb,
> -					    struct nullb_cmd *cmd);
> -void null_zone_write(struct nullb_cmd *cmd);
> -void null_zone_reset(struct nullb_cmd *cmd);
> +blk_status_t null_zone_report(struct nullb *nullb, struct bio *bio);
> +void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
> +			unsigned int nr_sectors);
> +void null_zone_reset(struct nullb_cmd *cmd, sector_t sector);
>  #else
>  static inline int null_zone_init(struct nullb_device *dev)
>  {
> @@ -98,11 +98,14 @@ static inline int null_zone_init(struct nullb_device *dev)
>  }
>  static inline void null_zone_exit(struct nullb_device *dev) {}
>  static inline blk_status_t null_zone_report(struct nullb *nullb,
> -					    struct nullb_cmd *cmd)
> +					    struct bio *bio)
>  {
>  	return BLK_STS_NOTSUPP;
>  }
> -static inline void null_zone_write(struct nullb_cmd *cmd) {}
> -static inline void null_zone_reset(struct nullb_cmd *cmd) {}
> +static inline void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
> +				   unsigned int nr_sectors)
> +{
> +}
> +static inline void null_zone_reset(struct nullb_cmd *cmd, sector_t sector) {}
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  #endif /* __NULL_BLK_H */
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
> index 6127e3ff7b4b..093b614d6524 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -1157,16 +1157,33 @@ static void null_restart_queue_async(struct nullb *nullb)
>  	}
>  }
>  
> +static bool cmd_report_zone(struct nullb *nullb, struct nullb_cmd *cmd)
> +{
> +	struct nullb_device *dev = cmd->nq->dev;
> +
> +	if (dev->queue_mode == NULL_Q_BIO) {
> +		if (bio_op(cmd->bio) == REQ_OP_ZONE_REPORT) {
> +			cmd->error = null_zone_report(nullb, cmd->bio);
> +			return true;
> +		}
> +	} else {
> +		if (req_op(cmd->rq) == REQ_OP_ZONE_REPORT) {
> +			cmd->error = null_zone_report(nullb, cmd->rq->bio);
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
>  {
>  	struct nullb_device *dev = cmd->nq->dev;
>  	struct nullb *nullb = dev->nullb;
>  	int err = 0;
>  
> -	if (req_op(cmd->rq) == REQ_OP_ZONE_REPORT) {
> -		cmd->error = null_zone_report(nullb, cmd);
> +	if (cmd_report_zone(nullb, cmd))
>  		goto out;
> -	}
>  
>  	if (test_bit(NULLB_DEV_FL_THROTTLED, &dev->flags)) {
>  		struct request *rq = cmd->rq;
> @@ -1234,10 +1251,24 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
>  	cmd->error = errno_to_blk_status(err);
>  
>  	if (!cmd->error && dev->zoned) {
> -		if (req_op(cmd->rq) == REQ_OP_WRITE)
> -			null_zone_write(cmd);
> -		else if (req_op(cmd->rq) == REQ_OP_ZONE_RESET)
> -			null_zone_reset(cmd);
> +		sector_t sector;
> +		unsigned int nr_sectors;
> +		int op;
> +
> +		if (dev->queue_mode == NULL_Q_BIO) {
> +			op = bio_op(cmd->bio);
> +			sector = cmd->bio->bi_iter.bi_sector;
> +			nr_sectors = cmd->bio->bi_iter.bi_size >> 9;
> +		} else {
> +			op = req_op(cmd->rq);
> +			sector = blk_rq_pos(cmd->rq);
> +			nr_sectors = blk_rq_sectors(cmd->rq);
> +		}
> +
> +		if (op == REQ_OP_WRITE)
> +			null_zone_write(cmd, sector, nr_sectors);
> +		else if (op == REQ_OP_ZONE_RESET)
> +			null_zone_reset(cmd, sector);
>  	}
>  out:
>  	/* Complete IO by inline, softirq or timer */
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
> index a979ca00d7be..7c6b86d98700 100644
> --- a/drivers/block/null_blk_zoned.c
> +++ b/drivers/block/null_blk_zoned.c
> @@ -48,8 +48,8 @@ void null_zone_exit(struct nullb_device *dev)
>  	kvfree(dev->zones);
>  }
>  
> -static void null_zone_fill_rq(struct nullb_device *dev, struct request *rq,
> -			      unsigned int zno, unsigned int nr_zones)
> +static void null_zone_fill_bio(struct nullb_device *dev, struct bio *bio,
> +			       unsigned int zno, unsigned int nr_zones)
>  {
>  	struct blk_zone_report_hdr *hdr = NULL;
>  	struct bio_vec bvec;
> @@ -57,7 +57,7 @@ static void null_zone_fill_rq(struct nullb_device *dev, struct request *rq,
>  	void *addr;
>  	unsigned int zones_to_cpy;
>  
> -	bio_for_each_segment(bvec, rq->bio, iter) {
> +	bio_for_each_segment(bvec, bio, iter) {
>  		addr = kmap_atomic(bvec.bv_page);
>  
>  		zones_to_cpy = bvec.bv_len / sizeof(struct blk_zone);
> @@ -84,29 +84,24 @@ static void null_zone_fill_rq(struct nullb_device *dev, struct request *rq,
>  	}
>  }
>  
> -blk_status_t null_zone_report(struct nullb *nullb,
> -				     struct nullb_cmd *cmd)
> +blk_status_t null_zone_report(struct nullb *nullb, struct bio *bio)
>  {
>  	struct nullb_device *dev = nullb->dev;
> -	struct request *rq = cmd->rq;
> -	unsigned int zno = null_zone_no(dev, blk_rq_pos(rq));
> +	unsigned int zno = null_zone_no(dev, bio->bi_iter.bi_sector);
>  	unsigned int nr_zones = dev->nr_zones - zno;
> -	unsigned int max_zones = (blk_rq_bytes(rq) /
> -					sizeof(struct blk_zone)) - 1;
> +	unsigned int max_zones;
>  
> +	max_zones = (bio->bi_iter.bi_size / sizeof(struct blk_zone)) - 1;
>  	nr_zones = min_t(unsigned int, nr_zones, max_zones);
> -
> -	null_zone_fill_rq(nullb->dev, rq, zno, nr_zones);
> +	null_zone_fill_bio(nullb->dev, bio, zno, nr_zones);
>  
>  	return BLK_STS_OK;
>  }
>  
> -void null_zone_write(struct nullb_cmd *cmd)
> +void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
> +		     unsigned int nr_sectors)
>  {
>  	struct nullb_device *dev = cmd->nq->dev;
> -	struct request *rq = cmd->rq;
> -	sector_t sector = blk_rq_pos(rq);
> -	unsigned int rq_sectors = blk_rq_sectors(rq);
>  	unsigned int zno = null_zone_no(dev, sector);
>  	struct blk_zone *zone = &dev->zones[zno];
>  
> @@ -118,7 +113,7 @@ void null_zone_write(struct nullb_cmd *cmd)
>  	case BLK_ZONE_COND_EMPTY:
>  	case BLK_ZONE_COND_IMP_OPEN:
>  		/* Writes must be at the write pointer position */
> -		if (blk_rq_pos(rq) != zone->wp) {
> +		if (sector != zone->wp) {
>  			cmd->error = BLK_STS_IOERR;
>  			break;
>  		}
> @@ -126,7 +121,7 @@ void null_zone_write(struct nullb_cmd *cmd)
>  		if (zone->cond == BLK_ZONE_COND_EMPTY)
>  			zone->cond = BLK_ZONE_COND_IMP_OPEN;
>  
> -		zone->wp += rq_sectors;
> +		zone->wp += nr_sectors;
>  		if (zone->wp == zone->start + zone->len)
>  			zone->cond = BLK_ZONE_COND_FULL;
>  		break;
> @@ -137,11 +132,10 @@ void null_zone_write(struct nullb_cmd *cmd)
>  	}
>  }
>  
> -void null_zone_reset(struct nullb_cmd *cmd)
> +void null_zone_reset(struct nullb_cmd *cmd, sector_t sector)
>  {
>  	struct nullb_device *dev = cmd->nq->dev;
> -	struct request *rq = cmd->rq;
> -	unsigned int zno = null_zone_no(dev, blk_rq_pos(rq));
> +	unsigned int zno = null_zone_no(dev, sector);
>  	struct blk_zone *zone = &dev->zones[zno];
>  
>  	zone->cond = BLK_ZONE_COND_EMPTY;
> 
> -- 
> Jens Axboe
> 
