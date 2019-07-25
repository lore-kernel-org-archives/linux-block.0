Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF89C76191
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 03:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245E722BE8
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 03:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbfGYDD7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 23:03:59 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:33938 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389521AbfGYDD7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 23:03:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TXkDTDf_1564023836;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TXkDTDf_1564023836)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Jul 2019 11:03:56 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/3] blk-throttle: add throttled io/bytes counter
Date:   Thu, 25 Jul 2019 11:03:55 +0800
Message-Id: <1564023835-99554-3-git-send-email-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564023835-99554-1-git-send-email-joseph.qi@linux.alibaba.com>
References: <1564023835-99554-1-git-send-email-joseph.qi@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add another 2 interfaces to stat io throttle information:
  blkio.throttle.total_io_queued
  blkio.throttle.total_bytes_queued

These interfaces are used for monitoring throttled io/bytes and
analyzing if delay has relations with io throttle.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 block/blk-throttle.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 1db461c..acc9feb 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -183,6 +183,10 @@ struct throtl_grp {
 	struct blkg_rwstat wait_time;
 	/* total IOs completed */
 	struct blkg_rwstat completed;
+	/* total bytes throttled */
+	struct blkg_rwstat total_bytes_queued;
+	/* total IOs throttled */
+	struct blkg_rwstat total_io_queued;
 };
 
 /* We measure latency for request size from <= 4k to >= 1M */
@@ -496,7 +500,9 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 
 	if (blkg_rwstat_init(&tg->service_time, gfp) ||
 	    blkg_rwstat_init(&tg->wait_time, gfp) ||
-	    blkg_rwstat_init(&tg->completed, gfp))
+	    blkg_rwstat_init(&tg->completed, gfp) ||
+	    blkg_rwstat_init(&tg->total_bytes_queued, gfp) ||
+	    blkg_rwstat_init(&tg->total_io_queued, gfp))
 		goto err;
 
 	throtl_service_queue_init(&tg->service_queue);
@@ -528,6 +534,8 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 	blkg_rwstat_exit(&tg->service_time);
 	blkg_rwstat_exit(&tg->wait_time);
 	blkg_rwstat_exit(&tg->completed);
+	blkg_rwstat_exit(&tg->total_bytes_queued);
+	blkg_rwstat_exit(&tg->total_io_queued);
 	kfree(tg);
 	return NULL;
 }
@@ -630,6 +638,10 @@ static void throtl_pd_offline(struct blkg_policy_data *pd)
 				    &tg->wait_time);
 		blkg_rwstat_add_aux(&blkg_to_tg(parent)->completed,
 				    &tg->completed);
+		blkg_rwstat_add_aux(&blkg_to_tg(parent)->total_bytes_queued,
+				    &tg->total_bytes_queued);
+		blkg_rwstat_add_aux(&blkg_to_tg(parent)->total_io_queued,
+				    &tg->total_io_queued);
 	}
 }
 
@@ -641,6 +653,8 @@ static void throtl_pd_free(struct blkg_policy_data *pd)
 	blkg_rwstat_exit(&tg->service_time);
 	blkg_rwstat_exit(&tg->wait_time);
 	blkg_rwstat_exit(&tg->completed);
+	blkg_rwstat_reset(&tg->total_bytes_queued);
+	blkg_rwstat_reset(&tg->total_io_queued);
 	kfree(tg);
 }
 
@@ -651,6 +665,8 @@ static void throtl_pd_reset(struct blkg_policy_data *pd)
 	blkg_rwstat_reset(&tg->service_time);
 	blkg_rwstat_reset(&tg->wait_time);
 	blkg_rwstat_reset(&tg->completed);
+	blkg_rwstat_reset(&tg->total_bytes_queued);
+	blkg_rwstat_reset(&tg->total_io_queued);
 }
 
 static struct throtl_grp *
@@ -1170,6 +1186,9 @@ static void throtl_add_bio_tg(struct bio *bio, struct throtl_qnode *qn,
 	throtl_qnode_add_bio(bio, qn, &sq->queued[rw]);
 
 	sq->nr_queued[rw]++;
+	blkg_rwstat_add(&tg->total_bytes_queued, bio_op(bio),
+			throtl_bio_data_size(bio));
+	blkg_rwstat_add(&tg->total_io_queued, bio_op(bio), 1);
 	throtl_enqueue_tg(tg);
 }
 
@@ -1641,6 +1660,16 @@ static int tg_print_rwstat(struct seq_file *sf, void *v)
 		.private = offsetof(struct throtl_grp, completed),
 		.seq_show = tg_print_rwstat,
 	},
+	{
+		.name = "throttle.total_bytes_queued",
+		.private = offsetof(struct throtl_grp, total_bytes_queued),
+		.seq_show = tg_print_rwstat,
+	},
+	{
+		.name = "throttle.total_io_queued",
+		.private = offsetof(struct throtl_grp, total_io_queued),
+		.seq_show = tg_print_rwstat,
+	},
 	{ }	/* terminate */
 };
 
-- 
1.8.3.1

