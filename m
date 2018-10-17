Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46348 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeJRAsl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Oct 2018 20:48:41 -0400
From: Avri Altman <avri.altman@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] block: Make write_hints[] big enough
Date: Wed, 17 Oct 2018 19:51:21 +0300
Message-Id: <1539795081-2394-1-git-send-email-avri.altman@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Just stumbled over this.
Looks like the write hints array in the request queue is not allotted
with the required space to accommodate all the write hint types.

fixes: f793dfd3f39a (blk-mq: expose write hints through debugfs)

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6869e0..0c8010d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -665,7 +665,7 @@ struct request_queue {
 
 	struct work_struct	release_work;
 
-#define BLK_MAX_WRITE_HINTS	5
+#define BLK_MAX_WRITE_HINTS	6
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
 
-- 
1.9.1
