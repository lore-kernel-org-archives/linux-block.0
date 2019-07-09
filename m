Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50D1C73C53
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 19:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43D02073D
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 19:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g69pc8cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfGITVn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:21:43 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2861 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGITVn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 15:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562700102; x=1594236102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=NDg4Jdfauokh0z2Y50ewAb5U2547jMbyxmfgWJh/EV0=;
  b=g69pc8czJ7vuhULBXRic2eM4qspYOEwB2qzHlSGFeR78iD6LnreNDXV/
   6D/MFL/trpuY/yezWmzU09rbCLs/HZPxF17YMqkLHKoZmXxRaAar5S7+Q
   75/NZ4l6bPG5bTj+q/o9uihPeOWc5aM/Ztr/dD53auu0r386LR4aGuUnQ
   TEuPUqA4UDT1D15keosP803f3MUq8NmWqLwYqZLBmPT0mRyrDHQRS45Ay
   MPGDN9vzDFXe1e4Sj/bDt44qIi+FMjpHiJ3uwbfdCKl/b+xQY+lAWW21Z
   rIXRFVhK1awQzHZGzz/9VAPlFkG4bIJyYxz5apK1p8slPPk4A0vLYVOko
   w==;
IronPort-SDR: kU4dJA6KcZw51Mi2BTue0a/T1QL2qHCWleXsntW+x7vo+sXD5CUpGa+n7X2DicrFnQzKHwRsmR
 Il+DrhT37my5ldX26il/a4gL/4nXOOB7+hApR3qcnExdNlldj0p7mqxxasa+CXQC3lUZR5vDti
 hJr0Dw6nJKKmj7/ZGm38H3dymKht4N2ZKX15v0/Rcb+f+Ukbbtkk6HEF39AIuXBFqqM/9k8Hg/
 t3IGdhm3JDvTvm6a9wmfxvx7+d9NXwwIQrvTIFtSVj+J10ojzEroED0Tjy1am3+kSFh3Rugeav
 d90=
X-IronPort-AV: E=Sophos;i="5.63,471,1557158400"; 
   d="scan'208";a="117396982"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 03:21:42 +0800
IronPort-SDR: sZ8K8jNUySjVAfpkbWS2/Ml0Ivv6uCDMlHNsNgi5KdIpECVda88c4aawxQrrPrXnn0d0HQG9p5
 YzEUFrZKlqckWRlL0GYrRnyL8RxZW/Bw8FBmIzt5IsHOWlk/pSWxfK6MZtutaEH73O/OryMIpL
 jk/v/vcEB0KCCpRN+6ViGcxujJa4DUrMloyziHY1ykBGyMpGYtOdkjvMXZ1oah5fcv4EaSOokK
 RYHIyYTYkNtoaOVsKn/GAhe/Q0ttVdmfMOKvzstGkqMx4EdyWSi41SYO7T1Z9+AcZcsut6ehbO
 EgGP/fXSlsP8+2hbmL/zieG2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 09 Jul 2019 12:20:28 -0700
IronPort-SDR: I2OsZLs1ia12FbJ0Ve5BfBMVoGGxT28o6jWS0ZPWfTGm5FjAd02SlgRtFj99ewSgDtRBwBRw3q
 kz6hU/i8L2IyrpNdqu5UNQaNR7UY+LwlS8owoBP/hsEfiX0zv9Hz8pWN8I2RSbYLj8tgCl2opt
 EYOj/tgBjjoQel62fgd7pcmviat1CicVu2Xprh25d2zwtnh8DdEwb7sj9dcsW0jABdKBiJ2ogT
 wEXV4KYLCP3AGAsqUZ1JceFE8/yqjSb5fvS0cNP8zqydxrAcBHH9h47Zo7hTCRpstXDOpAVz+Y
 XKw=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 12:21:42 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 1/6] null_blk: move duplicate code to callers
Date:   Tue,  9 Jul 2019 12:21:27 -0700
Message-Id: <20190709192132.24723-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190709192132.24723-1-chaitanya.kulkarni@wdc.com>
References: <20190709192132.24723-1-chaitanya.kulkarni@wdc.com>
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
index 99328ded60d1..b3be08edea43 100644
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
@@ -1280,6 +1252,8 @@ static struct nullb_queue *nullb_to_queue(struct nullb *nullb)
 
 static blk_qc_t null_queue_bio(struct request_queue *q, struct bio *bio)
 {
+	sector_t sector = bio->bi_iter.bi_sector;
+	sector_t nr_sectors = bio_sectors(bio);
 	struct nullb *nullb = q->queuedata;
 	struct nullb_queue *nq = nullb_to_queue(nullb);
 	struct nullb_cmd *cmd;
@@ -1287,7 +1261,7 @@ static blk_qc_t null_queue_bio(struct request_queue *q, struct bio *bio)
 	cmd = alloc_cmd(nq, 1);
 	cmd->bio = bio;
 
-	null_handle_cmd(cmd);
+	null_handle_cmd(cmd, sector, nr_sectors, bio_op(bio));
 	return BLK_QC_T_NONE;
 }
 
@@ -1321,6 +1295,8 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 {
 	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(bd->rq);
 	struct nullb_queue *nq = hctx->driver_data;
+	sector_t nr_sectors = blk_rq_sectors(bd->rq);
+	sector_t sector = blk_rq_pos(bd->rq);
 
 	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
 
@@ -1349,7 +1325,7 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (should_timeout_request(bd->rq))
 		return BLK_STS_OK;
 
-	return null_handle_cmd(cmd);
+	return null_handle_cmd(cmd, sector, nr_sectors, req_op(bd->rq));
 }
 
 static const struct blk_mq_ops null_mq_ops = {
-- 
2.17.0

