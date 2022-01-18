Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3676DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 18 Jan 2022 15:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346068AbiARP6q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:58:46 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61988 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242913AbiARP6m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jan 2022 10:58:42 -0500
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20IFwHnC070977;
        Wed, 19 Jan 2022 00:58:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Wed, 19 Jan 2022 00:58:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20IFwHOK070974
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 Jan 2022 00:58:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f6b947d0-1047-66b3-0243-af5017c9ab55@I-love.SAKURA.ne.jp>
Date:   Wed, 19 Jan 2022 00:58:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
References: <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
 <20220110103057.h775jv2br2xr2l5k@quack3.lan>
 <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp>
 <20220110134234.qebxn5gghqupsc7t@quack3.lan>
 <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp>
 <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan>
 <20220113104424.u6fj3z2zd34ohthc@quack3.lan>
 <f893638a-2109-c197-9783-c5e6dced23e5@I-love.SAKURA.ne.jp>
 <20220114195840.kdzegicjx7uyscoq@quack3.lan>
 <33f360ca-d3e1-7070-654e-26ef22109a61@I-love.SAKURA.ne.jp>
 <20220117081554.GA22708@lst.de>
 <cdaf1346-2885-f0da-8878-12264bd48348@I-love.SAKURA.ne.jp>
 <1c400c45-1427-6c8c-8053-a4e1e7e92b81@I-love.SAKURA.ne.jp>
In-Reply-To: <1c400c45-1427-6c8c-8053-a4e1e7e92b81@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/17 23:10, Tetsuo Handa wrote:
> On 2022/01/17 18:34, Tetsuo Handa wrote:
>> On 2022/01/17 17:15, Christoph Hellwig wrote:
>>> On Sat, Jan 15, 2022 at 09:34:10AM +0900, Tetsuo Handa wrote:
>>>> Christoph is not a fan of proliferating the use of task_work_add(). Can we go with exporting task_work_add()
>>>
>>> Not a fan != NAK.  If we can't think of anything better we'll have to do
>>> that.  Note that I also have a task_work_add API cleanup pending that makes
>>> it a lot less ugly.
>>>
>>>> for this release cycle? Or instead can we go with providing release() callback without disk->open_mutex held
>>>> ( https://lkml.kernel.org/r/08d703d1-8b32-ec9b-2b50-54b8376d3d40@i-love.sakura.ne.jp ) ?
>>>
>>> This one OTOH is a hard NAK as this is an API that will just cause a lot
>>> of problems.
>>
>> What problems can you think of with [PATCH 1/4] below?
>>
>> I found that patches below are robuster than task_work_add() approach because
>> the loop module does not need to know about refcounts which the core block layer
>> manipulates. If we go with task_work_add() approach, the loop module needs to be
>> updated in sync with refcount manipulations in the core block layer.
>>
> 
> For your information, below is how task_work_add() approach would look like.
> Despite full of refcount management, cannot provide synchronous autoclear
> operation if closed by kernel threads, cannot provide synchronous waiting if
> opened by kernel threads, possibility to fail to run autoclear operation when
> open by user threads failed... What a mess!
> 

I found a bit simpler refcount management. This should fix both /bin/mount
and /bin/umount breakage. Can we go with this approach?

From b0ae6e632f0d4980755364c822223b32e26cfbcd Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 19 Jan 2022 00:42:52 +0900
Subject: [PATCH] loop: don't hold lo->lo_mutex from lo_open() and lo_release()

Commit 322c4293ecc58110 ("loop: make autoclear operation asynchronous")
silenced a circular locking dependency warning, but further analysis by
Jan Kara revealed that fundamental problem is that waiting for I/O
completion (from blk_mq_freeze_queue()) with disk->open_mutex held has
possibility of deadlock. We need to fix this breakage, without waiting for
I/O completion with disk->open_mutex.

Since disk->open_mutex => lo->lo_mutex dependency is recorded by lo_open()
and lo_release(), and blk_mq_freeze_queue() by e.g. loop_set_status() waits
for I/O completion with lo->lo_mutex held, from locking dependency chain
perspective we need to kill disk->open_mutex => lo->lo_mutex dependency
as well.

This patch does the following things.

  (1) Revert commit 322c4293ecc58110, for moving only autoclear operation
      to WQ context caused a breakage for /bin/mount and /bin/umount users.

  (2) Move whole lo_release() operation to task_work context (if possible)
      or WQ context (otherwise).

      disk->open_mutex => lo->lo_mutex dependency by lo_release() will be
      avoided by this change.
      /bin/umount breakage will be avoided by running whole lo_release()
      operation from task_work context.

  (3) Split lo_open() into "holding a reference" part and "serializing
      between lo_open() and lo_release()" part, and replace lo->lo_mutex
      from the former part with a spinlock, and defer the latter part to
      task_work context (if possible) or just give up (otherwise).

      disk->open_mutex => lo->lo_mutex dependency by lo_open() will be
      avoided by the former part of this change.
      /bin/mount breakage will be avoided by running the latter part from
      task_work context.

Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: Jan Stancek <jstancek@redhat.com>
Reported-by: Mike Galbraith <efault@gmx.de>
Analyzed-by: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 322c4293ecc58110 ("loop: make autoclear operation asynchronous")
---
 drivers/block/loop.c | 225 +++++++++++++++++++++++++++++++------------
 drivers/block/loop.h |   2 +-
 2 files changed, 164 insertions(+), 63 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1b05c45c07c..2bbc1195c3fc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -89,6 +89,8 @@
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 static DEFINE_MUTEX(loop_validate_mutex);
+static DEFINE_SPINLOCK(loop_delete_spinlock);
+static DECLARE_WAIT_QUEUE_HEAD(loop_rundown_wait);
 
 /**
  * loop_global_lock_killable() - take locks for safe loop_validate_file() test
@@ -1165,40 +1167,13 @@ static void __loop_clr_fd(struct loop_device *lo)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART;
 
 	fput(filp);
-}
-
-static void loop_rundown_completed(struct loop_device *lo)
-{
 	mutex_lock(&lo->lo_mutex);
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
+	wake_up_all(&loop_rundown_wait);
 	module_put(THIS_MODULE);
 }
 
-static void loop_rundown_workfn(struct work_struct *work)
-{
-	struct loop_device *lo = container_of(work, struct loop_device,
-					      rundown_work);
-	struct block_device *bdev = lo->lo_device;
-	struct gendisk *disk = lo->lo_disk;
-
-	__loop_clr_fd(lo);
-	kobject_put(&bdev->bd_device.kobj);
-	module_put(disk->fops->owner);
-	loop_rundown_completed(lo);
-}
-
-static void loop_schedule_rundown(struct loop_device *lo)
-{
-	struct block_device *bdev = lo->lo_device;
-	struct gendisk *disk = lo->lo_disk;
-
-	__module_get(disk->fops->owner);
-	kobject_get(&bdev->bd_device.kobj);
-	INIT_WORK(&lo->rundown_work, loop_rundown_workfn);
-	queue_work(system_long_wq, &lo->rundown_work);
-}
-
 static int loop_clr_fd(struct loop_device *lo)
 {
 	int err;
@@ -1229,7 +1204,6 @@ static int loop_clr_fd(struct loop_device *lo)
 	mutex_unlock(&lo->lo_mutex);
 
 	__loop_clr_fd(lo);
-	loop_rundown_completed(lo);
 	return 0;
 }
 
@@ -1721,46 +1695,120 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 }
 #endif
 
+struct loop_open_task {
+	struct callback_head cb;
+	struct loop_device *lo;
+};
+
+struct loop_release_task {
+	union {
+		struct list_head head;
+		struct callback_head cb;
+		struct work_struct ws;
+	};
+	struct loop_device *lo;
+};
+
+static LIST_HEAD(release_task_spool);
+static DEFINE_SPINLOCK(release_task_spool_spinlock);
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
-	int err;
+	int err = 0;
+	struct loop_open_task *lot;
+	struct loop_release_task *lrt =
+		kmalloc(sizeof(*lrt), GFP_KERNEL | __GFP_NOWARN);
+
+	if (!lrt)
+		return -ENOMEM;
+	lot = kmalloc(sizeof(*lot), GFP_KERNEL | __GFP_NOWARN);
+	if (!lot) {
+		kfree(lrt);
+		return -ENOMEM;
+	}
 
-	err = mutex_lock_killable(&lo->lo_mutex);
-	if (err)
-		return err;
-	if (lo->lo_state == Lo_deleting)
+	spin_lock(&loop_delete_spinlock);
+	/* lo->lo_state may be changed to any Lo_* but Lo_deleting. */
+	if (data_race(lo->lo_state) == Lo_deleting)
 		err = -ENXIO;
 	else
 		atomic_inc(&lo->lo_refcnt);
-	mutex_unlock(&lo->lo_mutex);
-	return err;
+	spin_unlock(&loop_delete_spinlock);
+	if (err)
+		return err;
+	/* Add to spool, for -ENOMEM upon release() cannot be handled. */
+	spin_lock(&release_task_spool_spinlock);
+	list_add(&lrt->head, &release_task_spool);
+	spin_unlock(&release_task_spool_spinlock);
+	/* Try to avoid accessing Lo_rundown loop device. */
+	if (current->flags & PF_KTHREAD) {
+		kfree(lot);
+		return 0;
+	}
+	lot->lo = lo;
+	init_task_work(&lot->cb, loop_open_callbackfn);
+	if (task_work_add(current, &lot->cb, TWA_RESUME))
+		kfree(lot);
+	/*
+	 * Since the task_work list is LIFO, lo_post_release() scheduled by
+	 * lo_release() can run before lo_post_open() scheduled by lo_open()
+	 * runs when an error occurred and fput() scheduled lo_release() before
+	 * returning to user mode . This means that lo->refcnt may be already 0
+	 * when lo_post_open() runs. Therefore, use lo->async_pending in order
+	 * to prevent loop_remove() from releasing this loop device.
+	 */
+	else
+		atomic_inc(&lo->async_pending);
+	return 0;
 }
 
-static void lo_release(struct gendisk *disk, fmode_t mode)
+static void lo_post_release(struct gendisk *disk)
 {
 	struct loop_device *lo = disk->private_data;
 
 	mutex_lock(&lo->lo_mutex);
-	if (atomic_dec_return(&lo->lo_refcnt))
-		goto out_unlock;
 
+	/* Check whether this loop device can be cleared. */
+	if (atomic_dec_return(&lo->lo_refcnt) || lo->lo_state != Lo_bound)
+		goto out_unlock;
+	/*
+	 * Clear this loop device since nobody is using. Note that since
+	 * lo_open() increments lo->lo_refcnt without holding lo->lo_mutex,
+	 * I might become no longer the last user, but there is a fact that
+	 * there was no user.
+	 *
+	 * In autoclear mode, destroy WQ and remove configuration.
+	 * Otherwise flush possible ongoing bios in WQ and keep configuration.
+	 */
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
-		if (lo->lo_state != Lo_bound)
-			goto out_unlock;
 		lo->lo_state = Lo_rundown;
 		mutex_unlock(&lo->lo_mutex);
-		/*
-		 * In autoclear mode, stop the loop thread
-		 * and remove configuration after last close.
-		 */
-		loop_schedule_rundown(lo);
+		__loop_clr_fd(lo);
 		return;
-	} else if (lo->lo_state == Lo_bound) {
-		/*
-		 * Otherwise keep thread (if running) and config,
-		 * but flush possible ongoing bios in thread.
-		 */
+	} else {
 		blk_mq_freeze_queue(lo->lo_queue);
 		blk_mq_unfreeze_queue(lo->lo_queue);
 	}
@@ -1769,6 +1817,57 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 	mutex_unlock(&lo->lo_mutex);
 }
 
+static void loop_release_workfn(struct work_struct *work)
+{
+	struct loop_release_task *lrt =
+		container_of(work, struct loop_release_task, ws);
+	struct loop_device *lo = lrt->lo;
+	struct gendisk *disk = lo->lo_disk;
+
+	lo_post_release(disk);
+	/* Drop references which will be dropped after lo_release(). */
+	kobject_put(&disk_to_dev(disk)->kobj);
+	module_put(disk->fops->owner);
+	kfree(lrt);
+	atomic_dec(&lo->async_pending);
+}
+
+static void loop_release_callbackfn(struct callback_head *callback)
+{
+	struct loop_release_task *lrt =
+		container_of(callback, struct loop_release_task, cb);
+
+	loop_release_workfn(&lrt->ws);
+}
+
+static void lo_release(struct gendisk *disk, fmode_t mode)
+{
+	struct loop_device *lo = disk->private_data;
+	struct loop_release_task *lrt;
+
+	atomic_inc(&lo->async_pending);
+	/* Fetch from spool. */
+	spin_lock(&release_task_spool_spinlock);
+	lrt = list_first_entry(&release_task_spool, typeof(*lrt), head);
+	list_del(&lrt->head);
+	spin_unlock(&release_task_spool_spinlock);
+	/* Hold references which will be dropped after lo_release(). */
+	__module_get(disk->fops->owner);
+	kobject_get(&disk_to_dev(disk)->kobj);
+	/*
+	 * Prefer task work so that clear operation completes
+	 * before close() returns to user mode.
+	 */
+	lrt->lo = lo;
+	if (!(current->flags & PF_KTHREAD)) {
+		init_task_work(&lrt->cb, loop_release_callbackfn);
+		if (!task_work_add(current, &lrt->cb, TWA_RESUME))
+			return;
+	}
+	INIT_WORK(&lrt->ws, loop_release_workfn);
+	queue_work(system_long_wq, &lrt->ws);
+}
+
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
 	.open =		lo_open,
@@ -2030,6 +2129,7 @@ static int loop_add(int i)
 	if (!part_shift)
 		disk->flags |= GENHD_FL_NO_PART;
 	atomic_set(&lo->lo_refcnt, 0);
+	atomic_set(&lo->async_pending, 0);
 	mutex_init(&lo->lo_mutex);
 	lo->lo_number		= i;
 	spin_lock_init(&lo->lo_lock);
@@ -2071,6 +2171,8 @@ static int loop_add(int i)
 
 static void loop_remove(struct loop_device *lo)
 {
+	while (atomic_read(&lo->async_pending))
+		schedule_timeout_uninterruptible(1);
 	/* Make this loop device unreachable from pathname. */
 	del_gendisk(lo->lo_disk);
 	blk_cleanup_disk(lo->lo_disk);
@@ -2119,19 +2221,18 @@ static int loop_control_remove(int idx)
 	ret = mutex_lock_killable(&lo->lo_mutex);
 	if (ret)
 		goto mark_visible;
-	if (lo->lo_state != Lo_unbound ||
-	    atomic_read(&lo->lo_refcnt) > 0) {
-		mutex_unlock(&lo->lo_mutex);
+	spin_lock(&loop_delete_spinlock);
+	/* Mark this loop device no longer open()-able if nobody is using. */
+	if (lo->lo_state != Lo_unbound || atomic_read(&lo->lo_refcnt) > 0)
 		ret = -EBUSY;
-		goto mark_visible;
-	}
-	/* Mark this loop device no longer open()-able. */
-	lo->lo_state = Lo_deleting;
+	else
+		lo->lo_state = Lo_deleting;
+	spin_unlock(&loop_delete_spinlock);
 	mutex_unlock(&lo->lo_mutex);
-
-	loop_remove(lo);
-	return 0;
-
+	if (!ret) {
+		loop_remove(lo);
+		return 0;
+	}
 mark_visible:
 	/* Show this loop device again. */
 	mutex_lock(&loop_ctl_mutex);
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 918a7a2dc025..20fc5eebe455 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -56,7 +56,7 @@ struct loop_device {
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
 	bool			idr_visible;
-	struct work_struct      rundown_work;
+	atomic_t		async_pending;
 };
 
 struct loop_cmd {
-- 
2.32.0
