Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727237AbeHIJIc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Aug 2018 05:08:32 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 11/17] bcache: do not check NULL pointer before calling kmem_cache_destroy
Date: Thu,  9 Aug 2018 14:43:14 +0800
Message-Id: <20180809064320.10229-12-colyli@suse.de>
In-Reply-To: <20180809064320.10229-1-colyli@suse.de>
References: <20180809064320.10229-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

kmem_cache_destroy() is safe for NULL pointer as input, the NULL pointer
checking is unncessary. This patch just removes the NULL pointer checking
to make code simpler.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/request.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 449baec3fa19..4bdcec9167a0 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1367,8 +1367,7 @@ void bch_flash_dev_request_init(struct bcache_device *d)
 
 void bch_request_exit(void)
 {
-	if (bch_search_cache)
-		kmem_cache_destroy(bch_search_cache);
+	kmem_cache_destroy(bch_search_cache);
 }
 
 int __init bch_request_init(void)
-- 
2.18.0
