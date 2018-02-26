Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 26 Feb 2018 13:03:08 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc: hch@lst.de, Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, caspar@linux.alibaba.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 2/4] block: bio_check_eod() needs to consider partition
Message-ID: <20180226210308.GB9157@vader.DHCP.thefacebook.com>
References: <fc363a8d-957c-be3a-e60a-a8b40727d727@linux.alibaba.com>
 <9827cd58-0044-19a2-6bc1-bc4357ed846d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9827cd58-0044-19a2-6bc1-bc4357ed846d@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Feb 26, 2018 at 08:04:38PM +0800, Jiufei Xue wrote:
> bio_check_eod() should get the capacity of partiton, not the whole
> disk.
> 
> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
> ---
>  block/blk-core.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 6d82c4f..ef6677d 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2023,7 +2023,7 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
>  	return BLK_QC_T_NONE;
>  }
>  
> -static void handle_bad_sector(struct bio *bio)
> +static void handle_bad_sector(struct bio *bio, sector_t maxsector)
>  {
>  	char b[BDEVNAME_SIZE];
>  
> @@ -2031,7 +2031,7 @@ static void handle_bad_sector(struct bio *bio)
>  	printk(KERN_INFO "%s: rw=%d, want=%Lu, limit=%Lu\n",
>  			bio_devname(bio, b), bio->bi_opf,
>  			(unsigned long long)bio_end_sector(bio),
> -			(long long)get_capacity(bio->bi_disk));
> +			(long long)maxsector);
>  }
>  
>  #ifdef CONFIG_FAIL_MAKE_REQUEST
> @@ -2131,12 +2131,20 @@ static inline int blk_partition_remap(struct bio *bio)
>  static inline int bio_check_eod(struct bio *bio, unsigned int nr_sectors)
>  {
>  	sector_t maxsector;
> +	struct hd_struct *part;
>  
>  	if (!nr_sectors)
>  		return 0;
>  
>  	/* Test device or partition size, when known. */
> -	maxsector = get_capacity(bio->bi_disk);
> +	rcu_read_lock();
> +	part = __disk_get_part(bio->bi_disk, bio->bi_partno);
> +	if (part)
> +		maxsector = part_nr_sects_read(part);
> +	else
> +		maxsector = get_capacity(bio->bi_disk);

This case means that bio->bi_partno was invalid, right? Shouldn't this
be an error? I see that this is copied from guard_bio_eod(), but that
serves a slightly different purpose.

> +	rcu_read_unlock();
> +
>  	if (maxsector) {
>  		sector_t sector = bio->bi_iter.bi_sector;
>  
> @@ -2146,7 +2154,7 @@ static inline int bio_check_eod(struct bio *bio, unsigned int nr_sectors)
>  			 * without checking the size of the device, e.g., when
>  			 * mounting a device.
>  			 */
> -			handle_bad_sector(bio);
> +			handle_bad_sector(bio, maxsector);
>  			return 1;
>  		}
>  	}
> -- 
> 1.9.4
> 
> 
