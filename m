Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836386;
	b=WCALsow5OL3AtdHiZp7W6EOivfSqdka58yEFPY2YZqz3MXQ6M/arjWWJri3kge2B4N9P
	 fyI3UtxPz+g5WiTq8Hbb0oFFIbTT5o7ik+UrGu8Wov8y7jJbIYtJ0b0K2S+fI4RlhIhmK
	 IpNeYxK9YnU+M3rovmslSubKgaDEsZ5vVyhWy/BKbPiuBubw0KXUv4ipgK8+jL3sKVLey
	 sWMMLvqxp4o3Rqm4/RWJjpEZvJRwX6A2zRVGuJmwcAurEfwBgWXZWAs+rO/feiH+YDMWn
	 6uOlLLJBl9whz8gIt/Iui4ZCJGx+WI81Vc4rh6RgML/P5G3i4RToL9Xnu+v22NQR9LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836386;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=HVLhfDPAtkuIIkET2H5DHISx8bl/sic6XsQLMtIUZKo=;
	b=E7Tk6nW/gUkDAjqln+dd1qsbxXG0tWRmNoc3gPjShll7aQ4NF5Ao3qujJINNLS5zSHNS
	 g4PvuEegjEkIh1PUCAnEBCjYGnX4be1QT87mj7HmgALqEgWePByCNmFIN0CyB6EnxRTP3
	 fUzfwKRl9ut852dK0LA61UoyKqjZ4oswodY28mcd09xeHJxgZRlIlN8wpYa+GSPOzYZ22
	 6in0i0E8dAhLna8o2KjEDhAanjH6xTzN+cty4A6MChU+N9MGdZF3QYCDcZH9/p8bgXj/0
	 BvHCvtWwLw8LGZGNzmfdUy6Ltimydr67X8m77NvPvPr/hg3xxBcsv+gzO9OSBc4NYvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FE6606A31C
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 13:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40FE6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jSpqD5XJZz1c0Qp
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 21:38:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 22EFB40561
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 21:39:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP4 (Coremail) with UTF8SMTPSA id gCh0CgD3L++YB_tq_dlZEg--.38663S4;
	Mon, 16 Nov 2026 21:39:38 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: ming.lei@redhat.com,
	bvanassche@acm.org
Subject: [PATCH v3] blk-flush: fix a possible deadlock in the nvme timeout path
Date: Mon, 16 Nov 2026 21:29:43 +0800
Message-Id: <20261116132943.419435-1-yebin@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3L++YB_tq_dlZEg--.38663S4
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4xuFyUCFWxAry3Ar18Xwb_yoWfuw4kpF
	W5XayYkr4rWr40qrs3Aw4UAw1aqw4IyF13JFWFyr13Arn8G39akFyfJFyFqF45Ar93Ar47
	WFs8K39rZFyqv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
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
("block: mark flush request as IDLE when it is really finished"). When the
last reference is held by the timeout work itself (PATH[1] and PATH[2]),
flush_end_io() returns early and leaves the request in MQ_RQ_COMPLETE, so
blk_mq_tagset_wait_completed_request() called from the same timeout path
never observes count == 0 and loops forever.

Mark the flush request MQ_RQ_IDLE as soon as its completion is processed,
before waiting for the remaining references. Reference counting still
prevents the request from being freed or reused until the last reference is
dropped, so its tag cannot be reallocated underneath a holder.

flush_end_io() is also invoked from blk_mq_put_rq_ref() when a tag iterator
drops its reference, including for flush requests that are still in flight.
That path must not change the request state, otherwise the timeout handler
would no longer see an in-flight flush request (blk_mq_req_expired()
requires MQ_RQ_IN_FLIGHT) and blk_mq_queue_inflight()/nvme_cancel_tagset()
would skip it. Use a separate helper for that path that only drops the
reference.

Fixes: 9f16a66733c9 ("block: mark flush request as IDLE when it is really finished")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
v2 -> v3:
  - Don't mark the flush request IDLE unconditionally in flush_end_io():
    that path is also entered from blk_mq_put_rq_ref() for a request that
    may still be in flight, which would hide it from the timeout, cancel
    and inflight paths and reintroduce the bug fixed by 9f16a66733c9.
  - Split out flush_end_io_put_ref(); only the completion path now marks
    the request IDLE, so blk_mq_tagset_wait_completed_request() no longer
    spins when an iterator holds the last reference.
  - Add blk_flush_put_rq_ref() for the iterator path, which only drops the
    reference and leaves the request state untouched.
  - Correct the commit message.
  - Fix grammar, drop leading spaces, trim the call trace and shorten the
    source comment. 

 block/blk-flush.c | 63 ++++++++++++++++++++++++++++++++++++-----------
 block/blk-mq.c    |  2 +-
 block/blk.h       |  1 +
 3 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 38bd4ae5d9e7..ba6f3119b389 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -198,19 +198,18 @@ static void blk_flush_complete_seq(struct request *rq,
 	blk_kick_flush(q, fq, cmd_flags);
 }
 
-static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
-				       blk_status_t error,
-				       const struct io_comp_batch *iob)
+/*
+ * Drop a reference to a flush request and, if it was the last one, run the
+ * final cleanup. The caller must hold fq->mq_flush_lock.
+ */
+static enum rq_end_io_ret flush_end_io_put_ref(struct request *flush_rq,
+					       blk_status_t error)
 {
 	struct request_queue *q = flush_rq->q;
 	struct list_head *running;
 	struct request *rq, *n;
-	unsigned long flags = 0;
 	struct blk_flush_queue *fq = blk_get_flush_queue(flush_rq->mq_ctx);
 
-	/* release the tag's ownership to the req cloned from */
-	spin_lock_irqsave(&fq->mq_flush_lock, flags);
-
 	if (!req_ref_put_and_test(flush_rq)) {
 		/*
 		 * Remember the status of the flush for whoever drops the last
@@ -219,17 +218,10 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
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
@@ -257,10 +249,51 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
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
+	 * iterator holds the last reference (e.g. the timeout handler that is
+	 * running nvme_timeout()), leaving it in MQ_RQ_COMPLETE would make
+	 * blk_mq_tagset_wait_completed_request() loop forever. Reference
+	 * counting still prevents the request from being reused.
+	 */
+	WRITE_ONCE(flush_rq->state, MQ_RQ_IDLE);
+
+	ret = flush_end_io_put_ref(flush_rq, error);
+	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
+	return ret;
+}
+
+/*
+ * Called when a tag iterator drops its reference to a flush request. It must
+ * not change the request state: the iterator may be looking at a request that
+ * is still in flight.
+ */
+enum rq_end_io_ret blk_flush_put_rq_ref(struct request *flush_rq)
+{
+	struct blk_flush_queue *fq = blk_get_flush_queue(flush_rq->mq_ctx);
+	unsigned long flags;
+	enum rq_end_io_ret ret;
+
+	spin_lock_irqsave(&fq->mq_flush_lock, flags);
+	ret = flush_end_io_put_ref(flush_rq, BLK_STS_OK);
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

