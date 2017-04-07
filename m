Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933809AbdDGO7p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Apr 2017 10:59:45 -0400
Date: Fri, 7 Apr 2017 22:59:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCHv7 2/2] loop: support 4k physical blocksize
Message-ID: <20170407145924.GA29654@ming.t460p>
References: <1491562257-82574-1-git-send-email-hare@suse.de>
 <1491562257-82574-3-git-send-email-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491562257-82574-3-git-send-email-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 07, 2017 at 12:50:57PM +0200, Hannes Reinecke wrote:
> When generating bootable VM images certain systems (most notably
> s390x) require devices with 4k blocksize. This patch implements
> a new flag 'LO_FLAGS_BLOCKSIZE' which will set the physical
> blocksize to that of the underlying device, and allow to change
> the logical blocksize for up to the physical blocksize.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/block/loop.c      | 40 +++++++++++++++++++++++++++++++++++-----
>  drivers/block/loop.h      |  1 +
>  include/uapi/linux/loop.h |  3 +++
>  3 files changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 81b3900..0909e06 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -221,7 +221,8 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
>  }
>  
>  static int
> -figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
> +figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit,
> +		 loff_t logical_blocksize)
>  {
>  	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
>  	sector_t x = (sector_t)size;
> @@ -233,6 +234,12 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
>  		lo->lo_offset = offset;
>  	if (lo->lo_sizelimit != sizelimit)
>  		lo->lo_sizelimit = sizelimit;
> +	if (lo->lo_flags & LO_FLAGS_BLOCKSIZE) {
> +		lo->lo_logical_blocksize = logical_blocksize;
> +		blk_queue_physical_block_size(lo->lo_queue, lo->lo_blocksize);
> +		blk_queue_logical_block_size(lo->lo_queue,
> +					     lo->lo_logical_blocksize);
> +	}
>  	set_capacity(lo->lo_disk, x);
>  	bd_set_size(bdev, (loff_t)get_capacity(bdev->bd_disk) << 9);
>  	/* let user-space know about the new size */
> @@ -814,6 +821,7 @@ static void loop_config_discard(struct loop_device *lo)
>  	struct file *file = lo->lo_backing_file;
>  	struct inode *inode = file->f_mapping->host;
>  	struct request_queue *q = lo->lo_queue;
> +	int lo_bits = 9;
>  
>  	/*
>  	 * We use punch hole to reclaim the free space used by the
> @@ -833,7 +841,10 @@ static void loop_config_discard(struct loop_device *lo)
>  
>  	q->limits.discard_granularity = inode->i_sb->s_blocksize;
>  	q->limits.discard_alignment = 0;
> -	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
> +	if (lo->lo_flags & LO_FLAGS_BLOCKSIZE)
> +		lo_bits = blksize_bits(lo->lo_logical_blocksize);
> +
> +	blk_queue_max_discard_sectors(q, UINT_MAX >> lo_bits);
>  	q->limits.discard_zeroes_data = 1;
>  	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
>  }
> @@ -1087,6 +1098,7 @@ static int loop_clr_fd(struct loop_device *lo)
>  	int err;
>  	struct loop_func_table *xfer;
>  	kuid_t uid = current_uid();
> +	int lo_flags = lo->lo_flags;
>  
>  	if (lo->lo_encrypt_key_size &&
>  	    !uid_eq(lo->lo_key_owner, uid) &&
> @@ -1119,9 +1131,26 @@ static int loop_clr_fd(struct loop_device *lo)
>  	if (err)
>  		goto exit;
>  
> +	if (info->lo_flags & LO_FLAGS_BLOCKSIZE) {
> +		if (!(lo->lo_flags & LO_FLAGS_BLOCKSIZE))
> +			lo->lo_logical_blocksize = 512;
> +		lo->lo_flags |= LO_FLAGS_BLOCKSIZE;
> +		if (LO_INFO_BLOCKSIZE(info) != 512 &&
> +		    LO_INFO_BLOCKSIZE(info) != 1024 &&
> +		    LO_INFO_BLOCKSIZE(info) != 2048 &&
> +		    LO_INFO_BLOCKSIZE(info) != 4096)
> +			return -EINVAL;
> +		if (LO_INFO_BLOCKSIZE(info) > lo->lo_blocksize)
> +			return -EINVAL;
> +	}
> +
>  	if (lo->lo_offset != info->lo_offset ||
> -	    lo->lo_sizelimit != info->lo_sizelimit)
> -		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
> +	    lo->lo_sizelimit != info->lo_sizelimit ||
> +	    lo->lo_flags != lo_flags ||
> +	    ((lo->lo_flags & LO_FLAGS_BLOCKSIZE) &&
> +	     lo->lo_logical_blocksize != LO_INFO_BLOCKSIZE(info))) {
> +		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit,
> +				     LO_INFO_BLOCKSIZE(info)))
>  			err = -EFBIG;
>  			goto exit;
>  		}
> @@ -1312,7 +1341,8 @@ static int loop_set_capacity(struct loop_device *lo)
>  	if (unlikely(lo->lo_state != Lo_bound))
>  		return -ENXIO;
>  
> -	return figure_loop_size(lo, lo->lo_offset, lo->lo_sizelimit);
> +	return figure_loop_size(lo, lo->lo_offset, lo->lo_sizelimit,
> +				lo->lo_logical_blocksize);
>  }
>  
>  static int loop_set_dio(struct loop_device *lo, unsigned long arg)
> diff --git a/drivers/block/loop.h b/drivers/block/loop.h
> index fb2237c..579f2f7 100644
> --- a/drivers/block/loop.h
> +++ b/drivers/block/loop.h
> @@ -49,6 +49,7 @@ struct loop_device {
>  	struct file *	lo_backing_file;
>  	struct block_device *lo_device;
>  	unsigned	lo_blocksize;
> +	unsigned	lo_logical_blocksize;
>  	void		*key_data; 
>  
>  	gfp_t		old_gfp_mask;
> diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
> index c8125ec..a3960f9 100644
> --- a/include/uapi/linux/loop.h
> +++ b/include/uapi/linux/loop.h
> @@ -22,6 +22,7 @@ enum {
>  	LO_FLAGS_AUTOCLEAR	= 4,
>  	LO_FLAGS_PARTSCAN	= 8,
>  	LO_FLAGS_DIRECT_IO	= 16,
> +	LO_FLAGS_BLOCKSIZE	= 32,
>  };
>  
>  #include <asm/posix_types.h>	/* for __kernel_old_dev_t */
> @@ -59,6 +60,8 @@ struct loop_info64 {
>  	__u64		   lo_init[2];
>  };
>  
> +#define LO_INFO_BLOCKSIZE(l) (l)->lo_init[0]
> +
>  /*
>   * Loop filter types
>   */
> -- 
> 1.8.5.6
> 

Looks V7 still doesn't recover logical/physical block size for
new attached file?

Thanks,
Ming
