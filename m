Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2CA36C0D6
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919028; cv=none; b=Y5vIpThoOkqOA+xsc2q1K3BNe8f5NGSk2YeSBlmBFltEt4Uzyr2/SpmzPJAIhYiVwNwRfZKHouSZiPvjb+w4G3a2VwDoLlcR/kjcDUHF5yMzmVKS+hcbpOvD1QnpxmAo5+0+NBycgXbn7UYI/LiyzjMLH78wlsKweWpRAmf4GeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919028; c=relaxed/simple;
	bh=T0ZP64EorEPduqrDVPh40Gcjqo4lVu95jaLLfeFHwzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e0quiD6b59lswBJuzNhInruYRtP6VlIT8xL0dXa9Hb3olUkek8e0QNzxolREiGJABewpu3VvKa3fcPb6dq9eeIWGJbqtpW3SB3+T9j9Q1nxygwUQyNGcrTcF0kKIx0vBuyZ0jVosR0VEI8mOghwVyGRUlG3Y/6EDev3/MjKyeo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gYqtP3vTJzYQvJl
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 19:43:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9E06D4056F
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 19:43:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP1 (Coremail) with SMTP id cCh0CgA3OT7sqiZqxMw+BA--.50323S4;
	Mon, 08 Jun 2026 19:43:40 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	yebin@huaweicloud.com,
	yebin10@huawei.com
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH] blk-flush: fix possibe deadlock when process nvme_timeout()
Date: Mon,  8 Jun 2026 19:39:23 +0800
Message-Id: <20260608113923.3893518-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3OT7sqiZqxMw+BA--.50323S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1kJryUJw1rZFy5Ar4fKrg_yoWrZw1UpF
	4Yqa90kr1rWw18tr4xJw4DJr1vvws2yFs3Jrnayr13Zr4DG392kFyrtFyFqF13AF1vvrZ8
	WFs8K39rZFZFv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUr2-eDU
	UUU
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
         nvme_try_complete_req
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
           if (blk_mq_request_completed(req))
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
The preceding problem occurs because the timeout processing flow holds
the reference count of the request, and the flush request is always in
the MQ_RQ_COMPLETE state due to the special nature of the flush request.
As a result, a dead loop occurs in the nvme_dev_disable() process.
To solve the preceding problem, if only the timeout processing flow holds
the reference count when the flush request times out, the request status
must be changed to MQ_RQ_IDLE in advance. In this way, it is safe to call
blk_mq_tagset_wait_completed_request () during the timeout processing.

Fixes: e1569a16180a ("nvme: do not restart the request timeout if we're resetting the controller")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 block/blk-flush.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 403a46c86411..d12839b1fcb5 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -213,6 +213,18 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 
 	if (!req_ref_put_and_test(flush_rq)) {
 		fq->rq_status = error;
+
+		/*
+		 * The timeout processing flow holds the reference count
+		 * of flush_rq. If the last reference count is held by the
+		 * timeout processing flow, the status of flush_rq must be
+		 * changed to MQ_RQ_IDLE in advance. Otherwise, a deadlock
+		 * occurs when blk_mq_tagset_wait_completed_request() is
+		 * called in the timeout processing flow.
+		 */
+		if (req_ref_read(flush_rq) == 1 &&
+		    flush_rq->rq_flags & RQF_TIMED_OUT)
+			WRITE_ONCE(flush_rq->state, MQ_RQ_IDLE);
 		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 		return RQ_END_IO_NONE;
 	}
-- 
2.34.1

