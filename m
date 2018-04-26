Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35288 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbeDZHWI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Apr 2018 03:22:08 -0400
Received: by mail-it0-f66.google.com with SMTP id 186-v6so22538020itu.0
        for <linux-block@vger.kernel.org>; Thu, 26 Apr 2018 00:22:08 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH 1/2] blk-mq: count allocated but not started requests in iostats inflight
Date: Thu, 26 Apr 2018 00:21:58 -0700
Message-Id: <17d1ebc9d396ecc15bace2ed79a55ec754165979.1524727168.git.osandov@fb.com>
In-Reply-To: <cover.1524727168.git.osandov@fb.com>
References: <cover.1524727168.git.osandov@fb.com>
In-Reply-To: <cover.1524727168.git.osandov@fb.com>
References: <cover.1524727168.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In the legacy block case, we increment the counter right after we
allocate the request, not when the driver handles it. In both the legacy
and blk-mq cases, part_inc_in_flight() is called from
blk_account_io_start() right after we've allocated the request. blk-mq
only considers requests started requests as inflight, but this is
inconsistent with the legacy definition and the intention in the code.
This removes the started condition and instead counts all allocated
requests.

Fixes: f299b7c7a9de ("blk-mq: provide internal in-flight variant")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c3621453ad87..5450cbc61f8d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -95,18 +95,15 @@ static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 {
 	struct mq_inflight *mi = priv;
 
-	if (blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT) {
-		/*
-		 * index[0] counts the specific partition that was asked
-		 * for. index[1] counts the ones that are active on the
-		 * whole device, so increment that if mi->part is indeed
-		 * a partition, and not a whole device.
-		 */
-		if (rq->part == mi->part)
-			mi->inflight[0]++;
-		if (mi->part->partno)
-			mi->inflight[1]++;
-	}
+	/*
+	 * index[0] counts the specific partition that was asked for. index[1]
+	 * counts the ones that are active on the whole device, so increment
+	 * that if mi->part is indeed a partition, and not a whole device.
+	 */
+	if (rq->part == mi->part)
+		mi->inflight[0]++;
+	if (mi->part->partno)
+		mi->inflight[1]++;
 }
 
 void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
-- 
2.17.0
