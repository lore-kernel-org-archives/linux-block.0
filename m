Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755379AbdDFInn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Apr 2017 04:43:43 -0400
Date: Thu, 6 Apr 2017 16:43:18 +0800
From: Ming Lei <minlei@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH] loop: set queue logical block size
Message-ID: <20170406084313.GA4197@ming.t460p>
References: <07d6b9266284b98aa3a4706062bd135275220d38.1491466688.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <07d6b9266284b98aa3a4706062bd135275220d38.1491466688.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Apr 06, 2017 at 01:19:45AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The request queue created when we create a loop device has the default
> logical block size of 512. When we associate the device with an fd, we
> set the block size on the block_device but don't update the logical
> block size of the request_queue. This makes it impossibe to use direct
> I/O with a backing file on a device with a block size >512, as the
> following check in __loop_update_dio() fails:
> 
> 	sb_bsize = bdev_logical_block_size(inode->i_sb->s_bdev);
> 	if (queue_logical_block_size(lo->lo_queue) >= sb_bsize &&
> 	    ...
> 
> Fix it by updating the logical block size when we set the fd.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  drivers/block/loop.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index cc981f34e017..1bb22903ad1a 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -941,6 +941,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>  	/* let user-space know about the new size */
>  	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
>  
> +	blk_queue_logical_block_size(lo->lo_queue, lo_blocksize);
>  	set_blocksize(bdev, lo_blocksize);
>  
>  	lo->lo_state = Lo_bound;

Looks fine!

Reviewed-by: Ming Lei <minlei@redhat.com>

Thanks,
Ming
