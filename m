Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/2] block: fail op_is_write() requests to read-only
 partitions
To: Ilya Dryomov <idryomov@gmail.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>,
 David Disseldorp <ddiss@suse.de>, Sagi Grimberg <sagi@grimberg.me>
References: <1515601118-23192-1-git-send-email-idryomov@gmail.com>
 <1515601118-23192-2-git-send-email-idryomov@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <854c55f9-280b-de02-0be4-6ee8534802c8@kernel.dk>
Date: Wed, 10 Jan 2018 09:34:02 -0700
MIME-Version: 1.0
In-Reply-To: <1515601118-23192-2-git-send-email-idryomov@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/10/18 9:18 AM, Ilya Dryomov wrote:
> Regular block device writes go through blkdev_write_iter(), which does
> bdev_read_only(), while zeroout/discard/etc requests are never checked,
> both userspace- and kernel-triggered.  Add a generic catch-all check to
> generic_make_request_checks() to actually enforce ioctl(BLKROSET) and
> set_disk_ro(), which is used by quite a few drivers for things like
> snapshots, read-only backing files/images, etc.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  block/blk-core.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index f843ae4f858d..d132bec4a266 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2123,6 +2123,20 @@ static inline int bio_check_eod(struct bio *bio, unsigned int nr_sectors)
>  	return 0;
>  }
>  
> +static inline bool bio_check_ro(struct bio *bio)
> +{
> +	struct hd_struct *p;
> +	bool ret = false;
> +
> +	rcu_read_lock();
> +	p = __disk_get_part(bio->bi_disk, bio->bi_partno);
> +	if (!p || (p->policy && op_is_write(bio_op(bio))))
> +		ret = true;
> +	rcu_read_unlock();
> +
> +	return ret;
> +}> +
>  static noinline_for_stack bool
>  generic_make_request_checks(struct bio *bio)
>  {
> @@ -2145,11 +2159,18 @@ generic_make_request_checks(struct bio *bio)
>  		goto end_io;
>  	}
>  
> +	if (unlikely(bio_check_ro(bio))) {
> +		printk(KERN_ERR
> +		       "generic_make_request: Trying to write "
> +			"to read-only block-device %s (partno %d)\n",
> +			bio_devname(bio, b), bio->bi_partno);
> +		goto end_io;
> +	}

It's yet another check that adds part lookup and rcu lock/unlock in that
path. Can we combine some of them? Make this part of the remap?  This
overhead impacts every IO, let's not bloat it more than absolutely
necessary.

-- 
Jens Axboe


-- 
Jens Axboe
