Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7228C64E7C
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C7A20DD4
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgKZIQ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:16:27 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:53509 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388697AbgKZIQ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:16:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UGaDvNQ_1606378582;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UGaDvNQ_1606378582)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Nov 2020 16:16:22 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] blk-iocost: Factor out the active iocgs' state check into a separate function
Date:   Thu, 26 Nov 2020 16:16:14 +0800
Message-Id: <6d2097e2aeb24281359e91b18c89ac8be7ca3ab3.1606378475.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
References: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
References: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Factor out the iocgs' state check into a separate function to
simplify the ioc_timer_fn().

No functional change.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-iocost.c | 94 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 40 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a926179..93abfe0 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2069,40 +2069,21 @@ static void ioc_forgive_debts(struct ioc *ioc, u64 usage_us_sum, int nr_debtors,
 	}
 }
 
-static void ioc_timer_fn(struct timer_list *timer)
+/*
+ * Check the active iocgs' state to avoid oversleeping and deactive
+ * idle iocgs.
+ *
+ * Since waiters determine the sleep durations based on the vrate
+ * they saw at the time of sleep, if vrate has increased, some
+ * waiters could be sleeping for too long. Wake up tardy waiters
+ * which should have woken up in the last period and expire idle
+ * iocgs.
+ */
+static int ioc_check_iocgs(struct ioc *ioc, struct ioc_now *now)
 {
-	struct ioc *ioc = container_of(timer, struct ioc, timer);
+	int nr_debtors = 0;
 	struct ioc_gq *iocg, *tiocg;
-	struct ioc_now now;
-	LIST_HEAD(surpluses);
-	int nr_debtors = 0, nr_shortages = 0, nr_lagging = 0;
-	u64 usage_us_sum = 0;
-	u32 ppm_rthr = MILLION - ioc->params.qos[QOS_RPPM];
-	u32 ppm_wthr = MILLION - ioc->params.qos[QOS_WPPM];
-	u32 missed_ppm[2], rq_wait_pct;
-	u64 period_vtime;
-	int prev_busy_level;
-
-	/* how were the latencies during the period? */
-	ioc_lat_stat(ioc, missed_ppm, &rq_wait_pct);
 
-	/* take care of active iocgs */
-	spin_lock_irq(&ioc->lock);
-
-	ioc_now(ioc, &now);
-
-	period_vtime = now.vnow - ioc->period_at_vtime;
-	if (WARN_ON_ONCE(!period_vtime)) {
-		spin_unlock_irq(&ioc->lock);
-		return;
-	}
-
-	/*
-	 * Waiters determine the sleep durations based on the vrate they
-	 * saw at the time of sleep.  If vrate has increased, some waiters
-	 * could be sleeping for too long.  Wake up tardy waiters which
-	 * should have woken up in the last period and expire idle iocgs.
-	 */
 	list_for_each_entry_safe(iocg, tiocg, &ioc->active_iocgs, active_list) {
 		if (!waitqueue_active(&iocg->waitq) && !iocg->abs_vdebt &&
 		    !iocg->delay && !iocg_is_idle(iocg))
@@ -2112,24 +2093,24 @@ static void ioc_timer_fn(struct timer_list *timer)
 
 		/* flush wait and indebt stat deltas */
 		if (iocg->wait_since) {
-			iocg->local_stat.wait_us += now.now - iocg->wait_since;
-			iocg->wait_since = now.now;
+			iocg->local_stat.wait_us += now->now - iocg->wait_since;
+			iocg->wait_since = now->now;
 		}
 		if (iocg->indebt_since) {
 			iocg->local_stat.indebt_us +=
-				now.now - iocg->indebt_since;
-			iocg->indebt_since = now.now;
+				now->now - iocg->indebt_since;
+			iocg->indebt_since = now->now;
 		}
 		if (iocg->indelay_since) {
 			iocg->local_stat.indelay_us +=
-				now.now - iocg->indelay_since;
-			iocg->indelay_since = now.now;
+				now->now - iocg->indelay_since;
+			iocg->indelay_since = now->now;
 		}
 
 		if (waitqueue_active(&iocg->waitq) || iocg->abs_vdebt ||
 		    iocg->delay) {
 			/* might be oversleeping vtime / hweight changes, kick */
-			iocg_kick_waitq(iocg, true, &now);
+			iocg_kick_waitq(iocg, true, now);
 			if (iocg->abs_vdebt || iocg->delay)
 				nr_debtors++;
 		} else if (iocg_is_idle(iocg)) {
@@ -2143,7 +2124,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 			 * error and throw away. On reactivation, it'll start
 			 * with the target budget.
 			 */
-			excess = now.vnow - vtime - ioc->margins.target;
+			excess = now->vnow - vtime - ioc->margins.target;
 			if (excess > 0) {
 				u32 old_hwi;
 
@@ -2152,13 +2133,46 @@ static void ioc_timer_fn(struct timer_list *timer)
 							    WEIGHT_ONE);
 			}
 
-			__propagate_weights(iocg, 0, 0, false, &now);
+			__propagate_weights(iocg, 0, 0, false, now);
 			list_del_init(&iocg->active_list);
 		}
 
 		spin_unlock(&iocg->waitq.lock);
 	}
+
 	commit_weights(ioc);
+	return nr_debtors;
+}
+
+static void ioc_timer_fn(struct timer_list *timer)
+{
+	struct ioc *ioc = container_of(timer, struct ioc, timer);
+	struct ioc_gq *iocg, *tiocg;
+	struct ioc_now now;
+	LIST_HEAD(surpluses);
+	int nr_debtors, nr_shortages = 0, nr_lagging = 0;
+	u64 usage_us_sum = 0;
+	u32 ppm_rthr = MILLION - ioc->params.qos[QOS_RPPM];
+	u32 ppm_wthr = MILLION - ioc->params.qos[QOS_WPPM];
+	u32 missed_ppm[2], rq_wait_pct;
+	u64 period_vtime;
+	int prev_busy_level;
+
+	/* how were the latencies during the period? */
+	ioc_lat_stat(ioc, missed_ppm, &rq_wait_pct);
+
+	/* take care of active iocgs */
+	spin_lock_irq(&ioc->lock);
+
+	ioc_now(ioc, &now);
+
+	period_vtime = now.vnow - ioc->period_at_vtime;
+	if (WARN_ON_ONCE(!period_vtime)) {
+		spin_unlock_irq(&ioc->lock);
+		return;
+	}
+
+	nr_debtors = ioc_check_iocgs(ioc, &now);
 
 	/*
 	 * Wait and indebt stat are flushed above and the donation calculation
-- 
1.8.3.1

