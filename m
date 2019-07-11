Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED32C73C66
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E310E20872
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZzgE0Viv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfGKRyX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:54:23 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:7675 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfGKRyX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 13:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562867663; x=1594403663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CIKc2ffzqxk1B3QyfyXivrlbpoHofAyOZKZuuaTh18Y=;
  b=ZzgE0VivG0mFfY98t2VMJeqxWXgAMTjvhlipy9M+GTGR0jRZLtnCSs9G
   HSvuaFUFviNor4ZLozlpCIvRSA7hBnhL67mpfNv/gjEKqd+2kogmRJvQU
   ksS3XfOF0BG4eeP+4S97JubvcLof1fIaHFe5SxK7Em+fXx5Kh3PxdPJpa
   et6xxMDR3ZAmQ4c+FqYGlRWlbZHA0mYmfmzTqz3Wm02Q8x7lvEmD/1bBr
   5zoiM5yooRGlGVCZuUi3fVmTdZSZfTxBayuoBSozw/Wv7Eb2DSuDGWRJC
   hQq11Xb8bxiaMSwMYGkSS2GoL/huL+u/8yemJ7mh1e1p00qfuZL4DRkrm
   Q==;
IronPort-SDR: Y+rDzfdVVBbce0G86bsT1XOXxDIZzj10aQT2UsAO45B3QESpHJNUAynTlK/6tXI6231SU2O4tP
 +/091cV9Ta52oRMB2nLpT0v6ARIvyKKatQv1TyAU18DC4wCk1JUk2ZIXUA9vU5My9bFMhV25+l
 a9wZqvp7BFWx8EnP1QPL12BDNvFHENXntOhk86nbal2Bf/EHsYaa5kdeEaKEH4txOmdJkhWeVB
 Ebj2gHzO1pw8l7Ghoes3xqNBzcvwAkTEC04HlQBv2Yrg4haJkzaasz/jp7EBQxAwoVaDvucX7u
 2vU=
X-IronPort-AV: E=Sophos;i="5.63,479,1557158400"; 
   d="scan'208";a="114423678"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 01:54:14 +0800
IronPort-SDR: eQ+mpAw+y2PboymEwHi1d/sz5TopFcK7Kh3hIcEI0eRvwosfQcd5vjw6YoZcaplwhsGN2pMfhg
 SN6Kw6OVaboLYpIiHZ6xLlhV905RYreIp0uvzcrsIbc6LIuR0bHP+oiauH23XynrxMjSJje16H
 HNQBtpHqrxvv7W9zKxkf7tNbs3DhSkfxzhautsH8lf/IngnYPdYczvAkxxrAKa7LREKt2jmMaR
 ZBLktbYLv5ruymI78lPA2DJNpJlYYPLBnunabWJ00ygtJY5N3VdhCG64JWruegteTEpd5344C4
 XErco5ZFux1ypYdYPPdYMmgO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 11 Jul 2019 10:52:50 -0700
IronPort-SDR: ITcnQBtzrTT44VN/lJbo7dRq75Dy7pBGT9GN1Tm9SOjbgbQ2NvB7UPpyGHK7fSB5iQbBDwn/V1
 h65WJfaukkC4GCxOS+XzafuykYAKt4lUDYVVDj28INpYuVj6Lr6wqoWNrhEVfc29xeb+QYqgk7
 nJzMYTgH4RZHc2btzUtnUx07l2nXNkDCQFqE3lEH07iC8Wpu4WCPSUnYj7kAnBnHCwGH/SJWrm
 BngGlElbP/0lF7e10L5Uav+Ix5c2ekS7UqU90cqQkPuDIl2hN4J/LRVmoavFLnBGKl2EQicJmJ
 nqY=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jul 2019 10:54:13 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 4/8] null_blk: allow memory-backed write-zeroes-req
Date:   Thu, 11 Jul 2019 10:53:24 -0700
Message-Id: <20190711175328.16430-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
References: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds support for memory backed REQ_OP_WRITE_ZEROES
operations for the null_blk request mode. We introduce two new
functions where we zeroout the sector(s) using memset which are part
of the payloadless write-zeroes request.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 45 ++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 65da7c2d93b9..fca011a05277 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -725,6 +725,24 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
 	}
 }
 
+static void null_zero_sector(struct nullb_device *d, sector_t sect,
+			     sector_t nr_sects, bool cache)
+{
+	struct radix_tree_root *root = cache ? &d->cache : &d->data;
+	struct nullb_page *t_page;
+	unsigned int offset;
+	void *dest;
+
+	t_page = radix_tree_lookup(root, sect >> PAGE_SECTORS_SHIFT);
+	if (!t_page)
+		return;
+
+	offset = (sect & SECTOR_MASK) << SECTOR_SHIFT;
+	dest = kmap_atomic(t_page->page);
+	memset(dest + offset, 0, SECTOR_SIZE * nr_sects);
+	kunmap_atomic(dest);
+}
+
 static struct nullb_page *null_radix_tree_insert(struct nullb *nullb, u64 idx,
 	struct nullb_page *t_page, bool is_cache)
 {
@@ -1026,6 +1044,25 @@ static void null_handle_discard(struct nullb *nullb, sector_t sector, size_t n)
 	spin_unlock_irq(&nullb->lock);
 }
 
+static void null_handle_write_zeroes(struct nullb *nullb, sector_t sector,
+				     unsigned int bytes_left)
+{
+	sector_t nr_sectors;
+	size_t curr_bytes;
+
+	spin_lock_irq(&nullb->lock);
+	while (bytes_left > 0) {
+		curr_bytes = min_t(size_t, bytes_left, nullb->dev->blocksize);
+		nr_sectors = curr_bytes >> SECTOR_SHIFT;
+		null_zero_sector(nullb->dev, sector, nr_sectors, false);
+		if (null_cache_active(nullb))
+			null_zero_sector(nullb->dev, sector, nr_sectors, true);
+		sector += nr_sectors;
+		bytes_left -= curr_bytes;
+	}
+	spin_unlock_irq(&nullb->lock);
+}
+
 static int null_handle_flush(struct nullb *nullb)
 {
 	int err;
@@ -1075,9 +1112,15 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 
 	sector = blk_rq_pos(rq);
 
-	if (req_op(rq) == REQ_OP_DISCARD) {
+	switch (req_op(rq)) {
+	case REQ_OP_DISCARD:
 		null_handle_discard(nullb, sector, blk_rq_bytes(rq));
 		return 0;
+	case REQ_OP_WRITE_ZEROES:
+		null_handle_write_zeroes(nullb, sector, blk_rq_bytes(rq));
+		return 0;
+	default:
+		break;
 	}
 
 	spin_lock_irq(&nullb->lock);
-- 
2.17.0

