Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DEBC74260
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD51A20872
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b/h00G9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfGKRyd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:54:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53301 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfGKRyd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 13:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562867769; x=1594403769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=xrgkkYLUKVLCTDTwKNTbpRzC6EwM3DU/hQAYgk+n1J4=;
  b=b/h00G9VFgadBFb3R0HtLu4bdwzuqLHYg5gO0cY7dG1fs89vlgwgq2UB
   XjhfvoPCVu/7MaZ0ARNlPqmJL6uE9mMs4hy/KSBtQbgmxLf7HJm6GjpY0
   EG/XBOrEVoFZl5NP7YXkjVw19GQ9gHdirip+t7Gu4uRed1Y4QTb9GsOAQ
   lWmz/kDwNMhy0ojAc+7XdWP61x/OTCJZMFmQU7GFauGaKvNKfanq75Eqs
   9wJIIKIvRY0VPpPAvkkEjNLKvhA42xsnuFYLJ2RbETACw3s2P4fR4dgS5
   NwFwLuheCoR+tUtE8jUprGi/HEr5wTjW16pJHLj4SOY101bYSoOrSeSkU
   A==;
IronPort-SDR: 8UI4XCNqD9v63f13FewAF6ggrfUnMraGPoqBJdj8qASaCsX/4M2126U64/yJm3cZbGYE2GJdQD
 pgXB1DY1obkEExZBmoZXCGk+dQvYl8t+H0Rv6juVCSnnhsR7Un8lXXyJnHRNJ76bi4tjWpmKbQ
 6EspIkJsN2m55WbVae7Ff6+hmNVHdu/6HOSOHcWGnAAw4ek+cGv4zJs5F4TCvlbHPN3U0e8vCs
 QVGATNpzmYiVcadTpV2Y9j+B4QT/MOI5S7un03KfNNkL8f/rrsR8/DouL/My7anfcGrJA5GZhM
 5Ek=
X-IronPort-AV: E=Sophos;i="5.63,479,1557158400"; 
   d="scan'208";a="212743446"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 01:56:08 +0800
IronPort-SDR: bqeYdJIeJe9ZgszCaudr6HdozAFlzgdjghmEBuST0K33X3AaiaAUaNAzc+0+PcQYM81EmRy3Ar
 bS0EkjaTsJW8/FJjq413SiMXDZURVi/7p7ERN4WqFyOQDj4AbCFqS4ESIT8LQTN6LnGSOGEIET
 YvSkG5tvaVJMm3nOGQSTdxI7qVcieeyG7jZN010+kkoLDaRsd/wbJMAbxopU4APoVGGgDbRm7v
 582jz5bs9fCSagqRQekyOw8zHwsvSA4Bzpf4s+/a8Rzx2ww8UQZQI7g7zLhbU/76LLDnnoun61
 7Jir6WPZ3fwc/iwsaBXhp/MP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 11 Jul 2019 10:53:16 -0700
IronPort-SDR: cJND6v91UWnie+1rKxNkYwLBmGccRkTfU9LuMWxTzQ/c/1pPRT+IZmjRjHO5VONEsGmS+cB4ib
 MxKtYXcypQMUvk0tioeh9zDWD1eBM3xYE+Blzhy+rs1+tQllMJSJc2XBiT3NYRtYQoZ/eMa/5T
 56rhGJRtXsxs0hQ7ux9oQK6WGzRkehFwQw/Cgy9f8CPUWQ26fDFQnFXRmIWuGMWH4y7NB0xIWc
 NNcpjahytKaMb3iMkRTey73at2LbpgBTRjuWUy8tD1u98C4JR7TuOV1E5H6QWPDUXgPguQCd+j
 kN8=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jul 2019 10:54:32 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 6/8] null_blk: allow memory-backed write-zeroes-bio
Date:   Thu, 11 Jul 2019 10:53:26 -0700
Message-Id: <20190711175328.16430-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
References: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds support for memory backed REQ_OP_WRITE_ZEROES
operations for the null_blk bio mode.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index d463bde001b6..30cb90553167 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1147,6 +1147,7 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 
 static int null_handle_bio(struct nullb_cmd *cmd)
 {
+	unsigned int blk_bio_bytes = bio_sectors(cmd->bio) << SECTOR_SHIFT;
 	struct bio *bio = cmd->bio;
 	struct nullb *nullb = cmd->nq->dev->nullb;
 	int err;
@@ -1157,10 +1158,15 @@ static int null_handle_bio(struct nullb_cmd *cmd)
 
 	sector = bio->bi_iter.bi_sector;
 
-	if (bio_op(bio) == REQ_OP_DISCARD) {
-		null_handle_discard(nullb, sector,
-			bio_sectors(bio) << SECTOR_SHIFT);
+	switch (bio_op(bio)) {
+	case REQ_OP_DISCARD:
+		null_handle_discard(nullb, sector, blk_bio_bytes);
+		return 0;
+	case REQ_OP_WRITE_ZEROES:
+		null_handle_write_zeroes(nullb, sector, blk_bio_bytes);
 		return 0;
+	default:
+		break;
 	}
 
 	spin_lock_irq(&nullb->lock);
-- 
2.17.0

