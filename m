Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33244 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934189AbeEIJJC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 May 2018 05:09:02 -0400
Received: by mail-pf0-f195.google.com with SMTP id f20so16526082pfn.0
        for <linux-block@vger.kernel.org>; Wed, 09 May 2018 02:09:02 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH v3 1/7] block: move some wbt helpers to blk-wbt.c
Date: Wed,  9 May 2018 02:08:47 -0700
Message-Id: <c2045e45dd3a63579dd1710d1360279a0de1d41d.1525856631.git.osandov@fb.com>
In-Reply-To: <cover.1525856630.git.osandov@fb.com>
References: <cover.1525856630.git.osandov@fb.com>
In-Reply-To: <cover.1525856630.git.osandov@fb.com>
References: <cover.1525856630.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

A few helpers are only used from blk-wbt.c, so move them there, and put
wbt_track() behind the CONFIG_BLK_WBT typedef. This is in preparation
for changing how the wbt flags are tracked.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-wbt.c | 20 ++++++++++++++++++++
 block/blk-wbt.h | 33 ++++++++-------------------------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index a7a724580033..450cffa85dfb 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -29,6 +29,26 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/wbt.h>
 
+static inline void wbt_clear_state(struct blk_issue_stat *stat)
+{
+	stat->stat &= ~BLK_STAT_RES_MASK;
+}
+
+static inline enum wbt_flags wbt_stat_to_mask(struct blk_issue_stat *stat)
+{
+	return (stat->stat & BLK_STAT_RES_MASK) >> BLK_STAT_RES_SHIFT;
+}
+
+static inline bool wbt_is_tracked(struct blk_issue_stat *stat)
+{
+	return (stat->stat >> BLK_STAT_RES_SHIFT) & WBT_TRACKED;
+}
+
+static inline bool wbt_is_read(struct blk_issue_stat *stat)
+{
+	return (stat->stat >> BLK_STAT_RES_SHIFT) & WBT_READ;
+}
+
 enum {
 	/*
 	 * Default setting, we'll scale up (to 75% of QD max) or down (min 1)
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index d6a125e49db5..5bdae205e5df 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -35,31 +35,6 @@ enum {
 	WBT_STATE_ON_MANUAL	= 2,
 };
 
-static inline void wbt_clear_state(struct blk_issue_stat *stat)
-{
-	stat->stat &= ~BLK_STAT_RES_MASK;
-}
-
-static inline enum wbt_flags wbt_stat_to_mask(struct blk_issue_stat *stat)
-{
-	return (stat->stat & BLK_STAT_RES_MASK) >> BLK_STAT_RES_SHIFT;
-}
-
-static inline void wbt_track(struct blk_issue_stat *stat, enum wbt_flags wb_acct)
-{
-	stat->stat |= ((u64) wb_acct) << BLK_STAT_RES_SHIFT;
-}
-
-static inline bool wbt_is_tracked(struct blk_issue_stat *stat)
-{
-	return (stat->stat >> BLK_STAT_RES_SHIFT) & WBT_TRACKED;
-}
-
-static inline bool wbt_is_read(struct blk_issue_stat *stat)
-{
-	return (stat->stat >> BLK_STAT_RES_SHIFT) & WBT_READ;
-}
-
 struct rq_wait {
 	wait_queue_head_t wait;
 	atomic_t inflight;
@@ -113,6 +88,11 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 
 #ifdef CONFIG_BLK_WBT
 
+static inline void wbt_track(struct blk_issue_stat *stat, enum wbt_flags flags)
+{
+	stat->stat |= ((u64)flags) << BLK_STAT_RES_SHIFT;
+}
+
 void __wbt_done(struct rq_wb *, enum wbt_flags);
 void wbt_done(struct rq_wb *, struct blk_issue_stat *);
 enum wbt_flags wbt_wait(struct rq_wb *, struct bio *, spinlock_t *);
@@ -131,6 +111,9 @@ u64 wbt_default_latency_nsec(struct request_queue *);
 
 #else
 
+static inline void wbt_track(struct blk_issue_stat *stat, enum wbt_flags flags)
+{
+}
 static inline void __wbt_done(struct rq_wb *rwb, enum wbt_flags flags)
 {
 }
-- 
2.17.0
