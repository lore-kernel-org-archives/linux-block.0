Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757556AbeDXMPZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Apr 2018 08:15:25 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 6/6] bcache: use pr_info() to inform duplicated CACHE_SET_IO_DISABLE set
Date: Tue, 24 Apr 2018 20:14:46 +0800
Message-Id: <20180424121446.130552-7-colyli@suse.de>
In-Reply-To: <20180424121446.130552-1-colyli@suse.de>
References: <20180424121446.130552-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

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
index 487eb68b598f..158064e5a861 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1393,7 +1393,7 @@ bool bch_cached_dev_error(struct cached_dev *dc)
 	 */
 	c = dc->disk.c;
 	if (c && test_and_set_bit(CACHE_SET_IO_DISABLE, &c->flags))
-		pr_warn("CACHE_SET_IO_DISABLE already set");
+		pr_info("CACHE_SET_IO_DISABLE already set");
 
 	bcache_device_stop(&dc->disk);
 	return true;
@@ -1411,7 +1411,7 @@ bool bch_cache_set_error(struct cache_set *c, const char *fmt, ...)
 		return false;
 
 	if (test_and_set_bit(CACHE_SET_IO_DISABLE, &c->flags))
-		pr_warn("CACHE_SET_IO_DISABLE already set");
+		pr_info("CACHE_SET_IO_DISABLE already set");
 
 	/* XXX: we can be called from atomic context
 	acquire_console_sem();
-- 
2.16.2
