Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60805 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753437AbdAZTsd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 14:48:33 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <bart.vanassche@sandisk.com>, <hch@lst.de>, <osandov@fb.com>,
        <paolo.valente@linaro.org>, <hare@suse.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 2/5] blk-mq: fix potential race in queue restart and driver tag allocation
Date: Thu, 26 Jan 2017 12:48:15 -0700
Message-ID: <1485460098-16608-3-git-send-email-axboe@fb.com>
In-Reply-To: <1485460098-16608-1-git-send-email-axboe@fb.com>
References: <1485460098-16608-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Once we mark the queue as needing a restart, re-check if we can
get a driver tag. This fixes a theoretical issue where the needed
IO completes _after_ blk_mq_get_driver_tag() fails, but before we
manage to set the restart bit.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 223b9b080820..8041ad330289 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -928,7 +928,16 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 		if (!blk_mq_get_driver_tag(rq, &hctx, false)) {
 			if (!queued && reorder_tags_to_front(list))
 				continue;
+
+			/*
+			 * We failed getting a driver tag. Mark the queue(s)
+			 * as needing a restart. Retry getting a tag again,
+			 * in case the needed IO completed right before we
+			 * marked the queue as needing a restart.
+			 */
 			blk_mq_sched_mark_restart(hctx);
+			if (!blk_mq_get_driver_tag(rq, &hctx, false))
+				break;
 			break;
 		}
 		list_del_init(&rq->queuelist);
-- 
2.7.4

