Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9276CC04FE3
	for <linux-block@archiver.kernel.org>; Sun, 29 Aug 2021 01:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562A460ED3
	for <linux-block@archiver.kernel.org>; Sun, 29 Aug 2021 01:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbhH2BZF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Aug 2021 21:25:05 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49907 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhH2BZE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Aug 2021 21:25:04 -0400
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17T1Mtxr085178;
        Sun, 29 Aug 2021 10:22:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Sun, 29 Aug 2021 10:22:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17T1Mt8S085173
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 29 Aug 2021 10:22:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH v2] loop: reduce the loop_ctl_mutex scope
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block <linux-block@vger.kernel.org>
References: <2642808b-a7d0-28ff-f288-0f4eabc562f7@i-love.sakura.ne.jp>
 <20210827184302.GA29967@lst.de>
 <73c53177-be1b-cff1-a09e-ef7979a95200@i-love.sakura.ne.jp>
 <20210828071832.GA31755@lst.de>
 <c5e509ec-2361-af25-ec73-e033b5b46ebb@i-love.sakura.ne.jp>
Message-ID: <33a0a1e5-a79f-1887-6417-c5a81f58e47d@i-love.sakura.ne.jp>
Date:   Sun, 29 Aug 2021 10:22:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c5e509ec-2361-af25-ec73-e033b5b46ebb@i-love.sakura.ne.jp>
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
To avoid holding loop_ctl_mutex during whole add/remove operation, use
a bool flag to indicate whether the loop device is ready for use.

loop_unregister_transfer() which is called from cleanup_cryptoloop()
currently has possibility of use-after-free access due to lack of
serialization between kfree() from loop_remove() from loop_control_remove()
and mutex_lock() from unregister_transfer_cb(). But since lo->lo_encryption
should be already NULL when this function is called due to module unload,
and commit 222013f9ac30b9ce ("cryptoloop: add a deprecation warning")
indicates that we will remove this function shortly, this patch updates
this function to emit warning instead of checking lo->lo_encryption.

Holding loop_ctl_mutex in loop_exit() is pointless, for all users must
close /dev/loop-control and /dev/loop$num (in order to drop module's
refcount to 0) before loop_exit() starts, and nobody can open
/dev/loop-control or /dev/loop$num afterwards.

Link: https://syzkaller.appspot.com/bug?id=7bb10e8b62f83e4d445cdf4c13d69e407e629558 [1]
Reported-by: syzbot <syzbot+f61766d5763f9e7a118f@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+f61766d5763f9e7a118f@syzkaller.appspotmail.com>
---
Changes in v2:
  Don't replace loop_ctl_mutex mutex with loop_idr_spinlock spinlock.
  Don't traverse on loop_index_idr at loop_unregister_transfer().
  Don't use refcount for handling duplicated removal requests.

 drivers/block/loop.c | 77 ++++++++++++++++++++++++++++----------------
 drivers/block/loop.h |  1 +
 2 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f0cdff0c5fbf..b2c9d355e258 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2113,18 +2113,6 @@ int loop_register_transfer(struct loop_func_table *funcs)
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
@@ -2132,9 +2120,20 @@ int loop_unregister_transfer(int number)
 
 	if (n == 0 || n >= MAX_LO_CRYPT || (xfer = xfer_funcs[n]) == NULL)
 		return -EINVAL;
+	/*
+	 * This function is called from only cleanup_cryptoloop().
+	 * Given that each loop device that has a transfer enabled holds a
+	 * reference to the module implementing it we should never get here
+	 * with a transfer that is set (unless forced module unloading is
+	 * requested). Thus, check module's refcount and warn if this is
+	 * not a clean unloading.
+	 */
+#ifdef CONFIG_MODULE_UNLOAD
+	if (xfer->owner && module_refcount(xfer->owner) != -1)
+		pr_err("Unregistering a transfer function in use. Expect kernel crashes.\n");
+#endif
 
 	xfer_funcs[n] = NULL;
-	idr_for_each(&loop_index_idr, &unregister_transfer_cb, xfer);
 	return 0;
 }
 
@@ -2325,8 +2324,9 @@ static int loop_add(int i)
 	} else {
 		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_KERNEL);
 	}
+	mutex_unlock(&loop_ctl_mutex);
 	if (err < 0)
-		goto out_unlock;
+		goto out_free_dev;
 	i = err;
 
 	err = -ENOMEM;
@@ -2392,15 +2392,17 @@ static int loop_add(int i)
 	disk->private_data	= lo;
 	disk->queue		= lo->lo_queue;
 	sprintf(disk->disk_name, "loop%d", i);
+	/* Make this loop device reachable from pathname. */
 	add_disk(disk);
-	mutex_unlock(&loop_ctl_mutex);
+	/* Show this loop device. */
+	lo->idr_visible = true;
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
@@ -2410,9 +2412,14 @@ static int loop_add(int i)
 
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
@@ -2440,29 +2447,39 @@ static int loop_control_remove(int idx)
 	if (ret)
 		return ret;
 
+	/*
+	 * Hide this loop device for serialization, even if we bail out of
+	 * the removal. The only other place checking the visibility is the
+	 * LOOP_CTL_GET_FREE ioctl, which checks the same flags as we do below,
+	 * and which is fundamentally racy anyway.
+	 */
 	lo = idr_find(&loop_index_idr, idx);
-	if (!lo) {
-		ret = -ENODEV;
-		goto out_unlock_ctrl;
+	if (!lo || !cmpxchg(&lo->idr_visible, true, false)) {
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
+	/* Show this loop device again. */
+	lo->idr_visible = true;
+	return -EBUSY;
 }
 
 static int loop_control_get_free(int idx)
@@ -2474,7 +2491,7 @@ static int loop_control_get_free(int idx)
 	if (ret)
 		return ret;
 	idr_for_each_entry(&loop_index_idr, lo, id) {
-		if (lo->lo_state == Lo_unbound)
+		if (lo->idr_visible && lo->lo_state == Lo_unbound)
 			goto found;
 	}
 	mutex_unlock(&loop_ctl_mutex);
@@ -2590,10 +2607,14 @@ static void __exit loop_exit(void)
 	unregister_blkdev(LOOP_MAJOR, "loop");
 	misc_deregister(&loop_misc);
 
-	mutex_lock(&loop_ctl_mutex);
+	/*
+	 * There is no need to use loop_ctl_mutex here, for nobody else can
+	 * access loop_index_idr when this module is unloading (unless forced
+	 * module unloading is requested). If this is not a clean unloading,
+	 * we have no means to avoid kernel crash.
+	 */
 	idr_for_each_entry(&loop_index_idr, lo, id)
 		loop_remove(lo);
-	mutex_unlock(&loop_ctl_mutex);
 
 	idr_destroy(&loop_index_idr);
 }
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 1988899db63a..04c88dd6eabd 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -68,6 +68,7 @@ struct loop_device {
 	struct blk_mq_tag_set	tag_set;
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
+	bool			idr_visible;
 };
 
 struct loop_cmd {
-- 
2.25.1

