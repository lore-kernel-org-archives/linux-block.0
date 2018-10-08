Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk
Cc: linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	Shenghui Wang <shhuiw@foxmail.com>,
	Coly Li <colyli@suse.de>
Subject: [PATCH 13/15] bcache: use MAX_CACHES_PER_SET instead of magic number 8 in __bch_bucket_alloc_set
Date: Mon,  8 Oct 2018 20:41:19 +0800
Message-Id: <20181008124121.20192-14-colyli@suse.de>
In-Reply-To: <20181008124121.20192-1-colyli@suse.de>
References: <20181008124121.20192-1-colyli@suse.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Shenghui Wang <shhuiw@foxmail.com>

Current cache_set has MAX_CACHES_PER_SET caches most, and the macro
is used for
"
	struct cache *cache_by_alloc[MAX_CACHES_PER_SET];
"
in the define of struct cache_set.

Use MAX_CACHES_PER_SET instead of magic number 8 in
__bch_bucket_alloc_set.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 7a28232d868b..5002838ea476 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -484,7 +484,7 @@ int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
 	int i;
 
 	lockdep_assert_held(&c->bucket_lock);
-	BUG_ON(!n || n > c->caches_loaded || n > 8);
+	BUG_ON(!n || n > c->caches_loaded || n > MAX_CACHES_PER_SET);
 
 	bkey_init(k);
 
-- 
2.19.0
