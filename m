Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbdAHTqV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 8 Jan 2017 14:46:21 -0500
Date: Sun, 8 Jan 2017 20:46:14 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rabin Vincent <rabinv@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Wei Fang <fangwei1@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: fix blk_get_backing_dev_info() crash, use
 bdev->bd_queue
Message-ID: <20170108194614.GA18227@quack2.suse.cz>
References: <148366547505.38941.646379357860772670.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20170106102330.GB3533@quack2.suse.cz>
 <CAPcyv4gmvGkAbse619WOBsEd8DDn8Fe4kVJ7r+iYug8DEg+cEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPcyv4gmvGkAbse619WOBsEd8DDn8Fe4kVJ7r+iYug8DEg+cEg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri 06-01-17 09:45:45, Dan Williams wrote:
> On Fri, Jan 6, 2017 at 2:23 AM, Jan Kara <jack@suse.cz> wrote:
> > On Thu 05-01-17 17:17:55, Dan Williams wrote:
> >> The ->bd_queue member of struct block_device was added in commit
> >> 87192a2a49c4 ("vfs: cache request_queue in struct block_device") in
> >> v3.3. However, blk_get_backing_dev_info() has been using
> >> bdev_get_queue() and grabbing the request_queue through the gendisk
> >> since before the git era.
> >>
> >> At final __blkdev_put() time ->bd_disk is cleared while ->bd_queue is
> >> not. The queue remains valid until the final put of the parent disk.
> >>
> >> The following crash signature results from blk_get_backing_dev_info()
> >> trying to lookup the queue through ->bd_disk after the final put of the
> >> block device. Simply switch bdev_get_queue() to use ->bd_queue directly
> >> which is guaranteed to still be valid at invalidate_partition() time.
> >>
> >>  BUG: unable to handle kernel NULL pointer dereference at 0000000000000568
> >>  IP: blk_get_backing_dev_info+0x10/0x20
> >>  [..]
> >>  Call Trace:
> >>   __inode_attach_wb+0x3a7/0x5d0
> >>   __filemap_fdatawrite_range+0xf8/0x100
> >>   filemap_write_and_wait+0x40/0x90
> >>   fsync_bdev+0x54/0x60
> >>   ? bdget_disk+0x30/0x40
> >>   invalidate_partition+0x24/0x50
> >>   del_gendisk+0xfa/0x230
> >
> > So we have a similar reports of the same problem. E.g.:
> >
> > http://www.spinics.net/lists/linux-fsdevel/msg105153.html
> >
> > However I kind of miss how your patch would fix all those cases. The
> > principial problem is that inode_to_bdi() called on block device inode
> > wants to get the backing_dev_info however on last close of a block device
> > we do put_disk() and thus the request queue containing backing_dev_info
> > does not have to be around at that time. In your case you are lucky enough
> > to have the containing disk still around but that's not the case for all
> > inode_to_bdi() users (see e.g. the report I referenced) and your patch
> > would change relatively straightforward NULL pointer dereference to rather
> > subtle use-after-free issue
> 
> True. If there are other cases that don't hold their own queue
> reference this patch makes things worse.
> 
> > so I disagree with going down this path.
> 
> I still think this patch is the right thing to do, but it needs to
> come after the wider guarantee that having an active bdev reference
> guarantees that the queue and backing_dev_info are still allocated.
> 
> > So what I think needs to be done is that we make backing_dev_info
> > independently allocated structure with different lifetime rules to gendisk
> > or request_queue - definitely I want it to live as long as block device
> > inode exists. However it needs more thought what the exact lifetime rules
> > will be.
> 
> Hmm, why does it need to be separately allocated?
> 
> Something like this, passes the libnvdimm unit tests: (non-whitespace
> damaged version attached)

So the problem with this approach is that request queue will be pinned while
bdev inode exists. And how long that is is impossible to predict or influence
from userspace so e.g. you cannot remove device driver from memory and even
unplugging USB after it has been unmounted would suddently go via a path of
"device removed while it is used" which can have unexpected consequences. I
guess Jens or Christoph will know more about the details...

I have prototyped patches which split backing_dev_info from request_queue
and it was not even that difficult in the end. I'll give those patches some
testing and post them for comments...

								Honza

> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 7c1a24fb09d8..6742c49b38e4 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -378,7 +378,8 @@ EXPORT_SYMBOL(blk_run_queue);
> 
>  void blk_put_queue(struct request_queue *q)
>  {
> -       kobject_put(&q->kobj);
> +       if (q)
> +               kobject_put(&q->kobj);
>  }
>  EXPORT_SYMBOL(blk_put_queue);
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 05b553368bb4..7503110e37ff 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -589,12 +589,22 @@ static struct inode *bdev_alloc_inode(struct
> super_block *sb)
>         return &ei->vfs_inode;
>  }
> 
> +static void bdev_release(struct work_struct *w)
> +{
> +       struct block_device *bdev = container_of(w, typeof(*bdev), bd_release);
> +       struct bdev_inode *bdi = container_of(bdev, typeof(*bdi), bdev);
> +
> +       blk_put_queue(bdev->bd_queue);
> +       kmem_cache_free(bdev_cachep, bdi);
> +}
> +
>  static void bdev_i_callback(struct rcu_head *head)
>  {
>         struct inode *inode = container_of(head, struct inode, i_rcu);
> -       struct bdev_inode *bdi = BDEV_I(inode);
> +       struct block_device *bdev = &BDEV_I(inode)->bdev;
> 
> -       kmem_cache_free(bdev_cachep, bdi);
> +       /* blk_put_queue needs process context */
> +       schedule_work(&bdev->bd_release);
>  }
> 
>  static void bdev_destroy_inode(struct inode *inode)
> @@ -613,6 +623,7 @@ static void init_once(void *foo)
>  #ifdef CONFIG_SYSFS
>         INIT_LIST_HEAD(&bdev->bd_holder_disks);
>  #endif
> +       INIT_WORK(&bdev->bd_release, bdev_release);
>         inode_init_once(&ei->vfs_inode);
>         /* Initialize mutex for freeze. */
>         mutex_init(&bdev->bd_fsfreeze_mutex);
> @@ -1268,6 +1279,8 @@ static int __blkdev_get(struct block_device
> *bdev, fmode_t mode, int for_part)
>         mutex_lock_nested(&bdev->bd_mutex, for_part);
>         if (!bdev->bd_openers) {
>                 bdev->bd_disk = disk;
> +               if (!blk_get_queue(disk->queue))
> +                       goto out_clear;
>                 bdev->bd_queue = disk->queue;
>                 bdev->bd_contains = bdev;
> 
> @@ -1288,7 +1301,6 @@ static int __blkdev_get(struct block_device
> *bdev, fmode_t mode, int for_part)
>                                         disk_put_part(bdev->bd_part);
>                                         bdev->bd_part = NULL;
>                                         bdev->bd_disk = NULL;
> -                                       bdev->bd_queue = NULL;
>                                         mutex_unlock(&bdev->bd_mutex);
>                                         disk_unblock_events(disk);
>                                         put_disk(disk);
> @@ -1364,7 +1376,6 @@ static int __blkdev_get(struct block_device
> *bdev, fmode_t mode, int for_part)
>         disk_put_part(bdev->bd_part);
>         bdev->bd_disk = NULL;
>         bdev->bd_part = NULL;
> -       bdev->bd_queue = NULL;
>         if (bdev != bdev->bd_contains)
>                 __blkdev_put(bdev->bd_contains, mode, 1);
>         bdev->bd_contains = NULL;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index dc0478c07b2a..f084e4a2198b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -488,6 +488,7 @@ struct block_device {
>         int                     bd_fsfreeze_count;
>         /* Mutex for freeze */
>         struct mutex            bd_fsfreeze_mutex;
> +       struct work_struct      bd_release;
>  };
> 
>  /*

> diff --git a/block/blk-core.c b/block/blk-core.c
> index 7c1a24fb09d8..6742c49b38e4 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -378,7 +378,8 @@ EXPORT_SYMBOL(blk_run_queue);
>  
>  void blk_put_queue(struct request_queue *q)
>  {
> -	kobject_put(&q->kobj);
> +	if (q)
> +		kobject_put(&q->kobj);
>  }
>  EXPORT_SYMBOL(blk_put_queue);
>  
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 05b553368bb4..7503110e37ff 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -589,12 +589,22 @@ static struct inode *bdev_alloc_inode(struct super_block *sb)
>  	return &ei->vfs_inode;
>  }
>  
> +static void bdev_release(struct work_struct *w)
> +{
> +	struct block_device *bdev = container_of(w, typeof(*bdev), bd_release);
> +	struct bdev_inode *bdi = container_of(bdev, typeof(*bdi), bdev);
> +
> +	blk_put_queue(bdev->bd_queue);
> +	kmem_cache_free(bdev_cachep, bdi);
> +}
> +
>  static void bdev_i_callback(struct rcu_head *head)
>  {
>  	struct inode *inode = container_of(head, struct inode, i_rcu);
> -	struct bdev_inode *bdi = BDEV_I(inode);
> +	struct block_device *bdev = &BDEV_I(inode)->bdev;
>  
> -	kmem_cache_free(bdev_cachep, bdi);
> +	/* blk_put_queue needs process context */
> +	schedule_work(&bdev->bd_release);
>  }
>  
>  static void bdev_destroy_inode(struct inode *inode)
> @@ -613,6 +623,7 @@ static void init_once(void *foo)
>  #ifdef CONFIG_SYSFS
>  	INIT_LIST_HEAD(&bdev->bd_holder_disks);
>  #endif
> +	INIT_WORK(&bdev->bd_release, bdev_release);
>  	inode_init_once(&ei->vfs_inode);
>  	/* Initialize mutex for freeze. */
>  	mutex_init(&bdev->bd_fsfreeze_mutex);
> @@ -1268,6 +1279,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
>  	mutex_lock_nested(&bdev->bd_mutex, for_part);
>  	if (!bdev->bd_openers) {
>  		bdev->bd_disk = disk;
> +		if (!blk_get_queue(disk->queue))
> +			goto out_clear;
>  		bdev->bd_queue = disk->queue;
>  		bdev->bd_contains = bdev;
>  
> @@ -1288,7 +1301,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
>  					disk_put_part(bdev->bd_part);
>  					bdev->bd_part = NULL;
>  					bdev->bd_disk = NULL;
> -					bdev->bd_queue = NULL;
>  					mutex_unlock(&bdev->bd_mutex);
>  					disk_unblock_events(disk);
>  					put_disk(disk);
> @@ -1364,7 +1376,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
>  	disk_put_part(bdev->bd_part);
>  	bdev->bd_disk = NULL;
>  	bdev->bd_part = NULL;
> -	bdev->bd_queue = NULL;
>  	if (bdev != bdev->bd_contains)
>  		__blkdev_put(bdev->bd_contains, mode, 1);
>  	bdev->bd_contains = NULL;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index dc0478c07b2a..f084e4a2198b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -488,6 +488,7 @@ struct block_device {
>  	int			bd_fsfreeze_count;
>  	/* Mutex for freeze */
>  	struct mutex		bd_fsfreeze_mutex;
> +	struct work_struct	bd_release;
>  };
>  
>  /*

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
