Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC268C5517A
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5041720795
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RDl9VBB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgKKNA7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:00:59 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32534 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgKKNA5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 08:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605099657; x=1636635657;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=y0W/n85ooYUiGlOlhPN+jwG9olh1vpEoNQl3W0xc0iA=;
  b=RDl9VBB3yBCh6LCi00JfPJ20fc7SrTfn36VkUBhkabE+30KurUAHXCq0
   oF2sC7sQ8aiFe1M5FtMudffvGp5J6ZLMQVuzTtzaoLLd1X/ctBPss+Byv
   3BukVXe839uXgBqWE9QBv/tq2F7zoQyzLr5F8IRlFHrRcvDnkRPlwu5Rg
   Y66q394VQOfDYKXGr+IRUR8tfd9GKVQ4X9rk0B9kJ5vE6K3IJ5p/TM/ww
   PuQWdVx4vzhFRxTH1gUKONEGAxJlbpLhrWgvtgNocnsZUKYZl6BRynK9r
   wVO2FDiaVlLMR/4QBbiVochNqHaJMoMdb5bBZAjZAqctVJSR+9dxoeL7o
   Q==;
IronPort-SDR: bra0mJxE+ox3192rCRn+vdNh3xVtxiSMGLU0Um0jAndwkeSzvYV7Osp5jQVswGyEeK5kaxBb/O
 xyKHKNWnKMb1+N75K8HS1WVDKf423+2Hg+rjaM+kD2L9RY5PlAAZR+qepO2159TR+o3eSDhbNg
 dwUkwN2OZKrMaKop04vhjDFNEV4gKN+AOvPaP7W7lsVlCusHJ+L7LlDErR10XTskHk6/+kQ1J2
 PScm/mfy7ZNASVZrSQX42h4Lnrf35dgYNMz4jbwzv6LT8Jff+WYwPJ++IgEBH/NSu5/FmsykW2
 VMo=
X-IronPort-AV: E=Sophos;i="5.77,469,1596470400"; 
   d="scan'208";a="152283546"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 21:00:56 +0800
IronPort-SDR: TZ/C9nqtLdhc8yG4jEISrAExmieY6+kdV89PGePzcdMBsEnCkm7a7TSUUn1T4J3TzcZZCB9VX7
 1ny886KTYAeT2adEY+rbWc1RoMRJkRRYT+TU1DuhzGgudQ9tXxUJNwDWgKIZrtZ491vg6Yq+JT
 pck0encuztWFIXviIaSf+K5VCiHUE/TbefQ2YFN7gpbaqJ3yC4NHrENg8rHvcGmM8CXhaKagOp
 Il6MHxogNDstGw0kB5+PZcghrgLzdI8WAFVIXBauFxMkovBMlBee4fv9QMWbtyeJEqq9hgrVko
 uuPjMBJdBhU/fK049mBXvdsj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 04:45:39 -0800
IronPort-SDR: U+RCYwqQU4ZGKqJfswcqrX187A+FXkY1ustA1xnDABmgeIizQSxDAXt6wbTIx6Fky++3hteVKi
 8zEP8+ld0Fql/SLKk+M7i6Fb2Iuz2bOY3S07IayXiC+JAgvikI1Hv+mLM5J7/nIM960RZ4L2OW
 qZKNd3B6PMdU1nOKBMpr2nLVVJyjZfev1gBfZtd3aLD+ZlqrnFsvOsmsYQzbsLigAkrQFhIFF7
 BFdmoMM0fsIxHVdXNl/PDpfstmqbCmzbGn4leUOa81dBFS49NEi2k0wDB8NVPYN+iNBMVTWytH
 v9A=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Nov 2020 05:00:57 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 6/9] null_blk: cleanup discard handling
Date:   Wed, 11 Nov 2020 22:00:46 +0900
Message-Id: <20201111130049.967902-7-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111130049.967902-1-damien.lemoal@wdc.com>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
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
2.26.2

