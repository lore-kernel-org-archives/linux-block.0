Return-Path: <Adam.Manzanares@wdc.com>
From: Adam Manzanares <adam.manzanares@hgst.com>
To: <axboe@kernel.dk>, <hare@suse.de>, <mchristi@redhat.com>,
	<dan.j.williams@intel.com>, <martin.petersen@oracle.com>,
	<toshi.kani@hpe.com>, <damien.lemoal@hgst.com>, <ming.lei@canonical.com>,
	<tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-ide@vger.kernel.org>, Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v7 1/4] block: Add iocontext priority to request
Date: Tue, 6 Dec 2016 09:18:02 -0800
Message-ID: <1481044685-2803-2-git-send-email-adam.manzanares@hgst.com>
In-Reply-To: <1481044685-2803-1-git-send-email-adam.manzanares@hgst.com>
References: <1481044685-2803-1-git-send-email-adam.manzanares@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Adam.Manzanares@wdc.com
List-ID: <linux-block@vger.kernel.org>

From: Adam Manzanares <adam.manzanares@wdc.com>

Patch adds an association between iocontext ioprio and the ioprio of a
request. This is done to enable request based drivers the ability to
act on priority information stored in the request. An example being
ATA devices that support command priorities. If the ATA driver discovers
that the device supports command priorities and the request has valid
priority information indicating the request is high priority, then a high
priority command can be sent to the device. This should improve tail
latencies for high priority IO on any device that queues requests
internally and can make use of the priority information stored in the
request.

The ioprio of the request is set in blk_rq_set_prio which takes the
request and the ioc as arguments. If the ioc is valid in blk_rq_set_prio
then the iopriority of the request is set as the iopriority of the ioc.
In init_request_from_bio a check is made to see if the ioprio of the bio
is valid and if so then the request prio comes from the bio.

Signed-off-by: Adam Manzananares <adam.manzanares@wdc.com>
---
 block/blk-core.c       |  4 +++-
 include/linux/blkdev.h | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6c4a425..4d1d1f9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1154,6 +1154,7 @@ static struct request *__get_request(struct request_list *rl, unsigned int op,
 
 	blk_rq_init(q, rq);
 	blk_rq_set_rl(rq, rl);
+	blk_rq_set_prio(rq, ioc);
 	rq->cmd_flags = op;
 	rq->rq_flags = rq_flags;
 
@@ -1658,7 +1659,8 @@ void init_request_from_bio(struct request *req, struct bio *bio)
 
 	req->errors = 0;
 	req->__sector = bio->bi_iter.bi_sector;
-	req->ioprio = bio_prio(bio);
+	if (ioprio_valid(bio_prio(bio)))
+		req->ioprio = bio_prio(bio);
 	blk_rq_bio_prep(req->q, req, bio);
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 541fdd8..8c2a1ef 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1050,6 +1050,20 @@ static inline unsigned int blk_rq_count_bios(struct request *rq)
 }
 
 /*
+ * blk_rq_set_prio - associate a request with prio from ioc
+ * @rq: request of interest
+ * @ioc: target iocontext
+ *
+ * Assocate request prio with ioc prio so request based drivers
+ * can leverage priority information.
+ */
+static inline void blk_rq_set_prio(struct request *rq, struct io_context *ioc)
+{
+	if (ioc)
+		rq->ioprio = ioc->ioprio;
+}
+
+/*
  * Request issue related functions.
  */
 extern struct request *blk_peek_request(struct request_queue *q);
-- 
2.7.4
