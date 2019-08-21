Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7462C3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD92F233A1
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L9thsney"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfHUGMQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:12:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46795 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfHUGMP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 02:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566367935; x=1597903935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+CgoZ/ocgNTcJulImr9CQRjUBIQXXYEnN/SGKq6sN0A=;
  b=L9thsneyQ2NpAkJntZxSiAV/KsaUZfENhWaO9UHIu4JKTaad33SFi4/W
   A5iIs0aWZ2f66CzHUqITZRnLiHt0Cf17CMmmcLKMWeLNsqe/Kk0t6/5jI
   cu8MaxRC46J5g9pAAVT4Q5VjW8cEepaOf4EGj1rItF0sHjHg+GxEC5jXf
   qh3l+NnUWsmaiHnWH9WZIfBgIs2zErPe2ph9hYh/U4+bmQJOUpUvMPzok
   O/psDPavD+S4YGzGMC9WqgLWz0fuhQqJT7gRDqPY6STfQyNLbHlKy/IJ+
   5I8EMyK3mEmzYTTbzf1wuTqstzDBpJfVs/zg57wKNUcy5pQaxbXXLasqt
   A==;
IronPort-SDR: idT4I6Fc0qhb3Ee8FQ+uQIvGfwUeyKb8oTQB0sGxIeZodY0Dbjo9pRiV4+D9y7dt6Hd5QQrF/C
 3PWuw1nLiIQ6bBRy+PMTnElm3wgZgo+CXdjxPXeUhXQmtqachZhN44g70XhPWYU5c6eXsmoCFd
 i0Y001g+7ZEfu65r0kb6q6XGU5mpK6EgLbyJM8p7qaME552qJWaDM32elJdBV5K8iCGF7xtuPG
 SNfzx63URsX3X4T6h/rbptyHvd7u7XT1vReVmTRxvattrYGYvkLA1NfiREhNopQ73scexS7UFH
 rKQ=
X-IronPort-AV: E=Sophos;i="5.64,411,1559491200"; 
   d="scan'208";a="222880652"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 14:12:15 +0800
IronPort-SDR: SEILRXt/SrKK9cVWnBLZ5+A6JeNZXHsWF/BPEw4LmzGGuta5NlB+FU/ObDM6m98FE6fxaDPnBY
 veszYp8Oj5Wp/kkF47lO/Irprx70hOf2umM5ysuHrUOLvrZxh6CEwg6x/undDjXioT7Yh+8ZE9
 oiDn0bGyW4Vz5oKuEX7ovQWJVSfdWfMKRw5SZyHhOXq7sESoJ0fruj1IGuNIGe9K/dSNDSdx2h
 6Mpp9xMtEt2J0aPwulNpNl0RrSnAjYhUewbzDMHmRWVdIy9AzmvX4Ct+cSgCN7g0Sh8OpXSEpF
 ASnGsBz/Rfvk/6XVn0sXdggJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 23:09:36 -0700
IronPort-SDR: sf7UIrSw9Rwk5i9k5zjrBIF8/J99H8bua9MgofLvz7gP8vI6jev9ZrbFxENI6ilJJrVy2+8phw
 ZhdwDObYg43YZ8AALd1vaSgZiClBAB1+uprCkj77f+dCa1Cd8PSBaEITkhEV+h+SHRhnmsK3Jn
 oWeGaexsKRK6qECNtc38lqdOlHPe9QIrKSHcMSc9Rm5EwaxsGdk3Hdle5Ybwp5Mvl9X1BeNZBo
 VD4fvhALty0ykjJbHvr0pRRIBC297CtsIhNepap0S6t5U1wiKEzFXx+kHx/N/xcLiAvW0bKgHP
 KU4=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Aug 2019 23:12:15 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 3/3] block: set ioprio for discard, write-zeroes etc
Date:   Tue, 20 Aug 2019 23:11:56 -0700
Message-Id: <20190821061156.3127-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190821061156.3127-1-chaitanya.kulkarni@wdc.com>
References: <20190821061156.3127-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set the current process's iopriority for discard.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 5f2c429d4378..500a857e5d9f 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -64,6 +64,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
 		bio_set_op_attrs(bio, op, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		bio->bi_iter.bi_size = req_sects << 9;
 		sector += req_sects;
@@ -162,6 +163,7 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		bio->bi_io_vec->bv_offset = 0;
 		bio->bi_io_vec->bv_len = bdev_logical_block_size(bdev);
 		bio_set_op_attrs(bio, REQ_OP_WRITE_SAME, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		if (nr_sects > max_write_same_sectors) {
 			bio->bi_iter.bi_size = max_write_same_sectors << 9;
@@ -234,6 +236,7 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
 		bio->bi_opf = REQ_OP_WRITE_ZEROES;
+		bio_set_prio(bio, get_current_ioprio());
 		if (flags & BLKDEV_ZERO_NOUNMAP)
 			bio->bi_opf |= REQ_NOUNMAP;
 
@@ -286,6 +289,7 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		while (nr_sects != 0) {
 			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
-- 
2.17.0

