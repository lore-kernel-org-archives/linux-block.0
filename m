Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938548AbdD1EaT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 00:30:19 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Josef Bacik <jbacik@fb.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: nbd: fix double free
Date: Fri, 28 Apr 2017 12:29:42 +0800
Message-Id: <20170428042942.6567-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks it is a typo, just fix it, otherwise the following
warning can be trigerred:

[ming@VM]$sudo rmmod nbd
[sudo] password for ming:
==================================================================
BUG: KASAN: use-after-free in nbd_cleanup+0x115/0x18e [nbd] at addr ffff88024ca539b0
Read of size 8 by task rmmod/2079
Object at ffff88024ca53900, in cache kmalloc-256 size: 256
Allocated:
PID = 1414
Freed:
PID = 2079
Memory state around the buggy address:
 ffff88024ca53880: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88024ca53900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88024ca53980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88024ca53a00: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
 ffff88024ca53a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Fixes: c6a4759ea0c9(nbd: add device refcounting)
Cc: Josef Bacik <jbacik@fb.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/nbd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5583dc4ff941..fa44a6fce4cb 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2110,7 +2110,6 @@ static void __exit nbd_cleanup(void)
 		if (refcount_read(&nbd->refs) != 2)
 			printk(KERN_ERR "nbd: possibly leaking a device\n");
 		nbd_put(nbd);
-		nbd_put(nbd);
 	}
 
 	idr_destroy(&nbd_index_idr);
-- 
2.9.3
