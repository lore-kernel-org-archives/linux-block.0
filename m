Return-Path: <linux-block-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33257 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752082AbeB1JzA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Feb 2018 04:55:00 -0500
From: Michael Tretter <m.tretter@pengutronix.de>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <jbacik@fb.com>, kernel@pengutronix.de,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH] nbd: do not update block size if file system is mounted
Date: Wed, 28 Feb 2018 10:54:56 +0100
Message-Id: <20180228095456.31472-1-m.tretter@pengutronix.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If a file system is mounted on the nbd during a disconnect, resetting
the size to 0, might change the block size and destroy the buffer_head
mappings. This will cause a infinite loop when the file system looks for
the buffer_heads for flushing.

Only set the file size to 0, if we are the only opener of the nbd.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/block/nbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5f2a4240a204..0d1dbb60430b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1118,7 +1118,8 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 	if (ret)
 		sock_shutdown(nbd);
 	mutex_lock(&nbd->config_lock);
-	bd_set_size(bdev, 0);
+	if (bdev->bd_openers <= 1)
+		bd_set_size(bdev, 0);
 	/* user requested, ignore socket errors */
 	if (test_bit(NBD_DISCONNECT_REQUESTED, &config->runtime_flags))
 		ret = 0;
-- 
2.16.1
