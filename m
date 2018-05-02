Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41209 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbeEBRel (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 May 2018 13:34:41 -0400
Received: by mail-pg0-f68.google.com with SMTP id m21-v6so11132319pgv.8
        for <linux-block@vger.kernel.org>; Wed, 02 May 2018 10:34:41 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH 1/7] block: move some wbt helpers to blk-wbt.c
Date: Wed,  2 May 2018 10:34:20 -0700
Message-Id: <13f91069b511243a6245f091e9f0b8ce566daa0d.1525282392.git.osandov@fb.com>
In-Reply-To: <cover.1525282392.git.osandov@fb.com>
References: <cover.1525282392.git.osandov@fb.com>
In-Reply-To: <cover.1525282392.git.osandov@fb.com>
References: <cover.1525282392.git.osandov@fb.com>
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
index f92fc84b5e2c..030d6bdcaa4c 100644
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
index a232c98fbf4d..d3f47a721aec 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -31,31 +31,6 @@ enum {
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
@@ -109,6 +84,11 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 
 #ifdef CONFIG_BLK_WBT
 
+static inline void wbt_track(struct blk_issue_stat *stat, enum wbt_flags flags)
+{
+	stat->stat |= ((u64)flags) << BLK_STAT_RES_SHIFT;
+}
+
 void __wbt_done(struct rq_wb *, enum wbt_flags);
 void wbt_done(struct rq_wb *, struct blk_issue_stat *);
 enum wbt_flags wbt_wait(struct rq_wb *, struct bio *, spinlock_t *);
@@ -127,6 +107,9 @@ u64 wbt_default_latency_nsec(struct request_queue *);
 
 #else
 
+static inline void wbt_track(struct blk_issue_stat *stat, enum wbt_flags flags)
+{
+}
 static inline void __wbt_done(struct rq_wb *rwb, enum wbt_flags flags)
 {
 }
-- 
2.17.0
