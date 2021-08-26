Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29368C432BE
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 16:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0913E61058
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 16:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242962AbhHZQEt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:04:49 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58859 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbhHZQEt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 12:04:49 -0400
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17QG3lnB035104;
        Fri, 27 Aug 2021 01:03:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Fri, 27 Aug 2021 01:03:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17QG3lAe035100
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 27 Aug 2021 01:03:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block <linux-block@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] loop: replace loop_ctl_mutex with loop_idr_spinlock
Message-ID: <2642808b-a7d0-28ff-f288-0f4eabc562f7@i-love.sakura.ne.jp>
Date:   Fri, 27 Aug 2021 01:03:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot is reporting circular locking problem at __loop_clr_fd() [1], for
commit a160c6159d4a0cf8 ("block: add an optional probe callback to
major_names") is calling the module's probe function with major_names_lock
held.

Fortunately, since commit 990e78116d38059c ("block: loop: fix deadlock
between open and remove") stopped holding loop_ctl_mutex in lo_open(),
current role of loop_ctl_mutex is to serialize access to loop_index_idr
and loop_add()/loop_remove(); in other words, management of id for IDR.

Therefore, this patch introduces loop_idr_spinlock and a refcount for
protecting access to loop_index_idr. By introducing refcount for hiding
not-yet-initialized/to-be-released loop devices, we can remove
loop_ctl_mutex completely.

loop_unregister_transfer() which is called from cleanup_cryptoloop()
currently lacks serialization between kfree() from loop_remove() from
loop_control_remove() and mutex_lock() from unregister_transfer_cb().
We can use refcount and loop_idr_spinlock for serialization between
these functions.

Holding loop_ctl_mutex in loop_exit() is pointless, for all users must
close /dev/loop-control and /dev/loop$num (in order to drop module's
refcount to 0) before loop_exit() starts, and nobody can open
/dev/loop-control or /dev/loop$num afterwards.

Link: https://syzkaller.appspot.com/bug?id=7bb10e8b62f83e4d445cdf4c13d69e407e629558 [1]
Reported-by: syzbot <syzbot+f61766d5763f9e7a118f@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+f61766d5763f9e7a118f@syzkaller.appspotmail.com>
---
This is an alternative to "sort out the lock order in the loop driver v2"
posted at https://lkml.kernel.org/r/20210826133810.3700-1-hch@lst.de .

 drivers/block/loop.c | 125 +++++++++++++++++++++++++++----------------
 drivers/block/loop.h |   1 +
 2 files changed, 79 insertions(+), 47 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f0cdff0c5fbf..783b3d2ed277 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -87,7 +87,7 @@
 #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
 
 static DEFINE_IDR(loop_index_idr);
-static DEFINE_MUTEX(loop_ctl_mutex);
+static DEFINE_SPINLOCK(loop_idr_spinlock);
 static DEFINE_MUTEX(loop_validate_mutex);
 
 /**
@@ -2113,28 +2113,35 @@ int loop_register_transfer(struct loop_func_table *funcs)
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
+static void loop_remove(struct loop_device *lo);
 
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
+	spin_lock(&loop_idr_spinlock);
+	idr_for_each_entry(&loop_index_idr, lo, id) {
+		if (!refcount_inc_not_zero(&lo->idr_visible))
+			continue;
+		spin_unlock(&loop_idr_spinlock);
+		mutex_lock(&lo->lo_mutex);
+		if (lo->lo_encryption == xfer)
+			loop_release_xfer(lo);
+		mutex_unlock(&lo->lo_mutex);
+		if (refcount_dec_and_test(&lo->idr_visible))
+			loop_remove(lo);
+		spin_lock(&loop_idr_spinlock);
+	}
+	spin_unlock(&loop_idr_spinlock);
+
 	return 0;
 }
 
@@ -2313,20 +2320,20 @@ static int loop_add(int i)
 		goto out;
 	lo->lo_state = Lo_unbound;
 
-	err = mutex_lock_killable(&loop_ctl_mutex);
-	if (err)
-		goto out_free_dev;
-
 	/* allocate id, if @id >= 0, we're requesting that specific id */
+	idr_preload(GFP_KERNEL);
+	spin_lock(&loop_idr_spinlock);
 	if (i >= 0) {
-		err = idr_alloc(&loop_index_idr, lo, i, i + 1, GFP_KERNEL);
+		err = idr_alloc(&loop_index_idr, lo, i, i + 1, GFP_ATOMIC);
 		if (err == -ENOSPC)
 			err = -EEXIST;
 	} else {
-		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_KERNEL);
+		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_ATOMIC);
 	}
+	spin_unlock(&loop_idr_spinlock);
+	idr_preload_end();
 	if (err < 0)
-		goto out_unlock;
+		goto out_free_dev;
 	i = err;
 
 	err = -ENOMEM;
@@ -2392,16 +2399,18 @@ static int loop_add(int i)
 	disk->private_data	= lo;
 	disk->queue		= lo->lo_queue;
 	sprintf(disk->disk_name, "loop%d", i);
+	/* Make this loop device reachable from pathname. */
 	add_disk(disk);
-	mutex_unlock(&loop_ctl_mutex);
+	/* Show this loop device. */
+	refcount_set(&lo->idr_visible, 1);
 	return i;
 
 out_cleanup_tags:
 	blk_mq_free_tag_set(&lo->tag_set);
 out_free_idr:
+	spin_lock(&loop_idr_spinlock);
 	idr_remove(&loop_index_idr, i);
-out_unlock:
-	mutex_unlock(&loop_ctl_mutex);
+	spin_unlock(&loop_idr_spinlock);
 out_free_dev:
 	kfree(lo);
 out:
@@ -2410,9 +2419,14 @@ static int loop_add(int i)
 
 static void loop_remove(struct loop_device *lo)
 {
+	/* Make this loop device unreachable from pathname. */
 	del_gendisk(lo->lo_disk);
 	blk_cleanup_disk(lo->lo_disk);
 	blk_mq_free_tag_set(&lo->tag_set);
+	spin_lock(&loop_idr_spinlock);
+	idr_remove(&loop_index_idr, lo->lo_number);
+	spin_unlock(&loop_idr_spinlock);
+	/* There is no route which can find this loop device. */
 	mutex_destroy(&lo->lo_mutex);
 	kfree(lo);
 }
@@ -2435,52 +2449,67 @@ static int loop_control_remove(int idx)
 		pr_warn("deleting an unspecified loop device is not supported.\n");
 		return -EINVAL;
 	}
-		
-	ret = mutex_lock_killable(&loop_ctl_mutex);
-	if (ret)
-		return ret;
 
+	/*
+	 * Identify the loop device to remove. Skip the device if it is owned by
+	 * loop_remove()/loop_add() where it is not safe to access lo_mutex.
+	 */
+	spin_lock(&loop_idr_spinlock);
 	lo = idr_find(&loop_index_idr, idx);
-	if (!lo) {
-		ret = -ENODEV;
-		goto out_unlock_ctrl;
+	if (!lo || !refcount_inc_not_zero(&lo->idr_visible)) {
+		spin_unlock(&loop_idr_spinlock);
+		return -ENODEV;
 	}
+	spin_unlock(&loop_idr_spinlock);
 
 	ret = mutex_lock_killable(&lo->lo_mutex);
 	if (ret)
-		goto out_unlock_ctrl;
+		goto out;
 	if (lo->lo_state != Lo_unbound ||
 	    atomic_read(&lo->lo_refcnt) > 0) {
 		mutex_unlock(&lo->lo_mutex);
-		ret = -EBUSY;
-		goto out_unlock_ctrl;
+		if (lo->lo_state == Lo_deleting)
+			ret = -ENODEV;
+		else
+			ret = -EBUSY;
+		goto out;
 	}
+	/* Mark this loop device no longer open()-able. */
 	lo->lo_state = Lo_deleting;
 	mutex_unlock(&lo->lo_mutex);
-
-	idr_remove(&loop_index_idr, lo->lo_number);
-	loop_remove(lo);
-out_unlock_ctrl:
-	mutex_unlock(&loop_ctl_mutex);
+	/* Hide this loop device. */
+	refcount_dec(&lo->idr_visible);
+	/*
+	 * Try to wait for concurrent callers (they should complete shortly due to
+	 * lo->lo_state == Lo_deleting) operating on this loop device, in order to
+	 * help that subsequent loop_add() will not to fail with -EEXIST.
+	 * Note that this is best effort.
+	 */
+	for (ret = 0; refcount_read(&lo->idr_visible) != 1 && ret < HZ; ret++)
+		schedule_timeout_killable(1);
+	ret = 0;
+out:
+	/* Remove this loop device. */
+	if (refcount_dec_and_test(&lo->idr_visible))
+		loop_remove(lo);
 	return ret;
 }
 
 static int loop_control_get_free(int idx)
 {
 	struct loop_device *lo;
-	int id, ret;
+	int id;
 
-	ret = mutex_lock_killable(&loop_ctl_mutex);
-	if (ret)
-		return ret;
+	spin_lock(&loop_idr_spinlock);
 	idr_for_each_entry(&loop_index_idr, lo, id) {
-		if (lo->lo_state == Lo_unbound)
+		if (refcount_read(&lo->idr_visible) &&
+		    lo->lo_state == Lo_unbound)
 			goto found;
 	}
-	mutex_unlock(&loop_ctl_mutex);
+	spin_unlock(&loop_idr_spinlock);
 	return loop_add(-1);
 found:
-	mutex_unlock(&loop_ctl_mutex);
+	spin_unlock(&loop_idr_spinlock);
 	return id;
 }
 
@@ -2590,10 +2619,12 @@ static void __exit loop_exit(void)
 	unregister_blkdev(LOOP_MAJOR, "loop");
 	misc_deregister(&loop_misc);
 
-	mutex_lock(&loop_ctl_mutex);
+	/*
+	 * There is no need to use loop_idr_spinlock here, for nobody else can
+	 * access loop_index_idr when this module is unloading.
+	 */
 	idr_for_each_entry(&loop_index_idr, lo, id)
 		loop_remove(lo);
-	mutex_unlock(&loop_ctl_mutex);
 
 	idr_destroy(&loop_index_idr);
 }
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 1988899db63a..bed350d8722f 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -68,6 +68,7 @@ struct loop_device {
 	struct blk_mq_tag_set	tag_set;
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
+	refcount_t		idr_visible;
 };
 
 struct loop_cmd {
-- 
2.25.1

