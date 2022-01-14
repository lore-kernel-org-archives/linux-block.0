Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4533FC433F5
	for <linux-block@archiver.kernel.org>; Fri, 14 Jan 2022 15:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242928AbiANPu6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jan 2022 10:50:58 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:62575 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiANPu5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jan 2022 10:50:57 -0500
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20EFoaXM052784;
        Sat, 15 Jan 2022 00:50:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Sat, 15 Jan 2022 00:50:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20EFoYnL052776
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 15 Jan 2022 00:50:35 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f893638a-2109-c197-9783-c5e6dced23e5@I-love.SAKURA.ne.jp>
Date:   Sat, 15 Jan 2022 00:50:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp>
 <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
 <20220110103057.h775jv2br2xr2l5k@quack3.lan>
 <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp>
 <20220110134234.qebxn5gghqupsc7t@quack3.lan>
 <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp>
 <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan>
 <20220113104424.u6fj3z2zd34ohthc@quack3.lan>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220113104424.u6fj3z2zd34ohthc@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/13 19:44, Jan Kara wrote:
> OK, so I think I understand the lockdep complaint better. Lockdep
> essentially complains about the following scenario:
> 
> blkdev_put()
>   lock disk->open_mutex
>   lo_release
>     __loop_clr_fd()
>         |
>         | wait for IO to complete
>         v
> loop worker
>   write to backing file
>     sb_start_write(file)
>         |
>         | wait for fs with backing file to unfreeze
>         v
> process holding fs frozen
>   freeze_super()
>         |
>         | wait for remaining writers on the fs so that fs can be frozen
>         v
> sendfile()
>   sb_start_write()
>   do_splice_direct()
>         |
>         | blocked on read from /sys/power/resume, waiting for kernfs file
>         | lock
>         v
> write() "/dev/loop0" (in whatever form) to /sys/power/resume
>   calls blkdev_get_by_dev("/dev/loop0")
>     lock disk->open_mutex => deadlock
> 

Then, not calling flush_workqueue() from destroy_workqueue() from __loop_clr_fd() will not help
because the reason we did not need to call flush_workqueue() is that blk_mq_freeze_queue() waits
until all "struct work_struct" which flush_workqueue() would have waited completes?

If flush_workqueue() cannot complete because an I/O request cannot complete, blk_mq_freeze_queue()
as well cannot complete because it waits for I/O requests which flush_workqueue() would have waited?

Then, any attempt to revert commit 322c4293ecc58110 ("loop: make autoclear operation asynchronous")
(e.g. https://lkml.kernel.org/r/4e7b711f-744b-3a78-39be-c9432a3cecd2@i-love.sakura.ne.jp ) cannot be
used?

Now that commit 322c4293ecc58110 already arrived at linux.git, we need to quickly send a fixup patch
for these reported regressions. This "[PATCH v2 2/2] loop: use task_work for autoclear operation" did
not address "if (lo->lo_state == Lo_bound) { }" part. If we address this part, something like below diff?

----------------------------------------
 drivers/block/loop.c |  158 ++++++++++++++++++++++++++++++++++++++-------------
 drivers/block/loop.h |    1 
 2 files changed, 120 insertions(+), 39 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1b05c45c07c..eb750602c94d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -89,6 +89,8 @@
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 static DEFINE_MUTEX(loop_validate_mutex);
+static DECLARE_WAIT_QUEUE_HEAD(loop_rundown_wait);
+static DEFINE_SPINLOCK(loop_open_spinlock);
 
 /**
  * loop_global_lock_killable() - take locks for safe loop_validate_file() test
@@ -1172,33 +1174,10 @@ static void loop_rundown_completed(struct loop_device *lo)
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
@@ -1721,30 +1700,91 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
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
-	int err;
+	int err = 0;
 
-	err = mutex_lock_killable(&lo->lo_mutex);
-	if (err)
-		return err;
-	if (lo->lo_state == Lo_deleting)
+	/*
+	 * Avoid creating disk->open_mutex => lo->lo_mutex locking chain, for
+	 * calling blk_mq_freeze_queue() with lo->lo_mutex held will form a
+	 * circular locking dependency chain due to waiting for I/O requests
+	 * to complete.
+	 */
+	spin_lock(&loop_open_spinlock);
+	/*
+	 * Since the purpose of lo_open() is to protect this loop device from
+	 * entering Lo_rundown or Lo_deleting state, only serialization against
+	 * loop_control_remove() is sufficient.
+	 */
+	if (data_race(lo->lo_state) == Lo_deleting)
 		err = -ENXIO;
 	else
 		atomic_inc(&lo->lo_refcnt);
-	mutex_unlock(&lo->lo_mutex);
+	spin_unlock(&loop_open_spinlock);
+	/*
+	 * But loop_clr_fd() or __lo_release() might have already set this loop
+	 * device to Lo_rundown state. Since accessing Lo_rundown loop device
+	 * confuses userspace programs, try to wait for __loop_clr_fd() to
+	 * complete without disk->open_mutex held.
+	 */
+	if (!err && !(current->flags & PF_KTHREAD)) {
+		struct loop_rundown_waiter *lrw =
+			kmalloc(sizeof(*lrw), GFP_KERNEL | __GFP_NOFAIL);
+
+		init_task_work(&lrw->callback, loop_rundown_waiter_callbackfn);
+		lrw->lo = lo;
+		if (task_work_add(current, &lrw->callback, TWA_RESUME))
+			kfree(lrw);
+	}
 	return err;
 }
 
-static void lo_release(struct gendisk *disk, fmode_t mode)
+struct loop_release_trigger {
+	union {
+		struct work_struct   work;
+		struct callback_head callback;
+	};
+	struct loop_device *lo;
+};
+
+/* Perform actual creanup if nobody is using this loop device. */
+static void __lo_release(struct loop_release_trigger *lrt)
 {
-	struct loop_device *lo = disk->private_data;
+	struct loop_device *lo = lrt->lo;
+	struct gendisk *disk = lo->lo_disk;
+	bool cleared = false;
 
 	mutex_lock(&lo->lo_mutex);
-	if (atomic_dec_return(&lo->lo_refcnt))
+	if (atomic_read(&lo->lo_refcnt))
 		goto out_unlock;
-
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
 		if (lo->lo_state != Lo_bound)
 			goto out_unlock;
@@ -1754,8 +1794,8 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		loop_schedule_rundown(lo);
-		return;
+		__loop_clr_fd(lo);
+		cleared = true;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
 		 * Otherwise keep thread (if running) and config,
@@ -1764,9 +1804,48 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		blk_mq_freeze_queue(lo->lo_queue);
 		blk_mq_unfreeze_queue(lo->lo_queue);
 	}
+ out_unlock:
+	if (!cleared)
+		mutex_unlock(&lo->lo_mutex);
+	module_put(disk->fops->owner);
+	if (cleared)
+		loop_rundown_completed(lo);
+}
 
-out_unlock:
-	mutex_unlock(&lo->lo_mutex);
+static void loop_release_callbackfn(struct callback_head *callback)
+{
+	__lo_release(container_of(callback, struct loop_release_trigger,
+				  callback));
+}
+
+static void loop_release_workfn(struct work_struct *work)
+{
+	__lo_release(container_of(work, struct loop_release_trigger, work));
+}
+
+static void lo_release(struct gendisk *disk, fmode_t mode)
+{
+	struct loop_device *lo = disk->private_data;
+	struct loop_release_trigger *lrt;
+
+	if (atomic_dec_return(&lo->lo_refcnt))
+		return;
+	/*
+	 * In order to avoid waiting for I/O requests to complete under
+	 * disk->open_mutex held, defer actual clreanup to __lo_release().
+	 * Prefer task work context if possible in order to make sure that
+	 * __lo_release() completes before close() returns to user mode,
+	 */
+	lrt = kmalloc(sizeof(*lrt), GFP_KERNEL | __GFP_NOFAIL);
+	lrt->lo = lo;
+	__module_get(disk->fops->owner);
+	if (!(current->flags & PF_KTHREAD)) {
+		init_task_work(&lrt->callback, loop_release_callbackfn);
+		if (!task_work_add(current, &lrt->callback, TWA_RESUME))
+			return;
+	}
+	INIT_WORK(&lrt->work, loop_release_workfn);
+	queue_work(system_long_wq, &lrt->work);
 }
 
 static const struct block_device_operations lo_fops = {
@@ -2119,14 +2198,17 @@ static int loop_control_remove(int idx)
 	ret = mutex_lock_killable(&lo->lo_mutex);
 	if (ret)
 		goto mark_visible;
+	spin_lock(&loop_open_spinlock);
 	if (lo->lo_state != Lo_unbound ||
 	    atomic_read(&lo->lo_refcnt) > 0) {
+		spin_unlock(&loop_open_spinlock);
 		mutex_unlock(&lo->lo_mutex);
 		ret = -EBUSY;
 		goto mark_visible;
 	}
 	/* Mark this loop device no longer open()-able. */
 	lo->lo_state = Lo_deleting;
+	spin_unlock(&loop_open_spinlock);
 	mutex_unlock(&lo->lo_mutex);
 
 	loop_remove(lo);
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 918a7a2dc025..082d4b6bfc6a 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -56,7 +56,6 @@ struct loop_device {
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
 	bool			idr_visible;
-	struct work_struct      rundown_work;
 };
 
 struct loop_cmd {
----------------------------------------

This diff avoids disk->open_mutex => lo->lo_mutex chain.

ffffffff84a06140 OPS:    7944 FD:  305 BD:    4 +.+.: &disk->open_mutex
 -> [ffffffffa0158a48] sd_ref_mutex
 -> [ffffffff831be200] fs_reclaim
 -> [ffffffff849d7ee0] &n->list_lock
 -> [ffffffff8332ce18] depot_lock
 -> [ffffffff8312d508] tk_core.seq.seqcount
 -> [ffffffff84a06940] &obj_hash[i].lock
 -> [ffffffff84a05680] &hctx->lock
 -> [ffffffff84a05620] &x->wait#20
 -> [ffffffff849c10e0] &base->lock
 -> [ffffffff83d93000] &rq->__lock
 -> [ffffffff849c1060] (&timer.timer)
 -> [ffff88811ac44b48] lock#2
 -> [ffffffff849cebe0] &____s->seqcount
 -> [ffffffff84a05420] &q->sysfs_dir_lock
 -> [ffffffff84a04980] &bdev->bd_size_lock
 -> [ffffffff831bcdd8] free_vmap_area_lock
 -> [ffffffff831bcd78] vmap_area_lock
 -> [ffffffff849e5900] &xa->xa_lock#3
 -> [ffff88811ac44390] lock#6
 -> [ffffffff849e58f0] &mapping->private_lock
 -> [ffffffff84a06740] &dd->lock
 -> [ffffffff82ef8d78] (console_sem).lock
 -> [ffffffff83307c28] &sb->s_type->i_lock_key#3
 -> [ffffffff849e2420] &s->s_inode_list_lock
 -> [ffffffff831a9f68] pcpu_alloc_mutex
 -> [ffffffff84b8dd60] &x->wait#9
 -> [ffffffff84b77980] &k->list_lock
 -> [ffff88811ac45780] lock#3
 -> [ffffffff849ea3e0] &root->kernfs_rwsem
 -> [ffffffff8335b830] bus_type_sem
 -> [ffffffff8321b1b8] sysfs_symlink_target_lock
 -> [ffffffff84b8d7c0] &dev->power.lock
 -> [ffffffff833e2e28] dpm_list_mtx
 -> [ffffffff833e03b8] req_lock
 -> [ffffffff83d8e820] &p->pi_lock
 -> [ffffffff84b8dbc0] &x->wait#10
 -> [ffffffff84b77960] &k->k_lock
 -> [ffffffff84a06180] subsys mutex#48
 -> [ffffffff84a061a0] &xa->xa_lock#5
 -> [ffffffff82e14698] inode_hash_lock
 -> [ffffffff831bcf98] purge_vmap_area_lock
 -> [ffffffff849cd420] &lruvec->lru_lock
 -> [ffffffff849ccec0] &folio_wait_table[i]
 -> [ffffffff83410a68] sr_ref_mutex
 -> [ffffffff84a06240] &ev->block_mutex
 -> [ffffffff84a06220] &ev->lock
 -> [ffffffff831e7398] sb_lock
 -> [ffffffff84b8f280] &cd->lock
 -> [ffffffff82ea6878] pgd_lock
 -> [ffffffff82e14758] bdev_lock
 -> [ffffffff849ce0e0] &wb->list_lock
 -> [ffffffffa04b9378] loop_open_spinlock
 -> [ffffffff83d8e800] &____s->seqcount#2
 -> [ffffffff849c0b00] rcu_node_0
 -> [ffffffff83d94320] &lock->wait_lock

ffffffffa04b90c0 OPS:    3257 FD:  280 BD:    1 +.+.: &lo->lo_mutex
 -> [ffffffff831be200] fs_reclaim
 -> [ffffffff849d7ee0] &n->list_lock
 -> [ffffffff8332ce18] depot_lock
 -> [ffffffff82ec1450] cpu_hotplug_lock
 -> [ffffffff82ed3848] wq_pool_mutex
 -> [ffffffff83330448] uevent_sock_mutex
 -> [ffffffff84a06940] &obj_hash[i].lock
 -> [ffffffff831e7398] sb_lock
 -> [ffffffff83d8e800] &____s->seqcount#2
 -> [ffff88811ac44b48] lock#2
 -> [ffffffff849cebe0] &____s->seqcount
 -> [ffff88811ac45780] lock#3
 -> [ffffffff849ea3e0] &root->kernfs_rwsem
 -> [ffffffff83d94330] &sem->wait_lock
 -> [ffffffff83d8e820] &p->pi_lock
 -> [ffffffff84a04980] &bdev->bd_size_lock
 -> [ffffffff82ef8d78] (console_sem).lock
 -> [ffffffff84a05480] &q->mq_freeze_lock
 -> [ffffffff83322e18] percpu_ref_switch_lock
 -> [ffffffff84a05460] &q->mq_freeze_wq
 -> [ffffffff83d93000] &rq->__lock
 -> [ffffffff831cf1a0] quarantine_lock
 -> [ffffffff849e57a0] &dentry->d_lock
 -> [ffffffff83d94320] &lock->wait_lock
 -> [ffffffff83110f98] console_owner_lock

I think lo_open() and lo_release() are doing too much things. I wish "struct block_device_operations"
provides open() and release() callbacks without disk->open_mutex held...

