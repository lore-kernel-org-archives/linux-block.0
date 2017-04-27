Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56264 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756455AbdD0Wvr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2017 18:51:47 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <ming.lei@redhat.com>, <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 6/6] Revert "mtip32xx: pass BLK_MQ_F_NO_SCHED"
Date: Thu, 27 Apr 2017 16:51:34 -0600
Message-ID: <1493333494-600-7-git-send-email-axboe@fb.com>
In-Reply-To: <1493333494-600-1-git-send-email-axboe@fb.com>
References: <1493333494-600-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This reverts commit 4981d04dd8f1ab19e2cce008da556d7f099b6e68.

The driver has been converted to using the proper infrastructure
for issuing internal commands. This means it's now safe to use with
the scheduling infrastruture, so we can now revert the change
that turned off scheduling for mtip32xx.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index ba03a5b1f05a..cf11d364c848 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3955,7 +3955,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 	dd->tags.reserved_tags = 1;
 	dd->tags.cmd_size = sizeof(struct mtip_cmd);
 	dd->tags.numa_node = dd->numa_node;
-	dd->tags.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_SCHED;
+	dd->tags.flags = BLK_MQ_F_SHOULD_MERGE;
 	dd->tags.driver_data = dd;
 	dd->tags.timeout = MTIP_NCQ_CMD_TIMEOUT_MS;
 
-- 
2.7.4
