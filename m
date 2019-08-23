Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7494EC3A589
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 04:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ADA23407
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 04:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I1VDUFv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391752AbfHWEpc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 00:45:32 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47588 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389942AbfHWEpc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 00:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566535531; x=1598071531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ueQItnJ2oij3/q1Mp5ESe1w0t5lYJZrEK8sitBs/q1A=;
  b=I1VDUFv+NpDe4rYG3M4X0lb5Jzo/v2mOCYkCmxSIRk2eIoFGoNAXwPji
   oRKVxhVmC7KaA+bDO06NfqyUOrugM7nIGygp+uvyE4ztbaJkWQeBysF1X
   lZe5s/mXx2TYZNXqWi0Cv6tnIXRD3/ZzDy8787cagyWzPZfLYXFmzalre
   29UMhmCHktwZhEHyUapp2sjWntJdgyGac0wGP2udM4fvAF9iCHHOyrSeb
   sX2agbW+ylEEEkvafKALAOXJ/1JFkWswEnLsnGazPv98OP9lt74OmuniQ
   Yi4IAW3Q5Cy9NbUi/MKBazcm2J9LArpPgeNwjFbR3knoYglaj4geJptAv
   A==;
IronPort-SDR: IVYCAo9lHwkYbykqLY9n+N7CNe/WExWlTfDUgpKyW2OoIOg8nNLWKyNxLt+KeLbQbXqMKabosG
 83iLsPIaISUpu4P2NlxQJ6leTq+BMGe8Px4QmOwXwFOMPiUIjw7PuIxqroTKy8wRh6er5HHfEU
 YSG43Atvyfeh6UnwELSkV2VVKCuR9ngPUB2hLzv+MTWd9k+9TSGzeaTo9BFrGkJKsXm1yIV7jp
 +tMguVz5Hd/cDE9xzEEtyuBvKdhbl5Ci2WfQpgzdcoch11mvz+FdvbHQpwd0kJfsBw6s2HXYxu
 UAs=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121078096"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 12:45:31 +0800
IronPort-SDR: ooKwDupKhPPwVbGxgcao+oY5CgRxh8pXZF59Sa+w7Jt4xzIOUtiUHY5Xqou4hPZUkuI5DeFGI8
 0bIMH9tOnkZJPhhgs2jF3m5bwcmFyLIf6DUn8NeRTJgB18qOhum0vSfB7kn3yF3pPHsdRupFKI
 3qgvae9TNqvszmESXF1LtFweF3E/QbX0I4gAIi5u0t7sIhERB1/MNAyxUX3lmOkEUvlKFIgl8w
 bcQ1F9D7GwVJFDYJmCSg0ClSa5vEZ4R2nYsGzcrEgIxYGF1FrU49jRjPt1mVbHLoOH6P7/ZUV1
 p0uDgot9e+0fK6ldY8FcXa/F
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 21:42:49 -0700
IronPort-SDR: iGptXJp9rpd1w9WpNAttO4BQtAAqoUmmex3Xl5UV0mUkNGKzuzDaMdynopeL8WTiocxjKvzetz
 q5g0tH8qFugwevFlMIgsiiqfDwrKqrAcbyi2w9j3VUz73CNxOiNb6PowlDOiFCsPj/MOYYYLFG
 xSVcP3hBr5NTmDnJvNzBhO99rDT/yQkOm004NX62OYjS/UGjNl6a3N0WrEYp58v8/qPjGvd7wX
 wIg8m/tRlLuN5xs+dUZrTyhIMF9CBY065c7soYnB+z0Srru3G+4nYthl3lB4WVC4wUGGobiwVv
 6S8=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Aug 2019 21:45:30 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 1/6] null_blk: move duplicate code to callers
Date:   Thu, 22 Aug 2019 21:45:14 -0700
Message-Id: <20190823044519.3939-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190823044519.3939-1-chaitanya.kulkarni@wdc.com>
References: <20190823044519.3939-1-chaitanya.kulkarni@wdc.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

