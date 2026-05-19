Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5A1DE8BB;
	Tue, 19 May 2026 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182873; cv=none; b=N98BC4JPsVMIE8qtIYK4nDdCqtFGN8VKwxS0wJLiXc8BX1XrtBd/dV38e19fQOisuuJrwZ4H8lF/kCZTsicEwqF2R005pVz673BZdKqSOXbtJNlZ8HQ8IahHJKjap++68UrI59ExFeQY4rcEfySi1uqECeYk68F0lqRmzZQesFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182873; c=relaxed/simple;
	bh=aEQnsPukQSqa6lUUXnAh1X3y62rqxIaRosLtp0QUu64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCpNrTXm1OVQykP7vEvy0BxydLZ0OffSD5sHjppwXTLN7PyiPSLho0jNKhJncyvHc8IxPIlsUOTGxVE56Hv5GAKbdRPhnxpBSlt2BHdflRySF2i9F2xSZHnMIdxkhnvr+Dv1HSOxDHI2IEPzBP31pxAQd0MUL+JiO/VIqQ41gBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64J9RF2i061321;
	Tue, 19 May 2026 18:27:15 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64J9RFKM061316
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 19 May 2026 18:27:15 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d43125ff-cc66-49b7-b16d-1b2650c68c23@I-love.SAKURA.ne.jp>
Date: Tue, 19 May 2026 18:27:11 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] loop: Fix NULL pointer dereference by synchronizing
 lo_release and loop_queue_rq
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <69e2ca14.a00a0220.1bd0ca.0031.GAE@google.com>
 <e1d824ba-9ac7-4fde-a791-32eeadcd4258@I-love.SAKURA.ne.jp>
 <e33b4060-69d9-4d02-a330-2fbd19249237@I-love.SAKURA.ne.jp>
 <c0047a38-3d02-4ce5-88b0-2b7d0b9b69fa@acm.org>
 <f720dd8b-4aa3-48e4-a1bb-c0b43eb70f19@I-love.SAKURA.ne.jp>
 <af2205e3-205e-4743-a767-8593c2c4747a@I-love.SAKURA.ne.jp>
 <9b2032d6-3f36-4d2b-8128-985c08a4fa37@I-love.SAKURA.ne.jp>
 <20260518174013.4b72dd50a5bcb89daaed1f62@linux-foundation.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260518174013.4b72dd50a5bcb89daaed1f62@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav201.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/05/19 9:40, Andrew Morton wrote:
> AI review asked a couple of questions:
> 	https://sashiko.dev/#/patchset/9b2032d6-3f36-4d2b-8128-985c08a4fa37@I-love.SAKURA.ne.jp

To: gemini/gemini-3.1-pro-preview

Thank you for your valuable feedback. Your point about asynchronous I/O completing after drain_workqueue()
and potentially causing a UAF at file_inode() from kiocb_end_write() from lo_rw_aio_do_completion() is correct.
The drain_workqueue() alone does not wait for in-flight AIOs that have already returned -EIOCBQUEUED. However,
I'm not convinced that use of blk_mq_freeze_queue() inside __loop_clr_fd() where disk->open_mutex was already
held by bdev_release() is absolutely deadlock-free.

1. VFS and Block Layer Lock Contention:
   __loop_clr_fd() is exclusively invoked from the lo_release() path during the final close of the device.
   At this stage, the block layer is holding disk->open_mutex. If we call blk_mq_freeze_queue() here, it will
   synchronously wait for all in-flight AIOs to complete. However, the completion paths of those in-flight AIOs
   (or subsequent metadata processing in the underlying filesystem) may attempt to acquire resources or execute
   code paths that depend on the very same device state or open/close status. This creates a circular dependency,
   leading to an unrecoverable hang.

2. Memory Reclaim Deadlock:
   blk_mq_freeze_queue() blocks until the queue's usage counter drops to zero. If an in-flight AIO requires memory
   allocation for metadata updates upon completion, and the system is under heavy memory pressure, it can trigger
   direct memory reclaim. If the reclaim path attempts to sync other buffers or interact with the frozen loop
   device/queue, a circular deadlock occurs.

Therefore, I would like to choose SRCU-based synchronization instead of blk_mq_freeze_queue().

* Locking: We call srcu_read_lock(&loop_io_srcu) only for asynchronous paths (cmd->use_aio) immediately
  before submitting the I/O to the underlying filesystem in lo_rw_aio().

* Unlocking: The reader lock is released via srcu_read_unlock() at the very end of the AIO completion handler
  (lo_rw_aio_do_completion()).

* Synchronization: We place synchronize_srcu(&loop_io_srcu) immediately after drain_workqueue() in __loop_clr_fd().

I think that this guarantees that __loop_clr_fd() safely blocks until all pending AIO callbacks are 100% completed,
fully eliminating the UAF risk and ensuring the safety of the subsequent mapping_set_gfp_mask() and fput(), while
remaining entirely deadlock-free.

What do you think about this approach?

 drivers/block/loop.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0000913f7efc..7c3961f3cbc9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -80,6 +80,7 @@ struct loop_cmd {
 	struct list_head list_entry;
 	bool use_aio; /* use AIO interface to handle I/O */
 	atomic_t ref; /* only for aio */
+	int srcu_idx;
 	long ret;
 	struct kiocb iocb;
 	struct bio_vec *bvec;
@@ -93,6 +94,7 @@ struct loop_cmd {
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 static DEFINE_MUTEX(loop_validate_mutex);
+DEFINE_SRCU(loop_io_srcu);
 
 /**
  * loop_global_lock_killable() - take locks for safe loop_validate_file() test
@@ -327,6 +329,8 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 		kiocb_end_write(&cmd->iocb);
 	if (likely(!blk_should_fake_timeout(rq->q)))
 		blk_mq_complete_request(rq);
+	if (cmd->use_aio)
+		srcu_read_unlock(&loop_io_srcu, cmd->srcu_idx);
 }
 
 static void lo_rw_aio_complete(struct kiocb *iocb, long ret)
@@ -392,6 +396,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	if (cmd->use_aio) {
 		cmd->iocb.ki_complete = lo_rw_aio_complete;
 		cmd->iocb.ki_flags = IOCB_DIRECT;
+		cmd->srcu_idx = srcu_read_lock(&loop_io_srcu);
 	} else {
 		cmd->iocb.ki_complete = NULL;
 		cmd->iocb.ki_flags = 0;
@@ -1118,6 +1123,22 @@ static void __loop_clr_fd(struct loop_device *lo)
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
 
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
+	synchronize_srcu(&loop_io_srcu);
+
 	spin_lock_irq(&lo->lo_lock);
 	filp = lo->lo_backing_file;
 	lo->lo_backing_file = NULL;

