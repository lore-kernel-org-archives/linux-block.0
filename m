Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0C347252E;
	Sat, 19 Sep 2026 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789815116; cv=none; b=LNz8ltRnZlN1P/ifKgcofeqlhL5PthJUk62mV9Gy7oEX2BLRukbr/HHVXlSztOh2MOqbXWuRbWj8kufFSOxaXWMHy3PPoNEZtUDrLQ7pwSKO6xWC0ni2UfyTorGp4+ZBSk6aUwJJ6aZhRoMQ/0YoqQukDYyM73UZAc2fG55MkBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789815116; c=relaxed/simple;
	bh=iC29JAEfqFMEdPfBil/8vJAkSUiXs4LGmMu7D1WriVw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VbOzclugOQlLMwOsAwsIZ9IhZ+Lk+sWeAgQ3Q+BqNv1FmR3drcyhkB8YCYsoxNfYE2ICJMUZSNJGI7BrO7vx+p7nHhr89xWjVLt7Rw6BqIUUTeUe5afpyr5mxu3L/zyPAb76lzR2sdyR9fqdAUvzRfZnA08RxMQqyrQ3PZfIrSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68JAp3ZE057691;
	Sat, 19 Sep 2026 19:51:03 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68JAp2Eb057681
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 19 Sep 2026 19:51:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1b6728b4-3232-4ba6-8114-a3d04d694c62@I-love.SAKURA.ne.jp>
Date: Sat, 19 Sep 2026 19:51:00 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 2/2] loop: Perform __loop_clr_fd() from run_todo callback.
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-block <linux-block@vger.kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster
 <bfoster@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>, Hillf Danton <hdanton@sina.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
        rust-for-linux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nilay Shroff <nilay@linux.ibm.com>
References: <e615fb71-f386-4029-8ceb-22e375ad9e94@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <e615fb71-f386-4029-8ceb-22e375ad9e94@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav312.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is reporting NULL pointer dereference in lo_rw_aio().
An analysis by the Gemini AI collaborator considers that this problem
is caused by a timing shift primarily exposed by commit 65565ca5f99b
("block: unify the synchronous bi_end_io callbacks"), along with helper
refactorings like commit 92c3737a2473 ("block: add a bio_submit_or_kill
helper").

But due to difficulty of reproducing this race, discussion about what is
happening and how to fix this problem is stalling. Also, we haven't
identified how many filesystems are subjected to this problem.

Therefore, introduce a grace period for flushing outstanding I/O
(which should be a good thing from the perspective of defensive
programming) so that we won't hit NULL pointer dereference problem.

Since calling drain_workqueue() from __loop_clr_fd() with disk->open_mutex
held causes lockdep warnings, call __loop_clr_fd() from lo_run_todo().
Use rundown_owner for remembering who is responsible for calling
__loop_clr_fd() from lo_run_todo().

Link: https://lkml.kernel.org/r/fbb3edda-f108-4e5b-acf2-266f043f8125@I-love.SAKURA.ne.jp
Reported-by: syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28
Reported-by: syzbot+bc273027d5643e48e5b3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bc273027d5643e48e5b3
Depends-on: "block: Add run_todo() operation"
Fixes: 65565ca5f99b ("block: unify the synchronous bi_end_io callbacks")
Assisted-by: Gemini-Pro
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v4:
  Removed need_clear variable.

 drivers/block/loop.c | 66 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 758c20678bf6..86ddcd9dadf0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -75,6 +75,7 @@ struct loop_device {
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
 	bool			idr_visible;
+	struct task_struct	*rundown_owner; /* current or NULL */
 };
 
 struct loop_cmd {
@@ -1138,11 +1139,39 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 
 static void __loop_clr_fd(struct loop_device *lo)
 {
+	struct gendisk *disk = lo->lo_disk;
 	struct queue_limits lim;
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
 	int err;
 
+	/* Step 1: Flush all outstanding I/O, without open_mutex held. */
+	/*
+	 * Since loop_queue_rq() is called with RCU read lock, this synchronize_rcu()
+	 * makes sure that no more queue_work() calls are made from loop_queue_work()
+	 * from loop_queue_rq(). Subsequent loop_queue_rq() calls which are made after
+	 * this synchronize_rcu() returned shall see lo->lo_state != Lo_bound and
+	 * return with BLK_STS_IOERR.
+	 */
+	synchronize_rcu();
+	/*
+	 * This drain_workqueue() makes sure that no more loop_handle_cmd() calls are
+	 * made from loop_process_work() from loop_workfn()/loop_rootcg_workfn().
+	 */
+	drain_workqueue(lo->workqueue);
+	/*
+	 * This blk_mq_freeze_queue() waits for completion of all outstanding I/O
+	 * which has been scheduled via loop_queue_rq(), by waiting for q_usage_counter
+	 * to reach 0. Since the lo->lo_state != Lo_bound check in loop_queue_rq()
+	 * guarantees that no more new I/O requests are made, we can call
+	 * blk_mq_unfreeze_queue() immediately after blk_mq_freeze_queue() returns.
+	 */
+	blk_mq_unfreeze_queue(lo->lo_queue, blk_mq_freeze_queue(lo->lo_queue));
+
+	/* Step 2: Perform remaining cleanup, with open_mutex held. */
+	mutex_lock(&disk->open_mutex);
+	WARN_ON_ONCE(lo->lo_state != Lo_rundown);
+
 	spin_lock_irq(&lo->lo_lock);
 	filp = lo->lo_backing_file;
 	lo->lo_backing_file = NULL;
@@ -1153,12 +1182,7 @@ static void __loop_clr_fd(struct loop_device *lo)
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
@@ -1201,11 +1225,9 @@ static void __loop_clr_fd(struct loop_device *lo)
 	WRITE_ONCE(lo->lo_state, Lo_unbound);
 	mutex_unlock(&lo->lo_mutex);
 
-	/*
-	 * Need not hold lo_mutex to fput backing file. Calling fput holding
-	 * lo_mutex triggers a circular lock dependency possibility warning as
-	 * fput can take open_mutex which is usually taken before lo_mutex.
-	 */
+	/* Step 3: Drop refcounts, without open_mutex held. */
+	mutex_unlock(&disk->open_mutex);
+
 	fput(filp);
 }
 
@@ -1754,7 +1776,6 @@ static int lo_open(struct gendisk *disk, blk_mode_t mode)
 static void lo_release(struct gendisk *disk)
 {
 	struct loop_device *lo = disk->private_data;
-	bool need_clear = false;
 
 	if (disk_openers(disk) > 0)
 		return;
@@ -1768,11 +1789,27 @@ static void lo_release(struct gendisk *disk)
 	if (lo->lo_state == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR))
 		WRITE_ONCE(lo->lo_state, Lo_rundown);
 
-	need_clear = (lo->lo_state == Lo_rundown);
+	/*
+	 * In order to flush outstanding I/O (without open_mutex for deadlock
+	 * avoidance) before clearing the backing device, defer __loop_clr_fd()
+	 * to lo_run_todo().
+	 * The Lo_rundown state guarantees that lo_open() will fail with -ENXIO.
+	 * The failing lo_open() guarantees that lo_release() will not overwrite
+	 * lo->rundown_owner until __loop_clr_fd() resets to the Lo_unbound state.
+	 */
+	if (lo->lo_state == Lo_rundown)
+		WRITE_ONCE(lo->rundown_owner, current);
 	mutex_unlock(&lo->lo_mutex);
+}
 
-	if (need_clear)
+static void lo_run_todo(struct gendisk *disk)
+{
+	struct loop_device *lo = disk->private_data;
+
+	if (READ_ONCE(lo->rundown_owner) == current) {
+		WRITE_ONCE(lo->rundown_owner, NULL);
 		__loop_clr_fd(lo);
+	}
 }
 
 static void lo_free_disk(struct gendisk *disk)
@@ -1791,6 +1828,7 @@ static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
 	.open =         lo_open,
 	.release =	lo_release,
+	.run_todo =	lo_run_todo,
 	.ioctl =	lo_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl =	lo_compat_ioctl,
-- 
2.55.0

