Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFE1C74261
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A344D20872
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Vrqq+ibJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfGKRys (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:54:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:2298 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbfGKRys (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 13:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562867688; x=1594403688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GgnbhpLZF0KyyFkEePLjnFNiF4QdHVem34UKsj46o2o=;
  b=Vrqq+ibJfeqWhCTUYqVlrVSD7zDNRbnHWJomz3ziFfRyegr3kSQ98MQH
   2Wh2TtrEXWm6/maPaW9pMvLO7+qebp5fNtDMc34mMfXYPpd+QZNBzv6xv
   7ITgYK0gGYQGFlc3SuC+6oINBU2WIOZOui+/D7Yh15KcRDZVQETo7dsYU
   7+d57BD58Z/IuXydPEeyseDI/lUU7bqVwITA04hwx8ktE2fq1++tXqdBW
   qD4dmB2UYvC3VbA7eE2g6+1aR/kPRTkmQ4xkrdJmp63E43OYz8Gjfld2K
   qJL6dbOYDK+hPKpQ8a9iMLLaoZalLZOJhruxk9sbLePfqg/J+A4NkBCWC
   g==;
IronPort-SDR: Bm0Xb4TxpoXYS8MDJqwVCWotBkIzB9NxEkgeeLFZHZfp64lxZvn5bKFRUbrtfcufn0p++XTRRt
 8qacjwU0zWVMvY1I3N8ggU2MZ8JehVB+1re+5p74FNBxUMBrrUGQSrcCyh1+74ty4TTXwzJzk4
 8/iMcvLlEGdmBzojtA1GvE4kxIiaK+zlw1KJgtH90FYwwdKfSVWDDRP1CYpniqHBEWHE+/AzSD
 3O2BMBa1An0Ecbvg1Ngplx9P8WNncvYZRkqI+v5pl3W6jCDkqpgxD4nBR3u5NYl31h79fd5rvA
 xIs=
X-IronPort-AV: E=Sophos;i="5.63,479,1557158400"; 
   d="scan'208";a="112812840"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 01:54:47 +0800
IronPort-SDR: z2/kN1NktJ/L2tW3N2hbdc16iXA6w4JhPvS6WqCu6/I5N07RXGWmwTPq/rbfwyi9H7MDSUJgOj
 YBFAoW1E8ViChUfPGWejvGpYpHIRHopFYZMgtNGog6TrYtO2+IXGoAifFAhydMa1td+XNYsH4o
 N9oIdoZWkXQi9D+FjNqCTDgsUn1NsFGJHEgagdesBNF1uu0desA5xJRdyH/PZ9nv86hDBdNq9y
 frLknMiQLlDrIVpbjGV5rUWsBIR04TvlmpNZvbKp9D4hr11s/eavbpyTJMFjd+3kggb2WGn1Qs
 2fmOklpqfvfmgBEAVVZGP8vP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 11 Jul 2019 10:53:24 -0700
IronPort-SDR: wnKYkHcDYSfEPs3mqnQeeOzf+oN3AVGtQEfEVjoIdw17dS+lT/bllDB79bOK9cujx99+OT26RH
 p9ccIHBxW76znIj4d+6yStJ1BKFFtoCMVgJtwGs4ew89pOgaqDt8vOPvSekZrHWZiqrDU4+01N
 vO3mX5HjIAymXV4PW0D/5O24cLQnQhUHhDIcbBkmTyIJ/QMbppDWc52PRIC1Z4pzAza9mVi8u8
 +yhzXqpy2K7FZlhZ6eu8yf88QUEGf4CkDZBZtxATVm18CZahYyHE4PsCCtyAE2uU/W9s0AN9wr
 Ews=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jul 2019 10:54:47 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 8/8] null_blk: adjusts the code with latest changes
Date:   Thu, 11 Jul 2019 10:53:28 -0700
Message-Id: <20190711175328.16430-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
References: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that we have support for more than on special operations
REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES create a helper to isolate the
code common code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 41 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index c734ddaa697f..f59a05bcf56f 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1107,28 +1107,36 @@ static int null_transfer(struct nullb *nullb, struct page *page,
 	return err;
 }
 
+static inline bool null_handle_special_op(struct nullb *nullb, sector_t sector,
+					  unsigned int bytes, enum req_opf op)
+{
+	switch (op) {
+	case REQ_OP_DISCARD:
+		null_handle_discard(nullb, sector, bytes);
+		return true;
+	case REQ_OP_WRITE_ZEROES:
+		null_handle_write_zeroes(nullb, sector, bytes);
+		return true;
+	default:
+		break;
+	}
+	return false;
+}
+
 static int null_handle_rq(struct nullb_cmd *cmd)
 {
 	struct request *rq = cmd->rq;
 	struct nullb *nullb = cmd->nq->dev->nullb;
 	int err;
-	unsigned int len;
+	unsigned int len = blk_rq_bytes(rq);
 	sector_t sector;
 	struct req_iterator iter;
 	struct bio_vec bvec;
 
 	sector = blk_rq_pos(rq);
 
-	switch (req_op(rq)) {
-	case REQ_OP_DISCARD:
-		null_handle_discard(nullb, sector, blk_rq_bytes(rq));
+	if (null_handle_special_op(nullb, sector, len, req_op(rq)))
 		return 0;
-	case REQ_OP_WRITE_ZEROES:
-		null_handle_write_zeroes(nullb, sector, blk_rq_bytes(rq));
-		return 0;
-	default:
-		break;
-	}
 
 	spin_lock_irq(&nullb->lock);
 	rq_for_each_segment(bvec, rq, iter) {
@@ -1149,27 +1157,18 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 
 static int null_handle_bio(struct nullb_cmd *cmd)
 {
-	unsigned int blk_bio_bytes = bio_sectors(cmd->bio) << SECTOR_SHIFT;
+	unsigned int len = bio_sectors(cmd->bio) << SECTOR_SHIFT;
 	struct bio *bio = cmd->bio;
 	struct nullb *nullb = cmd->nq->dev->nullb;
 	int err;
-	unsigned int len;
 	sector_t sector;
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 
 	sector = bio->bi_iter.bi_sector;
 
-	switch (bio_op(bio)) {
-	case REQ_OP_DISCARD:
-		null_handle_discard(nullb, sector, blk_bio_bytes);
+	if (null_handle_special_op(nullb, sector, len, bio_op(bio)))
 		return 0;
-	case REQ_OP_WRITE_ZEROES:
-		null_handle_write_zeroes(nullb, sector, blk_bio_bytes);
-		return 0;
-	default:
-		break;
-	}
 
 	spin_lock_irq(&nullb->lock);
 	bio_for_each_segment(bvec, bio, iter) {
-- 
2.17.0

