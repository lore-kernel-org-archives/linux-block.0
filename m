Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35390 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757225AbdCUP5K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2017 11:57:10 -0400
Received: by mail-pf0-f181.google.com with SMTP id 20so33764908pfk.2
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2017 08:57:09 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Omar Sandoval <osandov@fb.com>
Subject: [PATCH v2 3/4] blk-stat: move BLK_RQ_STAT_BATCH definition to blk-stat.c
Date: Tue, 21 Mar 2017 08:56:07 -0700
Message-Id: <9b5f8735cff8ea4844c7d63725d351526bf6f7ce.1490110621.git.osandov@fb.com>
In-Reply-To: <cover.1490110621.git.osandov@fb.com>
References: <cover.1490110621.git.osandov@fb.com>
In-Reply-To: <cover.1490110621.git.osandov@fb.com>
References: <cover.1490110621.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is an implementation detail that no-one outside of blk-stat.c uses.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-stat.c          | 2 ++
 include/linux/blk_types.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index f80582be5344..4681c488c262 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -9,6 +9,8 @@
 #include "blk-stat.h"
 #include "blk-mq.h"
 
+#define BLK_RQ_STAT_BATCH	64
+
 static void blk_stat_flush_batch(struct blk_rq_stat *stat)
 {
 	const s32 nr_batch = READ_ONCE(stat->nr_batch);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d703acb55d0f..e213c5e7500b 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -287,8 +287,6 @@ struct blk_issue_stat {
 	u64 time;
 };
 
-#define BLK_RQ_STAT_BATCH	64
-
 struct blk_rq_stat {
 	s64 mean;
 	u64 min;
-- 
2.12.0
