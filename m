Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5927A314D2D;
	Mon, 11 May 2026 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499845; cv=none; b=AkQc6j+wEHqlAFi+WJqipsg7OykKikfQspJxJWtwJPAxeZ79JG7j0+lhBLOrjsEV+XyBA5BknXBeHe849PtioDcKCbvu7KBHgfgpjRBh2XhX98xqL/rvT6jZzq0jNMYyxBb0y/toFNKK06wqyTL1/o+zDZZGVyVPSbuNahgQ9Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499845; c=relaxed/simple;
	bh=gCzv8v1uAfyIzE+5M43AB+N7kVCSNtujZB9qgESEOyE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=O11bwuVZEuzZWewDudNCVEHDxBGi+ET1dDGxY01m72UCNzuWzgq61gPaJI8h1GRZW9Vslib1mHgefBfDL5gA+GzQ7xZP0M0mnxAUoxCKlp+SDSYmM0ScNnNxo/uQISNRhtLnM0mVg3fvZbXDdKSSqPU1/QhlE4fjpJ0epHtGR2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64BBhMFX097501;
	Mon, 11 May 2026 20:43:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64BBhLPM097493
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 11 May 2026 20:43:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e33b4060-69d9-4d02-a330-2fbd19249237@I-love.SAKURA.ne.jp>
Date: Mon, 11 May 2026 20:43:18 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] loop: Fix NULL pointer dereference by synchronizing
 lo_release and loop_queue_rq
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>
References: <69e2ca14.a00a0220.1bd0ca.0031.GAE@google.com>
 <e1d824ba-9ac7-4fde-a791-32eeadcd4258@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <e1d824ba-9ac7-4fde-a791-32eeadcd4258@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp
X-Virus-Status: clean

Summary:
This patch addresses a NULL pointer dereference in lo_rw_aio() by
introducing SRCU-based synchronization and explicit workqueue draining
during device release. This race appears to have been exacerbated or
introduced by recent changes in the block layer's request completion and
freezing logic.

Problem Description:
A NULL pointer dereference was reported by syzbot. The crash occurs when
lo_rw_aio() access lo->lo_backing_file which has already been cleared by
__loop_clr_fd().

The investigation suggests a gap between loop_queue_rq() and the driver's
internal workqueue. Even when the block layer attempts to freeze the queue,
requests that have already passed the loop_queue_rq() state check but have
not yet been queued to lo->workqueue can "leak" and execute after
lo_release() has proceeded to teardown the device.

Suspicious Commits and Behavioral Changes:
We suspect this race became visible due to behavioral changes in how the
block layer handles request completion and synchronization, specifically:

1. Commit 65565ca5f99b ("block: unify the synchronous bi_end_io
   callbacks"): This unified completion path might have altered the timing
   or the visibility of in-flight requests during a queue freeze, allowing
   lo_release() to proceed before the loop driver's internal asynchronous
   work has been fully accounted for.

2. Changes in blk_mq_freeze_queue(): In older kernels, the freeze mechanism
   might have more effectively covered the window between queue_rq and the
   driver's execution of that request. The current behavior seems to allow
   __loop_clr_fd() to run while loop_queue_rq() is still in the middle of
   scheduling work.

Stability and Backporting:
Because the underlying cause is tied to recent block layer refactoring,
this patch should not be backported to older stable kernels without careful
verification, as it may be unnecessary or lead to performance regressions
due to the added SRCU overhead.

Solution:
The patch closes the race window using SRCU:

* loop_queue_rq: Wrapped in srcu_read_lock() to ensure that once a request
  passes the Lo_bound check, the corresponding queue_work() must complete
  before the teardown path can finish its synchronization.

* lo_release: Calls synchronize_srcu() followed by drain_workqueue(). This
  sequence ensures:
  * No new work can be scheduled (lo_state change).
  * All ongoing scheduling calls have finished (synchronize_srcu).
  * All scheduled work has finished executing (drain_workqueue).
  * Finally, it is safe to clear lo_backing_file.

Trace Evidence:
Console logs with debug printk() patch confirm that __loop_clr_fd() has
cleared the file for loop3 between multiple lo_rw_aio() requests.

  [  122.956248][ T6148] loop3: detected capacity change from 0 to 32768
  [  122.958217][ T6142] lo_rw_aio(loop3) starting read with raw_refcnt=0x0, refcnt=1
  (...snipped...)
  [  123.234786][   T44] lo_rw_aio(loop3) starting read with raw_refcnt=0x0, refcnt=1
  [  123.254716][ T6148] __loop_clr_fd(loop3) clearing lo_backing_file with raw_refcnt=0x0, refcnt=1
  [  123.265134][  T180] lo_rw_aio(loop3) starting write with NULL file (already cleared?)
  [  123.265221][  T180] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000014: 0000 [#1] SMP KASAN PTI
  [  123.265238][  T180] KASAN: null-ptr-deref in range [0x00000000000000a0-0x00000000000000a7]
  [  123.265255][  T180] CPU: 0 UID: 0 PID: 180 Comm: kworker/u8:7 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
  [  123.265276][  T180] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
  [  123.265287][  T180] Workqueue: loop3 loop_workfn
  [  123.265320][  T180] RIP: 0010:lo_rw_aio+0xd1d/0x1170

Reported-by: syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28
Analyzed-by: AI Mode in Google Search (no mail address)
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Since this race condition is difficult to reproduce, we can't do bisection.
I hope you can figure out what has changed in the block layer for this merge window.
You might want to revert instead of modifying the loop driver.

 drivers/block/loop.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0000913f7efc..9be47ce97dab 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -93,6 +93,7 @@ struct loop_cmd {
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 static DEFINE_MUTEX(loop_validate_mutex);
+DEFINE_SRCU(loop_io_srcu);
 
 /**
  * loop_global_lock_killable() - take locks for safe loop_validate_file() test
@@ -1747,8 +1748,19 @@ static void lo_release(struct gendisk *disk)
 	need_clear = (lo->lo_state == Lo_rundown);
 	mutex_unlock(&lo->lo_mutex);
 
-	if (need_clear)
+	if (need_clear) {
+		/*
+		 * Now that loop_queue_rq() sees lo->lo_state != Lo_bound,
+		 * wait for already started loop_queue_rq() to complete.
+		 */
+		synchronize_srcu(&loop_io_srcu);
+		/*
+		 * Now that no more works are scheduled by loop_queue_rq(),
+		 * wait for already scheduled works to complete.
+		 */
+		drain_workqueue(lo->workqueue);
 		__loop_clr_fd(lo);
+	}
 }
 
 static void lo_free_disk(struct gendisk *disk)
@@ -1854,11 +1866,15 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *rq = bd->rq;
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	struct loop_device *lo = rq->q->queuedata;
+	int idx;
 
 	blk_mq_start_request(rq);
 
-	if (data_race(READ_ONCE(lo->lo_state)) != Lo_bound)
+	idx = srcu_read_lock(&loop_io_srcu);
+	if (data_race(READ_ONCE(lo->lo_state)) != Lo_bound) {
+		srcu_read_unlock(&loop_io_srcu, idx);
 		return BLK_STS_IOERR;
+	}
 
 	switch (req_op(rq)) {
 	case REQ_OP_FLUSH:
@@ -1888,6 +1904,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 #endif
 	loop_queue_work(lo, cmd);
 
+	srcu_read_unlock(&loop_io_srcu, idx);
 	return BLK_STS_OK;
 }
 
-- 
2.54.0


