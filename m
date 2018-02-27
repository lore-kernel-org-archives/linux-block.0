Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42653 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbeB0Rti (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 12:49:38 -0500
Received: by mail-pl0-f67.google.com with SMTP id 93-v6so1236669plc.9
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2018 09:49:38 -0800 (PST)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com, Coly Li <colyli@suse.de>
Subject: [PATCH 1/2] bcache: correct flash only vols (check all uuids)
Date: Tue, 27 Feb 2018 09:49:29 -0800
Message-Id: <20180227174930.15911-2-mlyle@lyle.org>
In-Reply-To: <20180227174930.15911-1-mlyle@lyle.org>
References: <20180227174930.15911-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Coly Li <colyli@suse.de>

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

[mlyle: commit subject edited for character limit]

Fixes: 2831231d4c3f ("bcache: reduce cache_set devices iteration by devices_max_used")
Reported-by: Tang Junhui <tang.junhui@zte.com.cn>
Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
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
2.14.1
