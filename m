Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44917 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1164303AbdD1OCN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 10:02:13 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <ming.lei@redhat.com>, <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 2/6] mtip32xx: kill atomic argument to mtip_quiesce_io()
Date: Fri, 28 Apr 2017 08:01:53 -0600
Message-ID: <1493388117-15185-5-git-send-email-axboe@fb.com>
In-Reply-To: <1493388117-15185-1-git-send-email-axboe@fb.com>
References: <1493388117-15185-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

All callers now pass in GFP_KERNEL, get rid of the argument.

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index d81d797ee65d..36f3d34f2156 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -1035,14 +1035,12 @@ static bool mtip_pause_ncq(struct mtip_port *port,
  *
  * @port    Pointer to port data structure
  * @timeout Max duration to wait (ms)
- * @atomic  gfp_t flag to indicate blockable context or not
  *
  * return value
  *	0	Success
  *	-EBUSY  Commands still active
  */
-static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout,
-								gfp_t atomic)
+static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout)
 {
 	unsigned long to;
 	unsigned int n;
@@ -1053,18 +1051,12 @@ static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout,
 	to = jiffies + msecs_to_jiffies(timeout);
 	do {
 		if (test_bit(MTIP_PF_SVC_THD_ACTIVE_BIT, &port->flags) &&
-			test_bit(MTIP_PF_ISSUE_CMDS_BIT, &port->flags) &&
-			atomic == GFP_KERNEL) {
+			test_bit(MTIP_PF_ISSUE_CMDS_BIT, &port->flags)) {
 			msleep(20);
 			continue; /* svc thd is actively issuing commands */
 		}
 
-		if (atomic == GFP_KERNEL)
-			msleep(100);
-		else {
-			cpu_relax();
-			udelay(100);
-		}
+		msleep(100);
 
 		if (mtip_check_surprise_removal(port->dd->pdev))
 			goto err_fault;
@@ -1142,8 +1134,7 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 
 	if (fis->command != ATA_CMD_STANDBYNOW1) {
 		/* wait for io to complete if non atomic */
-		if (mtip_quiesce_io(port,
-			MTIP_QUIESCE_IO_TIMEOUT_MS, GFP_KERNEL) < 0) {
+		if (mtip_quiesce_io(port, MTIP_QUIESCE_IO_TIMEOUT_MS) < 0) {
 			dev_warn(&dd->pdev->dev, "Failed to quiesce IO\n");
 			mtip_put_int_command(dd, int_cmd);
 			clear_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags);
@@ -4106,8 +4097,7 @@ static int mtip_block_remove(struct driver_data *dd)
 		 * Explicitly wait here for IOs to quiesce,
 		 * as mtip_standby_drive usually won't wait for IOs.
 		 */
-		if (!mtip_quiesce_io(dd->port, MTIP_QUIESCE_IO_TIMEOUT_MS,
-								GFP_KERNEL))
+		if (!mtip_quiesce_io(dd->port, MTIP_QUIESCE_IO_TIMEOUT_MS))
 			mtip_standby_drive(dd);
 	}
 	else
-- 
2.7.4
