Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B83C6379D
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD02A22256
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HowkZDg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgKTBzr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 20:55:47 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6558 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgKTBzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 20:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605837345; x=1637373345;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=VoDPqaAXpKnS5gRKKkrEI3GWtUDbZPmg3D2/N/jmIIM=;
  b=HowkZDg6g2QFdsW3rw5vYIzDXA/gefg80FDXvSWAHge026lt5ZpUJeLT
   t9azM9gisPfbnQ5Pzxs90k/5bgQljvHTI4ZdiJEOxA2WxprIeJokORIrt
   C4E4SvCiMBFm1pYvI/GyzEXeazg2NEkJvXhpPV87MCL9qIpL6TKHz+akB
   7QiHe/Xudy/xprwMNIJMPukQvZmftQg4ygCbx8ml8FTuJb/1lPOYkHPYQ
   0eQDe1iCWEH8V5AIVpxvFvAZM6am+MQu0m6ahESWtbO0t+DfPgrhEjzN5
   TRsJGQPVu7N1CmXsFmXpOV5WIzWJD8GJnW4XtsD1P5VjpZde+WFfMqAtJ
   w==;
IronPort-SDR: hWPdqJTAvX9hqCNcb9iqqgCEscQ98XjiLdLkvxfwN2s7f6JRz8XUttwayLTI++VMk1dJCHN6iG
 R4kDxCcMbDgpdRy51t0E1NpK7svnpZRYEn1P++4ur6KGemGYpvFHBXsHO82YNsOOu2rKdJN2gw
 Wx+y7wp8v5pfwGPpewSn20ZCm2xh2NPJtx6JLfoqkaD7BvA42rhHGV67q4HGHxRhBgRldGBMcX
 ukg3fIiEWh8sexaQF2U6zfKyzwJTZVD/X5kfYwSIFmaoYLQLGHXGxBP9/ioRaItEfTF0gesbQt
 x2M=
X-IronPort-AV: E=Sophos;i="5.78,354,1599494400"; 
   d="scan'208";a="157516406"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2020 09:55:45 +0800
IronPort-SDR: nVzOtdMXOlKpSN+IYIbOPtUXlW+1/FCY1CcyUFR9leXw2hTR7+Zi1PIjznN1vsAPX3FTHagFOk
 tepwtb9VbR580sObtuNgnzt8jWxAaKWnrVaG4vuTefaPNQQZQv/2JKJcBb/6Q+Cd/JLd4SvVJw
 JD5BSRZ3uJhkBvUyrvET7X2QB5as9Vk4EFdZZuNcrkJ2bmtw9BmuCYQMRUfMjRf3Y2uLCjdCMm
 n1mAbh9Ulne29AbwIaxwLpEqdt8VXeYlIKLhZ+CdGRqcHmyNLSQU+POQYVQMtGfcBTJIQa/DAP
 zn7gGT3HrkwGkrr57GYN1THT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 17:41:35 -0800
IronPort-SDR: rPMZOuef99YkOKk0VWpy2+jyAhwXKT9tOank77vQ5CGpG6k6iCfj9l/64rkdKElvO6KGOnk9x5
 mt8bN88ge9ECxL4WyApA682+dVDyCVEswvNZCCJC3UUZ7SOJeg9ZcoDyyNJUTzy3nm3yhEtxu3
 qAVRvCDC78Zosx7gN781dK9VubEEKofc+SpF9wlMQ1zAw68pMIWRayI+4MPvmWJBhoemPVxzs4
 gX2ZUG8QCgpZdngPtFy18CB2TS33m3Mvwr2bD5fE5DOGdBK07HmLhMWKbuMFL6b69zR+fBvHZZ
 XeI=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2020 17:55:45 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 6/9] null_blk: cleanup discard handling
Date:   Fri, 20 Nov 2020 10:55:16 +0900
Message-Id: <20201120015519.276820-7-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201120015519.276820-1-damien.lemoal@wdc.com>
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

null_handle_discard() is called from both null_handle_rq() and
null_handle_bio(). As these functions are only passed a nullb_cmd
structure, this forces pointer dereferences to identiify the discard
operation code and to access the sector range to be discarded.
Simplify all this by changing the interface of the functions
null_handle_discard() and null_handle_memory_backed() to pass along
the operation code, operation start sector and number of sectors. With
this change null_handle_discard() can be called directly from
null_handle_memory_backed().

Also add a message warning that the discard configuration attribute has
no effect when memory backing is disabled.

No functional change is introduced by this patch.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/null_blk_main.c | 43 ++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 4685ea401d5b..a223bee24e76 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1076,13 +1076,16 @@ static void nullb_fill_pattern(struct nullb *nullb, struct page *page,
 	kunmap_atomic(dst);
 }
 
-static void null_handle_discard(struct nullb *nullb, sector_t sector, size_t n)
+static blk_status_t null_handle_discard(struct nullb_device *dev,
+					sector_t sector, sector_t nr_sectors)
 {
+	struct nullb *nullb = dev->nullb;
+	size_t n = nr_sectors << SECTOR_SHIFT;
 	size_t temp;
 
 	spin_lock_irq(&nullb->lock);
 	while (n > 0) {
-		temp = min_t(size_t, n, nullb->dev->blocksize);
+		temp = min_t(size_t, n, dev->blocksize);
 		null_free_sector(nullb, sector, false);
 		if (null_cache_active(nullb))
 			null_free_sector(nullb, sector, true);
@@ -1090,6 +1093,8 @@ static void null_handle_discard(struct nullb *nullb, sector_t sector, size_t n)
 		n -= temp;
 	}
 	spin_unlock_irq(&nullb->lock);
+
+	return BLK_STS_OK;
 }
 
 static int null_handle_flush(struct nullb *nullb)
@@ -1149,17 +1154,10 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 	struct nullb *nullb = cmd->nq->dev->nullb;
 	int err;
 	unsigned int len;
-	sector_t sector;
+	sector_t sector = blk_rq_pos(rq);
 	struct req_iterator iter;
 	struct bio_vec bvec;
 
-	sector = blk_rq_pos(rq);
-
-	if (req_op(rq) == REQ_OP_DISCARD) {
-		null_handle_discard(nullb, sector, blk_rq_bytes(rq));
-		return 0;
-	}
-
 	spin_lock_irq(&nullb->lock);
 	rq_for_each_segment(bvec, rq, iter) {
 		len = bvec.bv_len;
@@ -1183,18 +1181,10 @@ static int null_handle_bio(struct nullb_cmd *cmd)
 	struct nullb *nullb = cmd->nq->dev->nullb;
 	int err;
 	unsigned int len;
-	sector_t sector;
+	sector_t sector = bio->bi_iter.bi_sector;
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 
-	sector = bio->bi_iter.bi_sector;
-
-	if (bio_op(bio) == REQ_OP_DISCARD) {
-		null_handle_discard(nullb, sector,
-			bio_sectors(bio) << SECTOR_SHIFT);
-		return 0;
-	}
-
 	spin_lock_irq(&nullb->lock);
 	bio_for_each_segment(bvec, bio, iter) {
 		len = bvec.bv_len;
@@ -1263,11 +1253,16 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
 }
 
 static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
-						     enum req_opf op)
+						     enum req_opf op,
+						     sector_t sector,
+						     sector_t nr_sectors)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	int err;
 
+	if (op == REQ_OP_DISCARD)
+		return null_handle_discard(dev, sector, nr_sectors);
+
 	if (dev->queue_mode == NULL_Q_BIO)
 		err = null_handle_bio(cmd);
 	else
@@ -1343,7 +1338,7 @@ blk_status_t null_process_cmd(struct nullb_cmd *cmd,
 	}
 
 	if (dev->memory_backed)
-		return null_handle_memory_backed(cmd, op);
+		return null_handle_memory_backed(cmd, op, sector, nr_sectors);
 
 	return BLK_STS_OK;
 }
@@ -1589,6 +1584,12 @@ static void null_config_discard(struct nullb *nullb)
 	if (nullb->dev->discard == false)
 		return;
 
+	if (!nullb->dev->memory_backed) {
+		nullb->dev->discard = false;
+		pr_info("discard option is ignored without memory backing\n");
+		return;
+	}
+
 	if (nullb->dev->zoned) {
 		nullb->dev->discard = false;
 		pr_info("discard option is ignored in zoned mode\n");
-- 
2.28.0

