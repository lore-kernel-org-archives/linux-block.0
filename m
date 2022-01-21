Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDE5C433EF
	for <linux-block@archiver.kernel.org>; Fri, 21 Jan 2022 11:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiAULk6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jan 2022 06:40:58 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:54297 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350181AbiAULk6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jan 2022 06:40:58 -0500
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20LBeFwS048235;
        Fri, 21 Jan 2022 20:40:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Fri, 21 Jan 2022 20:40:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20LBe9Hf048197
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 21 Jan 2022 20:40:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Stancek <jstancek@redhat.com>,
        Mike Galbraith <efault@gmx.de>
Subject: [PATCH v3 5/5] loop: add workaround for racy loop device reuse logic in /bin/mount
Date:   Fri, 21 Jan 2022 20:40:06 +0900
Message-Id: <20220121114006.3633-5-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220121114006.3633-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20220121114006.3633-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since lo_open() and lo_release() were previously serialized via
disk->open_mutex, new file descriptors returned by open() never reached
a loop device in Lo_rundown state unless ioctl(LOOP_CLR_FD) was inside
__loop_clr_fd(). But now that since lo_open() and lo_release() no longer
hold lo->lo_mutex in order to kill disk->open_mutex => lo->lo_mutex
dependency, new file descriptors returned by open() can easily reach a
loop device in Lo_rundown state.

So far, Jan Stancek and Mike Galbraith found that LTP's isofs testcase
which do mount/umount in close succession started failing. The root cause
is that loop device reuse logic in /bin/mount is racy, and Jan Kara posted
a patch for fixing one of two bugs [1].

But we need some migration period for allowing users to update their
util-linux package. Not everybody can use latest userspace programs.
Therefore, add a switch for allow emulating serialization between lo_open()
and lo_release() without using disk->open_mutex. This emulation is disabled
by default, and will be removed eventually. Since this emulation runs from
task work context, we don't need to worry about locking dependency problem.

Link: https://lkml.kernel.org/r/20220120114705.25342-1-jack@suse.cz [1]
Reported-by: Jan Stancek <jstancek@redhat.com>
Reported-by: Mike Galbraith <efault@gmx.de>
Analyzed-by: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
This hack is not popular, but without enabling this workaround, about 20% of
mount requests fails. If this workaround is enabled, no mount request fails.
I think we need this hack for a while.

root@fuzz:/mnt# time for i in $(seq 1 100); do mount -o loop,ro isofs.iso isofs/ && umount isofs/; done
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: isofs/: operation permitted for root only.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: isofs/: operation permitted for root only.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
mount: /mnt/isofs: can't read superblock on /dev/loop0.

real    0m9.896s
user    0m0.161s
sys     0m8.523s

drivers/block/loop.c | 58 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 74d919e98a6b..844471213494 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -90,6 +90,7 @@ static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 static DEFINE_MUTEX(loop_validate_mutex);
 static DEFINE_SPINLOCK(loop_delete_spinlock);
+static DECLARE_WAIT_QUEUE_HEAD(loop_rundown_wait);
 
 /**
  * loop_global_lock_killable() - take locks for safe loop_validate_file() test
@@ -1174,6 +1175,7 @@ static void __loop_clr_fd(struct loop_device *lo)
 	mutex_lock(&lo->lo_mutex);
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
+	wake_up_all(&loop_rundown_wait);
 	module_put(THIS_MODULE);
 }
 
@@ -1710,6 +1712,38 @@ struct loop_release_task {
 static LIST_HEAD(release_task_spool);
 static DEFINE_SPINLOCK(release_task_spool_spinlock);
 
+/* Workaround code for racy loop device reuse logic in /bin/mount. */
+static bool open_waits_rundown_device;
+module_param(open_waits_rundown_device, bool, 0644);
+MODULE_PARM_DESC(open_waits_rundown_device, "Please report if you need to enable this option.");
+
+struct loop_open_task {
+	struct callback_head cb;
+	struct loop_device *lo;
+};
+
+static void lo_post_open(struct gendisk *disk)
+{
+	struct loop_device *lo = disk->private_data;
+
+	/* Wait for lo_post_release() to leave lo->lo_mutex section. */
+	if (mutex_lock_killable(&lo->lo_mutex) == 0)
+		mutex_unlock(&lo->lo_mutex);
+	/* Also wait for __loop_clr_fd() to complete if Lo_rundown was set. */
+	wait_event_killable(loop_rundown_wait, data_race(lo->lo_state) != Lo_rundown);
+	atomic_dec(&lo->async_pending);
+}
+
+static void loop_open_callbackfn(struct callback_head *callback)
+{
+	struct loop_open_task *lot =
+		container_of(callback, struct loop_open_task, cb);
+	struct gendisk *disk = lot->lo->lo_disk;
+
+	lo_post_open(disk);
+	kfree(lot);
+}
+
 static int lo_open(struct block_device *bdev, fmode_t mode)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
@@ -1738,6 +1772,30 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
 	spin_lock(&release_task_spool_spinlock);
 	list_add(&lrt->head, &release_task_spool);
 	spin_unlock(&release_task_spool_spinlock);
+
+	/*
+	 * Try to avoid accessing Lo_rundown loop device.
+	 *
+	 * Since the task_work list is LIFO, lo_post_release() scheduled by
+	 * lo_release() can run before lo_post_open() scheduled by lo_open()
+	 * runs when an error occurred and fput() scheduled lo_release() before
+	 * returning to user mode. This means that lo->refcnt may be already 0
+	 * when lo_post_open() runs. Therefore, use lo->async_pending in order
+	 * to prevent loop_remove() from releasing this loop device.
+	 */
+	if (open_waits_rundown_device && !(current->flags & PF_KTHREAD)) {
+		struct loop_open_task *lot =
+			kmalloc(sizeof(*lrt), GFP_KERNEL | __GFP_NOWARN);
+
+		if (!lot)
+			return 0;
+		lot->lo = lo;
+		init_task_work(&lot->cb, loop_open_callbackfn);
+		if (task_work_add(current, &lot->cb, TWA_RESUME))
+			kfree(lot);
+		else
+			atomic_inc(&lo->async_pending);
+	}
 	return 0;
 }
 
-- 
2.32.0

