Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDAAC433F5
	for <linux-block@archiver.kernel.org>; Tue, 10 May 2022 03:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiEJDwO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 May 2022 23:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiEJDwG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 May 2022 23:52:06 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C200E4F9EB
        for <linux-block@vger.kernel.org>; Mon,  9 May 2022 20:48:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 202so13611087pgc.9
        for <linux-block@vger.kernel.org>; Mon, 09 May 2022 20:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WwAC7yJmQyf0urXxiRrxQbFHiuNL5jbhDc4jex67OW4=;
        b=bZHSJ7bpkl4sSuvW6mgl1I7nbbBfYx8MmE4fDYj0YNLtudrKynpdKr6QEbVDD9Aku7
         +lzGDsawCKQaHAvrWPKcZLCxQaCN0NzNz4g36sHzK2XrxG9ifgnZMEoGEifX9f6kOek9
         +CAie9y1101MRdqr+KufppR9BmcT9c342MFfWejKFKACEfsMD9CvkpxUqYBRs/LLmXve
         PfeqjwhMCkN0N8TOYDq1K5BbqFgvL9pa5lxblkiEvSuYtMc26a3IVoqe9wUnjwQGHX5m
         9wGi3o4znFUdECTJ3L3Zpof0j1AyTUIjES45k7/AUqouZjKaJqIYGXtLlSQ7VP4DssyV
         fU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WwAC7yJmQyf0urXxiRrxQbFHiuNL5jbhDc4jex67OW4=;
        b=eg6iFrC5Ylc+hXGqoNtlIes79CivgnOcs7f0x/9Q7sVCcyPDNDh8nCt605whcWlsiV
         5407wOwR7eKpQd8zwTzRV3UmstWfaMpnoNAeuOdL+GBiydp0/mdBEdi+Q824KXJ0Glsw
         vhMmEHi5nf02X2WNKdBqshyp4egqrRYd5bfOaW8gp1XIpyIhiPbGtavqBtkj6sIS15dw
         TA4ij3t716PHI6pjMa74U8fcTl7T5GL6ic4o2R2mIIyZfGRSY81PXhEmW/ZFUgw2s+8c
         kkOZBIPuBkYt4B6du1ld8vQoOyCQrjPo59gtF4+h/5qJL79NmgbiS+JEONr+jtVuJvQe
         UVng==
X-Gm-Message-State: AOAM532TmTs4L7FJd/s8w1rpvv8ScTbe9PCV6khJcLO6sSO/tgho/U4N
        DMrIeloEmyDx47mfexCQQoygDg==
X-Google-Smtp-Source: ABdhPJze/shPQuA0kzNOEmJipModZI0YI/vymQS2NKqCkqkUdo6hfyc+q4MB5shOw9M55p8HIrYGTw==
X-Received: by 2002:a63:1d50:0:b0:3c2:9152:5966 with SMTP id d16-20020a631d50000000b003c291525966mr15181661pgm.525.1652154485226;
        Mon, 09 May 2022 20:48:05 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id y16-20020a63b510000000b003c6ab6ba06csm3731640pge.79.2022.05.09.20.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 20:48:04 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] blk-iocost: combine local_stat and desc_stat to stat
Date:   Tue, 10 May 2022 11:47:57 +0800
Message-Id: <20220510034757.21761-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we flush usage, wait, indebt stat in iocg_flush_stat(), we use
local_stat and desc_stat, which has no point since the leaf iocg
only has local_stat and the inner iocg only has desc_stat. Also
we don't need to flush percpu abs_vusage for these inner iocgs.

This patch combine local_stat and desc_stat to stat, only flush
percpu abs_vusage for active leaf iocgs, then build inner walk
list to propagate.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 71 +++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 39 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 9bd670999d0a..9c1982d42d65 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -533,8 +533,7 @@ struct ioc_gq {
 
 	/* statistics */
 	struct iocg_pcpu_stat __percpu	*pcpu_stat;
-	struct iocg_stat		local_stat;
-	struct iocg_stat		desc_stat;
+	struct iocg_stat		stat;
 	struct iocg_stat		last_stat;
 	u64				last_stat_abs_vusage;
 	u64				usage_delta_us;
@@ -1371,7 +1370,7 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 		return true;
 	} else {
 		if (iocg->indelay_since) {
-			iocg->local_stat.indelay_us += now->now - iocg->indelay_since;
+			iocg->stat.indelay_us += now->now - iocg->indelay_since;
 			iocg->indelay_since = 0;
 		}
 		iocg->delay = 0;
@@ -1419,7 +1418,7 @@ static void iocg_pay_debt(struct ioc_gq *iocg, u64 abs_vpay,
 
 	/* if debt is paid in full, restore inuse */
 	if (!iocg->abs_vdebt) {
-		iocg->local_stat.indebt_us += now->now - iocg->indebt_since;
+		iocg->stat.indebt_us += now->now - iocg->indebt_since;
 		iocg->indebt_since = 0;
 
 		propagate_weights(iocg, iocg->active, iocg->last_inuse,
@@ -1513,7 +1512,7 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, bool pay_debt,
 
 	if (!waitqueue_active(&iocg->waitq)) {
 		if (iocg->wait_since) {
-			iocg->local_stat.wait_us += now->now - iocg->wait_since;
+			iocg->stat.wait_us += now->now - iocg->wait_since;
 			iocg->wait_since = 0;
 		}
 		return;
@@ -1641,11 +1640,30 @@ static void iocg_build_inner_walk(struct ioc_gq *iocg,
 	}
 }
 
+/* propagate the deltas to the parent */
+static void iocg_flush_stat_upward(struct ioc_gq *iocg)
+{
+	if (iocg->level > 0) {
+		struct iocg_stat *parent_stat =
+			&iocg->ancestors[iocg->level - 1]->stat;
+
+		parent_stat->usage_us +=
+			iocg->stat.usage_us - iocg->last_stat.usage_us;
+		parent_stat->wait_us +=
+			iocg->stat.wait_us - iocg->last_stat.wait_us;
+		parent_stat->indebt_us +=
+			iocg->stat.indebt_us - iocg->last_stat.indebt_us;
+		parent_stat->indelay_us +=
+			iocg->stat.indelay_us - iocg->last_stat.indelay_us;
+	}
+
+	iocg->last_stat = iocg->stat;
+}
+
 /* collect per-cpu counters and propagate the deltas to the parent */
-static void iocg_flush_stat_one(struct ioc_gq *iocg, struct ioc_now *now)
+static void iocg_flush_stat_leaf(struct ioc_gq *iocg, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
-	struct iocg_stat new_stat;
 	u64 abs_vusage = 0;
 	u64 vusage_delta;
 	int cpu;
@@ -1661,34 +1679,9 @@ static void iocg_flush_stat_one(struct ioc_gq *iocg, struct ioc_now *now)
 	iocg->last_stat_abs_vusage = abs_vusage;
 
 	iocg->usage_delta_us = div64_u64(vusage_delta, ioc->vtime_base_rate);
-	iocg->local_stat.usage_us += iocg->usage_delta_us;
-
-	/* propagate upwards */
-	new_stat.usage_us =
-		iocg->local_stat.usage_us + iocg->desc_stat.usage_us;
-	new_stat.wait_us =
-		iocg->local_stat.wait_us + iocg->desc_stat.wait_us;
-	new_stat.indebt_us =
-		iocg->local_stat.indebt_us + iocg->desc_stat.indebt_us;
-	new_stat.indelay_us =
-		iocg->local_stat.indelay_us + iocg->desc_stat.indelay_us;
-
-	/* propagate the deltas to the parent */
-	if (iocg->level > 0) {
-		struct iocg_stat *parent_stat =
-			&iocg->ancestors[iocg->level - 1]->desc_stat;
-
-		parent_stat->usage_us +=
-			new_stat.usage_us - iocg->last_stat.usage_us;
-		parent_stat->wait_us +=
-			new_stat.wait_us - iocg->last_stat.wait_us;
-		parent_stat->indebt_us +=
-			new_stat.indebt_us - iocg->last_stat.indebt_us;
-		parent_stat->indelay_us +=
-			new_stat.indelay_us - iocg->last_stat.indelay_us;
-	}
+	iocg->stat.usage_us += iocg->usage_delta_us;
 
-	iocg->last_stat = new_stat;
+	iocg_flush_stat_upward(iocg);
 }
 
 /* get stat counters ready for reading on all active iocgs */
@@ -1699,13 +1692,13 @@ static void iocg_flush_stat(struct list_head *target_iocgs, struct ioc_now *now)
 
 	/* flush leaves and build inner node walk list */
 	list_for_each_entry(iocg, target_iocgs, active_list) {
-		iocg_flush_stat_one(iocg, now);
+		iocg_flush_stat_leaf(iocg, now);
 		iocg_build_inner_walk(iocg, &inner_walk);
 	}
 
 	/* keep flushing upwards by walking the inner list backwards */
 	list_for_each_entry_safe_reverse(iocg, tiocg, &inner_walk, walk_list) {
-		iocg_flush_stat_one(iocg, now);
+		iocg_flush_stat_upward(iocg);
 		list_del_init(&iocg->walk_list);
 	}
 }
@@ -2152,16 +2145,16 @@ static int ioc_check_iocgs(struct ioc *ioc, struct ioc_now *now)
 
 		/* flush wait and indebt stat deltas */
 		if (iocg->wait_since) {
-			iocg->local_stat.wait_us += now->now - iocg->wait_since;
+			iocg->stat.wait_us += now->now - iocg->wait_since;
 			iocg->wait_since = now->now;
 		}
 		if (iocg->indebt_since) {
-			iocg->local_stat.indebt_us +=
+			iocg->stat.indebt_us +=
 				now->now - iocg->indebt_since;
 			iocg->indebt_since = now->now;
 		}
 		if (iocg->indelay_since) {
-			iocg->local_stat.indelay_us +=
+			iocg->stat.indelay_us +=
 				now->now - iocg->indelay_since;
 			iocg->indelay_since = now->now;
 		}
-- 
2.36.0

