Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51560C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 18:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336B260EB5
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 18:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhH0Snz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 14:43:55 -0400
Received: from verein.lst.de ([213.95.11.211]:34901 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229882AbhH0Snz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 14:43:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0D19E67373; Fri, 27 Aug 2021 20:43:03 +0200 (CEST)
Date:   Fri, 27 Aug 2021 20:43:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Hillf Danton <hdanton@sina.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] loop: replace loop_ctl_mutex with loop_idr_spinlock
Message-ID: <20210827184302.GA29967@lst.de>
References: <2642808b-a7d0-28ff-f288-0f4eabc562f7@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2642808b-a7d0-28ff-f288-0f4eabc562f7@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 27, 2021 at 01:03:45AM +0900, Tetsuo Handa wrote:
> 
> loop_unregister_transfer() which is called from cleanup_cryptoloop()
> currently lacks serialization between kfree() from loop_remove() from
> loop_control_remove() and mutex_lock() from unregister_transfer_cb().
> We can use refcount and loop_idr_spinlock for serialization between
> these functions.


So before we start complicating things for loop_release_xfer - how
do you actually reproduce loop_unregister_transfer finding a loop
device with a transfer set?  AFAICS loop_unregister_transfer is only
called form exit_cryptoloop, which can only be called when
cryptoloop has a zero reference count.  But as long as a transfer
is registered an extra refcount is held on its owner.

> @@ -2313,20 +2320,20 @@ static int loop_add(int i)
>  		goto out;
>  	lo->lo_state = Lo_unbound;
>  
> -	err = mutex_lock_killable(&loop_ctl_mutex);
> -	if (err)
> -		goto out_free_dev;
> -
>  	/* allocate id, if @id >= 0, we're requesting that specific id */
> +	idr_preload(GFP_KERNEL);
> +	spin_lock(&loop_idr_spinlock);
>  	if (i >= 0) {
> -		err = idr_alloc(&loop_index_idr, lo, i, i + 1, GFP_KERNEL);
> +		err = idr_alloc(&loop_index_idr, lo, i, i + 1, GFP_ATOMIC);
>  		if (err == -ENOSPC)
>  			err = -EEXIST;
>  	} else {
> -		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_KERNEL);
> +		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_ATOMIC);
>  	}
> +	spin_unlock(&loop_idr_spinlock);
> +	idr_preload_end();

Can you explain why the mutex is switched to a spinlock?  I could not
find any caller that can't block, so there doesn't seem to be a real
need for a spinlock, while a spinlock requires extra work and GFP_ATOMIC
allocations here.  Dropping the _killable probably makes some sense,
but seems like a separate cleanup.

> +	if (!lo || !refcount_inc_not_zero(&lo->idr_visible)) {
> +		spin_unlock(&loop_idr_spinlock);
> +		return -ENODEV;
>  	}
> +	spin_unlock(&loop_idr_spinlock);

> +	refcount_dec(&lo->idr_visible);
> +	/*
> +	 * Try to wait for concurrent callers (they should complete shortly due to
> +	 * lo->lo_state == Lo_deleting) operating on this loop device, in order to
> +	 * help that subsequent loop_add() will not to fail with -EEXIST.
> +	 * Note that this is best effort.
> +	 */
> +	for (ret = 0; refcount_read(&lo->idr_visible) != 1 && ret < HZ; ret++)
> +		schedule_timeout_killable(1);
> +	ret = 0;

This dance looks pretty strange to me.  I think just making idr_visible
an atomic_t and using atomic_cmpxchg with just 0 and 1 as valid versions
will make this much simpler, as it avoids the need to deal with a > 1
count, and it also serializes multiple removal calls.

I quickly hacked this up as a slight variant of your patch, and it's been
running the syzbot reproducer you pointed me to for quite while now:

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f0cdff0c5fbf4..69ced1feb18d5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2113,28 +2113,29 @@ int loop_register_transfer(struct loop_func_table *funcs)
 	return 0;
 }
 
-static int unregister_transfer_cb(int id, void *ptr, void *data)
-{
-	struct loop_device *lo = ptr;
-	struct loop_func_table *xfer = data;
-
-	mutex_lock(&lo->lo_mutex);
-	if (lo->lo_encryption == xfer)
-		loop_release_xfer(lo);
-	mutex_unlock(&lo->lo_mutex);
-	return 0;
-}
-
 int loop_unregister_transfer(int number)
 {
 	unsigned int n = number;
 	struct loop_func_table *xfer;
+	struct loop_device *lo;
+	int id;
 
 	if (n == 0 || n >= MAX_LO_CRYPT || (xfer = xfer_funcs[n]) == NULL)
 		return -EINVAL;
 
 	xfer_funcs[n] = NULL;
-	idr_for_each(&loop_index_idr, &unregister_transfer_cb, xfer);
+
+	/*
+	 * loop_unregister_transfer is only called from cryptoloop module
+	 * unload.  Given that each loop device that has a transfer enabled
+	 * hold a reference to the module implementing it we should never
+	 * get here with a transfer that is set.
+	 */
+	mutex_lock(&loop_ctl_mutex);
+	idr_for_each_entry(&loop_index_idr, lo, id)
+		WARN_ON_ONCE(lo->lo_encryption == xfer);
+	mutex_unlock(&loop_ctl_mutex);
+
 	return 0;
 }
 
@@ -2325,8 +2326,9 @@ static int loop_add(int i)
 	} else {
 		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_KERNEL);
 	}
+	mutex_unlock(&loop_ctl_mutex);
 	if (err < 0)
-		goto out_unlock;
+		goto out_free_dev;
 	i = err;
 
 	err = -ENOMEM;
@@ -2392,15 +2394,17 @@ static int loop_add(int i)
 	disk->private_data	= lo;
 	disk->queue		= lo->lo_queue;
 	sprintf(disk->disk_name, "loop%d", i);
+	/* Make this loop device reachable from pathname. */
 	add_disk(disk);
-	mutex_unlock(&loop_ctl_mutex);
+	/* Show this loop device. */
+	atomic_set(&lo->idr_visible, 1);
 	return i;
 
 out_cleanup_tags:
 	blk_mq_free_tag_set(&lo->tag_set);
 out_free_idr:
+	mutex_lock(&loop_ctl_mutex);
 	idr_remove(&loop_index_idr, i);
-out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 out_free_dev:
 	kfree(lo);
@@ -2410,9 +2414,14 @@ static int loop_add(int i)
 
 static void loop_remove(struct loop_device *lo)
 {
+	/* Make this loop device unreachable from pathname. */
 	del_gendisk(lo->lo_disk);
 	blk_cleanup_disk(lo->lo_disk);
 	blk_mq_free_tag_set(&lo->tag_set);
+	mutex_lock(&loop_ctl_mutex);
+	idr_remove(&loop_index_idr, lo->lo_number);
+	mutex_unlock(&loop_ctl_mutex);
+	/* There is no route which can find this loop device. */
 	mutex_destroy(&lo->lo_mutex);
 	kfree(lo);
 }
@@ -2440,29 +2449,40 @@ static int loop_control_remove(int idx)
 	if (ret)
 		return ret;
 
+	/*
+	 * Identify the loop device to remove. Skip the device if it is owned by
+	 * loop_remove()/loop_add() where it is not safe to access lo_mutex.
+	 * The loop device is marked invisible even if we bail out of the
+	 * removal, but the only other place checking the visibility is the
+	 * LOOP_CTL_GET_FREE ioctl, which checks the same flags as we do below,
+	 * and which is fundamentally racy anyway.
+	 */
 	lo = idr_find(&loop_index_idr, idx);
-	if (!lo) {
-		ret = -ENODEV;
-		goto out_unlock_ctrl;
+	if (!lo || atomic_cmpxchg(&lo->idr_visible, 1, 0) == 0) {
+		mutex_unlock(&loop_ctl_mutex);
+		return -ENODEV;
 	}
+	mutex_unlock(&loop_ctl_mutex);
 
 	ret = mutex_lock_killable(&lo->lo_mutex);
 	if (ret)
-		goto out_unlock_ctrl;
+		goto mark_visible;
 	if (lo->lo_state != Lo_unbound ||
 	    atomic_read(&lo->lo_refcnt) > 0) {
 		mutex_unlock(&lo->lo_mutex);
 		ret = -EBUSY;
-		goto out_unlock_ctrl;
+		goto mark_visible;
 	}
+	/* Mark this loop device no longer open()-able. */
 	lo->lo_state = Lo_deleting;
 	mutex_unlock(&lo->lo_mutex);
 
-	idr_remove(&loop_index_idr, lo->lo_number);
 	loop_remove(lo);
-out_unlock_ctrl:
-	mutex_unlock(&loop_ctl_mutex);
-	return ret;
+	return 0;
+
+mark_visible:
+	atomic_inc(&lo->idr_visible);
+	return -EBUSY;
 }
 
 static int loop_control_get_free(int idx)
@@ -2474,7 +2494,8 @@ static int loop_control_get_free(int idx)
 	if (ret)
 		return ret;
 	idr_for_each_entry(&loop_index_idr, lo, id) {
-		if (lo->lo_state == Lo_unbound)
+		if (atomic_read(&lo->idr_visible) &&
+		    lo->lo_state == Lo_unbound)
 			goto found;
 	}
 	mutex_unlock(&loop_ctl_mutex);
@@ -2590,10 +2611,12 @@ static void __exit loop_exit(void)
 	unregister_blkdev(LOOP_MAJOR, "loop");
 	misc_deregister(&loop_misc);
 
-	mutex_lock(&loop_ctl_mutex);
+	/*
+	 * There is no need to use loop_ctl_mutex here, for nobody else can
+	 * access loop_index_idr when this module is unloading.
+	 */
 	idr_for_each_entry(&loop_index_idr, lo, id)
 		loop_remove(lo);
-	mutex_unlock(&loop_ctl_mutex);
 
 	idr_destroy(&loop_index_idr);
 }
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 1988899db63ac..1ec5135da54a7 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -68,6 +68,7 @@ struct loop_device {
 	struct blk_mq_tag_set	tag_set;
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
+	atomic_t		idr_visible; /* a bool in reality */
 };
 
 struct loop_cmd {
