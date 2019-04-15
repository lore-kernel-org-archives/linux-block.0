Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8123DC10F0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 05:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507C22077C
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 05:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gDuJ9OM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbfDOF5W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:57:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:5613 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOF5W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 01:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555307843; x=1586843843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z3pmJnVNPpm7Vi7lyJ7ODoQa9EmWnw00Z4B16s/OUF4=;
  b=gDuJ9OM/jubjZpCMUY7Ld5AnLjOPcQBPVXZZ/9XAoHPAzaHao7lqD6T3
   nirX2dXTsSG5wbacumn9ysJFeajMMEgBdYRu1vGCLcVd6XuJ/5naYEA6q
   CrXI67GW/k9InBMBz3rcUr6G8pKnSjR24/dCwGtH2PcQpBPXKz1NHWOnV
   kVEYamjSo3NFxJmYycFgyKRfPnBBfzULkq1wHlMuwVZ8fYwtfo5g4qPKG
   1pITtVNPDtHcQ0UcaWqeowEKuEyW4Oz2C7C8yB5D4ekQFriJOZkPFkouw
   hw1niJBbqEVrMBBahkAujlYFK647hi3fWB0GGTvQTejFooQoOK7KS+Bri
   g==;
X-IronPort-AV: E=Sophos;i="5.60,352,1549900800"; 
   d="scan'208";a="107710666"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2019 13:57:23 +0800
IronPort-SDR: lKqPYoz+NN8WZUt1VS5AGgiozszCf1IZi22ZCAgMl5JeEES6j7axuh5bYIZB9oAOG05rCqvGHp
 yRELk/+2JVadBV3ZOQ8YrjYd8ndsnth9WsM/BtXpf+aGMGBZpaZKVr8o13ynp6UDUAbxMuVA1q
 33ssFOGJNdI0c8EavvSByEpLRP6Cp87Vm4u13HLjb0HFS0b8ehOwMPvy7w/0G6OUMv7c4tsARB
 HT70ljvPp018O6VWBN9BBkc8dOyLdrJZ1aPvf+viWDh8sSy13qTKKz0Lc1dn/azhzhMyhKvh6q
 PaMKNg/tYAD8v6pkIijniErl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 14 Apr 2019 22:34:09 -0700
IronPort-SDR: ZMbPDnYqZsxOJphnSpe3Y6t8UfUPbRyOqAwC31Cu+JCjtaKSIOjgbfucUHLIi8h5OUq2ELU0Gb
 eAtCu2jcnxmjBe2wkUz3cYmoHN7JqGyM+1XFjYY8bzpfRUGWkMs70nJx+Hap9+4ZJvwlQK/HBq
 DNQEZ1NHB5sT7wiS+gIW/k601F3WJxfousTo2r25MercRk4oDWNODHWV2mkLVRzt9sjDqC9+LO
 adG54Zy+oe+cVQ6xla44y1rCpRvQ9FQIMKEViQ2RonBWRowba7gtoQb045BlHuYdb77gZPdiX4
 UtI=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Apr 2019 22:57:22 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/2] block: add task priority to init bio iopriority
Date:   Sun, 14 Apr 2019 22:57:03 -0700
Message-Id: <20190415055703.5512-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190415055703.5512-1-chaitanya.kulkarni@wdc.com>
References: <20190415055703.5512-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This uses the current process's ioprioty and initializes the bios
issued in the discard, write-zeroes and write-same operations.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-lib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 5f2c429d4378..12c340e7637c 100644
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
+		bio_set_prio(bio, get_task_ioprio(current));
 
 		bio->bi_iter.bi_size = req_sects << 9;
 		sector += req_sects;
@@ -162,6 +164,7 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		bio->bi_io_vec->bv_offset = 0;
 		bio->bi_io_vec->bv_len = bdev_logical_block_size(bdev);
 		bio_set_op_attrs(bio, REQ_OP_WRITE_SAME, 0);
+		bio_set_prio(bio, get_task_ioprio(current));
 
 		if (nr_sects > max_write_same_sectors) {
 			bio->bi_iter.bi_size = max_write_same_sectors << 9;
@@ -234,6 +237,8 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
 		bio->bi_opf = REQ_OP_WRITE_ZEROES;
+		bio_set_prio(bio, get_task_ioprio(current));
+
 		if (flags & BLKDEV_ZERO_NOUNMAP)
 			bio->bi_opf |= REQ_NOUNMAP;
 
@@ -286,6 +291,7 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+		bio_set_prio(bio, get_task_ioprio(current));
 
 		while (nr_sects != 0) {
 			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
-- 
2.19.1

