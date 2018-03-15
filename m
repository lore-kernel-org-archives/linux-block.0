Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4231 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbeCOPI2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:08:28 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 04/16] bcache: Fix kernel-doc warnings
Date: Thu, 15 Mar 2018 08:08:02 -0700
Message-Id: <20180315150814.9412-5-bart.vanassche@wdc.com>
In-Reply-To: <20180315150814.9412-1-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Avoid that building with W=1 triggers warnings about the kernel-doc
headers.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/md/bcache/btree.c   |  2 +-
 drivers/md/bcache/closure.c |  8 ++++----
 drivers/md/bcache/request.c |  1 +
 drivers/md/bcache/util.c    | 18 ++++++++----------
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index c30609c54c03..d20f963799b6 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -959,7 +959,7 @@ static struct btree *mca_alloc(struct cache_set *c, struct btree_op *op,
 	return b;
 }
 
-/**
+/*
  * bch_btree_node_get - find a btree node in the cache and lock it, reading it
  * in from disk if necessary.
  *
diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
index 7f12920c14f7..87c45dfa7c38 100644
--- a/drivers/md/bcache/closure.c
+++ b/drivers/md/bcache/closure.c
@@ -46,7 +46,7 @@ void closure_sub(struct closure *cl, int v)
 }
 EXPORT_SYMBOL(closure_sub);
 
-/**
+/*
  * closure_put - decrement a closure's refcount
  */
 void closure_put(struct closure *cl)
@@ -55,7 +55,7 @@ void closure_put(struct closure *cl)
 }
 EXPORT_SYMBOL(closure_put);
 
-/**
+/*
  * closure_wake_up - wake up all closures on a wait list, without memory barrier
  */
 void __closure_wake_up(struct closure_waitlist *wait_list)
@@ -79,9 +79,9 @@ EXPORT_SYMBOL(__closure_wake_up);
 
 /**
  * closure_wait - add a closure to a waitlist
- *
- * @waitlist will own a ref on @cl, which will be released when
+ * @waitlist: will own a ref on @cl, which will be released when
  * closure_wake_up() is called on @waitlist.
+ * @cl: closure pointer.
  *
  */
 bool closure_wait(struct closure_waitlist *waitlist, struct closure *cl)
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 6422846b546e..ed129ba557a8 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -295,6 +295,7 @@ static void bch_data_insert_start(struct closure *cl)
 
 /**
  * bch_data_insert - stick some data in the cache
+ * @cl: closure pointer.
  *
  * This is the starting point for any data to end up in a cache device; it could
  * be from a normal write, or a writeback write, or a write to a flash only
diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
index 6198041f0ee2..74febd5230df 100644
--- a/drivers/md/bcache/util.c
+++ b/drivers/md/bcache/util.c
@@ -82,10 +82,9 @@ STRTO_H(strtoll, long long)
 STRTO_H(strtoull, unsigned long long)
 
 /**
- * bch_hprint() - formats @v to human readable string for sysfs.
- *
- * @v - signed 64 bit integer
- * @buf - the (at least 8 byte) buffer to format the result into.
+ * bch_hprint - formats @v to human readable string for sysfs.
+ * @buf: the (at least 8 byte) buffer to format the result into.
+ * @v: signed 64 bit integer
  *
  * Returns the number of bytes used by format.
  */
@@ -225,13 +224,12 @@ void bch_time_stats_update(struct time_stats *stats, uint64_t start_time)
 }
 
 /**
- * bch_next_delay() - increment @d by the amount of work done, and return how
- * long to delay until the next time to do some work.
- *
- * @d - the struct bch_ratelimit to update
- * @done - the amount of work done, in arbitrary units
+ * bch_next_delay() - update ratelimiting statistics and calculate next delay
+ * @d: the struct bch_ratelimit to update
+ * @done: the amount of work done, in arbitrary units
  *
- * Returns the amount of time to delay by, in jiffies
+ * Increment @d by the amount of work done, and return how long to delay in
+ * jiffies until the next time to do some work.
  */
 uint64_t bch_next_delay(struct bch_ratelimit *d, uint64_t done)
 {
-- 
2.16.2
