Return-Path: <SRS0=Ui87=EP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED169C56201
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 12:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49DC206B6
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 12:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Bh7n/ap6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgKIMvc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:51:32 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43853 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729715AbgKIMvY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 07:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604926283; x=1636462283;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=V53lZ6HRaKMK0GTUP2mNLfYo0n0b5X2xdLQJ2wUFowE=;
  b=Bh7n/ap6PxS/BwSFJDZ7YrLYFZuCAqkfreYMC5G7MZCNk7XyOxou028i
   jkT7hbHXyS/klrFqk7yNWe4pRXM+ZWYZMQEaHtVSA0zFkWhmIofGqZV5D
   IKCS9R2JdheCW5jVl2gi8wBqF6hC3JQfOYcNX6yZLEBPXKc/aa+a7At8m
   IJk365fLDvFfY6yykT/KRlXxzwyeI8YuH6xI/fF3u1UNY37udUvwsvobG
   ctkZcaASh3Vx9gPedkuZSIpiA0KS2eA8A/czCxK5P3fwDVZD94Yb2WIcl
   nDHZqeAjtysuBlLt6KjGZn0tImm91hNOwXOlLyAI+42D6vKbdQr8Kivik
   Q==;
IronPort-SDR: 0ulmYk/JbzyCfOm9+TqNSuC62OVtddv7OvLbFzkdoRItxAfrKAwUeM4zkHyZeAu1p6LVY/9i1Z
 G8ro3IyqDGED4enrrizwrAdDjDYXxpeLQz4Tf301hLO+p0iC3afYN8E50CJtIn3KWvOqqXxf8y
 023lK29onIdJ83djwYx6P5UIEpD3PaI4QPw5puVsc02Z9wMy+E3OtqInDIERNXkDEwZtRGVKvu
 hdw7kN6zMZphsR7+6A/EPSjadDfv4z2tQuVhC6dm4+tyu7ndG6ce/X1jUlmMGhqNbC9bRuKty4
 Rfk=
X-IronPort-AV: E=Sophos;i="5.77,463,1596470400"; 
   d="scan'208";a="156668404"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2020 20:51:11 +0800
IronPort-SDR: eBj2Dh8P4m+wqggWquuhwUokdDIAbOoEKaNoVZnNHL4gT2KlQgvtcGobfyQpuXmrS/BCiWYp2z
 +mnvR/V9BWDRMF3W4hgg8xnTmXgdMyn34OUIrYLgJz1+Ta/NP5NBM9YDTp77kYMHY4d2BPimsU
 LCIBIFA2JXvjLUavdbxr4tZWmkzbSJe7gQDrJC2rSXUIQ8vkFywgZsQU8NBp/XzHYJvUHa0VGi
 +GXMelST56SNg3h5kPCHeyvca+LgT/4NwlYGf9aBBT0wm46Kosv18lm0OzGLQloubjBoPtdMXh
 VdLC22a9GBb54QAi6xs+yyNz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 04:37:14 -0800
IronPort-SDR: UE9cq56IjtAl++0momAxXUK6pfM41ShkffuODmzxT+JT2jJbXXmb2/4zUsFGlKYx0eNqPgpc1V
 SweYEjHRvMUalDWqtcc2cByq0KicR40FE5SHBzUdCH80yNaJZfqEz4JoEk57TsGBWLPQmKlcsn
 Hi7FPmWbz7OX/edwxunwzJAtxvlhLzWSD0lcyi6SwjIO6rIeMr+fA7g2JuHGOXmm4UkySpTLVC
 BMtl/OtEsjI+yctqXqxXBzi/Bw5K173tdVsU+YTa+yHzArF/Xi+PF7Tv8wqoRe+iskpLwjAfTr
 Qgs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 04:51:11 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/6] null_blk: cleanup discard handling
Date:   Mon,  9 Nov 2020 21:51:03 +0900
Message-Id: <20201109125105.551734-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109125105.551734-1-damien.lemoal@wdc.com>
References: <20201109125105.551734-1-damien.lemoal@wdc.com>
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
index 4685ea401d5b..1483413a81da 100644
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

