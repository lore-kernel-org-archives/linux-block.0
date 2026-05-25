Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBEC23C503
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779680431; cv=none; b=EhJJESlbZTzxBisRPvbarXiDxLl+sCoO96tlhUwLR/l+ZJ+lKQBsuw8XL1xMfRWS5F37fJppb17xQ0db9cn4XMPVpqgyGhs/gYKeF/VLGqvTRd5moScYQSoyHs7IhPAzPKZle5I5y5iDuwd6iwMaPpJqg+LHAyiNO49jbh4KVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779680431; c=relaxed/simple;
	bh=hhDPtijQgqTS/DbP5UJ+pBBe702PEJVvDttz51c/FaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1lLI/i4aEq+flqcNvBJ6CcP+kg2aSlqHNpWSw0fdAIWL9GwQjyCiuimLngGlZ8jmM7z8APY3+Fr/kua4RTx9Iv3fvmGtMxIUn3KsJfOiDLGaH/UkGM3kzgyawJMxgZ6DQuKq3pYOSvLS4WAMa19ODQ8h9Qm/6DnPJ5Ra9rhVlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64P3eMoo099445;
	Mon, 25 May 2026 12:40:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64P3eLh6099440
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 25 May 2026 12:40:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fda8abc8-6aa2-463b-bf72-865f6b838034@I-love.SAKURA.ne.jp>
Date: Mon, 25 May 2026 12:40:19 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] loop: Fix NULL pointer dereference in lo_rw_aio()
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <c0047a38-3d02-4ce5-88b0-2b7d0b9b69fa@acm.org>
 <f720dd8b-4aa3-48e4-a1bb-c0b43eb70f19@I-love.SAKURA.ne.jp>
 <af2205e3-205e-4743-a767-8593c2c4747a@I-love.SAKURA.ne.jp>
 <9b2032d6-3f36-4d2b-8128-985c08a4fa37@I-love.SAKURA.ne.jp>
 <20260518174013.4b72dd50a5bcb89daaed1f62@linux-foundation.org>
 <d43125ff-cc66-49b7-b16d-1b2650c68c23@I-love.SAKURA.ne.jp>
 <ag0lS_CbKO9R5CV8@fedora>
 <94076bc9-2c09-4bb6-8468-b6b8af419cb9@I-love.SAKURA.ne.jp>
 <ag1nfIFcykmQHbkk@fedora>
 <1ab8c579-eb76-4227-8a72-6ec819135219@I-love.SAKURA.ne.jp>
 <ag1223nAa0wZ8ALC@fedora>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ag1223nAa0wZ8ALC@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav201.rs.sakura.ne.jp
X-Virus-Status: clean

Some commit which was merged in the merge window for 7.1 broke the loop
driver; a race window where lo_release() clears the backing file via
__loop_clr_fd() despite some I/O requests are pending was introduced [1][2].

The exact commit which changed the behavior is not known due to lack of
reproducer and timing dependent behavior, but it seems that we need to
solve this problem in the loop driver despite there was no change for the
loop driver during this merge window.

To close this race, try to flush pending I/O requests. However, calling
drain_workqueue() from __loop_clr_fd() with disk->open_mutex held causes
lockdep warnings [3][4]. We need to flush pending I/O requests without
disk->open_mutex held.

In the past, commit 322c4293ecc5 ("loop: make autoclear operation
asynchronous") has tried to defer __loop_clr_fd() to WQ context. But it was
reverted by commit bf23747ee053 ("loop: revert "make autoclear operation
asynchronous"") because userspace might be expecting that fput() on the
backing file is processed before lo_release() from close() returns to user
mode.

Therefore, this patch tries to defer __loop_clr_fd() to task work context.
__loop_clr_fd() is split into three steps:

  Step 1: Flush pending I/O requests without holding disk->open_mutex.

  Step 2: Do what __loop_clr_fd() from lo_release() was doing with
          disk->open_mutex held.

  Step 3: Drop refcounts without holding disk->open_mutex.

A potential side effect of this approach is that a userspace program who
issued open() request before __loop_clr_fd() completes might be confused
by observing -ENXIO because lo_open() can be called before __loop_clr_fd()
completes.

Except for the side effect above, I expect this patch to work by the
following reasons.

- The existing Lo_rundown state safely guarantees that any subsequent
  lo_open() attempts will immediately fail with -ENXIO, preventing races
  even after disk->open_mutex is temporarily released.

- Since returning from lo_release() normally allows the block layer to
  immediately drop module and device references, this patch explicitly
  increments the refcounts (__module_get() and get_device()) before
  deferring the work, and safely releases them at the end of Step 3
  inside __loop_clr_fd().

- It prefers task_work so that userspace processes expecting immediate
  completion (such as fput() side-effects) receive a deterministic
  behavior before returning from close(). It falls back to schedule_work()
  if the current context is a kernel thread (PF_KTHREAD) or if
  task_work_add() fails.

Link: https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28 [1]
Link: https://syzkaller.appspot.com/bug?extid=bc273027d5643e48e5b3 [2]
Link: https://syzkaller.appspot.com/bug?extid=2f62807dc3239b8f584e [3]
Link: https://syzkaller.appspot.com/bug?extid=c4e9d077bcc86bee08dc [4]
Analyzed-by: AI Mode in Google Search (no mail address)
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 86 ++++++++++++++++++++++++++++++++++++--------
 kernel/task_work.c   |  1 +
 2 files changed, 73 insertions(+), 14 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0000913f7efc..d97aa2c209e3 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -36,6 +36,7 @@
 #include <linux/blk-mq.h>
 #include <linux/spinlock.h>
 #include <uapi/linux/loop.h>
+#include <linux/task_work.h>
 
 /* Possible states of device */
 enum {
@@ -74,6 +75,10 @@ struct loop_device {
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
 	bool			idr_visible;
+	union {
+		struct callback_head lo_clr_task_work;
+		struct work_struct lo_clr_work;
+	};
 };
 
 struct loop_cmd {
@@ -1112,12 +1117,34 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	return error;
 }
 
-static void __loop_clr_fd(struct loop_device *lo)
+static void __loop_clr_fd(struct callback_head *callback)
 {
+	struct loop_device *lo = container_of(callback, struct loop_device, lo_clr_task_work);
 	struct queue_limits lim;
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
 
+	/* Step 1: Flush all outstanding I/O, without open_mutex held. */
+
+	/*
+	 * Now that loop_queue_rq() sees lo->lo_state != Lo_bound,
+	 * wait for already started loop_queue_rq() to complete.
+	 */
+	synchronize_rcu();
+	/*
+	 * Now that no more works are scheduled by loop_queue_rq(),
+	 * wait for already scheduled works to complete.
+	 */
+	drain_workqueue(lo->workqueue);
+	/*
+	 * Now that no more AIO requests are scheduled by lo_rw_aio(),
+	 * wait for already started AIO to complete.
+	 */
+	blk_mq_unfreeze_queue(lo->lo_queue, blk_mq_freeze_queue(lo->lo_queue));
+
+	/* Step 2: Perform remaining cleanup, with open_mutex held. */
+	mutex_lock(&lo->lo_disk->open_mutex);
+
 	spin_lock_irq(&lo->lo_lock);
 	filp = lo->lo_backing_file;
 	lo->lo_backing_file = NULL;
@@ -1128,12 +1155,7 @@ static void __loop_clr_fd(struct loop_device *lo)
 	lo->lo_sizelimit = 0;
 	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
 
-	/*
-	 * Reset the block size to the default.
-	 *
-	 * No queue freezing needed because this is called from the final
-	 * ->release call only, so there can't be any outstanding I/O.
-	 */
+	/* Reset the block size to the default. */
 	lim = queue_limits_start_update(lo->lo_queue);
 	lim.logical_block_size = SECTOR_SIZE;
 	lim.physical_block_size = SECTOR_SIZE;
@@ -1145,8 +1167,6 @@ static void __loop_clr_fd(struct loop_device *lo)
 	/* let user-space know about this change */
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
-	/* This is safe: open() is still holding a reference. */
-	module_put(THIS_MODULE);
 
 	disk_force_media_change(lo->lo_disk);
 
@@ -1154,9 +1174,6 @@ static void __loop_clr_fd(struct loop_device *lo)
 		int err;
 
 		/*
-		 * open_mutex has been held already in release path, so don't
-		 * acquire it if this function is called in such case.
-		 *
 		 * If the reread partition isn't from release path, lo_refcnt
 		 * must be at least one and it can only become zero when the
 		 * current holder is released.
@@ -1181,12 +1198,31 @@ static void __loop_clr_fd(struct loop_device *lo)
 	WRITE_ONCE(lo->lo_state, Lo_unbound);
 	mutex_unlock(&lo->lo_mutex);
 
+	/* Step 3: Drop refcounts, without open_mutex held. */
+	mutex_unlock(&lo->lo_disk->open_mutex);
+
 	/*
 	 * Need not hold lo_mutex to fput backing file. Calling fput holding
 	 * lo_mutex triggers a circular lock dependency possibility warning as
 	 * fput can take open_mutex which is usually taken before lo_mutex.
 	 */
 	fput(filp);
+
+	/*
+	 * Drop all references that would have been dropped as soon as
+	 * returning from lo_release() and releasing disk->open_mutex.
+	 */
+	module_put(lo->lo_disk->fops->owner);
+	put_device(disk_to_dev(lo->lo_disk));
+
+	module_put(THIS_MODULE);
+}
+
+static void loop_clr_work(struct work_struct *work)
+{
+	struct loop_device *lo = container_of(work, struct loop_device, lo_clr_work);
+
+	__loop_clr_fd(&lo->lo_clr_task_work);
 }
 
 static int loop_clr_fd(struct loop_device *lo)
@@ -1747,8 +1783,30 @@ static void lo_release(struct gendisk *disk)
 	need_clear = (lo->lo_state == Lo_rundown);
 	mutex_unlock(&lo->lo_mutex);
 
-	if (need_clear)
-		__loop_clr_fd(lo);
+	/*
+	 * In order to flush pending I/O requests before clearing the backing device,
+	 * defer __loop_clr_fd() to task work context or normal workqueue context.
+	 * The Lo_rundown state guarantees that lo_open() will fail with -ENXIO.
+	 */
+	if (need_clear) {
+		/*
+		 * Grab all references that will be dropped as soon as returning from
+		 * lo_release() and releasing disk->open_mutex.
+		 */
+		get_device(disk_to_dev(disk));
+		__module_get(disk->fops->owner);
+		/*
+		 * Prefer task work, for userspace might be expecting that fput()
+		 * on the backing file is processed before lo_release() from close()
+		 * returns to user mode.
+		 */
+		init_task_work(&lo->lo_clr_task_work, __loop_clr_fd);
+		if ((current->flags & PF_KTHREAD) ||
+		    task_work_add(current, &lo->lo_clr_task_work, TWA_RESUME)) {
+			INIT_WORK(&lo->lo_clr_work, loop_clr_work);
+			schedule_work(&lo->lo_clr_work);
+		}
+	}
 }
 
 static void lo_free_disk(struct gendisk *disk)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 0f7519f8e7c9..45fd146b85df 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -102,6 +102,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(task_work_add);
 
 /**
  * task_work_cancel_match - cancel a pending work added by task_work_add()
-- 
2.54.0


