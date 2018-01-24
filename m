Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mxhk.zte.com.cn ([63.217.80.70]:41278 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752355AbeAXGw5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jan 2018 01:52:57 -0500
From: tang.junhui@zte.com.cn
To: colyli@suse.de, mlyle@lyle.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: [PATCH] bcache: lock in btree_flush_write() to avoid races
Date: Wed, 24 Jan 2018 14:54:24 +0800
Message-Id: <1516776864-26993-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>

In btree_flush_write(), two places need to take a locker to
avoid races:

Firstly, we need take rcu read locker to protect the bucket_hash
traverse, since hlist_for_each_entry_rcu() must be called under
the protection of rcu read locker.

Secondly, we need take b->write_lock locker to protect journal
of the btree node, otherwise, the btree node may have been
written, and the journal have been assign to NULL.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
---
 drivers/md/bcache/journal.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 02a98dd..505f9f3 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -375,7 +375,9 @@ static void btree_flush_write(struct cache_set *c)
 retry:
 	best = NULL;
 
-	for_each_cached_btree(b, c, i)
+	rcu_read_lock();
+	for_each_cached_btree(b, c, i) {
+		mutex_lock(&b->write_lock);
 		if (btree_current_write(b)->journal) {
 			if (!best)
 				best = b;
@@ -385,6 +387,9 @@ static void btree_flush_write(struct cache_set *c)
 				best = b;
 			}
 		}
+		mutex_unlock(&b->write_lock);
+	}
+	rcu_read_unlock();
 
 	b = best;
 	if (b) {
-- 
1.8.3.1
