Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80E3C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F19620866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H9ow+rRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfEAE3T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:29:19 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1134 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfEAE3S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685033; x=1588221033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LhqRagllkGZHLs/m4zvbUXcM7SjQHImCYNA8GzNsP4M=;
  b=H9ow+rRxupFnLvt8p7MPtu8xspoOhf/DEQNBF048W8YwqDi+O9IUXrgN
   EP0RzcnSGFfTVW4vUSy2YzWo3ncfgUnTouuZY0bxq6NQs2d236rDye58S
   NF+JRiTJBMo1d0tEq/EDKQBkAyc6yQW3o29GIGJxmGx5dAdS7mJDRcwht
   vGfVNKxsm3lSiNVeWrBIATk2D5U00535QUXLRFsWer2FoGFPdnNARWq7q
   n/Dvox1Swv4dtnogFvWgczw3v+BAoCTtS0IJCW8uq+RYQqUQdLgWbFFA6
   mz/9Nzq5lCom2Nt5/+zbQBK9WO/P3fmJ7QfZ+Tx5gS5TzY2oYGGHlrcsr
   w==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="206432286"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:30:33 +0800
IronPort-SDR: Wc6A1PIDUjFhLHN1EnA4tm5UpTnuGwxAAK2eeX6bevGiVFncat2MaSITc1ErccQl+v51nPhjBn
 HzWsTY+FH9IfSDXBGm71rg9Osa1jpCuHKVhtTMJNOm+GayHM0n7pDkgrZ4Krk+idvukUGb95a+
 FSzSXFoG9/QuB2Q8AzV1MYKwGNy3mRtOygfOm0PJfkoPLsi+CYEuID69vUGGrGE8NHjWUaKHj5
 Ma8N6LBgrc4PjmgvZBRpLUmnnhQu5Y09z0iFk/TbfWC3nk2Eu4HfJLGdmlKmi/0svJSlPRDcWf
 /Xw1JiMUIriP9WUsmKwANEI3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:07:47 -0700
IronPort-SDR: 4IDcp3SX/WAXFp97DRTjSK7AcMbcUCv4BTI14IMPiKcy5X3UzPsy59NQ9AE4RB+XE/aEMz/Wo/
 0pN2yH0V92X1yvwOqX+J5V6oCo14mBzN2oeEoyJzQI/606hah+NE7l0mB+fb9kU5RGcuUkLENB
 vmv2i8Wb2XyNlDM+I712jq/Kuxs1bJ1yHKXolzQFJcw/Shj7gffxnKJ0GsDRzSA+6qXEl92vHH
 YkS4snochiIk/7LCCJp53VO0fC08c3MgFlbkm1KioZ1C0WGK74YX1oQ44TdJB+hD41cwWxdkeV
 ruw=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:29:19 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 11/18] block: set ioprio for zone-reset
Date:   Tue, 30 Apr 2019 21:28:24 -0700
Message-Id: <20190501042831.5313-12-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This change is required so that we can track the priority for the
REQ_OP_ZONE_RESET using "blkzone reset <device_name>" command.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-zoned.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 2d98803faec2..5d8517654b16 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -13,6 +13,7 @@
 #include <linux/rbtree.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
+#include <linux/ioprio.h>
 
 #include "blk.h"
 
@@ -248,6 +249,7 @@ int blkdev_reset_zones(struct block_device *bdev,
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
 		bio_set_op_attrs(bio, REQ_OP_ZONE_RESET, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		sector += zone_sectors;
 
-- 
2.19.1

