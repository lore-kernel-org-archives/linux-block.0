Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69443C56202
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEFC20729
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mD+3udUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgKKFQ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 00:16:57 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43941 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgKKFQ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 00:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605071815; x=1636607815;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=rHpbzx20o9PwMzL7RFD80zQCgVYK7sbQTqbaYUE8Lvo=;
  b=mD+3udURCrYcBpozNWUmRh3liXOkkoXcgWO1c3C5yF57rgCbLhhBP0u8
   o+anivZ5REAVz185WvuGQ3Z1J2KrH+4S2JAvVToUFyVON+dXFeL18kSRX
   2VDzWjgpxZfNfgFngWDgcBUhFslnj/3AZWE6g4GFNc5dd932PA7RfUn73
   IF4+Wdj5oIRF5ZpShsyJjiDtz9ue6EB2HypJSxsy5/NQ00/QZsQ5VkE+t
   RwmyFu0nBWgwhpaL+IgYsO6uy795eYpnMekIiaSOygVuh8LaBzihIDf3G
   OwUuzHPM1bcC9yat/vNQ6rnceC1BTaia67MI4HwtKs8yeex/ThVLrbl1G
   A==;
IronPort-SDR: wSFO5Z2uUgwW6wfYfiW0isTZsEfnMe0ZwKUaXv8rBwgT4DqvJE8c7SzOa4UIio9BzQ+v12BNjE
 74GpHJrQ5hK3bWit+kmBGJjdoeH3RFVr6VNNvJIlgxF3YpujG3UlIpx+88HnTij7each00UCWy
 4xCuweyM/G7I4PIlX8iz1aRrm/O9Y5b7TtfZJXXORZqsdsh2sVPKRpWYqkvbdwkA+lzge5LTYE
 NkOWb7O2F9za2iVtAOG9o3gwtbNYOjEXoN6fO9fpYc6g7mM2NX8VT677alo0OYWK8FewjMpNwJ
 1k8=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="152254641"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 13:16:55 +0800
IronPort-SDR: 1xFLGTbg0oLre+v24dwdoh6KgnMRAGDGcjJPIXDhOkpHgo3+3gW3KMnOM32X9fKKkCS6NcnJqe
 b1NxxMfMV/f0TojKuFqMYJEh3ovUCJSOeLDwOFHQjU6PQHOZHotHKBbZR4p8Aehg/f7dpS6nTF
 lh87FyCg3PwOt71Bc9HaGcjKttbMQf1Vz2Mitop0RYAcc1GLK6Ows7YexGZvf0ab3QnQSjHf02
 Wt7U62GVkUH7kkW3CYqo/hnOcT6aZxKYVjQW/1zrPIy5D+Z2OZS6s8VHR/AIIvuwt4Uoe4SoiJ
 AN0djRdx7qAlhl8ovLWJ2gI9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:01:42 -0800
IronPort-SDR: k24SH/hhWnJvTLGsPdSxfqD2HL41utss07/JXqG3eftTQsK0+ZsRZ2cy9pvmci9vZKHnt1nkst
 WyMEJCiTYEbNa+n1PXIEEJK3ovdSDtQlOMN4oCi06ZQYun6mTK2UHtr0LtM89SPPbXS6upotxm
 2e4L/ljCMuHTfnY3OFDSeyaBh6MjOX9cGdYsOUGAFS4OUWjJb3kDuwAYCEosYt6BtiGUQYYKgy
 FtOJnzLy/WLTBuqp6DpaFSrigz8SVef34EBd5qrxBOqUJiRD1cD5aof6O/lk8RVz6CS9rfgivs
 kEA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Nov 2020 21:16:55 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 6/9] null_blk: cleanup discard handling
Date:   Wed, 11 Nov 2020 14:16:45 +0900
Message-Id: <20201111051648.635300-7-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111051648.635300-1-damien.lemoal@wdc.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
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
---
 drivers/block/null_blk_main.c | 43 ++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index b77a506a4ae4..06b909fd230b 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1076,13 +1076,16 @@ static void nullb_fill_pattern(struct nullb *nullb, struct page *page,
 	kunmap_atomic(dst);
 }
 
-static void null_handle_discard(struct nullb *nullb, sector_t sector, size_t n)
+static void null_handle_discard(struct nullb_device *dev, sector_t sector,
+				sector_t nr_sectors)
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
@@ -1149,17 +1152,10 @@ static int null_handle_rq(struct nullb_cmd *cmd)
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
@@ -1183,18 +1179,10 @@ static int null_handle_bio(struct nullb_cmd *cmd)
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
@@ -1263,11 +1251,18 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
 }
 
 static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
-						     enum req_opf op)
+						enum req_opf op, sector_t sector,
+						sector_t nr_sectors)
+
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	int err;
 
+	if (op == REQ_OP_DISCARD) {
+		null_handle_discard(dev, sector, nr_sectors);
+		return 0;
+	}
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

