Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:30641 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753737AbdHQUOd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2017 16:14:33 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Akhil Bhansali <Akhil.Bhansali@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 27/55] skd: Make the skd_isr() code more brief
Date: Thu, 17 Aug 2017 13:13:10 -0700
Message-Id: <20170817201338.16537-28-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index e2d205b58fe2..7d5048d95037 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2830,14 +2830,13 @@ static void skd_isr_msg_from_dev(struct skd_device *skdev);
 static irqreturn_t
 skd_isr(int irq, void *ptr)
 {
-	struct skd_device *skdev;
+	struct skd_device *skdev = ptr;
 	u32 intstat;
 	u32 ack;
 	int rc = 0;
 	int deferred = 0;
 	int flush_enqueued = 0;
 
-	skdev = (struct skd_device *)ptr;
 	spin_lock(&skdev->lock);
 
 	for (;; ) {
-- 
2.14.0
