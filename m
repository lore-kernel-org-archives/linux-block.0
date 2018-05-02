Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH 6/6] bcache: use pr_info() to inform duplicated CACHE_SET_IO_DISABLE set
Date: Wed,  2 May 2018 22:46:59 +0800
Message-Id: <20180502144659.118628-7-colyli@suse.de>
In-Reply-To: <20180502144659.118628-1-colyli@suse.de>
References: <20180502144659.118628-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

It is possible that multiple I/O requests hits on failed cache device or
backing device, therefore it is quite common that CACHE_SET_IO_DISABLE is
set already when a task tries to set the bit from bch_cached_dev_error()
or bch_cache_set_error(). Currently the message "CACHE_SET_IO_DISABLE
already set" is printed by pr_warn(), which might mislead users to think
a serious fault happens in source code.

This patch uses pr_info() to print the information in such situations,
avoid extra worries. This information is helpful to understand bcache
behavior in cache device failures, so I still keep them in source code.

Fixes: a705642fd4ded ("bcache: set CACHE_SET_IO_DISABLE in bch_cached_dev_error()")
Fixes: 771f393e8ffc9 ("bcache: add CACHE_SET_IO_DISABLE to struct cache_set flags")
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 507755fcac5a..3dea06b41d43 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1394,7 +1394,7 @@ bool bch_cached_dev_error(struct cached_dev *dc)
 	 */
 	c = dc->disk.c;
 	if (c && test_and_set_bit(CACHE_SET_IO_DISABLE, &c->flags))
-		pr_warn("CACHE_SET_IO_DISABLE already set");
+		pr_info("CACHE_SET_IO_DISABLE already set");
 
 	bcache_device_stop(&dc->disk);
 	return true;
@@ -1412,7 +1412,7 @@ bool bch_cache_set_error(struct cache_set *c, const char *fmt, ...)
 		return false;
 
 	if (test_and_set_bit(CACHE_SET_IO_DISABLE, &c->flags))
-		pr_warn("CACHE_SET_IO_DISABLE already set");
+		pr_info("CACHE_SET_IO_DISABLE already set");
 
 	/* XXX: we can be called from atomic context
 	acquire_console_sem();
-- 
2.16.3
