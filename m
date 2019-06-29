Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D24C4321A
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 05:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98766214AF
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 05:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jw1L3wZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfF2FFG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 01:05:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:28723 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfF2FFG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 01:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561784707; x=1593320707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dKnrLUk0qlsHPa3dAslqUoy6mwhm2PBa8f+jbng9EZ8=;
  b=Jw1L3wZjuhS6wQ/kmczYxwOP5kku+x9TsuJ7De6XbRrENp4OOvDmYZsr
   HOMVvI4KGyLivjQ0wjAvMqac/f6Gu24ogC4qBoL29eFvHV2tQCiyn7q39
   3hQR7QjibU40HhfMOCiNpvziA/c9/votCEoWawSqDl5QiJefWa6O7L+94
   QE4aH9uv6K4/jYTSlWgOmq6S8noWrtiherqv7w2TYfpZMitALyVzX5mjR
   YgO+g1XeUKnst5dBHzojj+QTnJ5LD8WnEZkTDrgmcQA8nYHr5JRULRbWC
   6tUuZCyhjin2o7ftCKT4Mcv6rUKEeS3EShqyOVBwlD90iRzAcQ6BE4Osf
   g==;
X-IronPort-AV: E=Sophos;i="5.63,430,1557158400"; 
   d="scan'208";a="116692880"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2019 13:05:07 +0800
IronPort-SDR: OYJvJPZqEJfaVbA4lHcnucsQ5WuQANUE8Chc4goztG7PYj4OFmSOq8qTPKA5G1x7yrC7qmhETN
 q6akFCMBUM4nR2JTdYdpCzxxbD1bZjDLOVUCu0g4j9JyRK+1RW4yG6fnsSIXlaN0HC57tF34u6
 4OIVj1ORz/56hzeIN0G+Bfg6ccMQlLD9KNXS34fOEhmyGzn6RjJxx5Ku7hJRKUHeFxPwCCt85R
 +B9zGZ8qk1FXzfaBoXTdeBjkN+tlXJaufnUH5ptVKg/G5dAMg5wLPlk2rsola8hN2nqp16waCz
 YYF8++/Peu8R5huOXLzr3xEY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 28 Jun 2019 22:04:17 -0700
IronPort-SDR: /eyZmEKjs/LAwwA9mZMK02+BwAiAMp0qJvCVdStdoyPRVsSL4/5uMccK34llRm1wJGTSLw99kd
 5yQgmoY3k+ZeIjsDbGtFqB308lH9eUXNYQb4u18DyrUFRMxJPKeAfjjcXE2EZAQV6qq2tFMGVI
 y0PuhDBduv1yMjVxkfKclJTwmmSLCKlyjunN3XDHXjxrQfFyY3HVfZOxon8IgqGqlbd26nlWpV
 Kcw/OTUFBaafYVRkJr2GOjxeLsiwtubAexprQJVK4ECjiwV5AbxerD5Y8VlYQ/pCYbl8jyBG+X
 qm8=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Jun 2019 22:05:05 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, bvanassche@acm.org, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/5] null_blk: create a helper for badblocks
Date:   Fri, 28 Jun 2019 22:04:39 -0700
Message-Id: <20190629050442.8459-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190629050442.8459-1-chaitanya.kulkarni@wdc.com>
References: <20190629050442.8459-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch creates a helper for handling badblocks code in the
null_handle_cmd().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 62 ++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 98e2985f57fc..80c30bcf024f 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1158,6 +1158,42 @@ static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
 	return sts;
 }
 
+static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd)
+{
+	struct nullb_device *dev = cmd->nq->dev;
+	struct badblocks *bb = &dev->badblocks;
+	sector_t sector, size, first_bad;
+	blk_status_t sts = BLK_STS_OK;
+	bool is_flush = true;
+	int bad_sectors;
+
+	if (dev->nullb->dev->badblocks.shift == -1)
+		goto out;
+
+	if (dev->queue_mode == NULL_Q_BIO &&
+			bio_op(cmd->bio) != REQ_OP_FLUSH) {
+		is_flush = false;
+		sector = cmd->bio->bi_iter.bi_sector;
+		size = bio_sectors(cmd->bio);
+	}
+	if (dev->queue_mode != NULL_Q_BIO &&
+			req_op(cmd->rq) != REQ_OP_FLUSH) {
+		is_flush = false;
+		sector = blk_rq_pos(cmd->rq);
+		size = blk_rq_sectors(cmd->rq);
+	}
+
+	if (is_flush)
+		goto out;
+
+	if (badblocks_check(bb, sector, size, &first_bad, &bad_sectors)) {
+		cmd->error = BLK_STS_IOERR;
+		sts = BLK_STS_IOERR;
+	}
+out:
+	return sts;
+}
+
 static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 {
 	struct nullb_device *dev = cmd->nq->dev;
@@ -1169,29 +1205,9 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 	if (sts != BLK_STS_OK)
 		return sts;
 
-	if (nullb->dev->badblocks.shift != -1) {
-		int bad_sectors;
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
-			cmd->error = BLK_STS_IOERR;
-			goto out;
-		}
-	}
+	sts = null_handle_badblocks(cmd);
+	if (sts != BLK_STS_OK)
+		goto out;
 
 	if (dev->memory_backed) {
 		if (dev->queue_mode == NULL_Q_BIO) {
-- 
2.21.0

