Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921945;
	b=WdBFLmRUiB6A+L5cL71riIIIt8WZyovLsPHyDrk6lRM6SHuxdhYOFGP1Va+LXdIKMxJV
	 8a1s2rh3JMhcom525NAVEEltvRnbH8135niPjn3Yi1aqVyaMcDmW+A+egtKCiii1tDIrc
	 fuOxmlQnD311lS2jSkZ6jB1r0UN2XTAZFY4mrb+qSFBUHRzSxUhXogGKCuuVz3T49IMAe
	 REAoj2T5DGvL+g2fM9/4pVqp5ZBgEoUqwHGJM4ULdxRwkAH2p7SOX3kri8kDHtPQ7bqXo
	 vOY32/wK+5hofjb/colY0rtViK94KtHjXGw0irIdITRL2//jtHNVHfR22lPCBDsrgGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921945;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=W1NqBkgOwldJAGKAsrbwFr1nxuedJRsxeUt9G5j9HPE=;
	b=s+HWSn14J+1JweFx6MVO+cUd8vED1rvwAhWvTL8giWK1Vy1i9odG9HwzW6nOkxMjRxk2
	 sq6XpBxzlHTUsvnbTDZZsEvysxXK5gGEcnvz+PLZjFkChFnFjn9swLZ2i9N1xa2Kwqc2h
	 dqnzthvuu3T4hM3V/NVr/FDnN/34OUjKuN7KK5F4a4CJaH6BU1N0tx/ZjoOMeeYsMS5pw
	 wjcQFcI9OqLreqybqkQk3tIOfGGn8JPhbObOORWy52K/Hyr8qDdyr+Gw/q5sjYNUy3vn3
	 djNHeR5ihtNapimR0WxMxryA6cFfsu7+P32GBXQ2yh+Bghbae3TnhmhSnbQm3uF3FYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CC7606A31C
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 13:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6CC7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jTQSZ3h9cz1c1Gy
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 21:24:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A3C864056E
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 21:25:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP4 (Coremail) with UTF8SMTPSA id gCh0CgB3sO_QVfxqx7HbEg--.61244S4;
	Tue, 17 Nov 2026 21:25:37 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	bvanassche@acm.org
Cc: ming.lei@redhat.com
Subject: [PATCH v4] blk-flush: fix a possible deadlock in the nvme timeout path
Date: Tue, 17 Nov 2026 21:15:40 +0800
Message-Id: <20261117131540.3542423-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3sO_QVfxqx7HbEg--.61244S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Zw15KrWfJw4rAr47CF1xKrg_yoWkGr4rpF
	W5XayYkr4rWr40qr4fJw4DZw13Zw4SyF13JFZYkr13Zrn8G39akryfJryFqFW3Ar93Ar47
	WFs8K39rZFWqqrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

When processing nvme_timeout():

[  206.734601][ T8184] nvme nvme0: I/O tag 512 (1200) opcode 0x0 (I/O Cmd) QID 3 timeout, aborting req_op:FLUSH(2) size:0
[  206.736112][    C0] nvme nvme0: Abort status: 0x0
[  208.094637][ T8184] nvme nvme0: I/O tag 512 (1200) opcode 0x0 (I/O Cmd) QID 3 timeout, reset controller

[root@localhost ~]# cat /proc/8184/stack
[<0>] msleep+0x37/0x50
[<0>] blk_mq_tagset_wait_completed_request+0x6f/0xe0
[<0>] nvme_cancel_tagset+0x79/0xa0
[<0>] nvme_dev_disable+0x55c/0x7e0
[<0>] nvme_timeout+0x25b/0x1530
[<0>] blk_mq_handle_expired+0x210/0x2c0
[<0>] bt_iter+0x2bb/0x360
[<0>] blk_mq_queue_tag_busy_iter+0x9f8/0x1f30
[<0>] blk_mq_timeout_work+0x5dc/0x7d0
[<0>] process_one_work+0xa08/0x1d00
[<0>] worker_thread+0x698/0xeb0
[<0>] kthread+0x408/0x540
[<0>] ret_from_fork+0xa4d/0xdd0
[<0>] ret_from_fork_asm+0x1a/0x30

The above issue may happen as follows:
nvme_timeout  // tag 512 request's flush request the first timeout
  iod->aborted = 1;
  abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
         BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);  // Abort tag 512 flush request
  blk_execute_rq_nowait(abort_req->q, NULL, abort_req, 0, abort_endio);
     // Abort request completion, will no wait
        ....
 ****'abort_req' not complete***
        ....
nvme_timeout  // tag 512 request's flush request the second timeout
 if (!nvmeq->qid || (iod->flags & IOD_ABORTED))
   nvme_req(req)->flags |= NVME_REQ_CANCELLED;
   goto disable;
     ...
   **** tag 512 request's flush request end ****
        nvme_try_complete_req  // PATH[1]
         blk_mq_complete_request_remote(req);
          WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
           ...
            nvme_end_req(req);
             blk_mq_end_request(req, status);
              __blk_mq_end_request(rq, error);
               if (rq->end_io)
                rq->end_io(rq, error);
                 flush_end_io(rq, error);
                 // The timeout process holds the reference count.
                 // so request keep MQ_RQ_COMPLETE state
                  if (!refcount_dec_and_test(&flush_rq->ref))
                   fq->rq_status = error;
                   return;
   **** tag 512 flush request is MQ_RQ_COMPLETE state ****
disable:
  nvme_dev_disable(dev, false);
    nvme_cancel_tagset(&dev->ctrl);
      blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request,
                              &dev->ctrl);
        nvme_cancel_request
          if (blk_mq_request_completed(req)) // PATH[2]
            return true;
     blk_mq_tagset_wait_completed_request(&dev->tagset);
       while (true)
         blk_mq_tagset_busy_iter(tagset,
                          blk_mq_tagset_count_completed_rqs, &count);
            blk_mq_tagset_count_completed_rqs();
            // request is MQ_RQ_COMPLETE state
               if (blk_mq_request_completed(rq))   // return true
                 (*count)++;
         if (!count) // So the value of 'count' is never 0, loop endless
             break;
         msleep(5);

The root cause is that a flush request is moved to MQ_RQ_IDLE only when its
reference count drops to zero, which was introduced by commit 9f16a66733c9
("block: mark flush request as IDLE when it is really finished").

bt_iter() obtains a reference to the request via blk_mq_find_and_get_req()
before invoking the ->timeout() callback, and that reference is only
dropped by blk_mq_put_rq_ref() after ->timeout() has returned. The timeout
handler thus holds a reference while it runs. When ->timeout() itself waits
for completed requests to become idle, as nvme_timeout() does through
blk_mq_tagset_wait_completed_request(), it waits for a request whose last
reference is held by the very call that is waiting: flush_end_io() returns
early and leaves the request in MQ_RQ_COMPLETE, so count never reaches zero
and the loop spins forever.

Fix this by marking the flush request MQ_RQ_IDLE as soon as its
completion is processed, before waiting for the remaining references.
This is what blk_mq_free_request() and blk_mq_end_request_batch()
already do for regular requests: the state is set to MQ_RQ_IDLE before
the reference is dropped. This restores the behavior of commit
65ff5cd04551 ("blk-mq: mark flush request as IDLE in flush_end_io()"),
which commit 9f16a66733c9 ("block: mark flush request as IDLE when it
is really finished") moved out of the common path because flush_end_io()
is also called from the tag iteration code. This patch restores it for
the completion path only.

Marking the state early does not allow fq->flush_rq to be reused:
blk_kick_flush() only issues a new flush request if
fq->flush_pending_idx == fq->flush_running_idx, and fq->flush_running_idx
is only toggled by flush_end_io_put_ref() after the last reference has been
dropped.

flush_end_io() is also invoked from blk_mq_put_rq_ref() when a tag iterator
drops its reference, including for flush requests that are still in flight.
That path must not change the request state, otherwise the timeout handler
would no longer see an in-flight flush request (blk_mq_req_expired()
requires MQ_RQ_IN_FLIGHT) and blk_mq_queue_inflight()/nvme_cancel_tagset()
would skip it. Use a separate helper for that path that only drops the
reference. Since the initial reference of a flush request is only dropped
by flush_end_io(), the last reference can only be dropped from that helper
after flush_end_io() has already set the request state to MQ_RQ_IDLE, so
not touching the state there is fine.

Fixes: 9f16a66733c9 ("block: mark flush request as IDLE when it is really finished")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
v3 -> v4:
  - Make the commit message explain explicitly that bt_iter() holds a
    reference across ->timeout(), so waiting for completed requests waits
    for itself.
  - Mention that regular requests already set MQ_RQ_IDLE before dropping
    the reference, and document the history of commit 65ff5cd04551 and
    9f16a66733c9.
  - Annotate flush_end_io_put_ref() with __must_hold(&fq->mq_flush_lock)
    (fq is now passed in) instead of a comment.
  - Drop the block driver name from the source comment and explain why the
    request cannot be reused until the last reference is dropped.
  - Explain why blk_flush_put_rq_ref() need not touch the request state.

 block/blk-flush.c | 73 ++++++++++++++++++++++++++++++++++++-----------
 block/blk-mq.c    |  2 +-
 block/blk.h       |  1 +
 3 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 38bd4ae5d9e7..9e642b9709cd 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -198,18 +198,18 @@ static void blk_flush_complete_seq(struct request *rq,
 	blk_kick_flush(q, fq, cmd_flags);
 }
 
-static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
-				       blk_status_t error,
-				       const struct io_comp_batch *iob)
+/*
+ * Drop a reference to a flush request and, if it was the last one, run the
+ * final cleanup.
+ */
+static enum rq_end_io_ret flush_end_io_put_ref(struct request *flush_rq,
+					       struct blk_flush_queue *fq,
+					       blk_status_t error)
+	__must_hold(&fq->mq_flush_lock)
 {
 	struct request_queue *q = flush_rq->q;
 	struct list_head *running;
 	struct request *rq, *n;
-	unsigned long flags = 0;
-	struct blk_flush_queue *fq = blk_get_flush_queue(flush_rq->mq_ctx);
-
-	/* release the tag's ownership to the req cloned from */
-	spin_lock_irqsave(&fq->mq_flush_lock, flags);
 
 	if (!req_ref_put_and_test(flush_rq)) {
 		/*
@@ -219,17 +219,10 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 		 */
 		if (error != BLK_STS_OK)
 			fq->rq_status = error;
-		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 		return RQ_END_IO_NONE;
 	}
 
 	blk_account_io_flush(flush_rq);
-	/*
-	 * Flush request has to be marked as IDLE when it is really ended
-	 * because its .end_io() is called from timeout code path too for
-	 * avoiding use-after-free.
-	 */
-	WRITE_ONCE(flush_rq->state, MQ_RQ_IDLE);
 	if (fq->rq_status != BLK_STS_OK) {
 		error = fq->rq_status;
 		fq->rq_status = BLK_STS_OK;
@@ -257,10 +250,58 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 		blk_flush_complete_seq(rq, fq, seq, error);
 	}
 
-	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 	return RQ_END_IO_NONE;
 }
 
+static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
+				       blk_status_t error,
+				       const struct io_comp_batch *iob)
+{
+	struct blk_flush_queue *fq = blk_get_flush_queue(flush_rq->mq_ctx);
+	enum rq_end_io_ret ret;
+	unsigned long flags;
+
+	/* release the tag's ownership to the req cloned from */
+	spin_lock_irqsave(&fq->mq_flush_lock, flags);
+
+	/*
+	 * Mark the request IDLE as soon as its completion is processed. If an
+	 * iterator holds the last reference (e.g. a request timeout handler),
+	 * leaving it in MQ_RQ_COMPLETE would make
+	 * blk_mq_tagset_wait_completed_request() loop forever. This does not
+	 * allow the request to be reused: blk_kick_flush() only issues a new
+	 * flush request if fq->flush_pending_idx == fq->flush_running_idx, and
+	 * fq->flush_running_idx is only toggled by flush_end_io_put_ref() after
+	 * the last reference has been dropped.
+	 */
+	WRITE_ONCE(flush_rq->state, MQ_RQ_IDLE);
+
+	ret = flush_end_io_put_ref(flush_rq, fq, error);
+	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
+	return ret;
+}
+
+/*
+ * Called when a tag iterator drops its reference to a flush request. It must
+ * not change the request state: the iterator may be looking at a request that
+ * is still in flight.
+ *
+ * Not touching the state here is fine even when this drops the last reference,
+ * because the initial reference is only dropped by flush_end_io(), which has
+ * already marked the request MQ_RQ_IDLE by the time this can be the last one.
+ */
+enum rq_end_io_ret blk_flush_put_rq_ref(struct request *flush_rq)
+{
+	struct blk_flush_queue *fq = blk_get_flush_queue(flush_rq->mq_ctx);
+	unsigned long flags;
+	enum rq_end_io_ret ret;
+
+	spin_lock_irqsave(&fq->mq_flush_lock, flags);
+	ret = flush_end_io_put_ref(flush_rq, fq, BLK_STS_OK);
+	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
+	return ret;
+}
+
 bool is_flush_rq(struct request *rq)
 {
 	return rq->end_io == flush_end_io;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ae22d556540..1bb75de288c1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1688,7 +1688,7 @@ static bool blk_mq_req_expired(struct request *rq, struct blk_expired_data *expi
 void blk_mq_put_rq_ref(struct request *rq)
 {
 	if (is_flush_rq(rq)) {
-		if (rq->end_io(rq, 0, NULL) == RQ_END_IO_FREE)
+		if (blk_flush_put_rq_ref(rq) == RQ_END_IO_FREE)
 			blk_mq_free_request(rq);
 	} else if (req_ref_put_and_test(rq)) {
 		__blk_mq_free_request(rq);
diff --git a/block/blk.h b/block/blk.h
index 0e38e4b88cf5..c190ecd9bd66 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -45,6 +45,7 @@ struct blk_flush_queue {
 };
 
 bool is_flush_rq(struct request *req);
+enum rq_end_io_ret blk_flush_put_rq_ref(struct request *req);
 
 struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 					      gfp_t flags);
-- 
2.34.1

