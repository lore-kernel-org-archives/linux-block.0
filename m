Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56247 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751465AbeBZQK7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Feb 2018 11:10:59 -0500
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>,
        Michael Lyle <mlyle@lyle.org>
Subject: [PATCH] bcache: check all uuid elements when start flash only volumes
Date: Tue, 27 Feb 2018 00:10:47 +0800
Message-Id: <20180226161047.14577-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Commit 2831231d4c3f ("bcache: reduce cache_set devices iteration by
devices_max_used") adds c->devices_max_used to reduce iteration of
c->uuids elements, this value is updated in bcache_device_attach().

But for flash only volume, when calling flash_devs_run(), the function
bcache_device_attach() is not called yet and c->devices_max_used is not
updated. The unexpected result is, the flash only volume won't be run
by flash_devs_run().

This patch fixes the issue by iterate all c->uuids elements in
flash_devs_run(). c->devices_max_used will be updated properly when
bcache_device_attach() gets called.

Fixes: 2831231d4c3f ("bcache: reduce cache_set devices iteration by devices_max_used")
Reported-by: Tang Junhui <tang.junhui@zte.com.cn>
Signed-off-by: Coly Li <colyli@suse.de>
Cc: Michael Lyle <mlyle@lyle.org>
---
 drivers/md/bcache/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 312895788036..4d1d8dfb2d2a 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1274,7 +1274,7 @@ static int flash_devs_run(struct cache_set *c)
 	struct uuid_entry *u;
 
 	for (u = c->uuids;
-	     u < c->uuids + c->devices_max_used && !ret;
+	     u < c->uuids + c->nr_uuids && !ret;
 	     u++)
 		if (UUID_FLASH_ONLY(u))
 			ret = flash_dev_run(c, u);
-- 
2.16.1
