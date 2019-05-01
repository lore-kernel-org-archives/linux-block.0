Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B5DC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C55820866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iditoqYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfEAE3V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:29:21 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:27525 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEAE3V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685037; x=1588221037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YQLRazvQBodZqxKQ1h+b6iz7uBF7LEs6H41zDiHcVnk=;
  b=iditoqYBahHWKZvMl4cnXkIQf+honQ/1ZnDEUQQNHAzPMCdSFI6RfXcB
   pAHS+SytpxdTqlXRwCxW7jeaniEfJsXEcMXWr5aMz6f/dejEmWCrbd68z
   56UzZv6YnGUHQot/waUZyZDtvdyXLr1/C7cP79c9dlNSIO2ghBL82RieZ
   9DovHzJBijUGEuA5PQWRrr1rRwujIKt5nM3pDpVuruFPiy5Jo2OQWU55E
   hkmI+bmeyPcrmw/9AzTOnjF/vfmzbCdKcZ2MFcr6Xoltn8EcpGHdynoF+
   SgEL9ivjzfP0sSeTRw5EF4kMLpM+hr40dWUul3i1Hv2WAj0LFD53kTjhU
   w==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="206432287"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:30:37 +0800
IronPort-SDR: eHKRGBfmz7QJuTjWhtKGi2G+Vget6u9ijHD5YFZ4PhruCGwCcZ2uFOL+t1eciQaO+8/PuAmWXY
 OVgLYWpFrWxCySzrGA2w34+JXiwmcW58yiaGsI0g71e3ZVbz2NEZGNuM5fvRzgjFX/z1xDfgQr
 IBpVdZlN8dE85gNvucjMrLCVt1QWUxCJfLWs+e3Z0a22OG2Ply9c0+LIsxMZPOGh5pbf7Nsg3x
 lEFrCqZAe6HC0DrYbGCXGfsNa1x7hIDND5NhM+gzUbfSkPpP9vACNKYKam+jMs0sR5845WOLfO
 EDWQT+llDKvwolvd7drpMh3j
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:07:50 -0700
IronPort-SDR: wGqmCV+oh+T0ripu+wAidQejLuIo2oRA9gRJFtK92/XASEv8B1jrN7ReWWobDlo68VuYhEMymf
 LVIK3Xy5B2jkPdLSQ7vy0KBWD4F9njJG9XuUFne2gblo4sbt/zQK2Avyv1ncP55/wF2wOwgtk3
 ex7TjUVVcDgTPWSz821lXbJLAdt9B/o+UeOB6OAyXlGq4EJkReRURx18ok1EoXgg5e0VBEIHR2
 bkjhVZ1nEbrJoSOpe3RSbqM/YRoIhQbtf+VZ0ps8/bgQPxhfjsO/+eYArhwvU8OWoXATt4WtPa
 io8=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:29:21 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 12/18] block: set ioprio for flush bio
Date:   Tue, 30 Apr 2019 21:28:25 -0700
Message-Id: <20190501042831.5313-13-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This change is required to track the priority for the flush operations
with blktrace extension.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-flush.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index d95f94892015..af84ed4cafc9 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -70,6 +70,7 @@
 #include <linux/blkdev.h>
 #include <linux/gfp.h>
 #include <linux/blk-mq.h>
+#include <linux/ioprio.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -446,6 +447,7 @@ int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
 	bio = bio_alloc(gfp_mask, 0);
 	bio_set_dev(bio, bdev);
 	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
+	bio_set_prio(bio, get_current_ioprio());
 
 	ret = submit_bio_wait(bio);
 
-- 
2.19.1

