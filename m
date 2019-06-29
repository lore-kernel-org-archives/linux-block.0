Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4329C4321A
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 05:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C81214AF
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 05:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PP5+ykFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfF2FFn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 01:05:43 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:18799 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfF2FFn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 01:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561784742; x=1593320742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rPijYuJVtPOfdrCqQnG8pzfi1badlCEPEZ8dbgwaWGY=;
  b=PP5+ykFAKxKT/tKH5M7G0k89Yxa5vAxrENRAgRZ3AM0TM1SYU+E6SNwE
   L2ESh+06G4qkWhb/GbKShIqLpC6V/hDHOqZbFKDs7OSMk9w7jE4SH0DDH
   fuMrKv+5iGijX2QNtabc1FviiD4wc05vK6O3M3duTj/NGah5PWdCBAE4+
   c8EL7JPk1KQVzQmu9MFMgwQpuNV/cXpBLagEjEhQ5TjD/Ijqz7YBsOkqp
   F4UkXVsquZDqk4Ff7u8Xqwx2YVzup0TQq1zi1H90/H6Fm/vb1wU8bzv9P
   qDJodH1vxqiof817mFfT9z/NjuJKftkIF9WkIHTmsX8rO6SZKDhEnVLvp
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,430,1557158400"; 
   d="scan'208";a="218207938"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2019 13:05:30 +0800
IronPort-SDR: t0/mitBA9aNwbjO6QRVMlXIjiie1AkRJY+QTzOT3fSznm/L/oHkWOz2cAZJa4YtHAxfS/uXIuJ
 OhMvwu31l+Sk1Q11IAgoVq1FM+cCaqqcX9hfDP9wQldU9wSjhNS1ctz83Q1uBy4D2a6iqiJy91
 IZThpg13woxRyxLO++vZNEYh0CsTH3RkUpWYEHdplvgAjyVz+0ZbwIEcScFvRRwLgdtM5s9Z5X
 4/76RdFeMDwE+1tklhq5USHiwhVegk4bs9TvrFJJgSf59D0GjnfjzHnHXCsOpi9NlaiEQGAEw0
 8eornvr9CJne0lEDldzEmHbp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 28 Jun 2019 22:04:35 -0700
IronPort-SDR: vFT+fLEoUW25vnBwiKXucvlwq9vBc7fpfoMI5KvTUDBNv0y5Pq0xWs8I7SHoyWsZUGpN5J27Xa
 KAN0HNjNQurHEVX8bUXR86rwMelj7zEVX8eRAOStk7WWP1DpIC2zdh9FTSGoKFz1VXFZ/7ftQC
 AfmdGcup/ljsXakt9/sBa3PKX7TIwO7oaK985+/iOc64lMvj8824ofnVc0z6KIWsUfLo85GRXt
 ewgKmJPv/h80FsU91VefrI8jtazqrLtheSGO+qZa8ckCgp7mZ4EINa8KYJNtrdM11NweO+s6Ac
 cik=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Jun 2019 22:05:30 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, bvanassche@acm.org, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 5/5] null_blk: create a helper for req completion
Date:   Fri, 28 Jun 2019 22:04:42 -0700
Message-Id: <20190629050442.8459-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190629050442.8459-1-chaitanya.kulkarni@wdc.com>
References: <20190629050442.8459-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch creates a helper function for handling the request
completion in the null_handle_cmd().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 47 +++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 824392681a28..c5343d514c66 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1242,30 +1242,12 @@ static inline void nullb_handle_zoned(struct nullb_cmd *cmd)
 	}
 }
 
-static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
+static inline void nullb_handle_cmd_completion(struct nullb_cmd *cmd)
 {
-	struct nullb_device *dev = cmd->nq->dev;
-	blk_status_t sts;
-	int err = 0;
-
-	sts = null_handle_throttled(cmd);
-	if (sts != BLK_STS_OK)
-		return sts;
-
-	sts = null_handle_badblocks(cmd);
-	if (sts != BLK_STS_OK)
-		goto out;
-
-	err = nullb_handle_memory_backed(cmd);
-	cmd->error = errno_to_blk_status(err);
-
-	if (!cmd->error && dev->zoned)
-		nullb_handle_zoned(cmd);
-out:
 	/* Complete IO by inline, softirq or timer */
-	switch (dev->irqmode) {
+	switch (cmd->nq->dev->irqmode) {
 	case NULL_IRQ_SOFTIRQ:
-		switch (dev->queue_mode)  {
+		switch (cmd->nq->dev->queue_mode)  {
 		case NULL_Q_MQ:
 			blk_mq_complete_request(cmd->rq);
 			break;
@@ -1284,6 +1266,29 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 		null_cmd_end_timer(cmd);
 		break;
 	}
+}
+
+static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
+{
+	struct nullb_device *dev = cmd->nq->dev;
+	blk_status_t sts;
+	int err = 0;
+
+	sts = null_handle_throttled(cmd);
+	if (sts != BLK_STS_OK)
+		return sts;
+
+	sts = null_handle_badblocks(cmd);
+	if (sts != BLK_STS_OK)
+		goto out;
+
+	err = nullb_handle_memory_backed(cmd);
+	cmd->error = errno_to_blk_status(err);
+
+	if (!cmd->error && dev->zoned)
+		nullb_handle_zoned(cmd);
+out:
+	nullb_handle_cmd_completion(cmd);
 	return BLK_STS_OK;
 }
 
-- 
2.21.0

