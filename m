Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B74C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 15:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbiCNPYe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiCNPYd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 11:24:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2FE6340
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 08:23:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 628352110B;
        Mon, 14 Mar 2022 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647271401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8/ZljCH/2TcWiAYlpbq61DCKg7hF/ispGvFGpp70iI=;
        b=zUaDFRuStyFv9/ySeB/ZB26nFrPv3IEara7f1096Ox5/rCqSVBnZe/TDsj93aWjeMqNFYB
        4kJivOz6RP93dyggSg8xgU2iIUHbvIoxUkmNiiPhO0MRzlC7o4lIL0YGdV6PovkMWiAocV
        J91hczyrNIDddR5Q5M363hvu+VXibr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647271401;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8/ZljCH/2TcWiAYlpbq61DCKg7hF/ispGvFGpp70iI=;
        b=wshTy/uW9vmS8kz9JjiUUBh8U9JGnbxePx80jsIeVXf8tf4cvVRfUGXAAaguKWGT3vIqnK
        pyvRJj6jGBN1RnAw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 30EF9A3B93;
        Mon, 14 Mar 2022 15:23:20 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2DFB4A0615; Mon, 14 Mar 2022 16:23:18 +0100 (CET)
Date:   Mon, 14 Mar 2022 16:23:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+6479585dfd4dedd3f7e1@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] loop: don't hold lo->lo_mutex from lo_open() and
 lo_release()
Message-ID: <20220314152318.k4cvwe737q5r5juw@quack3.lan>
References: <00000000000099c4ca05da07e42f@google.com>
 <bbdd20da-bccb-2dbb-7c46-be06dcfc26eb@I-love.SAKURA.ne.jp>
 <613b094e-2b76-11b7-458b-553aafaf0df7@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <613b094e-2b76-11b7-458b-553aafaf0df7@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 14-03-22 00:15:22, Tetsuo Handa wrote:
> syzbot is reporting circular locking problem at __loop_clr_fd() [1], for
> commit 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
> is calling destroy_workqueue() with disk->open_mutex held.
> 
> Commit 322c4293ecc58110 ("loop: make autoclear operation asynchronous")
> tried to fix this problem by deferring __loop_clr_fd() from lo_release()
> to a WQ context, but that commit was reverted because there are userspace
> programs which depend on that __loop_clr_fd() completes by the moment
> close() returns to user mode.
> 
> This time, we try to fix this problem by deferring __loop_clr_fd() from
> lo_release() to a task work context. Since task_work_add() is not exported
> but Christoph does not want to export it, this patch uses anonymous inode
> interface as a wrapper for calling task_work_add() via fput().
> 
> Although Jan has found two bugs in /bin/mount where one of these was fixed
> in util-linux package [2], I found that not holding lo->lo_mutex from
> lo_open() causes occasional I/O error [3] (due to
> 
> 	if (lo->lo_state != Lo_bound)
> 		return BLK_STS_IOERR;
> 
> check in loop_queue_rq()) when systemd-udevd opens a loop device and
> reads from it before loop_configure() updates lo->lo_state to Lo_bound.

Thanks for detailed explanation here. Finally, I can see what is the
problem with the open path. A few questions here:

1) Can you please remind me why do we need to also remove the lo_mutex from
lo_open()? The original lockdep problem was only for __loop_clr_fd(),
wasn't it?

2) Cannot we just move the generation of DISK_EVENT_MEDIA_CHANGE event
after the moment the loop device is configured? That way systemd won't
start probing the new loop device until it is fully configured.

Because the less hacks with task_work we have the better.

Also I don't think the deadlock is really fixed when you wait for
__loop_clr_fd() during open. It is maybe just hidden from lockdep. But the
fundamental problem of the cycle syzbot constructed is that flushing of IO
to a loop device may end up depending on open of that loop device to
finish. So if pending __loop_clr_fd() is a problem for somebody (is it?),
we still need to let open finish and deal with waiting for __loop_clr_fd()
in other places where that actually causes problem (and make sure
Lo_rundown is either treated as Lo_unbound or wait for Lo_rundown to
transition to Lo_unbound).

> That is, not only we need to wait for __loop_clr_fd() upon close() event
> (in order to avoid unexpected umount() failure) but also we need to wait
> for lo->lo_mutex upon open() event (in order to avoid unexpected I/O
> errors). Therefore, schedule a task work from both lo_open() and
> lo_release().

Honestly, the anon inode trick makes the code pretty much unreadable. As
far as I remember Christoph was not pricipially against using task_work. He
just wanted the task_work API to be improved so that it is easier to use.

								Honza

 
> Link: https://syzkaller.appspot.com/bug?extid=6479585dfd4dedd3f7e1 [1]
> Link: https://github.com/util-linux/util-linux/commit/3e1fc3bbee99384c [2]
> Link: https://lkml.kernel.org/r/a72c59c6-298b-e4ba-b1f5-2275afab49a1@I-love.SAKURA.ne.jp [3]
> Reported-by: syzbot <syzbot+6479585dfd4dedd3f7e1@syzkaller.appspotmail.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  drivers/block/loop.c | 244 +++++++++++++++++++++++++++++++------------
>  drivers/block/loop.h |   1 +
>  2 files changed, 180 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 19fe19eaa50e..2f60356ad428 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -80,6 +80,7 @@
>  #include <linux/blk-cgroup.h>
>  #include <linux/sched/mm.h>
>  #include <linux/statfs.h>
> +#include <linux/anon_inodes.h>
>  
>  #include "loop.h"
>  
> @@ -90,6 +91,8 @@
>  static DEFINE_IDR(loop_index_idr);
>  static DEFINE_MUTEX(loop_ctl_mutex);
>  static DEFINE_MUTEX(loop_validate_mutex);
> +static DEFINE_SPINLOCK(loop_delete_spinlock);
> +static DECLARE_WAIT_QUEUE_HEAD(loop_rundown_wait);
>  
>  /**
>   * loop_global_lock_killable() - take locks for safe loop_validate_file() test
> @@ -1088,7 +1091,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	return error;
>  }
>  
> -static void __loop_clr_fd(struct loop_device *lo, bool release)
> +static void __loop_clr_fd(struct loop_device *lo)
>  {
>  	struct file *filp;
>  	gfp_t gfp = lo->old_gfp_mask;
> @@ -1150,8 +1153,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
>  	/* let user-space know about this change */
>  	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
>  	mapping_set_gfp_mask(filp->f_mapping, gfp);
> -	/* This is safe: open() is still holding a reference. */
> -	module_put(THIS_MODULE);
>  	blk_mq_unfreeze_queue(lo->lo_queue);
>  
>  	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
> @@ -1159,37 +1160,18 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
>  	if (lo->lo_flags & LO_FLAGS_PARTSCAN) {
>  		int err;
>  
> -		/*
> -		 * open_mutex has been held already in release path, so don't
> -		 * acquire it if this function is called in such case.
> -		 *
> -		 * If the reread partition isn't from release path, lo_refcnt
> -		 * must be at least one and it can only become zero when the
> -		 * current holder is released.
> -		 */
> -		if (!release)
> -			mutex_lock(&lo->lo_disk->open_mutex);
> +		mutex_lock(&lo->lo_disk->open_mutex);
>  		err = bdev_disk_changed(lo->lo_disk, false);
> -		if (!release)
> -			mutex_unlock(&lo->lo_disk->open_mutex);
> +		mutex_unlock(&lo->lo_disk->open_mutex);
>  		if (err)
>  			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
>  				__func__, lo->lo_number, err);
>  		/* Device is gone, no point in returning error */
>  	}
>  
> -	/*
> -	 * lo->lo_state is set to Lo_unbound here after above partscan has
> -	 * finished. There cannot be anybody else entering __loop_clr_fd() as
> -	 * Lo_rundown state protects us from all the other places trying to
> -	 * change the 'lo' device.
> -	 */
>  	lo->lo_flags = 0;
>  	if (!part_shift)
>  		lo->lo_disk->flags |= GENHD_FL_NO_PART;
> -	mutex_lock(&lo->lo_mutex);
> -	lo->lo_state = Lo_unbound;
> -	mutex_unlock(&lo->lo_mutex);
>  
>  	/*
>  	 * Need not hold lo_mutex to fput backing file. Calling fput holding
> @@ -1197,6 +1179,11 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
>  	 * fput can take open_mutex which is usually taken before lo_mutex.
>  	 */
>  	fput(filp);
> +	mutex_lock(&lo->lo_mutex);
> +	lo->lo_state = Lo_unbound;
> +	mutex_unlock(&lo->lo_mutex);
> +	wake_up_all(&loop_rundown_wait);
> +	module_put(THIS_MODULE);
>  }
>  
>  static int loop_clr_fd(struct loop_device *lo)
> @@ -1228,7 +1215,7 @@ static int loop_clr_fd(struct loop_device *lo)
>  	lo->lo_state = Lo_rundown;
>  	mutex_unlock(&lo->lo_mutex);
>  
> -	__loop_clr_fd(lo, false);
> +	__loop_clr_fd(lo);
>  	return 0;
>  }
>  
> @@ -1720,52 +1707,176 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
>  }
>  #endif
>  
> -static int lo_open(struct block_device *bdev, fmode_t mode)
> +static int lo_no_open(struct inode *inode, struct file *file)
>  {
> -	struct loop_device *lo = bdev->bd_disk->private_data;
> -	int err;
> +	return -ENXIO;
> +}
>  
> -	err = mutex_lock_killable(&lo->lo_mutex);
> -	if (err)
> -		return err;
> -	if (lo->lo_state == Lo_deleting)
> -		err = -ENXIO;
> -	else
> -		atomic_inc(&lo->lo_refcnt);
> -	mutex_unlock(&lo->lo_mutex);
> -	return err;
> +static int lo_post_open(struct inode *inode, struct file *file)
> +{
> +	struct loop_device *lo = file->private_data;
> +
> +	/* Nothing to do if lo_open() failed. */
> +	if (!lo)
> +		return 0;
> +	/* Wait for loop_configure()/loop_post_release() to complete. */
> +	if (mutex_lock_killable(&lo->lo_mutex) == 0)
> +		mutex_unlock(&lo->lo_mutex);
> +	/*
> +	 * Also wait for __loop_clr_fd() to complete because
> +	 * loop_post_release() releases lo->lo_mutex before __loop_clr_fd()
> +	 * is called.
> +	 */
> +	wait_event_killable(loop_rundown_wait, data_race(lo->lo_state) != Lo_rundown);
> +	atomic_dec(&lo->async_pending);
> +	return 0;
>  }
>  
> -static void lo_release(struct gendisk *disk, fmode_t mode)
> +static const struct file_operations loop_open_fops = {
> +	.open = lo_no_open,
> +	.release = lo_post_open,
> +};
> +
> +static int lo_post_release(struct inode *inode, struct file *file)
>  {
> -	struct loop_device *lo = disk->private_data;
> +	struct gendisk *disk = file->private_data;
> +	struct loop_device *lo;
>  
> +	/* Nothing to do if lo_open() failed. */
> +	if (!disk)
> +		return 0;
> +	lo = disk->private_data;
>  	mutex_lock(&lo->lo_mutex);
> -	if (atomic_dec_return(&lo->lo_refcnt))
> +	/* Check whether this loop device can be cleared. */
> +	if (atomic_dec_return(&lo->lo_refcnt) || lo->lo_state != Lo_bound)
>  		goto out_unlock;
> -
> +	/*
> +	 * Clear this loop device since nobody is using. Note that since
> +	 * lo_open() increments lo->lo_refcnt without holding lo->lo_mutex,
> +	 * I might become no longer the last user, but there is a fact that
> +	 * there was no user.
> +	 *
> +	 * In autoclear mode, destroy WQ and remove configuration.
> +	 * Otherwise flush possible ongoing bios in WQ and keep configuration.
> +	 */
>  	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
> -		if (lo->lo_state != Lo_bound)
> -			goto out_unlock;
>  		lo->lo_state = Lo_rundown;
>  		mutex_unlock(&lo->lo_mutex);
> -		/*
> -		 * In autoclear mode, stop the loop thread
> -		 * and remove configuration after last close.
> -		 */
> -		__loop_clr_fd(lo, true);
> -		return;
> -	} else if (lo->lo_state == Lo_bound) {
> -		/*
> -		 * Otherwise keep thread (if running) and config,
> -		 * but flush possible ongoing bios in thread.
> -		 */
> +		__loop_clr_fd(lo);
> +		goto done;
> +	} else {
>  		blk_mq_freeze_queue(lo->lo_queue);
>  		blk_mq_unfreeze_queue(lo->lo_queue);
>  	}
>  
>  out_unlock:
>  	mutex_unlock(&lo->lo_mutex);
> +done:
> +	/* Drop references which would have been dropped after lo_release(). */
> +	kobject_put(&disk_to_dev(disk)->kobj);
> +	module_put(disk->fops->owner);
> +	atomic_dec(&lo->async_pending);
> +	return 0;
> +}
> +
> +static const struct file_operations loop_close_fops = {
> +	.open = lo_no_open,
> +	.release = lo_post_release,
> +};
> +
> +struct release_event {
> +	struct list_head head;
> +	struct file *file;
> +};
> +
> +static LIST_HEAD(release_event_spool);
> +static DEFINE_SPINLOCK(release_event_spinlock);
> +
> +static int lo_open(struct block_device *bdev, fmode_t mode)
> +{
> +	struct loop_device *lo = bdev->bd_disk->private_data;
> +	int err = 0;
> +	/*
> +	 * Reserve an anon_inode for calling lo_post_open() before returning to
> +	 * user mode. Since fput() by kernel thread defers actual cleanup to WQ
> +	 * context, there is no point with calling lo_post_open() from kernel
> +	 * threads.
> +	 */
> +	struct file *open = (current->flags & PF_KTHREAD) ? NULL :
> +		anon_inode_getfile("loop.open", &loop_open_fops, NULL, O_CLOEXEC);
> +	/*
> +	 * Reserve an anon_inode for calling lo_post_release() from
> +	 * lo_release() before returning to user mode.
> +	 */
> +	struct file *close = anon_inode_getfile("loop.close", &loop_close_fops, NULL, O_CLOEXEC);
> +	struct release_event *ev = kmalloc(sizeof(*ev), GFP_KERNEL | __GFP_NOWARN);
> +
> +	if (!ev || IS_ERR(open) || IS_ERR(close)) {
> +		err = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	spin_lock(&loop_delete_spinlock);
> +	/* lo->lo_state may be changed to any Lo_* but Lo_deleting. */
> +	if (data_race(lo->lo_state) == Lo_deleting)
> +		err = -ENXIO;
> +	else
> +		atomic_inc(&lo->lo_refcnt);
> +	spin_unlock(&loop_delete_spinlock);
> +	if (err)
> +		goto cleanup;
> +
> +	/* close->private_data is set when lo_release() is called. */
> +	ev->file = close;
> +	spin_lock(&release_event_spinlock);
> +	list_add(&ev->head, &release_event_spool);
> +	spin_unlock(&release_event_spinlock);
> +
> +	/*
> +	 * Try to avoid accessing Lo_rundown loop device.
> +	 *
> +	 * Since the task_work list is LIFO, lo_post_release() will run before
> +	 * lo_post_open() runs if an error occur between returned from
> +	 * lo_open() and returning to user mode. This means that lo->refcnt may
> +	 * be already 0 when lo_post_open() runs. Therefore, use
> +	 * lo->async_pending in order to prevent loop_remove() from releasing
> +	 * this loop device.
> +	 */
> +	if (open) {
> +		open->private_data = lo;
> +		atomic_inc(&lo->async_pending);
> +		fput(open);
> +	}
> +	return 0;
> + cleanup:
> +	if (!IS_ERR_OR_NULL(open))
> +		fput(open);
> +	if (!IS_ERR(close))
> +		fput(close);
> +	kfree(ev);
> +	return err;
> +}
> +
> +static void lo_release(struct gendisk *disk, fmode_t mode)
> +{
> +	struct loop_device *lo = disk->private_data;
> +	struct release_event *ev;
> +
> +	atomic_inc(&lo->async_pending);
> +	/*
> +	 * Fetch from spool. Since a successful lo_open() call is coupled with
> +	 * a lo_release() call, we are guaranteed that spool is not empty.
> +	 */
> +	spin_lock(&release_event_spinlock);
> +	ev = list_first_entry(&release_event_spool, typeof(*ev), head);
> +	list_del(&ev->head);
> +	spin_unlock(&release_event_spinlock);
> +	/* Hold references which will be dropped after lo_release(). */
> +	__module_get(disk->fops->owner);
> +	kobject_get(&disk_to_dev(disk)->kobj);
> +	ev->file->private_data = disk;
> +	fput(ev->file);
> +	kfree(ev);
>  }
>  
>  static const struct block_device_operations lo_fops = {
> @@ -2029,6 +2140,7 @@ static int loop_add(int i)
>  	if (!part_shift)
>  		disk->flags |= GENHD_FL_NO_PART;
>  	atomic_set(&lo->lo_refcnt, 0);
> +	atomic_set(&lo->async_pending, 0);
>  	mutex_init(&lo->lo_mutex);
>  	lo->lo_number		= i;
>  	spin_lock_init(&lo->lo_lock);
> @@ -2070,6 +2182,9 @@ static int loop_add(int i)
>  
>  static void loop_remove(struct loop_device *lo)
>  {
> +	/* Wait for task work and/or WQ to complete. */
> +	while (atomic_read(&lo->async_pending))
> +		schedule_timeout_uninterruptible(1);
>  	/* Make this loop device unreachable from pathname. */
>  	del_gendisk(lo->lo_disk);
>  	blk_cleanup_disk(lo->lo_disk);
> @@ -2118,19 +2233,18 @@ static int loop_control_remove(int idx)
>  	ret = mutex_lock_killable(&lo->lo_mutex);
>  	if (ret)
>  		goto mark_visible;
> -	if (lo->lo_state != Lo_unbound ||
> -	    atomic_read(&lo->lo_refcnt) > 0) {
> -		mutex_unlock(&lo->lo_mutex);
> +	spin_lock(&loop_delete_spinlock);
> +	/* Mark this loop device no longer open()-able if nobody is using. */
> +	if (lo->lo_state != Lo_unbound || atomic_read(&lo->lo_refcnt) > 0)
>  		ret = -EBUSY;
> -		goto mark_visible;
> -	}
> -	/* Mark this loop device no longer open()-able. */
> -	lo->lo_state = Lo_deleting;
> +	else
> +		lo->lo_state = Lo_deleting;
> +	spin_unlock(&loop_delete_spinlock);
>  	mutex_unlock(&lo->lo_mutex);
> -
> -	loop_remove(lo);
> -	return 0;
> -
> +	if (!ret) {
> +		loop_remove(lo);
> +		return 0;
> +	}
>  mark_visible:
>  	/* Show this loop device again. */
>  	mutex_lock(&loop_ctl_mutex);
> diff --git a/drivers/block/loop.h b/drivers/block/loop.h
> index 082d4b6bfc6a..20fc5eebe455 100644
> --- a/drivers/block/loop.h
> +++ b/drivers/block/loop.h
> @@ -56,6 +56,7 @@ struct loop_device {
>  	struct gendisk		*lo_disk;
>  	struct mutex		lo_mutex;
>  	bool			idr_visible;
> +	atomic_t		async_pending;
>  };
>  
>  struct loop_cmd {
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
