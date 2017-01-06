Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38763 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970052AbdAFKY3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Jan 2017 05:24:29 -0500
Date: Fri, 6 Jan 2017 11:23:30 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: axboe@fb.com, Andi Kleen <ak@linux.intel.com>,
        Jan Kara <jack@suse.cz>, Rabin Vincent <rabinv@axis.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Wei Fang <fangwei1@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: fix blk_get_backing_dev_info() crash, use
 bdev->bd_queue
Message-ID: <20170106102330.GB3533@quack2.suse.cz>
References: <148366547505.38941.646379357860772670.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <148366547505.38941.646379357860772670.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu 05-01-17 17:17:55, Dan Williams wrote:
> The ->bd_queue member of struct block_device was added in commit
> 87192a2a49c4 ("vfs: cache request_queue in struct block_device") in
> v3.3. However, blk_get_backing_dev_info() has been using
> bdev_get_queue() and grabbing the request_queue through the gendisk
> since before the git era.
> 
> At final __blkdev_put() time ->bd_disk is cleared while ->bd_queue is
> not. The queue remains valid until the final put of the parent disk.
> 
> The following crash signature results from blk_get_backing_dev_info()
> trying to lookup the queue through ->bd_disk after the final put of the
> block device. Simply switch bdev_get_queue() to use ->bd_queue directly
> which is guaranteed to still be valid at invalidate_partition() time.
> 
>  BUG: unable to handle kernel NULL pointer dereference at 0000000000000568
>  IP: blk_get_backing_dev_info+0x10/0x20
>  [..]
>  Call Trace:
>   __inode_attach_wb+0x3a7/0x5d0
>   __filemap_fdatawrite_range+0xf8/0x100
>   filemap_write_and_wait+0x40/0x90
>   fsync_bdev+0x54/0x60
>   ? bdget_disk+0x30/0x40
>   invalidate_partition+0x24/0x50
>   del_gendisk+0xfa/0x230

So we have a similar reports of the same problem. E.g.:

http://www.spinics.net/lists/linux-fsdevel/msg105153.html

However I kind of miss how your patch would fix all those cases. The
principial problem is that inode_to_bdi() called on block device inode
wants to get the backing_dev_info however on last close of a block device
we do put_disk() and thus the request queue containing backing_dev_info
does not have to be around at that time. In your case you are lucky enough
to have the containing disk still around but that's not the case for all
inode_to_bdi() users (see e.g. the report I referenced) and your patch
would change relatively straightforward NULL pointer dereference to rather
subtle use-after-free issue so I disagree with going down this path.

So what I think needs to be done is that we make backing_dev_info
independently allocated structure with different lifetime rules to gendisk
or request_queue - definitely I want it to live as long as block device
inode exists. However it needs more thought what the exact lifetime rules
will be.

								Honza
> 
> Cc: <stable@vger.kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Wei Fang <fangwei1@huawei.com>
> Cc: Rabin Vincent <rabinv@axis.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Fixes: 87192a2a49c4 ("vfs: cache request_queue in struct block_device")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  block/blk-core.c       |    4 ++--
>  include/linux/blkdev.h |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 61ba08c58b64..04737548e1e1 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -109,8 +109,8 @@ void blk_queue_congestion_threshold(struct request_queue *q)
>   * @bdev:	device
>   *
>   * Locates the passed device's request queue and returns the address of its
> - * backing_dev_info.  This function can only be called if @bdev is opened
> - * and the return value is never NULL.
> + * backing_dev_info.  This function can only be called while there is an
> + * active reference against the parent gendisk.
>   */
>  struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev)
>  {
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 83695641bd5e..27779709f821 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -962,7 +962,7 @@ bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie);
>  
>  static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
>  {
> -	return bdev->bd_disk->queue;	/* this is never NULL */
> +	return bdev->bd_queue;	/* this is never NULL */
>  }
>  
>  /*
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
