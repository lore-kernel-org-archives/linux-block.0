Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727501AbeHJJyB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 05:54:01 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, shhuiw@foxmail.com,
        Coly Li <colyli@suse.de>
Subject: [PATCH v2 11/17] bcache: do not check NULL pointer before calling kmem_cache_destroy
Date: Fri, 10 Aug 2018 15:23:51 +0800
Message-Id: <20180810072357.19823-12-colyli@suse.de>
In-Reply-To: <20180810072357.19823-1-colyli@suse.de>
References: <20180810072357.19823-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

kmem_cache_destroy() is safe for NULL pointer as input, the NULL pointer
checking is unncessary. This patch just removes the NULL pointer checking
to make code simpler.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Shenghui Wang <shhuiw@foxmail.com>
---
 drivers/md/bcache/request.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 55264e71369d..51be355a3309 100644
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
