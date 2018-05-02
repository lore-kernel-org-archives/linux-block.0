Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH v3 6/6] bcache: use pr_info() to inform duplicated CACHE_SET_IO_DISABLE set
Date: Wed,  2 May 2018 23:13:17 +0800
Message-Id: <20180502151317.120036-7-colyli@suse.de>
In-Reply-To: <20180502151317.120036-1-colyli@suse.de>
References: <20180502151317.120036-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

It is possible that multiple I/O requests hits on failed cache device or
backing device, therefore it is quite common that CACHE_SET_IO_DISABLE is
set already when a task tries to set the bit from bch_cache_set_error().
Currently the message "CACHE_SET_IO_DISABLE already set" is printed by
pr_warn(), which might mislead users to think a serious fault happens in
source code.

This patch uses pr_info() to print the information in such situation,
avoid extra worries. This information is helpful to understand bcache
behavior in cache device failures, so I still keep them in source code.

Fixes: 771f393e8ffc9 ("bcache: add CACHE_SET_IO_DISABLE to struct cache_set flags")
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index cedbb41533c2..3dea06b41d43 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1412,7 +1412,7 @@ bool bch_cache_set_error(struct cache_set *c, const char *fmt, ...)
 		return false;
 
 	if (test_and_set_bit(CACHE_SET_IO_DISABLE, &c->flags))
-		pr_warn("CACHE_SET_IO_DISABLE already set");
+		pr_info("CACHE_SET_IO_DISABLE already set");
 
 	/* XXX: we can be called from atomic context
 	acquire_console_sem();
-- 
2.16.3
