Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57819 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750865AbdEBP7J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 May 2017 11:59:09 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <ming.lei@redhat.com>, <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 1/2] mtip32xx: cleanup internal tag assumptions
Date: Tue, 2 May 2017 09:59:00 -0600
Message-ID: <1493740741-4471-2-git-send-email-axboe@fb.com>
In-Reply-To: <1493740741-4471-1-git-send-email-axboe@fb.com>
References: <1493740741-4471-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We don't decode the internal tag to the proper group or tag
indx. This works fine because we have hard wired it as 0 for now,
but could break if we get rid of that.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 96fe6500e941..3204623f746a 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -847,16 +847,15 @@ static inline void mtip_process_legacy(struct driver_data *dd, u32 port_stat)
 	struct mtip_port *port = dd->port;
 	struct mtip_cmd *cmd = mtip_cmd_from_tag(dd, MTIP_TAG_INTERNAL);
 
-	if (test_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags) &&
-	    (cmd != NULL) && !(readl(port->cmd_issue[MTIP_TAG_INTERNAL])
-		& (1 << MTIP_TAG_INTERNAL))) {
-		if (cmd->comp_func) {
-			cmd->comp_func(port, MTIP_TAG_INTERNAL, cmd, 0);
-			return;
+	if (test_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags) && cmd) {
+		int group = MTIP_TAG_INDEX(MTIP_TAG_INTERNAL);
+		int status = readl(port->cmd_issue[group]);
+
+		if (!(status & (1 << MTIP_TAG_BIT(MTIP_TAG_INTERNAL)))) {
+			if (cmd->comp_func)
+				cmd->comp_func(port, MTIP_TAG_INTERNAL, cmd, 0);
 		}
 	}
-
-	return;
 }
 
 /*
@@ -1213,8 +1212,8 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 		goto exec_ic_exit;
 	}
 
-	if (readl(port->cmd_issue[MTIP_TAG_INTERNAL])
-			& (1 << MTIP_TAG_INTERNAL)) {
+	if (readl(port->cmd_issue[MTIP_TAG_INDEX(MTIP_TAG_INTERNAL)])
+			& (1 << MTIP_TAG_BIT(MTIP_TAG_INTERNAL))) {
 		rv = -ENXIO;
 		if (!test_bit(MTIP_DDF_REMOVE_PENDING_BIT, &dd->dd_flag)) {
 			mtip_device_reset(dd);
-- 
2.7.4
