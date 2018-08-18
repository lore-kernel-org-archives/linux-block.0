Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:49080 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbeHRJ3c (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Aug 2018 05:29:32 -0400
From: zhong jiang <zhongjiang@huawei.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCHv2] block: Use NULL to compare with pointer-typed value rather than 0
Date: Sat, 18 Aug 2018 14:11:06 +0800
Message-ID: <1534572666-16086-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We should use NULL to compare with pointer-typed value rather than
0. The issue is detected with the help of Coccinelle.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/block/ataflop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index dfb2c26..fc63ffd 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1354,8 +1354,7 @@ static int floppy_revalidate(struct gendisk *disk)
 	unsigned int drive = p - unit;
 
 	if (test_bit(drive, &changed_floppies) ||
-	    test_bit(drive, &fake_change) ||
-	    p->disktype == 0) {
+	    test_bit(drive, &fake_change) || !p->disktype) { 
 		if (UD.flags & FTD_MSG)
 			printk(KERN_ERR "floppy: clear format %p!\n", UDT);
 		BufferDrive = -1;
-- 
1.7.12.4
