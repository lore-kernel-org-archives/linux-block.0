Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk
Cc: linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	Shenghui Wang <shhuiw@foxmail.com>,
	Coly Li <colyli@suse.de>
Subject: [PATCH 10/15] bcache: remove unused bch_passthrough_cache
Date: Mon,  8 Oct 2018 20:41:16 +0800
Message-Id: <20181008124121.20192-11-colyli@suse.de>
In-Reply-To: <20181008124121.20192-1-colyli@suse.de>
References: <20181008124121.20192-1-colyli@suse.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Shenghui Wang <shhuiw@foxmail.com>

struct kmem_cache *bch_passthrough_cache is not used in
bcache code. Remove it.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/request.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/request.h b/drivers/md/bcache/request.h
index aa055cfeb099..721bf336ed1a 100644
--- a/drivers/md/bcache/request.h
+++ b/drivers/md/bcache/request.h
@@ -39,6 +39,6 @@ void bch_data_insert(struct closure *cl);
 void bch_cached_dev_request_init(struct cached_dev *dc);
 void bch_flash_dev_request_init(struct bcache_device *d);
 
-extern struct kmem_cache *bch_search_cache, *bch_passthrough_cache;
+extern struct kmem_cache *bch_search_cache;
 
 #endif /* _BCACHE_REQUEST_H_ */
-- 
2.19.0
