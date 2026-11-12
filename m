Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491959;
	b=ZEVDVbtstvlliiVhvi2OQWsa5YI+/DrKQzwlAAODO1XIBOHWh0VzaA/Lvd+3vv098cDF
	 NuPRVZJ7HnpL31BTYBm1VNeGkb539LQMkbpgGULBeFW15mu9yxR4PFd35GMmeofrHwIMP
	 aBdpfv80dw8gngX7UOvNqG4Je8VrhlHSJG+L2TTau/9jjTE0Xio5SrgN7oQ06/jMgs9Vj
	 dgxwo0B8km7dNt2rzDbPgxjqcfT5douhxlgDRJbF0vN/ishWX1sCSHE6xBGOtggH2WJSU
	 sVJxgj53C8eadiaq5vQnZ6Rk30JcUSa8fGIGKD/KpdxBz+7OtHTyiXPjSgefd13dyrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491959;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=I4/ayADIAoyZkhm+jTYK9As+I4OJduMflusadYAyTO8=;
	b=VD7hoFxU7KE0uJ4ekoz5C6dCYiUqPZLO2cbenbkLpQHn9/f+iUChhb76pQswl/9uTQ5q
	 VanZcV3aHdRaSBcBwBmu17APV2OenbJIhoPfvIfwM5t543zBMPVvBgpcRv46G7HPOhLr1
	 D75x+Eo1U9si1UaJMOXZ60QbhTavJYfYcMeAvHvqasKf4O12KW9muUSEKB5LpXBcR9ev6
	 BKMbhLMPaRTsSFApK5gUp1clbKmJ8n4L2DGOLgooQzkh9MqtCrfYLLCOgGQfXzVqFOruj
	 qmTVaW3TCFt152uIBlNVqmFVrg77qfoKWw1cFhdi2P0uMx4/fdmTCKTCpWmPFD0uHBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CC860A383C
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 13:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6CC860A383C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jQMRq36Vtz1yQl
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 21:58:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 216E840573
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 21:59:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP4 (Coremail) with UTF8SMTPSA id gCh0CgCn4O8uxvVqRc9REA--.9397S4;
	Thu, 12 Nov 2026 21:59:12 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
Subject: [PATCH v2] blk-flush: fix possible deadlock when process nvme_timeout()
Date: Thu, 12 Nov 2026 21:50:19 +0800
Message-Id: <20261112135019.3290131-1-yebin@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn4O8uxvVqRc9REA--.9397S4
X-Coremail-Antispam: 1UD129KBjvJXoW3GF4DZw1rCF15Cr1xur17KFg_yoWxCFW8pF
	WYqayjkrn5Wr48trs7J3yDZr95Zw42yF13Jr9avry3Zrs8G39akrWrtryFqF1ayF95Xr4x
	WFZ0g397XFWqvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

 There's when process nvme_timeout():
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

 Above issue may happen as follows:
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

The root cause is that the flush-rq is moved to MQ_RQ_IDLE only when its
reference count drops to zero, which was introduced by commit 9f16a66733c9
("block: mark flush request as IDLE when it is really finished"). When
the last reference is held by a request iterator - here
blk_mq_timeout_work() iterating tags and running nvme_timeout()
- flush_end_io() returns early and leaves the request in MQ_RQ_COMPLETE,
so the very same timeout flow spins forever in
blk_mq_tagset_wait_completed_request().
In fact, the flush request cannot be set to the MQ_RQ_IDLE in the timeout
processing procedure in both the PATH[1] and PATH[2] cases.

Fix this by marking the flush request as IDLE as soon as flush_end_io()
is invoked, i.e. restore the behavior introduced by commit 65ff5cd04551
("blk-mq: mark flush request as IDLE in flush_end_io()"), which aligns
flush requests with normal requests: blk_mq_free_request() also sets
MQ_RQ_IDLE before the last reference is put.

Reverting to that version is safe now because:
 - The request can only be freed/reused after its reference count reaches
   zero, and whether the final cleanup has to be run is decided by the
   reference count below, not by the request state. blk_mq_put_rq_ref()
   chooses to call ->end_io() based on is_flush_rq() rather than the
   state, so the cleanup (io accounting, releasing the borrowed tags and
   advancing the flush state machine) still runs exactly once, on the last
   reference. Marking IDLE early therefore cannot double-account or leak
   the request.
 - The use-after-free that the above commit wanted to avoid predates
   the per-request reference counting model, under which a request that
   is still referenced can no longer be reallocated beneath its holder.

Fixes: 9f16a66733c9 ("block: mark flush request as IDLE when it is really finished")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 block/blk-flush.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 38bd4ae5d9e7..277c5a9a4bb7 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -211,6 +211,28 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 	/* release the tag's ownership to the req cloned from */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
 
+	/*
+	 * Mark the flush request as IDLE as soon as its .end_io() is invoked,
+	 * aligning it with how a normal request behaves: blk_mq_free_request()
+	 * sets MQ_RQ_IDLE before the last reference is put too.
+	 *
+	 * flush_end_io() is called from both the normal completion path and
+	 * from blk_mq_put_rq_ref() when a request iterator drops its reference.
+	 * If the last reference is held by such an iterator (e.g. the timeout
+	 * work that is currently running nvme_timeout()), the request would
+	 * otherwise stay in MQ_RQ_COMPLETE and make the
+	 * blk_mq_tagset_wait_completed_request() called from that same path
+	 * spin forever.
+	 *
+	 * This is safe because the request is only freed/reused once its
+	 * reference count reaches zero, and whether ->end_io() has to run the
+	 * final cleanup is decided by the reference count below, not by the
+	 * request state.  The cleanup (io accounting, releasing tags and
+	 * advancing the flush state machine) still runs exactly once, on the
+	 * last reference.
+	 */
+	WRITE_ONCE(flush_rq->state, MQ_RQ_IDLE);
+
 	if (!req_ref_put_and_test(flush_rq)) {
 		/*
 		 * Remember the status of the flush for whoever drops the last
@@ -224,12 +246,6 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
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
-- 
2.34.1

