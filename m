Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58404 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755557AbdD0Wvp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2017 18:51:45 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <ming.lei@redhat.com>, <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 3/6] mtip32xx: abstract out "are any commands active" helper
Date: Thu, 27 Apr 2017 16:51:31 -0600
Message-ID: <1493333494-600-4-git-send-email-axboe@fb.com>
In-Reply-To: <1493333494-600-1-git-send-email-axboe@fb.com>
References: <1493333494-600-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is a prep patch for backoff in ->queue_rq() for non-ncq commands.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 36f3d34f2156..f0732cc92864 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -1030,6 +1030,22 @@ static bool mtip_pause_ncq(struct mtip_port *port,
 	return false;
 }
 
+static bool mtip_commands_active(struct mtip_port *port)
+{
+	unsigned int n;
+	unsigned int active = 1;
+
+	/*
+	 * Ignore s_active bit 0 of array element 0.
+	 * This bit will always be set
+	 */
+	active = readl(port->s_active[0]) & 0xFFFFFFFE;
+	for (n = 1; n < port->dd->slot_groups; n++)
+		active |= readl(port->s_active[n]);
+
+	return active != 0;
+}
+
 /*
  * Wait for port to quiesce
  *
@@ -1043,8 +1059,7 @@ static bool mtip_pause_ncq(struct mtip_port *port,
 static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout)
 {
 	unsigned long to;
-	unsigned int n;
-	unsigned int active = 1;
+	bool active = true;
 
 	blk_mq_stop_hw_queues(port->dd->queue);
 
@@ -1061,14 +1076,7 @@ static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout)
 		if (mtip_check_surprise_removal(port->dd->pdev))
 			goto err_fault;
 
-		/*
-		 * Ignore s_active bit 0 of array element 0.
-		 * This bit will always be set
-		 */
-		active = readl(port->s_active[0]) & 0xFFFFFFFE;
-		for (n = 1; n < port->dd->slot_groups; n++)
-			active |= readl(port->s_active[n]);
-
+		active = mtip_commands_active(port);
 		if (!active)
 			break;
 	} while (time_before(jiffies, to));
-- 
2.7.4
