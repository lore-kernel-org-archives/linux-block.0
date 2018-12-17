Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2D5C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 06:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2092084A
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 06:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z9XOgM0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeLQGOZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:14:25 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62977 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbeLQGOY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 01:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1545027265; x=1576563265;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FJi7EP653pH07LTUVJhk6YytwlWhlwobRmeeZxuT3pM=;
  b=Z9XOgM0Y+BXclPoMwXoc/4JE88BcBDR7TDTJrGNh+6HafErW+lY4xLpU
   RgOYaW1Vrfk9kPX/TwQvto1Gu9jbrVfZsAQrxLyGCN/X8A/FR0Do9BZvg
   Rb/MqDs3xWylH8Nwe0VnJxWAvInQMkBQ2ND3XAopbXPL8xM/dHLQMXM5K
   F+Ptw1XptZReefKr+1NTXxmBbROrlGd6Uhq7Qplz/uw3d2yA+LNm6/nxf
   mOWBZuHhF97qAK0Eji82rJZp0QYNP4Ba8WbAV64SBd465SBW2jRXBcQd7
   Msv0fLPIGf8t7sf2iQPTY9u99O1767dxS+xWhhknBuW+rRetD1UnzebN8
   A==;
X-IronPort-AV: E=Sophos;i="5.56,364,1539619200"; 
   d="scan'208";a="98492252"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2018 14:14:08 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 16 Dec 2018 21:55:27 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Dec 2018 22:14:06 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: mq-deadline: Fix write completion handling
Date:   Mon, 17 Dec 2018 15:14:05 +0900
Message-Id: <20181217061405.11681-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For a zoned block device using mq-deadline, if a write request for a
zone is received while another write was already dispatched for the same
zone, dd_dispatch_request() will return NULL and the newly inserted
write request is kept in the scheduler queue waiting for the ongoing
zone write to complete. With this behavior, when no other request has
been dispatched, rq_list in blk_mq_sched_dispatch_requests() is empty
and blk_mq_sched_mark_restart_hctx() not called. This in turn leads to
__blk_mq_free_request() call of blk_mq_sched_restart() to not run the
queue when the already dispatched write request completes. The newly
dispatched request stays stuck in the scheduler queue until eventually
another request is submitted.

This problem does not affect SCSI disk as the SCSI stack handles queue
restart on request completion. However, this problem is can be triggered
the nullblk driver with zoned mode enabled.

Fix this by always requesting a queue restart in dd_dispatch_request()
if no request was dispatched while WRITE requests are queued.

Fixes: 5700f69178e9 ("mq-deadline: Introduce zone locking support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-mq-sched.c |  2 +-
 block/blk-mq-sched.h |  1 +
 block/mq-deadline.c  | 12 +++++++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 29bfe8017a2d..c77640900221 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -54,7 +54,7 @@ void blk_mq_sched_assign_ioc(struct request *rq, struct bio *bio)
  * Mark a hardware queue as needing a restart. For shared queues, maintain
  * a count of how many hardware queues are marked for restart.
  */
-static void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
+void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
 {
 	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
 		return;
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 8a9544203173..38e06e23821f 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -15,6 +15,7 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 				struct request **merged_request);
 bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio);
 bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq);
+void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx);
 void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_sched_insert_request(struct request *rq, bool at_head,
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 099a9e05854c..d5e21ce44d2c 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -373,9 +373,16 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
 
 /*
  * One confusing aspect here is that we get called for a specific
- * hardware queue, but we return a request that may not be for a
+ * hardware queue, but we may return a request that is for a
  * different hardware queue. This is because mq-deadline has shared
  * state for all hardware queues, in terms of sorting, FIFOs, etc.
+ *
+ * For a zoned block device, __dd_dispatch_request() may return NULL
+ * if all the queued write requests are directed at zones that are already
+ * locked due to on-going write requests. In this case, make sure to mark
+ * the queue as needing a restart to ensure that the queue is run again
+ * and the pending writes dispatched once the target zones for the ongoing
+ * write requests are unlocked in dd_finish_request().
  */
 static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 {
@@ -384,6 +391,9 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 
 	spin_lock(&dd->lock);
 	rq = __dd_dispatch_request(dd);
+	if (!rq && blk_queue_is_zoned(hctx->queue) &&
+	    !list_empty(&dd->fifo_list[WRITE]))
+		blk_mq_sched_mark_restart_hctx(hctx);
 	spin_unlock(&dd->lock);
 
 	return rq;
-- 
2.19.2

