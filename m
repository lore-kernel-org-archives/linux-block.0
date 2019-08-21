Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD58BC3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5E722D6D
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gctFSIuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfHUGN1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:13:27 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37532 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfHUGN1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 02:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566368006; x=1597904006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=03o5Ng+xLElrc3iL8uEV730C8Y98WKwHciPKKrtiuA0=;
  b=gctFSIuBdMojo9Mt5/Rr+xi1Lu0r7NoBJANKHYDBsmomcaxztlPaXGYq
   2AzWYiukl7fvT1C3VnGN/RskV4fn9fiLebhZpjLlNH63KdpSUWHQPmz2J
   yiqZLJR94Yx2QurlwqzC8ZdUWWAZiKntLyGmSxOjVKw12G37LsjL55ELA
   kUwblmZxKBAcCw3xldLC5/6ZM61UGlBW26Vp8f4Avu8ilgJ0FHzKR21RN
   A+n0r++06jMzqcjZtmHgX3BmkGpmI8NScnehXkj7st8sUwGbGqYQahp8j
   CFvr8yNbAIaNWr+hdSuw404je36iIHrV4RU00PMTYTC9jh5yg1SNLpJB0
   g==;
IronPort-SDR: Qdu6kWfD6AvkRlOLxLBpR8RCcSooKkLAXee0b00MbkGs9iAeWZN2/4EO7xHewFfjpizGLWz7Tz
 LH0cCmIv5SoO65m+P868HXDetbQo1eXA+3gC5H24e0sEZJHKkPIWPA6EpcDJnw8W2U+Tj56Pzq
 hNZRT+vakAgzE0jDMbQI2P9cQYKE6fdtljp6YL2NpgwbhB/gL3sgzbXOQ42NvNNFvw6zwsxNrf
 ki4ivD+gA0SxDZsOfy/tnQlZaG9k3RLgKxnfwQoU9fGLMt1FnuhTVEa34x6negkP7k0/UlMk1m
 Iik=
X-IronPort-AV: E=Sophos;i="5.64,411,1559491200"; 
   d="scan'208";a="117239008"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 14:13:26 +0800
IronPort-SDR: v1yGivytG2wosMqBNaCeYKwH+ldOEASbXnQyR5UD92a7CM3wsJYjkYlGeSHvqPAAZvk2RhGRmV
 pXAT77iNJPbJo6JnDkc+4l2R/cs5MMM7X5XrVp91GzwEIuQFG2IdGXmXHoT59D8q9mUaqw+LNn
 HfPz5262aJWw7FKkVd/jEmFl9cKsejSyry7f2pNVjNuFvBgD7BGCLOKus3XHheGiWC/JyGMcI6
 4oONAKYvePXjdwQ8EOdXBH7GciWbTnbn6Acmp1wCg9W/6WCsJ+8nPCE0L7Efy/KRFZogbaaozj
 2zL29smRKfc9p59kL2jaWCJl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 23:10:47 -0700
IronPort-SDR: hgNCWtTKckibskIcPYYNxXQ3yaKCvMXNvW4Sj9aEGE+eyylBJUQTgZj2Omq1b6PFyXWTcXLVu0
 AjFcwYprJFJjCDC8HltSdmiedeHFRYh8UOcC6UjwUziNO5G6c8pRKjsPpVH4K+Bx52Me7HD/hb
 US/Lnf/ahI9SSxiUkwVozYBoOzQn5EF820nHzYdds6Js9oIZJjYlTsCYf/9z9jjFq2zas6Pcww
 dNooWacDZz6zVD2mw8QZVRP6vNGKzPQhM0D/NAXkDu6Aot+eNvImDDN1y3JUVIflRv6v0J9oFt
 5Io=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Aug 2019 23:13:25 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 1/6] null_blk: move duplicate code to callers
Date:   Tue, 20 Aug 2019 23:13:09 -0700
Message-Id: <20190821061314.3262-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com>
References: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a preparation patch which moves the duplicate code for sectors
and nr_sectors calculations for bio vs request mode into their
respective callers (null_queue_bio(), null_qeueue_req()). Now the core
function only deals with the respective actions and commands instead of
having to calculte the bio vs req operations and different sector
related variables. We also move the flush command handling at the top
which significantly simplifies the rest of the code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 66 +++++++++++------------------------
 1 file changed, 21 insertions(+), 45 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 99c56d72ff78..7277f2db8ec9 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1133,7 +1133,8 @@ static void null_restart_queue_async(struct nullb *nullb)
 		blk_mq_start_stopped_hw_queues(q, true);
 }
 
-static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
+static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
+				    sector_t nr_sectors, enum req_opf op)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	struct nullb *nullb = dev->nullb;
@@ -1156,60 +1157,31 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 		}
 	}
 
+	if (op == REQ_OP_FLUSH) {
+		cmd->error = errno_to_blk_status(null_handle_flush(nullb));
+		goto out;
+	}
 	if (nullb->dev->badblocks.shift != -1) {
 		int bad_sectors;
-		sector_t sector, size, first_bad;
-		bool is_flush = true;
-
-		if (dev->queue_mode == NULL_Q_BIO &&
-				bio_op(cmd->bio) != REQ_OP_FLUSH) {
-			is_flush = false;
-			sector = cmd->bio->bi_iter.bi_sector;
-			size = bio_sectors(cmd->bio);
-		}
-		if (dev->queue_mode != NULL_Q_BIO &&
-				req_op(cmd->rq) != REQ_OP_FLUSH) {
-			is_flush = false;
-			sector = blk_rq_pos(cmd->rq);
-			size = blk_rq_sectors(cmd->rq);
-		}
-		if (!is_flush && badblocks_check(&nullb->dev->badblocks, sector,
-				size, &first_bad, &bad_sectors)) {
+		sector_t first_bad;
+
+		if (badblocks_check(&nullb->dev->badblocks, sector, nr_sectors,
+				&first_bad, &bad_sectors)) {
 			cmd->error = BLK_STS_IOERR;
 			goto out;
 		}
 	}
 
 	if (dev->memory_backed) {
-		if (dev->queue_mode == NULL_Q_BIO) {
-			if (bio_op(cmd->bio) == REQ_OP_FLUSH)
-				err = null_handle_flush(nullb);
-			else
-				err = null_handle_bio(cmd);
-		} else {
-			if (req_op(cmd->rq) == REQ_OP_FLUSH)
-				err = null_handle_flush(nullb);
-			else
-				err = null_handle_rq(cmd);
-		}
+		if (dev->queue_mode == NULL_Q_BIO)
+			err = null_handle_bio(cmd);
+		else
+			err = null_handle_rq(cmd);
 	}
+
 	cmd->error = errno_to_blk_status(err);
 
 	if (!cmd->error && dev->zoned) {
-		sector_t sector;
-		unsigned int nr_sectors;
-		enum req_opf op;
-
-		if (dev->queue_mode == NULL_Q_BIO) {
-			op = bio_op(cmd->bio);
-			sector = cmd->bio->bi_iter.bi_sector;
-			nr_sectors = cmd->bio->bi_iter.bi_size >> 9;
-		} else {
-			op = req_op(cmd->rq);
-			sector = blk_rq_pos(cmd->rq);
-			nr_sectors = blk_rq_sectors(cmd->rq);
-		}
-
 		if (op == REQ_OP_WRITE)
 			null_zone_write(cmd, sector, nr_sectors);
 		else if (op == REQ_OP_ZONE_RESET)
@@ -1282,6 +1254,8 @@ static struct nullb_queue *nullb_to_queue(struct nullb *nullb)
 
 static blk_qc_t null_queue_bio(struct request_queue *q, struct bio *bio)
 {
+	sector_t sector = bio->bi_iter.bi_sector;
+	sector_t nr_sectors = bio_sectors(bio);
 	struct nullb *nullb = q->queuedata;
 	struct nullb_queue *nq = nullb_to_queue(nullb);
 	struct nullb_cmd *cmd;
@@ -1289,7 +1263,7 @@ static blk_qc_t null_queue_bio(struct request_queue *q, struct bio *bio)
 	cmd = alloc_cmd(nq, 1);
 	cmd->bio = bio;
 
-	null_handle_cmd(cmd);
+	null_handle_cmd(cmd, sector, nr_sectors, bio_op(bio));
 	return BLK_QC_T_NONE;
 }
 
@@ -1323,6 +1297,8 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 {
 	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(bd->rq);
 	struct nullb_queue *nq = hctx->driver_data;
+	sector_t nr_sectors = blk_rq_sectors(bd->rq);
+	sector_t sector = blk_rq_pos(bd->rq);
 
 	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
 
@@ -1351,7 +1327,7 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (should_timeout_request(bd->rq))
 		return BLK_STS_OK;
 
-	return null_handle_cmd(cmd);
+	return null_handle_cmd(cmd, sector, nr_sectors, req_op(bd->rq));
 }
 
 static const struct blk_mq_ops null_mq_ops = {
-- 
2.17.0

