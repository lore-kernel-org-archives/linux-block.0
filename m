Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3A6C433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 11:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239925AbiA0LEW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 06:04:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38930 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239941AbiA0LEV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 06:04:21 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 93084210F7;
        Thu, 27 Jan 2022 11:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643281460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YhCdl10FbQKM1lg3DWmXOhrdVoHtZuKs/FFRrF6xPdo=;
        b=umHW/o+H6jQL1NKN8Zzz0fksLqz1GhSpQWWoaO3yRttBUaH0EuAf9Mvyi4VttcB7OlDCpS
        sQ1cdmFtMIjsBmIRH2sKjrQt8RLdr1Acichl63L7+Cj2FXhfmyffOMUno0EylesU+v/jwa
        w9szxZO8vyoEY7PBs97P2fdGI0uR4Gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643281460;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YhCdl10FbQKM1lg3DWmXOhrdVoHtZuKs/FFRrF6xPdo=;
        b=o+mF65vmb587PueVgAKH6B4eCh2mya8+k0bZMW34RHLiXzWt7KwDRdo35eaduihaDlfHgw
        IP/ul8QLZ7m/ZGCw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7076AA3B88;
        Thu, 27 Jan 2022 11:04:20 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 33F14A05E6; Thu, 27 Jan 2022 12:04:20 +0100 (CET)
Date:   Thu, 27 Jan 2022 12:04:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        syzbot <syzbot+643e4ce4b6ad1347d372@syzkaller.appspotmail.com>
Subject: Re: [PATCH 8/8] loop: make autoclear operation synchronous again
Message-ID: <20220127110420.xbi5hwehxk7dgzr7@quack3.lan>
References: <20220126155040.1190842-1-hch@lst.de>
 <20220126155040.1190842-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126155040.1190842-9-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 26-01-22 16:50:40, Christoph Hellwig wrote:
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> The kernel test robot is reporting that xfstest can fail at
> 
>   umount ext2 on xfs
>   umount xfs
> 
> sequence, for commit 322c4293ecc58110 ("loop: make autoclear operation
> asynchronous") broke what commit ("loop: Make explicit loop device
> destruction lazy") wanted to achieve.
> 
> Although we cannot guarantee that nobody is holding a reference when
> "umount xfs" is called, we should try to close a race window opened
> by asynchronous autoclear operation.
> 
> It turned out that there is no need to call flush_workqueue() from
> __loop_clr_fd(), for blk_mq_freeze_queue() blocks until all pending
> "struct work_struct" are processed by loop_process_work().
> 
> Revert commit 322c4293ecc58110 ("loop: make autoclear operation
> asynchronous"), and simply defer calling destroy_workqueue() till
> loop_remove() after ensuring that the worker rbtree and repaing
> timer are kept alive while the loop device exists.
> 
> Since a loop device is likely reused after once created thanks to
> ioctl(LOOP_CTL_GET_FREE), being unable to destroy corresponding WQ
> when ioctl(LOOP_CLR_FD) is called should be an acceptable waste.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Tested-by: syzbot <syzbot+643e4ce4b6ad1347d372@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> [hch: rebased, keep the work rbtree and timer around longer]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 71 ++++++++++++++------------------------------
>  drivers/block/loop.h |  1 -
>  2 files changed, 23 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index fc0cdd1612b1d..cf7830a68113a 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1038,10 +1038,10 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	    !file->f_op->write_iter)
>  		lo->lo_flags |= LO_FLAGS_READ_ONLY;
>  
> -	lo->workqueue = alloc_workqueue("loop%d",
> -					WQ_UNBOUND | WQ_FREEZABLE,
> -					0,
> -					lo->lo_number);
> +	if (!lo->workqueue)
> +		lo->workqueue = alloc_workqueue("loop%d",
> +						WQ_UNBOUND | WQ_FREEZABLE,
> +						0, lo->lo_number);
>  	if (!lo->workqueue) {
>  		error = -ENOMEM;
>  		goto out_unlock;
> @@ -1147,10 +1147,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
>  	if (!release)
>  		blk_mq_freeze_queue(lo->lo_queue);
>  
> -	destroy_workqueue(lo->workqueue);
> -	loop_free_idle_workers(lo, true);
> -	del_timer_sync(&lo->timer);
> -
>  	spin_lock_irq(&lo->lo_lock);
>  	filp = lo->lo_backing_file;
>  	lo->lo_backing_file = NULL;
> @@ -1176,9 +1172,11 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
>  	if (lo->lo_flags & LO_FLAGS_PARTSCAN) {
>  		int err;
>  
> -		mutex_lock(&lo->lo_disk->open_mutex);
> +		if (!release)
> +			mutex_lock(&lo->lo_disk->open_mutex);
>  		err = bdev_disk_changed(lo->lo_disk, false);
> -		mutex_unlock(&lo->lo_disk->open_mutex);
> +		if (!release)
> +			mutex_unlock(&lo->lo_disk->open_mutex);
>  		if (err)
>  			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
>  				__func__, lo->lo_number, err);
> @@ -1189,39 +1187,17 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
>  	if (!part_shift)
>  		lo->lo_disk->flags |= GENHD_FL_NO_PART;
>  
> -	fput(filp);
> -}
> -
> -static void loop_rundown_completed(struct loop_device *lo)
> -{
>  	mutex_lock(&lo->lo_mutex);
>  	lo->lo_state = Lo_unbound;
>  	mutex_unlock(&lo->lo_mutex);
>  	module_put(THIS_MODULE);
> -}
> -
> -static void loop_rundown_workfn(struct work_struct *work)
> -{
> -	struct loop_device *lo = container_of(work, struct loop_device,
> -					      rundown_work);
> -	struct block_device *bdev = lo->lo_device;
> -	struct gendisk *disk = lo->lo_disk;
>  
> -	__loop_clr_fd(lo, true);
> -	kobject_put(&bdev->bd_device.kobj);
> -	module_put(disk->fops->owner);
> -	loop_rundown_completed(lo);
> -}
> -
> -static void loop_schedule_rundown(struct loop_device *lo)
> -{
> -	struct block_device *bdev = lo->lo_device;
> -	struct gendisk *disk = lo->lo_disk;
> -
> -	__module_get(disk->fops->owner);
> -	kobject_get(&bdev->bd_device.kobj);
> -	INIT_WORK(&lo->rundown_work, loop_rundown_workfn);
> -	queue_work(system_long_wq, &lo->rundown_work);
> +	/*
> +	 * Need not hold lo_mutex to fput backing file. Calling fput holding
> +	 * lo_mutex triggers a circular lock dependency possibility warning as
> +	 * fput can take open_mutex which is usually taken before lo_mutex.
> +	 */
> +	fput(filp);
>  }
>  
>  static int loop_clr_fd(struct loop_device *lo)
> @@ -1254,7 +1230,6 @@ static int loop_clr_fd(struct loop_device *lo)
>  	mutex_unlock(&lo->lo_mutex);
>  
>  	__loop_clr_fd(lo, false);
> -	loop_rundown_completed(lo);
>  	return 0;
>  }
>  
> @@ -1753,20 +1728,14 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
>  		return;
>  
>  	mutex_lock(&lo->lo_mutex);
> -	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
> -		if (lo->lo_state != Lo_bound)
> -			goto out_unlock;
> +	if (lo->lo_state == Lo_bound &&
> +	    (lo->lo_flags & LO_FLAGS_AUTOCLEAR)) {
>  		lo->lo_state = Lo_rundown;
>  		mutex_unlock(&lo->lo_mutex);
> -		/*
> -		 * In autoclear mode, stop the loop thread
> -		 * and remove configuration after last close.
> -		 */
> -		loop_schedule_rundown(lo);
> +		__loop_clr_fd(lo, true);
>  		return;
>  	}
>  
> -out_unlock:
>  	mutex_unlock(&lo->lo_mutex);
>  }
>  
> @@ -2056,6 +2025,12 @@ static void loop_remove(struct loop_device *lo)
>  	mutex_lock(&loop_ctl_mutex);
>  	idr_remove(&loop_index_idr, lo->lo_number);
>  	mutex_unlock(&loop_ctl_mutex);
> +
> +	if (lo->workqueue)
> +		destroy_workqueue(lo->workqueue);
> +	loop_free_idle_workers(lo, true);
> +	del_timer_sync(&lo->timer);
> +
>  	/* There is no route which can find this loop device. */
>  	mutex_destroy(&lo->lo_mutex);
>  	kfree(lo);
> diff --git a/drivers/block/loop.h b/drivers/block/loop.h
> index 918a7a2dc0259..082d4b6bfc6a6 100644
> --- a/drivers/block/loop.h
> +++ b/drivers/block/loop.h
> @@ -56,7 +56,6 @@ struct loop_device {
>  	struct gendisk		*lo_disk;
>  	struct mutex		lo_mutex;
>  	bool			idr_visible;
> -	struct work_struct      rundown_work;
>  };
>  
>  struct loop_cmd {
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
