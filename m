Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:42684 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S933132AbeBMCMO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Feb 2018 21:12:14 -0500
Subject: Re: [PATCH 4/6] genhd: Fix use after free in __blkdev_get()
To: Jan Kara <jack@suse.cz>, <linux-block@vger.kernel.org>
References: <20180206160529.20713-1-jack@suse.cz>
 <20180206160529.20713-5-jack@suse.cz>
CC: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Eric Biggers <ebiggers3@gmail.com>
From: Hou Tao <houtao1@huawei.com>
Message-ID: <5ca54e88-cb46-ac73-6320-ed25570206c6@huawei.com>
Date: Tue, 13 Feb 2018 10:11:19 +0800
MIME-Version: 1.0
In-Reply-To: <20180206160529.20713-5-jack@suse.cz>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jan,

On 2018/2/7 0:05, Jan Kara wrote:
> When two blkdev_open() calls race with device removal and recreation,
> __blkdev_get() can use looked up gendisk after it is freed:
> 
> CPU0				CPU1			CPU2
> 							del_gendisk(disk);
> 							  bdev_unhash_inode(inode);
> blkdev_open()			blkdev_open()
>   bdev = bd_acquire(inode);
>     - creates and returns new inode
> 				  bdev = bd_acquire(inode);
> 				    - returns the same inode
>   __blkdev_get(devt)		  __blkdev_get(devt)
>     disk = get_gendisk(devt);
>       - got structure of device going away
> 							<finish device removal>
> 							<new device gets
> 							 created under the same
> 							 device number>
> 				  disk = get_gendisk(devt);
> 				    - got new device structure
> 				  if (!bdev->bd_openers) {
> 				    does the first open
> 				  }
>     if (!bdev->bd_openers)
>       - false
>     } else {
>       put_disk_and_module(disk)
>         - remember this was old device - this was last ref and disk is
>           now freed
>     }
>     disk_unblock_events(disk); -> oops
> 
> Fix the problem by making sure we drop reference to disk in
> __blkdev_get() only after we are really done with it.
> 
> Reported-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/block_dev.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

After applying the patch, the use-after-free problem is gone, so

Tested-by: Hou Tao <houtao1@huawei.com>

> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 1dbbf847911a..fe41a76769fa 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1409,6 +1409,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
>  	int ret;
>  	int partno;
>  	int perm = 0;
> +	bool first_open = false;
>  
>  	if (mode & FMODE_READ)
>  		perm |= MAY_READ;
> @@ -1435,6 +1436,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
>  	disk_block_events(disk);
>  	mutex_lock_nested(&bdev->bd_mutex, for_part);
>  	if (!bdev->bd_openers) {
> +		first_open = true;
>  		bdev->bd_disk = disk;
>  		bdev->bd_queue = disk->queue;
>  		bdev->bd_contains = bdev;
> @@ -1520,14 +1522,15 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
>  			if (ret)
>  				goto out_unlock_bdev;
>  		}
> -		/* only one opener holds refs to the module and disk */
> -		put_disk_and_module(disk);
>  	}
>  	bdev->bd_openers++;
>  	if (for_part)
>  		bdev->bd_part_count++;
>  	mutex_unlock(&bdev->bd_mutex);
>  	disk_unblock_events(disk);
> +	/* only one opener holds refs to the module and disk */
> +	if (!first_open)
> +		put_disk_and_module(disk);
>  	return 0;
>  
>   out_clear:
> 
