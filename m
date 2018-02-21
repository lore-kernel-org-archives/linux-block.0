Return-Path: <bo.li.liu@oracle.com>
Date: Wed, 21 Feb 2018 15:54:12 -0700
From: Liu Bo <bo.li.liu@oracle.com>
To: xuejiufei <jiufei.xue@linux.alibaba.com>
Cc: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, caspar@linux.alibaba.com
Subject: Re: [PATCH RESEND] blk-throttle: avoid double counted
Message-ID: <20180221225412.GA15815@dhcp-10-211-47-181.usdhcp.oraclecorp.com>
Reply-To: bo.li.liu@oracle.com
References: <b802b5e4-b5ed-b09f-8da9-9a4823434015@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b802b5e4-b5ed-b09f-8da9-9a4823434015@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 14, 2018 at 11:22:10AM +0800, xuejiufei wrote:
> If a bio is split after counted to the stat_bytes and stat_ios in
> blkcg_bio_issue_check(), the bio could be resubmitted and enters the
> block throttle layer again. This will cause the part of the bio is
> counted twice.
> 
> The flag BIO_THROTTLED can not be used to fix this problem considering the
> following two cases.
> 1. The bio is throttled and resubmitted to the block throttle layer. It
> has the flag BIO_THROTTLED and should be counted.
> 2. The bio can be dispatched and has been counted, then it is split
> and resubmitted to the block throttle layer. It also has the flag
> BIO_THROTTLED but should not be counted again.
> 
> So we add another flag BIO_THROTL_COUNTED to avoid double counted.
>

The patch looks good and safe to me.

Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Tested-by: Liu Bo <bo.li.liu@oracle.com>

Verified with the following steps:

# mount -t cgroup -o blkio xxx /mnt/liubo
# mkdir /mnt/liubo/test
# echo 0 > /mnt/liubo/test/tasks
# echo 1 > /mnt/liubo/test/blkio.reset_stats
# xfs_io -f -d -c "pwrite -b 2M 0 2M" /mnt/btrfs/foobar

- w/o the patch (only device of interest 8:128 is shown),
# cat /mnt/liubo/test/blkio.throttle.io_serviced
8:128 Read 0
8:128 Write 3
8:128 Sync 3
8:128 Async 0
8:128 Total 3
Total 3
# cat /mnt/liubo/test/blkio.throttle.io_service_bytes                                                                
8:128 Read 0
8:128 Write 3948544
8:128 Sync 3948544
8:128 Async 0
8:128 Total 3948544
Total 3948544

(also verified by blktrace about the split, 2M was split into 504K +
1280K + 264K.)

- w/ the patch,
# cat /mnt/liubo/test/blkio.throttle.io_serviced
8:128 Read 0
8:128 Write 1
8:128 Sync 1
8:128 Async 0
8:128 Total 1
Total 5
# cat /mnt/liubo/test/blkio.throttle.io_service_bytes
8:128 Read 0
8:128 Write 2097152
8:128 Sync 2097152
8:128 Async 0
8:128 Total 2097152


Thanks,

-liubo


> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
> ---
>  block/bio.c                | 2 ++
>  include/linux/bio.h        | 6 ++++--
>  include/linux/blk-cgroup.h | 3 ++-
>  include/linux/blk_types.h  | 1 +
>  4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 9ef6cf3..4594c2e 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -601,6 +601,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
>  	bio_set_flag(bio, BIO_CLONED);
>  	if (bio_flagged(bio_src, BIO_THROTTLED))
>  		bio_set_flag(bio, BIO_THROTTLED);
> +	if (bio_flagged(bio_src, BIO_THROTL_COUNTED))
> +		bio_set_flag(bio, BIO_THROTL_COUNTED);
>  	bio->bi_opf = bio_src->bi_opf;
>  	bio->bi_write_hint = bio_src->bi_write_hint;
>  	bio->bi_iter = bio_src->bi_iter;
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 23d29b3..aefc24c 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -492,8 +492,10 @@ extern struct bio *bio_copy_user_iov(struct request_queue *,
>  
>  #define bio_set_dev(bio, bdev) 			\
>  do {						\
> -	if ((bio)->bi_disk != (bdev)->bd_disk)	\
> -		bio_clear_flag(bio, BIO_THROTTLED);\
> +	if ((bio)->bi_disk != (bdev)->bd_disk)	{	\
> +		bio_clear_flag(bio, BIO_THROTTLED);	\
> +		bio_clear_flag(bio, BIO_THROTL_COUNTED);\
> +	}					\
>  	(bio)->bi_disk = (bdev)->bd_disk;	\
>  	(bio)->bi_partno = (bdev)->bd_partno;	\
>  } while (0)
> diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
> index e9825ff..c151bc9 100644
> --- a/include/linux/blk-cgroup.h
> +++ b/include/linux/blk-cgroup.h
> @@ -701,11 +701,12 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
>  
>  	throtl = blk_throtl_bio(q, blkg, bio);
>  
> -	if (!throtl) {
> +	if (!throtl && !bio_flagged(bio, BIO_THROTL_COUNTED)) {
>  		blkg = blkg ?: q->root_blkg;
>  		blkg_rwstat_add(&blkg->stat_bytes, bio->bi_opf,
>  				bio->bi_iter.bi_size);
>  		blkg_rwstat_add(&blkg->stat_ios, bio->bi_opf, 1);
> +		bio_set_flag(bio, BIO_THROTL_COUNTED);
>  	}
>  
>  	rcu_read_unlock();
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 9e7d8bd..7a3890a 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -135,6 +135,7 @@ struct bio {
>  				 * throttling rules. Don't do it again. */
>  #define BIO_TRACE_COMPLETION 10	/* bio_endio() should trace the final completion
>  				 * of this bio. */
> +#define BIO_THROTL_COUNTED 11	/* This bio has already counted to rwstat. */
>  /* See BVEC_POOL_OFFSET below before adding new flags */
>  
>  /*
> -- 
> 1.8.3.1
> 
