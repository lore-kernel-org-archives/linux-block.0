Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50EFC432BE
	for <linux-block@archiver.kernel.org>; Thu,  2 Sep 2021 00:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823346108B
	for <linux-block@archiver.kernel.org>; Thu,  2 Sep 2021 00:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhIBAIi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Sep 2021 20:08:38 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58405 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhIBAIi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Sep 2021 20:08:38 -0400
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 18207cUn064005;
        Thu, 2 Sep 2021 09:07:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Thu, 02 Sep 2021 09:07:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 18207bFa063999
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Sep 2021 09:07:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH v3 (repost)] loop: reduce the loop_ctl_mutex scope
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>
References: <2642808b-a7d0-28ff-f288-0f4eabc562f7@i-love.sakura.ne.jp>
 <20210827184302.GA29967@lst.de>
 <73c53177-be1b-cff1-a09e-ef7979a95200@i-love.sakura.ne.jp>
 <20210828071832.GA31755@lst.de>
 <c5e509ec-2361-af25-ec73-e033b5b46ebb@i-love.sakura.ne.jp>
 <33a0a1e5-a79f-1887-6417-c5a81f58e47d@i-love.sakura.ne.jp>
 <cc5c215f-4b3b-94e9-560b-a02d0e23c97c@i-love.sakura.ne.jp>
 <20210901061021.GA15503@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <adb1e792-fc0e-ee81-7ea0-0906fc36419d@i-love.sakura.ne.jp>
Date:   Thu, 2 Sep 2021 09:07:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210901061021.GA15503@lst.de>
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
currently has possibility of use-after-free problem due to lack of
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
Changes in v3:
  Don't use cmpxchg(), for kernel test robot <lkp@intel.com> reported
  that some archtectures do not support cmpxchg() on bool.
  Add data_race() annotation to loop_control_get_free().

Changes in v2:
  Don't replace loop_ctl_mutex mutex with loop_idr_spinlock spinlock.
  Don't traverse on loop_index_idr at loop_unregister_transfer().
  Don't use refcount for handling duplicated removal requests.

 drivers/block/loop.c | 75 +++++++++++++++++++++++++++++---------------
 drivers/block/loop.h |  1 +
 2 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index fa1c298a8cfb..7bf4686af774 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2111,18 +2111,6 @@ int loop_register_transfer(struct loop_func_table *funcs)
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
@@ -2130,9 +2118,20 @@ int loop_unregister_transfer(int number)
 
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
+		pr_err("Danger! Unregistering an in use transfer function.\n");
+#endif
 
 	xfer_funcs[n] = NULL;
-	idr_for_each(&loop_index_idr, &unregister_transfer_cb, xfer);
 	return 0;
 }
 
@@ -2323,8 +2322,9 @@ static int loop_add(int i)
 	} else {
 		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_KERNEL);
 	}
+	mutex_unlock(&loop_ctl_mutex);
 	if (err < 0)
-		goto out_unlock;
+		goto out_free_dev;
 	i = err;
 
 	err = -ENOMEM;
@@ -2393,15 +2393,19 @@ static int loop_add(int i)
 	disk->events		= DISK_EVENT_MEDIA_CHANGE;
 	disk->event_flags	= DISK_EVENT_FLAG_UEVENT;
 	sprintf(disk->disk_name, "loop%d", i);
+	/* Make this loop device reachable from pathname. */
 	add_disk(disk);
+	/* Show this loop device. */
+	mutex_lock(&loop_ctl_mutex);
+	lo->idr_visible = true;
 	mutex_unlock(&loop_ctl_mutex);
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
@@ -2411,9 +2415,14 @@ static int loop_add(int i)
 
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
@@ -2437,31 +2446,40 @@ static int loop_control_remove(int idx)
 		return -EINVAL;
 	}
 		
+	/* Hide this loop device for serialization. */
 	ret = mutex_lock_killable(&loop_ctl_mutex);
 	if (ret)
 		return ret;
-
 	lo = idr_find(&loop_index_idr, idx);
-	if (!lo) {
+	if (!lo || !lo->idr_visible)
 		ret = -ENODEV;
-		goto out_unlock_ctrl;
-	}
+	else
+		lo->idr_visible = false;
+	mutex_unlock(&loop_ctl_mutex);
+	if (ret)
+		return ret;
 
+	/* Check whether this loop device can be removed. */
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
+	return 0;
+
+mark_visible:
+	/* Show this loop device again. */
+	mutex_lock(&loop_ctl_mutex);
+	lo->idr_visible = true;
 	mutex_unlock(&loop_ctl_mutex);
 	return ret;
 }
@@ -2475,7 +2493,8 @@ static int loop_control_get_free(int idx)
 	if (ret)
 		return ret;
 	idr_for_each_entry(&loop_index_idr, lo, id) {
-		if (lo->lo_state == Lo_unbound)
+		/* Hitting a race results in creating a new loop device which is harmless. */
+		if (lo->idr_visible && data_race(lo->lo_state) == Lo_unbound)
 			goto found;
 	}
 	mutex_unlock(&loop_ctl_mutex);
@@ -2591,10 +2610,14 @@ static void __exit loop_exit(void)
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
2.18.4


