Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00254C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C504520866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FL8zCZDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfEAE3P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:29:15 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:63878 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfEAE3P (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685027; x=1588221027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mQB58nts35Ww5eOF0dlJ1jSMf+R7PvSJPJcn6K0Evds=;
  b=FL8zCZDj9KzN/wgap/vrtO293/tSQorLZu6gXPvaJ/8aqUomBsCTBv/C
   RdUNJprATxVStro7g2ty8+YRIm5oKdHbeKQ/CEei1m6vJL9Iim+E63Fzm
   /8Ml2zTFb35VByPFuBHHo7oFw4b6ZqDhLyPr8Nc703B7SUjTq5iwgq8V/
   Gar207QLORENdI7UiuExgpRnDlVgGg2kPxn44/ZfWetUTeoeo1C6CL528
   929GpzzfwidCVPQUMpXYVnR3aDBp5O3bv8NzNOurK1VCD3ALYjaqu1//t
   KkjSZSuCrNZ/MM3YPkJTn5gr1leUppKg7AMDx5MICjH+yntTKNJNW/V7T
   g==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="206432285"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:30:27 +0800
IronPort-SDR: A47iitbTLO21VQAMcFejlEFl3Mc/B+f8Y2JaDu4RtG9UGu1H3akUSxsJKzmwYLmXi7zDJnlFdP
 ht2QenrcdHji6HsouFZ4KqXLvCZYgpzlR9RXgRojCyJ7wCDFBSghyIClbYvnQtc1ViHeoWFJp1
 UDC9lxI03E4sVCwhfdbPWCqPoG/SgEDLZyvEiHHOufwAn2Sb9PuA0GjtaADk7ZKcsteSxkvzIr
 Wrn+Kp+UnDZss+0RIh222Gg3W3x9e5crB91Z799vHK+vC3KDJwhVAVTfFWnlMm0MSaTstMt/eP
 PHlpiJMsvaX13AGbXJGwFbZ5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:07:43 -0700
IronPort-SDR: xyaV8pkaehT5joxWG6LIMvdqJZLcEqW9cQMbNzrWxSOPQTU28heQMnBKqsiG+588qk1fk0Tgbi
 N3utiF6KIkJVg3vwIbvZPzuJP36/53OTC+l1aKHVJ5XsnTIs4x0SUU29myO4Gub5dXBNFpX/qz
 YUdwbkJOqyHuFHnFRHvLItf9SYZMnvg8JE9K2LElJp/gQ9zcnX7WX2Iew+gK6i2/FYYQrjtYec
 fGUT+0RaGiUOQ3Jr1oQW3TPB5qwwtkEYUkfM0HyHnwaejO6qcsVqt6Vs67xb30pF1bbL0O527p
 rl8=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:29:15 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 10/18] block: set ioprio for write-zeroes, discard etc
Date:   Tue, 30 Apr 2019 21:28:23 -0700
Message-Id: <20190501042831.5313-11-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This change is required so that using tools like blkdisacrd we can
track the priority with blktrace newly added blktrace extension along
with the new operations like write-zeroes.

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
2.19.1

