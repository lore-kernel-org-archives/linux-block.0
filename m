Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: colyli@suse.de,
	axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Shenghui Wang <shhuiw@foxmail.com>
Subject: [PATCH 6/9] bcache: free heap cache_set->flush_btree in bch_journal_free
Date: Thu, 26 Jul 2018 12:17:38 +0800
Message-Id: <20180726041741.1669-7-colyli@suse.de>
In-Reply-To: <20180726041741.1669-1-colyli@suse.de>
References: <20180726041741.1669-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Shenghui Wang <shhuiw@foxmail.com>

Free the cache_set->flush_bree heap memory on journal free.

Signed-off-by: Wang Sheng-Hui <shhuiw@foxmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/journal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 18f1b5239620..10748c626a1d 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -828,6 +828,7 @@ void bch_journal_free(struct cache_set *c)
 	free_pages((unsigned long) c->journal.w[1].data, JSET_BITS);
 	free_pages((unsigned long) c->journal.w[0].data, JSET_BITS);
 	free_fifo(&c->journal.pin);
+	free_heap(&c->flush_btree);
 }
 
 int bch_journal_alloc(struct cache_set *c)
-- 
2.17.1
