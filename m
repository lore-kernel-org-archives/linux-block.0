Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:42915 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbeHQQnU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 12:43:20 -0400
From: zhong jiang <zhongjiang@huawei.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] block: Use NULL to compare with pointer-typed value rather than 0
Date: Fri, 17 Aug 2018 21:27:53 +0800
Message-ID: <1534512473-39710-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We should use NULL to compare with pointer-typed value rather than
0. The issue is detected with the help of Coccinelle.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/block/ataflop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index dfb2c26..cca93e3 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1355,7 +1355,7 @@ static int floppy_revalidate(struct gendisk *disk)
 
 	if (test_bit(drive, &changed_floppies) ||
 	    test_bit(drive, &fake_change) ||
-	    p->disktype == 0) {
+	    p->disktype == NULL) {
 		if (UD.flags & FTD_MSG)
 			printk(KERN_ERR "floppy: clear format %p!\n", UDT);
 		BufferDrive = -1;
-- 
1.7.12.4
