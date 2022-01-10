Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CD3C433FE
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 10:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243963AbiAJKbG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 05:31:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42850 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiAJKbB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 05:31:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9B86F2114D;
        Mon, 10 Jan 2022 10:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641810659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fy1vWt5bnCY596XNmv3bi4Br9wh7jHy5H7M0wk1OcD4=;
        b=XQLhfs/b3HafFcXwtR2QzomykyTy3T6MVqB1eUf23LZMgyUDLyB0BwqVLa99ZviVXBhCst
        Wx++cVmZ/+bUi9Zt4tLQMXkmX3NMAqjc91ioGGjbuYq7cdVGiEnWAEjJM0tHVPLeMnQcF1
        HsQXyRzNs3e7ybgQ++Z4sBeKC2EDY9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641810659;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fy1vWt5bnCY596XNmv3bi4Br9wh7jHy5H7M0wk1OcD4=;
        b=gq4fq9DgioW/d/PSMuVLrtLr0URodKU6Buj6ltNta3JtWDzvIcr5iedspiW/uhXH400ehY
        SIo828ou10KPbsBg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2D117A3B8B;
        Mon, 10 Jan 2022 10:30:58 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E24D7A06D7; Mon, 10 Jan 2022 11:30:57 +0100 (CET)
Date:   Mon, 10 Jan 2022 11:30:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Message-ID: <20220110103057.h775jv2br2xr2l5k@quack3.lan>
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp>
 <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 07-01-22 20:04:31, Tetsuo Handa wrote:
> Jan Stancek is reporting that commit 322c4293ecc58110 ("loop: make
> autoclear operation asynchronous") broke LTP tests which run /bin/mount
> and /bin/umount in close succession like
> 
>   while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done
> 
> . This is because since /usr/lib/systemd/systemd-udevd asynchronously
> opens the loop device which /bin/mount and /bin/umount are operating,
> autoclear from lo_release() is likely triggered by systemd-udevd than
> mount or umount. And unfortunately, /bin/mount fails if read of superblock
> (for examining filesystem type) returned an error due to the backing file
> being cleared by __loop_clr_fd(). It turned out that disk->open_mutex was
> by chance serving as a barrier for serializing "__loop_clr_fd() from
> lo_release()" and "vfs_read() after lo_open()", and we need to restore
> this barrier (without reintroducing circular locking dependency).
> 
> Also, the kernel test robot is reporting that that commit broke xfstest
> which does
> 
>   umount ext2 on xfs
>   umount xfs
> 
> sequence.
> 
> One of approaches for fixing these problems is to revert that commit and
> instead remove destroy_workqueue() from __loop_clr_fd(), for it turned out
> that we did not need to call flush_workqueue() from __loop_clr_fd() since
> blk_mq_freeze_queue() blocks until all pending "struct work_struct" are
> processed by loop_process_work(). But we are not sure whether it is safe
> to wait blk_mq_freeze_queue() etc. with disk->open_mutex held; it could
> be simply because dependency is not clear enough for fuzzers to cover and
> lockdep to detect.
> 
> Therefore, before taking revert approach, let's try if we can use task
> work approach which is called without locks held while the caller can
> wait for completion of that task work before returning to user mode.
> 
> This patch tries to make lo_open()/lo_release() to locklessly wait for
> __loop_clr_fd() by inserting a task work into lo_open()/lo_release() if
> possible.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Eek, I agree that the patch may improve the situation but is the complexity
and ugliness really worth it? I mean using task work in
loop_schedule_rundown() makes a lot of sense because the loop

while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done

will not fail because of dangling work in the workqueue after umount ->
__loop_clr_fd(). But when other processes like systemd-udevd start to mess
with the loop device, then you have no control whether the following mount
will see isofs.iso busy or not - it depends on when systemd-udevd decides
to close the loop device. What your waiting in lo_open() achieves is only
that if __loop_clr_fd() from systemd-udevd happens to run at the same time
as lo_open() from mount, then we won't see EBUSY. But IMO that is not worth
the complexity in lo_open() because if systemd-udevd happens to close the
loop device a milisecond later, you will get EBUSY anyway (and you would
get it even in the past) Or am I missing something?

								Honza

> ---
> Changes in v2:
>   Need to also wait on lo_open(), per Jan's testcase.
> 
>  drivers/block/loop.c | 70 ++++++++++++++++++++++++++++++++++++++++----
>  drivers/block/loop.h |  5 +++-
>  2 files changed, 68 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index b1b05c45c07c..8ef6da186c5c 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -89,6 +89,7 @@
>  static DEFINE_IDR(loop_index_idr);
>  static DEFINE_MUTEX(loop_ctl_mutex);
>  static DEFINE_MUTEX(loop_validate_mutex);
> +static DECLARE_WAIT_QUEUE_HEAD(loop_rundown_wait);
>  
>  /**
>   * loop_global_lock_killable() - take locks for safe loop_validate_file() test
> @@ -1172,13 +1173,12 @@ static void loop_rundown_completed(struct loop_device *lo)
>  	mutex_lock(&lo->lo_mutex);
>  	lo->lo_state = Lo_unbound;
>  	mutex_unlock(&lo->lo_mutex);
> +	wake_up_all(&loop_rundown_wait);
>  	module_put(THIS_MODULE);
>  }
>  
> -static void loop_rundown_workfn(struct work_struct *work)
> +static void loop_rundown_start(struct loop_device *lo)
>  {
> -	struct loop_device *lo = container_of(work, struct loop_device,
> -					      rundown_work);
>  	struct block_device *bdev = lo->lo_device;
>  	struct gendisk *disk = lo->lo_disk;
>  
> @@ -1188,6 +1188,18 @@ static void loop_rundown_workfn(struct work_struct *work)
>  	loop_rundown_completed(lo);
>  }
>  
> +static void loop_rundown_callbackfn(struct callback_head *callback)
> +{
> +	loop_rundown_start(container_of(callback, struct loop_device,
> +					rundown.callback));
> +}
> +
> +static void loop_rundown_workfn(struct work_struct *work)
> +{
> +	loop_rundown_start(container_of(work, struct loop_device,
> +					rundown.work));
> +}
> +
>  static void loop_schedule_rundown(struct loop_device *lo)
>  {
>  	struct block_device *bdev = lo->lo_device;
> @@ -1195,8 +1207,13 @@ static void loop_schedule_rundown(struct loop_device *lo)
>  
>  	__module_get(disk->fops->owner);
>  	kobject_get(&bdev->bd_device.kobj);
> -	INIT_WORK(&lo->rundown_work, loop_rundown_workfn);
> -	queue_work(system_long_wq, &lo->rundown_work);
> +	if (!(current->flags & PF_KTHREAD)) {
> +		init_task_work(&lo->rundown.callback, loop_rundown_callbackfn);
> +		if (!task_work_add(current, &lo->rundown.callback, TWA_RESUME))
> +			return;
> +	}
> +	INIT_WORK(&lo->rundown.work, loop_rundown_workfn);
> +	queue_work(system_long_wq, &lo->rundown.work);
>  }
>  
>  static int loop_clr_fd(struct loop_device *lo)
> @@ -1721,19 +1738,60 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
>  }
>  #endif
>  
> +struct loop_rundown_waiter {
> +	struct callback_head callback;
> +	struct loop_device *lo;
> +};
> +
> +static void loop_rundown_waiter_callbackfn(struct callback_head *callback)
> +{
> +	struct loop_rundown_waiter *lrw =
> +		container_of(callback, struct loop_rundown_waiter, callback);
> +
> +	/*
> +	 * Locklessly wait for completion of __loop_clr_fd().
> +	 * This should be safe because of the following rules.
> +	 *
> +	 *  (a) From locking dependency perspective, this function is called
> +	 *      without any locks held.
> +	 *  (b) From execution ordering perspective, this function is called
> +	 *      by the moment lo_open() from open() syscall returns to user
> +	 *      mode.
> +	 *  (c) From use-after-free protection perspective, this function is
> +	 *      called before loop_remove() is called, for lo->lo_refcnt taken
> +	 *      by lo_open() prevents loop_control_remove() and loop_exit().
> +	 */
> +	wait_event_killable(loop_rundown_wait, data_race(lrw->lo->lo_state) != Lo_rundown);
> +	kfree(lrw);
> +}
> +
>  static int lo_open(struct block_device *bdev, fmode_t mode)
>  {
>  	struct loop_device *lo = bdev->bd_disk->private_data;
> +	struct loop_rundown_waiter *lrw =
> +		kmalloc(sizeof(*lrw), GFP_KERNEL | __GFP_NOWARN);
>  	int err;
>  
> +	if (!lrw)
> +		return -ENOMEM;
>  	err = mutex_lock_killable(&lo->lo_mutex);
> -	if (err)
> +	if (err) {
> +		kfree(lrw);
>  		return err;
> +	}
>  	if (lo->lo_state == Lo_deleting)
>  		err = -ENXIO;
>  	else
>  		atomic_inc(&lo->lo_refcnt);
>  	mutex_unlock(&lo->lo_mutex);
> +	if (!err && !(current->flags & PF_KTHREAD)) {
> +		init_task_work(&lrw->callback, loop_rundown_waiter_callbackfn);
> +		lrw->lo = lo;
> +		if (task_work_add(current, &lrw->callback, TWA_RESUME))
> +			kfree(lrw);
> +	} else {
> +		kfree(lrw);
> +	}
>  	return err;
>  }
>  
> diff --git a/drivers/block/loop.h b/drivers/block/loop.h
> index 918a7a2dc025..596472f9cde3 100644
> --- a/drivers/block/loop.h
> +++ b/drivers/block/loop.h
> @@ -56,7 +56,10 @@ struct loop_device {
>  	struct gendisk		*lo_disk;
>  	struct mutex		lo_mutex;
>  	bool			idr_visible;
> -	struct work_struct      rundown_work;
> +	union {
> +		struct work_struct   work;
> +		struct callback_head callback;
> +	} rundown;
>  };
>  
>  struct loop_cmd {
> -- 
> 2.32.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
