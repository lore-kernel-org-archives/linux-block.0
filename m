Return-Path: <linux-block-owner@vger.kernel.org>
Received: from iad1-shared-relay2.dreamhost.com ([208.113.157.41]:44992 "EHLO
        iad1-shared-relay2.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752416AbdF3KVQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 06:21:16 -0400
Received: from iad1-shared-relay1.dreamhost.com (iad1-shared-relay1.dreamhost.com [208.113.157.50])
        by iad1-shared-relay2.dreamhost.com (Postfix) with ESMTP id 4ED853E5687
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:21:09 -0700 (PDT)
Received: from ware.dreamhost.com (ware.dreamhost.com [64.111.127.160])
        by iad1-shared-relay1.dreamhost.com (Postfix) with ESMTP id 4A7F0B400CB
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:21:08 -0700 (PDT)
In-Reply-To: <20170629134510.GA32385@infradead.org>
References: <20170629134510.GA32385@infradead.org>
From: Tang Junhui <tang.junhui@zte.com.cn>
Date: Tue, 27 Jun 2017 17:37:29 -0700
Subject: [PATCH 16/19] bcache: increase the number of open buckets
To: linux-block@vger.kernel.org
Message-Id: <20170629222108.428BB100128@ware.dreamhost.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In currently, we only alloc 6 open buckets for each cache set,
but in usually, we always attach about 10 or so backend devices for
each cache set, and the each bcache device are always accessed by
about 10 or so threads in top application layer. So 6 open buckets
are too few, It has led to that each of the same thread write data
to different buckets, which would cause low efficiency write-back,
and also cause buckets inefficient, and would be Very easy to run
out of.

I add debug message in bch_open_buckets_alloc() to print alloc bucket
info, and test with ten bcache devices with a cache set, and each
bcache device is accessed by ten threads.

>From the debug message, we can see that, after the modification, One
bucket is more likely to assign to the same thread, and the data from
the same thread are more likely to write the same bucket. Usually the
same thread always write/read the same backend device, so it is good
for write-back and also promote the usage efficiency of buckets.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
---
 drivers/md/bcache/alloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index ca4abe1..cacbe2d 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -68,6 +68,8 @@
 #include <linux/random.h>
 #include <trace/events/bcache.h>
 
+#define MAX_OPEN_BUCKETS 128
+
 /* Bucket heap / gen */
 
 uint8_t bch_inc_gen(struct cache *ca, struct bucket *b)
@@ -671,7 +673,7 @@ int bch_open_buckets_alloc(struct cache_set *c)
 
 	spin_lock_init(&c->data_bucket_lock);
 
-	for (i = 0; i < 6; i++) {
+	for (i = 0; i < MAX_OPEN_BUCKETS; i++) {
 		struct open_bucket *b = kzalloc(sizeof(*b), GFP_KERNEL);
 		if (!b)
 			return -ENOMEM;
-- 
1.8.3.1
