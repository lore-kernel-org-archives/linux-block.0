Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47308 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753488AbdAZTse (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 14:48:34 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <bart.vanassche@sandisk.com>, <hch@lst.de>, <osandov@fb.com>,
        <paolo.valente@linaro.org>, <hare@suse.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 3/5] blk-mq: release driver tag on a requeue event
Date: Thu, 26 Jan 2017 12:48:16 -0700
Message-ID: <1485460098-16608-4-git-send-email-axboe@fb.com>
In-Reply-To: <1485460098-16608-1-git-send-email-axboe@fb.com>
References: <1485460098-16608-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We don't want to hold on to this resource when we have a scheduler
attached.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8041ad330289..089b2eedca4f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -879,6 +879,21 @@ static bool blk_mq_get_driver_tag(struct request *rq,
 	return false;
 }
 
+static void blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
+				  struct request *rq)
+{
+	if (rq->tag == -1 || rq->internal_tag == -1)
+		return;
+
+	blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, rq->tag);
+	rq->tag = -1;
+
+	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
+		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
+		atomic_dec(&hctx->nr_active);
+	}
+}
+
 /*
  * If we fail getting a driver tag because all the driver tags are already
  * assigned and on the dispatch list, BUT the first entry does not have a
@@ -952,6 +967,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 			queued++;
 			break;
 		case BLK_MQ_RQ_QUEUE_BUSY:
+			blk_mq_put_driver_tag(hctx, rq);
 			list_add(&rq->queuelist, list);
 			__blk_mq_requeue_request(rq);
 			break;
-- 
2.7.4

