Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:47674 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933076AbeFLNYW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jun 2018 09:24:22 -0400
Subject: Re: Regarding the recent new blk-mq timeout handling
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <88c22c6d-8482-8854-6e9b-88605eab3735@oracle.com>
 <CACVXFVN8r6LNxayK-Kp0H_aq=pjMxK0Q1a8Q4fj2BaQeh1-Yhw@mail.gmail.com>
 <cfafc2df-1003-67dd-4978-058dfca265bd@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <dd7f3013-c40d-8752-e56e-3e89065da848@oracle.com>
Date: Tue, 12 Jun 2018 21:23:53 +0800
MIME-Version: 1.0
In-Reply-To: <cfafc2df-1003-67dd-4978-058dfca265bd@oracle.com>
Content-Type: multipart/mixed;
 boundary="------------6D43595FAF4B8BF3E0FEB20A"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------6D43595FAF4B8BF3E0FEB20A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



On 06/12/2018 09:01 PM, jianchao.wang wrote:
> Hi ming
> 
> Thanks for your kindly response.
> 
> On 06/12/2018 06:17 PM, Ming Lei wrote:
>> On Tue, Jun 12, 2018 at 6:04 PM, jianchao.wang
>> <jianchao.w.wang@oracle.com> wrote:
>>> Hi Jens and Christoph
>>>
>>> In the recent commit of new blk-mq timeout handling, we don't have any protection
>>> on timed out request against the completion path. We just hold a request->ref count,
>>> it just could avoid the request tag to be released and life-recycle, but not completion.
>>>
>>> For the scsi mid-layer, what if a request is in error handler and normal completion come
>>> at the moment ?
>>
>> Per my understanding, now the protection needs to be done completely by driver.
>>
> 
> But looks like the drivers have not prepared well to take over this work right now.
> 

I modified the scsi-debug module as the attachment
0001-scsi-debug-make-normal-completion-and-timeout-could-.patch
and try to simulate the scenario where timeout and completion path occur concurrently.
The system would run into crash easily.
4.17.rc7 survived from this test.

Maybe we could do as the attachment 0001-blk-mq-protect-timed-out-request-against-completion-.patch
then replace all the blk_mq_complete_request in timeout path. Then we could preserve the capability
to protect the timed out request against completion path.
The patch also survived from the test.

Thanks
Jianchao
>>
>> Thanks,
>> Ming Lei
>>
> 

--------------6D43595FAF4B8BF3E0FEB20A
Content-Type: text/x-patch;
 name="0001-scsi-debug-make-normal-completion-and-timeout-could-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-scsi-debug-make-normal-completion-and-timeout-could-.pa";
 filename*1="tch"

>From 640a67e7b4386ac42ee789f54dd0898ecd00f8f7 Mon Sep 17 00:00:00 2001
From: Jianchao Wang <jianchao.w.wang@oracle.com>
Date: Tue, 12 Jun 2018 12:04:26 +0800
Subject: [PATCH] scsi-debug: make normal completion and timeout could occur
 concurrently

Invoke blk_abort_request to force the request timed out periodically,
when complete the request in workqueue context.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/scsi/scsi_debug.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 656c98e..2ca0280 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -4323,6 +4323,8 @@ static void setup_inject(struct sdebug_queue *sqp,
 	sqcp->inj_host_busy = !!(SDEBUG_OPT_HOST_BUSY & sdebug_opts);
 }
 
+static atomic_t g_abort_counter;
+
 /* Complete the processing of the thread that queued a SCSI command to this
  * driver. It either completes the command by calling cmnd_done() or
  * schedules a hr timer or work queue then returns 0. Returns
@@ -4459,6 +4461,11 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 			sd_dp->issuing_cpu = raw_smp_processor_id();
 		sd_dp->defer_t = SDEB_DEFER_WQ;
 		schedule_work(&sd_dp->ew.work);
+		atomic_inc(&g_abort_counter);
+		if (atomic_read(&g_abort_counter)%2000 == 0) {
+			blk_abort_request(cmnd->request);
+			trace_printk("abort request tag %d\n", cmnd->request->tag);
+		}
 	}
 	if (unlikely((SDEBUG_OPT_Q_NOISE & sdebug_opts) &&
 		     (scsi_result == device_qfull_result)))
@@ -5843,6 +5850,7 @@ static int sdebug_driver_probe(struct device *dev)
 	struct Scsi_Host *hpnt;
 	int hprot;
 
+	atomic_set(&g_abort_counter, 0);
 	sdbg_host = to_sdebug_host(dev);
 
 	sdebug_driver_template.can_queue = sdebug_max_queue;
-- 
2.7.4


--------------6D43595FAF4B8BF3E0FEB20A
Content-Type: text/x-patch;
 name="0001-blk-mq-protect-timed-out-request-against-completion-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-blk-mq-protect-timed-out-request-against-completion-.pa";
 filename*1="tch"

>From fcc515b3a642c909e8b82d2a240014faff5acd44 Mon Sep 17 00:00:00 2001
From: Jianchao Wang <jianchao.w.wang@oracle.com>
Date: Tue, 12 Jun 2018 21:20:13 +0800
Subject: [PATCH] blk-mq: protect timed out request against completion path

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c         | 22 +++++++++++++++-------
 include/linux/blk-mq.h |  1 +
 include/linux/blkdev.h |  6 ++++++
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6332940..2714a23 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -473,6 +473,7 @@ static void __blk_mq_free_request(struct request *rq)
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 	const int sched_tag = rq->internal_tag;
 
+	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 	if (rq->tag != -1)
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
@@ -509,7 +510,6 @@ void blk_mq_free_request(struct request *rq)
 	if (blk_rq_rl(rq))
 		blk_put_rl(blk_rq_rl(rq));
 
-	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 	if (refcount_dec_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
 }
@@ -552,15 +552,17 @@ static void __blk_mq_complete_request_remote(void *data)
 	rq->q->softirq_done_fn(rq);
 }
 
-static void __blk_mq_complete_request(struct request *rq)
+/*
+ * The LLDD timeout path must invoke this interface to complete
+ * the request.
+ */
+void __blk_mq_complete_request(struct request *rq)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	bool shared = false;
 	int cpu;
 
-	if (cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) !=
-			MQ_RQ_IN_FLIGHT)
-		return;
+	WARN_ON(blk_mq_rq_state(rq) != MQ_RQ_COMPLETE);
 
 	if (rq->internal_tag != -1)
 		blk_mq_sched_completed_request(rq);
@@ -584,6 +586,7 @@ static void __blk_mq_complete_request(struct request *rq)
 	}
 	put_cpu();
 }
+EXPORT_SYMBOL(__blk_mq_complete_request);
 
 static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
 	__releases(hctx->srcu)
@@ -617,7 +620,9 @@ void blk_mq_complete_request(struct request *rq)
 {
 	if (unlikely(blk_should_fake_timeout(rq->q)))
 		return;
-	__blk_mq_complete_request(rq);
+
+	if (blk_mq_mark_rq_complete(rq))
+		__blk_mq_complete_request(rq);
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
@@ -779,6 +784,7 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		WARN_ON_ONCE(ret != BLK_EH_RESET_TIMER);
 	}
 
+	WRITE_ONCE(req->state, MQ_RQ_IDLE);
 	blk_add_timer(req);
 }
 
@@ -830,8 +836,10 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	 * expired; if it is not expired, then the request was completed and
 	 * reallocated as a new request.
 	 */
-	if (blk_mq_req_expired(rq, next))
+	if (blk_mq_req_expired(rq, next) &&
+		blk_mq_mark_rq_complete(rq)) {
 		blk_mq_rq_timed_out(rq, reserved);
+	}
 	if (refcount_dec_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index fb35517..10a496b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -259,6 +259,7 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_complete_request(struct request *rq);
+void __blk_mq_complete_request(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio);
 bool blk_mq_queue_stopped(struct request_queue *q);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bca3a92..4c8b29a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -270,6 +270,12 @@ struct request {
 #endif
 };
 
+static inline bool blk_mq_mark_rq_complete(struct request *rq)
+{
+	return (cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
+			MQ_RQ_IN_FLIGHT);
+}
+
 static inline bool blk_op_is_scsi(unsigned int op)
 {
 	return op == REQ_OP_SCSI_IN || op == REQ_OP_SCSI_OUT;
-- 
2.7.4


--------------6D43595FAF4B8BF3E0FEB20A--
