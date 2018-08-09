Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727689AbeHIJJJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Aug 2018 05:09:09 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 17/17] bcache: add the missing code comments for smp_mb()
Date: Thu,  9 Aug 2018 14:43:20 +0800
Message-Id: <20180809064320.10229-18-colyli@suse.de>
In-Reply-To: <20180809064320.10229-1-colyli@suse.de>
References: <20180809064320.10229-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Checkpatch.pl warns there are 2 locations of smp_mb() without code
comment. This patch adds the missing code comments for these smp_mb()
calls.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/closure.h | 4 +++-
 drivers/md/bcache/super.c   | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/closure.h b/drivers/md/bcache/closure.h
index 7f3594c0be14..eca0d496b686 100644
--- a/drivers/md/bcache/closure.h
+++ b/drivers/md/bcache/closure.h
@@ -289,10 +289,12 @@ static inline void closure_init_stack(struct closure *cl)
 }
 
 /**
- * closure_wake_up - wake up all closures on a wait list.
+ * closure_wake_up - wake up all closures on a wait list,
+ *		     with memory barrier
  */
 static inline void closure_wake_up(struct closure_waitlist *list)
 {
+	/* Memory barrier for the wait list */
 	smp_mb();
 	__closure_wake_up(list);
 }
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index f8fe39c72f99..985e2f456081 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1136,11 +1136,11 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
 	list_move(&dc->list, &c->cached_devs);
 	calc_cached_dev_sectors(c);
 
-	smp_wmb();
 	/*
 	 * dc->c must be set before dc->count != 0 - paired with the mb in
 	 * cached_dev_get()
 	 */
+	smp_wmb();
 	refcount_set(&dc->count, 1);
 
 	/* Block writeback thread, but spawn it */
-- 
2.18.0
