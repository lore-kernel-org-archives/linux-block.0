Return-Path: <ming.lei@redhat.com>
Date: Fri, 3 Nov 2017 23:18:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "loberman@redhat.com" <loberman@redhat.com>,
	"hch@infradead.org" <hch@infradead.org>,
	"roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Message-ID: <20171103151844.GB5059@ming.t460p>
References: <1509638224.2484.14.camel@wdc.com>
 <20171102233835.GA27370@ming.t460p>
 <1509666235.2484.23.camel@wdc.com>
 <20171102234801.GB27370@ming.t460p>
 <1509666897.2484.25.camel@wdc.com>
 <20171103001541.GF27370@ming.t460p>
 <1509670091.2636.0.camel@wdc.com>
 <CAFfF4qsbPCj3XLw0HkyJYELcqeqiPx_nR-G-1tSRew9z7ujw2Q@mail.gmail.com>
 <20171103021234.GH27370@ming.t460p>
 <1509676969.10883.0.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509676969.10883.0.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 03, 2017 at 02:42:50AM +0000, Bart Van Assche wrote:
> On Fri, 2017-11-03 at 10:12 +0800, Ming Lei wrote:
> > [root@ibclient srp-test]# ./run_tests
> > modprobe: FATAL: Module target_core_mod is in use.
> 
> LIO must be unloaded before srp-test software is started.

Hi Bart,

Even with help of Laurence, we still can't setup your srp-test
in our test environment today.

But we have run Laurence's usual 3 tests on IB/SRP with/without all
my following patches against V4.14-rc4, looks everything is fine, and
no I/O hang is observed.

        0001-blk-mq-sched-dispatch-from-scheduler-IFF-progress-is.patch
        0002-blk-mq-sched-move-actual-dispatching-into-one-helper.patch
        0003-sbitmap-introduce-__sbitmap_for_each_set.patch
        0004-block-kyber-check-if-there-are-requests-in-ctx-in-ky.patch
        0005-blk-mq-introduce-.get_budget-and-.put_budget-in-blk_.patch
        0006-blk-mq-sched-improve-dispatching-from-sw-queue.patch
        0007-scsi-allow-passing-in-null-rq-to-scsi_prep_state_che.patch
        0008-scsi-implement-.get_budget-and-.put_budget-for-blk-m.patch
        0009-blk-mq-don-t-handle-TAG_SHARED-in-restart.patch
        0010-blk-mq-don-t-restart-queue-when-.get_budget-returns-.patch

BTW, Laurence found there is kernel crash in his IB/SRP test when running
for-next branch of block tree, so we just test v4.14-rc4 w/wo my blk-mq patches.

And I looked at the SCSI's queue_rq code for a while, and only found
one issue which may cause IO hang, and the following patch may address
this issue, but not sure if it is same with your issue. Could you apply
this patch and see if your issue can be fixed?

BTW, it should be helpful to check the blk-mq debugfs related files
when your I/O hang happens, could you provide that info?

--

>From edcb243d9a6f3446bd9a9f95c00bed7616dd7368 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 3 Nov 2017 12:11:59 +0800
Subject: [PATCH] SCSI_MQ: fix IO hang in case of queue busy

We have to insert the rq back before checking .device_busy,
otherwise When IO completes just after the check and before
this req is added to hctx->dispatch, this queue may never get
chance to be run, then this IO may hang forever.

This patch introduces BLK_STS_RESOURCE_OK for handling this
issue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c            | 17 +++++++++++++++++
 drivers/scsi/scsi_lib.c   |  8 ++++++++
 include/linux/blk-mq.h    |  1 +
 include/linux/blk_types.h |  1 +
 4 files changed, 27 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e4d2490f4e7e..e1e03576edca 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -660,6 +660,16 @@ static void __blk_mq_requeue_request(struct request *rq)
 	}
 }
 
+void blk_mq_reinsert_request_hctx(struct blk_mq_hw_ctx *hctx, struct request *rq)
+{
+	__blk_mq_requeue_request(rq);
+
+	spin_lock(&hctx->lock);
+	list_add_tail(&rq->queuelist, &hctx->dispatch);
+	spin_unlock(&hctx->lock);
+}
+EXPORT_SYMBOL(blk_mq_reinsert_request_hctx);
+
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 {
 	__blk_mq_requeue_request(rq);
@@ -1165,6 +1175,12 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 			list_add(&rq->queuelist, list);
 			__blk_mq_requeue_request(rq);
 			break;
+		} else if (ret == BLK_STS_RESOURCE_OK) {
+			/*
+			 * BLK_STS_RESOURCE_OK means driver handled this
+			 * STS_RESOURCE already, we just need to stop dispatch.
+			 */
+			break;
 		}
 
  fail_rq:
@@ -1656,6 +1672,7 @@ static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	ret = q->mq_ops->queue_rq(hctx, &bd);
 	switch (ret) {
 	case BLK_STS_OK:
+	case BLK_STS_RESOURCE_OK:
 		*cookie = new_cookie;
 		return;
 	case BLK_STS_RESOURCE:
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 7f218ef61900..0165c1caed82 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2030,9 +2030,17 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case BLK_STS_OK:
 		break;
 	case BLK_STS_RESOURCE:
+		/*
+		 * We have to insert the rq back before checking .device_busy,
+		 * otherwise when IO completes just after the check and before
+		 * this req is added to hctx->dispatch, this queue may never get
+		 * chance to be run, then this IO may hang forever.
+		 */
+		blk_mq_reinsert_request_hctx(hctx, req);
 		if (atomic_read(&sdev->device_busy) == 0 &&
 		    !scsi_device_blocked(sdev))
 			blk_mq_delay_run_hw_queue(hctx, SCSI_QUEUE_DELAY);
+		ret = BLK_STS_RESOURCE_OK;
 		break;
 	default:
 		/*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e5e6becd57d3..4740f643d8c5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -244,6 +244,7 @@ void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
 
+void blk_mq_reinsert_request_hctx(struct blk_mq_hw_ctx *hctx, struct request *rq);
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 				bool kick_requeue_list);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3385c89f402e..b630cc026a93 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -32,6 +32,7 @@ typedef u8 __bitwise blk_status_t;
 #define BLK_STS_PROTECTION	((__force blk_status_t)8)
 #define BLK_STS_RESOURCE	((__force blk_status_t)9)
 #define BLK_STS_IOERR		((__force blk_status_t)10)
+#define BLK_STS_RESOURCE_OK	((__force blk_status_t)11)
 
 /* hack for device mapper, don't use elsewhere: */
 #define BLK_STS_DM_REQUEUE    ((__force blk_status_t)11)
-- 
2.9.5


-- 
Ming
