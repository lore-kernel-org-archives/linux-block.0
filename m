Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCCFC4321A
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 05:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AD9214AF
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 05:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cMR/AXa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfF2FFY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 01:05:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27331 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfF2FFY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 01:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561784723; x=1593320723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tlBpfcAVxnlFlUQlVXVVs5RLfQ4mFtw2mZWOifeqQlA=;
  b=cMR/AXa3mn9Vx6jYRPFO50CQPvd80Iq0xKvFnFhZuGixm/+30mYyv9TZ
   4ZKkRpeQE/w4dbTPMPLXvmPZe66xE9h1KFbyKuY6uPN70+bl37J3frYZN
   rLZ4+psnMuJtKZXu0yHhWskH7a7vW6nkRESsRA9BKepxJuuKquzGTgaxy
   NDC+N64gy7f5YynqZ+9ccXsdloVsHoD4PeQQSPJOI/PRrNWwiWZ6o8RU0
   IS35rm1daGgSUbl8PtKfaSUv5Y+GCgqc+VE4/Fzwxkx5OgDx6wVObfl8n
   PtFJAOdoiYbn+OJcSb+hN/O2HZyf91xazSdMELpzqBHwMb4trGC1V9g8u
   A==;
X-IronPort-AV: E=Sophos;i="5.63,430,1557158400"; 
   d="scan'208";a="111829943"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2019 13:05:23 +0800
IronPort-SDR: AM0tCepizJMI97F5LqtVaQHOrJMvOftxoZxrxmh97/BELkwZRSQP9TjQZeAzZfLnyul5KlEy2+
 wp6eVA+/+13FVitul6qetpdonyfHpKuUBkjRRaM8ATRdF9bT5nqeZshqVIRgJXFgT2fXHrxTwg
 qM3UOAm8pdCf/6hCelg7FzjRriN5KiF9xo+uQd3j2pTPrhGeTsAS9dtprRMzniA5uDtgsP70lP
 mOEVe4EzyIwT41lZ13UVab51eIc4ljnz47zbPwSTin89P81+pixVK+pCBqOXFpqXD5ylvwWi6c
 3VHiYED9lFxGX2FaGxIY83lg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 28 Jun 2019 22:04:27 -0700
IronPort-SDR: R7ahFVZ5knu/3A8Xwx0p7B1Wq9O4XRwNGCrhN7tL8RVkzh32v+rz9HExKtZwsVTROZzQOfh3Jw
 f1zWk4xhAJtvm4XSXKXd8w5VW+9a+sHe1kacqNjRO6YUpUx/166YmMc2B59fLGVVeuPP/xllRz
 JYOlJVofZe8etTZGURfeuXCGIGZHKh+12FtNQGnNeC9RnaWKEBX3rB4cvjFx9+10pgOBem3pud
 U4gd32Gc04EyTxmwCRIaPNpVBn0FwrnQT+wPmBmKks8SMiD8DO4ObVYy9P9yhgVzPg6p2ldQo6
 Yq4=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Jun 2019 22:05:22 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, bvanassche@acm.org, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 4/5] null_blk: create a helper for zoned devices
Date:   Fri, 28 Jun 2019 22:04:41 -0700
Message-Id: <20190629050442.8459-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190629050442.8459-1-chaitanya.kulkarni@wdc.com>
References: <20190629050442.8459-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch creates a helper function for handling zoned block device
operations.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 50 +++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index e75d187c7393..824392681a28 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1214,6 +1214,34 @@ static inline int nullb_handle_memory_backed(struct nullb_cmd *cmd)
 	return null_handle_rq(cmd);
 }
 
+static inline void nullb_handle_zoned(struct nullb_cmd *cmd)
+{
+	unsigned int nr_sectors;
+	sector_t sector;
+	req_opf op;
+
+	if (cmd->nq->dev->queue_mode == NULL_Q_BIO) {
+		op = bio_op(cmd->bio);
+		sector = cmd->bio->bi_iter.bi_sector;
+		nr_sectors = cmd->bio->bi_iter.bi_size >> 9;
+	} else {
+		op = req_op(cmd->rq);
+		sector = blk_rq_pos(cmd->rq);
+		nr_sectors = blk_rq_sectors(cmd->rq);
+	}
+
+	switch ((op)) {
+	case REQ_OP_WRITE:
+		null_zone_write(cmd, sector, nr_sectors);
+		break;
+	case REQ_OP_ZONE_RESET:
+		null_zone_reset(cmd, sector);
+		break;
+	default:
+		break;
+	}
+}
+
 static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 {
 	struct nullb_device *dev = cmd->nq->dev;
@@ -1231,26 +1259,8 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 	err = nullb_handle_memory_backed(cmd);
 	cmd->error = errno_to_blk_status(err);
 
-	if (!cmd->error && dev->zoned) {
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
-		if (op == REQ_OP_WRITE)
-			null_zone_write(cmd, sector, nr_sectors);
-		else if (op == REQ_OP_ZONE_RESET)
-			null_zone_reset(cmd, sector);
-	}
+	if (!cmd->error && dev->zoned)
+		nullb_handle_zoned(cmd);
 out:
 	/* Complete IO by inline, softirq or timer */
 	switch (dev->irqmode) {
-- 
2.21.0

