Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45757 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeEQJyA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 May 2018 05:54:00 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>,
        stable@vger.kernel.org, Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2] bcache: return 0 from bch_debug_init() if CONFIG_DEBUG_FS=n
Date: Thu, 17 May 2018 17:53:48 +0800
Message-Id: <20180517095348.21392-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Commit 539d39eb2708 ("bcache: fix wrong return value in bch_debug_init()")
returns the return value of debugfs_create_dir() to bcache_init(). When
CONFIG_DEBUG_FS=n, bch_debug_init() always returns 1 and makes
bcache_init() failedi.

This patch makes bch_debug_init() always returns 0 if CONFIG_DEBUG_FS=n,
so bcache can continue to work for the kernels which don't have debugfs
enanbled.

Fixes: Commit 539d39eb2708 ("bcache: fix wrong return value in bch_debug_init()")
Cc: stable@vger.kernel.org
Signed-off-by: Coly Li <colyli@suse.de>
Reported-by: Massimo B. <massimo.b@gmx.net>
Reported-by: Kai Krakow <kai@kaishome.de>
Tested-by: Kai Krakow <kai@kaishome.de>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
---
 drivers/md/bcache/bcache.h | 5 +++++
 drivers/md/bcache/debug.c  | 8 ++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 3a0cfb237af9..5b3fe87f32ee 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -994,8 +994,13 @@ void bch_open_buckets_free(struct cache_set *);
 
 int bch_cache_allocator_start(struct cache *ca);
 
+#ifdef CONFIG_DEBUG_FS
 void bch_debug_exit(void);
 int bch_debug_init(struct kobject *);
+#else
+static inline void bch_debug_exit(void) {};
+static inline int bch_debug_init(struct kobject *kobj) { return 0; };
+#endif
 void bch_request_exit(void);
 int bch_request_init(void);
 
diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 4e63c6f6c04d..20e5e524e88e 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -17,8 +17,6 @@
 #include <linux/random.h>
 #include <linux/seq_file.h>
 
-struct dentry *bcache_debug;
-
 #ifdef CONFIG_BCACHE_DEBUG
 
 #define for_each_written_bset(b, start, i)				\
@@ -151,6 +149,8 @@ void bch_data_verify(struct cached_dev *dc, struct bio *bio)
 
 /* XXX: cache set refcounting */
 
+struct dentry *bcache_debug;
+
 struct dump_iterator {
 	char			buf[PAGE_SIZE];
 	size_t			bytes;
@@ -240,8 +240,6 @@ void bch_debug_init_cache_set(struct cache_set *c)
 	}
 }
 
-#endif
-
 void bch_debug_exit(void)
 {
 	if (!IS_ERR_OR_NULL(bcache_debug))
@@ -254,3 +252,5 @@ int __init bch_debug_init(struct kobject *kobj)
 
 	return IS_ERR_OR_NULL(bcache_debug);
 }
+
+#endif
-- 
2.16.3
