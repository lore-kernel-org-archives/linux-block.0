Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474E0C76186
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 03:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282E7229F4
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 03:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbfGYDEJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 23:04:09 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:42972 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389521AbfGYDEJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 23:04:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TXkNf.i_1564023835;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TXkNf.i_1564023835)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Jul 2019 11:03:55 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/3] blk-throttle: add counter for completed io
Date:   Thu, 25 Jul 2019 11:03:54 +0800
Message-Id: <1564023835-99554-2-git-send-email-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564023835-99554-1-git-send-email-joseph.qi@linux.alibaba.com>
References: <1564023835-99554-1-git-send-email-joseph.qi@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now we have counters for wait_time and service_time, so add another
counter for completed ios, then the average latency can be measured.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 block/blk-throttle.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a5880f0..1db461c 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -181,6 +181,8 @@ struct throtl_grp {
 	struct blkg_rwstat service_time;
 	/* total time spent on block throttle */
 	struct blkg_rwstat wait_time;
+	/* total IOs completed */
+	struct blkg_rwstat completed;
 };
 
 /* We measure latency for request size from <= 4k to >= 1M */
@@ -493,7 +495,8 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 		return NULL;
 
 	if (blkg_rwstat_init(&tg->service_time, gfp) ||
-	    blkg_rwstat_init(&tg->wait_time, gfp))
+	    blkg_rwstat_init(&tg->wait_time, gfp) ||
+	    blkg_rwstat_init(&tg->completed, gfp))
 		goto err;
 
 	throtl_service_queue_init(&tg->service_queue);
@@ -524,6 +527,7 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 err:
 	blkg_rwstat_exit(&tg->service_time);
 	blkg_rwstat_exit(&tg->wait_time);
+	blkg_rwstat_exit(&tg->completed);
 	kfree(tg);
 	return NULL;
 }
@@ -624,6 +628,8 @@ static void throtl_pd_offline(struct blkg_policy_data *pd)
 				    &tg->service_time);
 		blkg_rwstat_add_aux(&blkg_to_tg(parent)->wait_time,
 				    &tg->wait_time);
+		blkg_rwstat_add_aux(&blkg_to_tg(parent)->completed,
+				    &tg->completed);
 	}
 }
 
@@ -634,6 +640,7 @@ static void throtl_pd_free(struct blkg_policy_data *pd)
 	del_timer_sync(&tg->service_queue.pending_timer);
 	blkg_rwstat_exit(&tg->service_time);
 	blkg_rwstat_exit(&tg->wait_time);
+	blkg_rwstat_exit(&tg->completed);
 	kfree(tg);
 }
 
@@ -643,6 +650,7 @@ static void throtl_pd_reset(struct blkg_policy_data *pd)
 
 	blkg_rwstat_reset(&tg->service_time);
 	blkg_rwstat_reset(&tg->wait_time);
+	blkg_rwstat_reset(&tg->completed);
 }
 
 static struct throtl_grp *
@@ -1065,6 +1073,7 @@ static void throtl_stats_update_completion(struct throtl_grp *tg,
 		blkg_rwstat_add(&tg->service_time, op, now - io_start_time);
 	if (time_after64(io_start_time, start_time))
 		blkg_rwstat_add(&tg->wait_time, op, io_start_time - start_time);
+	blkg_rwstat_add(&tg->completed, op, 1);
 	local_irq_restore(flags);
 }
 
@@ -1627,6 +1636,11 @@ static int tg_print_rwstat(struct seq_file *sf, void *v)
 		.private = offsetof(struct throtl_grp, wait_time),
 		.seq_show = tg_print_rwstat,
 	},
+	{
+		.name = "throttle.io_completed",
+		.private = offsetof(struct throtl_grp, completed),
+		.seq_show = tg_print_rwstat,
+	},
 	{ }	/* terminate */
 };
 
-- 
1.8.3.1

