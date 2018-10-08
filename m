Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk
Cc: linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	Dongbo Cao <cdbdyx@163.com>,
	Coly Li <colyli@suse.de>
Subject: [PATCH 11/15] bcache: remove useless parameter of bch_debug_init()
Date: Mon,  8 Oct 2018 20:41:17 +0800
Message-Id: <20181008124121.20192-12-colyli@suse.de>
In-Reply-To: <20181008124121.20192-1-colyli@suse.de>
References: <20181008124121.20192-1-colyli@suse.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Dongbo Cao <cdbdyx@163.com>

Parameter "struct kobject *kobj" in bch_debug_init() is useless,
remove it in this patch.

Signed-off-by: Dongbo Cao <cdbdyx@163.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bcache.h | 2 +-
 drivers/md/bcache/debug.c  | 2 +-
 drivers/md/bcache/super.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 83504dd8100a..5cfa1ec1b7a1 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -1003,7 +1003,7 @@ void bch_open_buckets_free(struct cache_set *c);
 int bch_cache_allocator_start(struct cache *ca);
 
 void bch_debug_exit(void);
-void bch_debug_init(struct kobject *kobj);
+void bch_debug_init(void);
 void bch_request_exit(void);
 int bch_request_init(void);
 
diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 06da66b2488a..8f448b9c96a1 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -253,7 +253,7 @@ void bch_debug_exit(void)
 		debugfs_remove_recursive(bcache_debug);
 }
 
-void __init bch_debug_init(struct kobject *kobj)
+void __init bch_debug_init(void)
 {
 	/*
 	 * it is unnecessary to check return value of
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index dc392a485269..719686ea5e27 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2381,7 +2381,7 @@ static int __init bcache_init(void)
 	    sysfs_create_files(bcache_kobj, files))
 		goto err;
 
-	bch_debug_init(bcache_kobj);
+	bch_debug_init();
 	closure_debug_init();
 
 	return 0;
-- 
2.19.0
