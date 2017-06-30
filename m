Return-Path: <bcache@lists.ewheeler.net>
From: bcache@lists.ewheeler.net
To: linux-block@vger.kernel.org
Cc: linux-bcache@vger.kernel.org,
	hch@infradead.org,
	axboe@kernel.dk,
	Tang Junhui <tang.junhui@zte.com.cn>
Subject: [PATCH 13/19] bcache: delete redundant calling set_gc_sectors()
Date: Fri, 30 Jun 2017 13:43:02 -0700
Message-Id: <1498855388-16990-13-git-send-email-bcache@lists.ewheeler.net>
In-Reply-To: <1498855388-16990-1-git-send-email-bcache@lists.ewheeler.net>
References: <20170629134510.GA32385@infradead.org>
 <1498855388-16990-1-git-send-email-bcache@lists.ewheeler.net>
List-ID: <linux-block@vger.kernel.org>

From: Tang Junhui <tang.junhui@zte.com.cn>

set_gc_sectors() has been called in bch_gc_thread(), and it was called
again in bch_btree_gc_finish() . The following call is unnecessary, so
delete it.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
---
 drivers/md/bcache/btree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 77aa20b..66d8036 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1662,7 +1662,6 @@ static size_t bch_btree_gc_finish(struct cache_set *c)
 
 	mutex_lock(&c->bucket_lock);
 
-	set_gc_sectors(c);
 	c->gc_mark_valid = 1;
 	c->need_gc	= 0;
 
-- 
1.8.3.1
