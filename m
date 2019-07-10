Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BB0C73C69
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 04:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070F620665
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 04:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SdQw4vGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfGJEDd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 00:03:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:6854 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfGJEDd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 00:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562731412; x=1594267412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hUvdRy+/KdHolAGjVHQl4o3RvlK2spNjtcqD7idebbw=;
  b=SdQw4vGsaZImxnfA/nt0cUb7G620uFqo3mIKVkdrdrbmQIsIgVbLWi3R
   RowGgOjIut/8PJtEdL0rl2c6TsC7Qm16Nl5+yd0Ac24KrfcDKrIyn9pWK
   /7GcT/Ryo6WCvT36q/5iFmtAWuhreddE8OLDg9DhsYsxoFuj3v7ZQSlyF
   6gca/Ynow5PDY6BvcHfgFZX1yo/4ddlz2E/9k3R5mGlkOHp/U4CkVu4As
   Wne7WSFdJZCrhybOn8OoFi5zvaVwA0zuZGbf4zYF07a9fqvOhnhueAyav
   GuUbkjsDWRedDbANs8KnRaqYINaQ0xCCqsG7hQ9IhwBuqkgk451zA0/tP
   A==;
IronPort-SDR: rVtriZaRWr7AcZFhVeLyjmW6pEL3zjmDCLFUqMX/5pqcKcywrCZppRhhk4LJlr/gXhmG8ah7SE
 8pnPMJM9uXyfc2eR7HP3BKAmIxaHCUpHDtcCoK2gkWgqdO3HQzDsqcNhDaoNHnjYk/6GvexxJR
 Ghu7TZbV1RJclfUAwsx2k4Io/EoPtqsGs0EQUQgwEuz6L4/Sf+b4tiC+RkIJEnuOjX+AfVUSas
 +nOXHUXdJuczpXWAzSZol3qhqFtIMGZeY0v8lixO+h7fA5NyNHd7UVCLOa2x/BQGtr9QlcD6d6
 U2w=
X-IronPort-AV: E=Sophos;i="5.63,473,1557158400"; 
   d="scan'208";a="113789921"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 12:03:24 +0800
IronPort-SDR: EXT0oIBJaRutpLrCIxi+g103xrphUpEdZ45o8FmA0olTaIcGQgfrZl9FUDN+JpRHBwgU8AhHZm
 KJiEGzkk1/oEtPBP+N5TIXTEP4r6OPOO7VQfhXlwOEy1yvV24+3DB2wr81UkwAHXbfkiQCb3/z
 yIcu2l1xaBnudsqGgCbPY36Euyfh+bf7iFu+fkhHJT3BvlHxpMewV1s4HCZEDWxszv9kHgrpm4
 wucjnWCAMDatYSx6IvRB8Yb2cL2MjvzPEMNAK4uhlJVRptDufmjt9befC/WJu8Fx+3tXea3+4q
 hZaOps0xz43xO6RASHluAI+o
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 09 Jul 2019 21:02:10 -0700
IronPort-SDR: volrXMRRY8gj8n1c+OXTreexEVpouxkjb2vHjRY6IrHYuTBvHBkhLQVnWbPbjGUYqViubIBM4g
 UH1PyCU8fNHGADCiNzBckw/f2wNPwux8NLvfQ3fW0ekzs5nCYqQ78Pst74xeDfXSwI5dxI89dn
 yDA7Z0CCSxd/HU0c7HiSPY85Wlx+FCNi6RmzaOIpr/l5Jwrne9MDACM+lLE5FZrA4wSapYiwCd
 NC/SjuhtJDmWhZPxWUxbqjMZIcbCkoHyzuFGxIm+VXQaMWq357PcpEpYgimZ4gQ6rNQvQ3OecY
 hd4=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 21:03:24 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, axboe@kernel.dk,
        hch@lst.de
Subject: [PATCH 3/3] block: set ioprio for write-zeroes, discard etc
Date:   Tue,  9 Jul 2019 21:02:24 -0700
Message-Id: <20190710040224.12342-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190710040224.12342-1-chaitanya.kulkarni@wdc.com>
References: <20190710040224.12342-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set the current process's iopriority for discard, write-zeroes and
write-same operations.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-lib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 5f2c429d4378..efc9a1bf5262 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -7,6 +7,7 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/scatterlist.h>
+#include <linux/ioprio.h>
 
 #include "blk.h"
 
@@ -64,6 +65,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
 		bio_set_op_attrs(bio, op, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		bio->bi_iter.bi_size = req_sects << 9;
 		sector += req_sects;
@@ -162,6 +164,7 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		bio->bi_io_vec->bv_offset = 0;
 		bio->bi_io_vec->bv_len = bdev_logical_block_size(bdev);
 		bio_set_op_attrs(bio, REQ_OP_WRITE_SAME, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		if (nr_sects > max_write_same_sectors) {
 			bio->bi_iter.bi_size = max_write_same_sectors << 9;
@@ -234,6 +237,8 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
 		bio->bi_opf = REQ_OP_WRITE_ZEROES;
+		bio_set_prio(bio, get_current_ioprio());
+
 		if (flags & BLKDEV_ZERO_NOUNMAP)
 			bio->bi_opf |= REQ_NOUNMAP;
 
@@ -286,6 +291,7 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		while (nr_sects != 0) {
 			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
-- 
2.17.0

