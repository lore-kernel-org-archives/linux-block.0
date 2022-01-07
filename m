Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA6AC433F5
	for <linux-block@archiver.kernel.org>; Fri,  7 Jan 2022 11:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346962AbiAGLE6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jan 2022 06:04:58 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59855 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346886AbiAGLEz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jan 2022 06:04:55 -0500
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 207B4ao0064077;
        Fri, 7 Jan 2022 20:04:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Fri, 07 Jan 2022 20:04:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 207B4aqg064074
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 7 Jan 2022 20:04:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
Date:   Fri, 7 Jan 2022 20:04:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: [PATCH v2 2/2] loop: use task_work for autoclear operation
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp>
In-Reply-To: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jan Stancek is reporting that commit 322c4293ecc58110 ("loop: make
autoclear operation asynchronous") broke LTP tests which run /bin/mount
and /bin/umount in close succession like

  while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done

. This is because since /usr/lib/systemd/systemd-udevd asynchronously
opens the loop device which /bin/mount and /bin/umount are operating,
autoclear from lo_release() is likely triggered by systemd-udevd than
mount or umount. And unfortunately, /bin/mount fails if read of superblock
(for examining filesystem type) returned an error due to the backing file
being cleared by __loop_clr_fd(). It turned out that disk->open_mutex was
by chance serving as a barrier for serializing "__loop_clr_fd() from
lo_release()" and "vfs_read() after lo_open()", and we need to restore
this barrier (without reintroducing circular locking dependency).

Also, the kernel test robot is reporting that that commit broke xfstest
which does

  umount ext2 on xfs
  umount xfs

sequence.

One of approaches for fixing these problems is to revert that commit and
instead remove destroy_workqueue() from __loop_clr_fd(), for it turned out
that we did not need to call flush_workqueue() from __loop_clr_fd() since
blk_mq_freeze_queue() blocks until all pending "struct work_struct" are
processed by loop_process_work(). But we are not sure whether it is safe
to wait blk_mq_freeze_queue() etc. with disk->open_mutex held; it could
be simply because dependency is not clear enough for fuzzers to cover and
lockdep to detect.

Therefore, before taking revert approach, let's try if we can use task
work approach which is called without locks held while the caller can
wait for completion of that task work before returning to user mode.

This patch tries to make lo_open()/lo_release() to locklessly wait for
__loop_clr_fd() by inserting a task work into lo_open()/lo_release() if
possible.

Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Need to also wait on lo_open(), per Jan's testcase.

 drivers/block/loop.c | 70 ++++++++++++++++++++++++++++++++++++++++----
 drivers/block/loop.h |  5 +++-
 2 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1b05c45c07c..8ef6da186c5c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -89,6 +89,7 @@
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 static DEFINE_MUTEX(loop_validate_mutex);
+static DECLARE_WAIT_QUEUE_HEAD(loop_rundown_wait);
 
 /**
  * loop_global_lock_killable() - take locks for safe loop_validate_file() test
@@ -1172,13 +1173,12 @@ static void loop_rundown_completed(struct loop_device *lo)
 	mutex_lock(&lo->lo_mutex);
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
+	wake_up_all(&loop_rundown_wait);
 	module_put(THIS_MODULE);
 }
 
-static void loop_rundown_workfn(struct work_struct *work)
+static void loop_rundown_start(struct loop_device *lo)
 {
-	struct loop_device *lo = container_of(work, struct loop_device,
-					      rundown_work);
 	struct block_device *bdev = lo->lo_device;
 	struct gendisk *disk = lo->lo_disk;
 
@@ -1188,6 +1188,18 @@ static void loop_rundown_workfn(struct work_struct *work)
 	loop_rundown_completed(lo);
 }
 
+static void loop_rundown_callbackfn(struct callback_head *callback)
+{
+	loop_rundown_start(container_of(callback, struct loop_device,
+					rundown.callback));
+}
+
+static void loop_rundown_workfn(struct work_struct *work)
+{
+	loop_rundown_start(container_of(work, struct loop_device,
+					rundown.work));
+}
+
 static void loop_schedule_rundown(struct loop_device *lo)
 {
 	struct block_device *bdev = lo->lo_device;
@@ -1195,8 +1207,13 @@ static void loop_schedule_rundown(struct loop_device *lo)
 
 	__module_get(disk->fops->owner);
 	kobject_get(&bdev->bd_device.kobj);
-	INIT_WORK(&lo->rundown_work, loop_rundown_workfn);
-	queue_work(system_long_wq, &lo->rundown_work);
+	if (!(current->flags & PF_KTHREAD)) {
+		init_task_work(&lo->rundown.callback, loop_rundown_callbackfn);
+		if (!task_work_add(current, &lo->rundown.callback, TWA_RESUME))
+			return;
+	}
+	INIT_WORK(&lo->rundown.work, loop_rundown_workfn);
+	queue_work(system_long_wq, &lo->rundown.work);
 }
 
 static int loop_clr_fd(struct loop_device *lo)
@@ -1721,19 +1738,60 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 }
 #endif
 
+struct loop_rundown_waiter {
+	struct callback_head callback;
+	struct loop_device *lo;
+};
+
+static void loop_rundown_waiter_callbackfn(struct callback_head *callback)
+{
+	struct loop_rundown_waiter *lrw =
+		container_of(callback, struct loop_rundown_waiter, callback);
+
+	/*
+	 * Locklessly wait for completion of __loop_clr_fd().
+	 * This should be safe because of the following rules.
+	 *
+	 *  (a) From locking dependency perspective, this function is called
+	 *      without any locks held.
+	 *  (b) From execution ordering perspective, this function is called
+	 *      by the moment lo_open() from open() syscall returns to user
+	 *      mode.
+	 *  (c) From use-after-free protection perspective, this function is
+	 *      called before loop_remove() is called, for lo->lo_refcnt taken
+	 *      by lo_open() prevents loop_control_remove() and loop_exit().
+	 */
+	wait_event_killable(loop_rundown_wait, data_race(lrw->lo->lo_state) != Lo_rundown);
+	kfree(lrw);
+}
+
 static int lo_open(struct block_device *bdev, fmode_t mode)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
+	struct loop_rundown_waiter *lrw =
+		kmalloc(sizeof(*lrw), GFP_KERNEL | __GFP_NOWARN);
 	int err;
 
+	if (!lrw)
+		return -ENOMEM;
 	err = mutex_lock_killable(&lo->lo_mutex);
-	if (err)
+	if (err) {
+		kfree(lrw);
 		return err;
+	}
 	if (lo->lo_state == Lo_deleting)
 		err = -ENXIO;
 	else
 		atomic_inc(&lo->lo_refcnt);
 	mutex_unlock(&lo->lo_mutex);
+	if (!err && !(current->flags & PF_KTHREAD)) {
+		init_task_work(&lrw->callback, loop_rundown_waiter_callbackfn);
+		lrw->lo = lo;
+		if (task_work_add(current, &lrw->callback, TWA_RESUME))
+			kfree(lrw);
+	} else {
+		kfree(lrw);
+	}
 	return err;
 }
 
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 918a7a2dc025..596472f9cde3 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -56,7 +56,10 @@ struct loop_device {
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
 	bool			idr_visible;
-	struct work_struct      rundown_work;
+	union {
+		struct work_struct   work;
+		struct callback_head callback;
+	} rundown;
 };
 
 struct loop_cmd {
-- 
2.32.0


