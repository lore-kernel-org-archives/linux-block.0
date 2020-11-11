Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F0AC55ABD
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76082075A
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D0bPMEpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgKKFyL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 00:54:11 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45435 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKFyK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 00:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605074051; x=1636610051;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3tdcKQHijx6GZc/MoLPIQJim8rjpwdPIEpCQfSuNvpY=;
  b=D0bPMEpbQvjZa/tffD7TXkvuCaYa4liiquL7sLlvzZSunCRZDZVBFHKt
   vF1tn+rqUA0rj/VQULIRbrY2vzdLD43RpjvxqR6J6uE4eXuPDyDAs9z5C
   /JxceTpQzL21lpUXCQkmBbUszTai+y007JpKxBI6/c2g2DPnY0eJV42CM
   LkkLACG4RA/gDCdqItGOPySPunP8vWv15+6C8wCvj4gZRInv0a+6VcZyd
   v2WOslyt9K123NYXpa5NduEC5Fje54vWL8zizJgvixLGAiEF9wmVyxYWi
   DKxe/FPRs8JCdUZ5CKkPxN+aU/nN2Jv3iFdGfwxijIhP4SZ9ruWEJ1L1C
   w==;
IronPort-SDR: sjY+cflZ46CIhdDX91rVwbpEtiCe6Qq+ANjqhNLLc5ckt21LJpOdMvmVMtxsZ4G1AzzscVY+o/
 cuKpYr58XQHDP0AVs/9A+ahCCKOrEYi13fCgeqoABuhaKrmuV4r7z3byIyjAljCM9dHSPP0Rb5
 90eRPho/zAyv64uD+YIPvUlCa03lfu54Flmg8UzinT4ce8tcIIvKdAScwEJ4eisEvtCbXh22C8
 Gh9btF7gkQ3decmziTu1xuPsKT969WF9Y4Jkq8kAcoE4V1DBDiWKMUOYdj8mo5HGZdt/aLgLXT
 IuE=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="153553926"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 13:54:10 +0800
IronPort-SDR: TVFUcsoFac509J7EC61EgpuKc3s68N1G/BGvV5U/qm86DG+2o2yTWiEpHVuLieGFHToju6VtNg
 stcp6gRjSoveAO+llQzhiJFc07Zlor70a6PpA4j2gsvsDx+xU9X4o9ORACMi4vmbhfoE7Rypdz
 Y8x3u3JTbT7IDDhiDglchR6GaASHt6BKPhp/vQiOeFvyLOZx0wgYvKVeVXURQL2um6HKAYibkL
 jXtsQkrxoxM8p4qz49pG1DWAL38ziJlN9UHOLN9VrV/lImKgIfKS2u+GyDnOQsDTJUpy+tq+CD
 /IxOp5Nn40JJTtdczBxN5WWe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:40:10 -0800
IronPort-SDR: H5Hq/dGapVqT7BEa3PTyyd/Fpph/0RWtZeFkcWhna7c9enfJWWavJwGVnRfgAcXwSTvvXQwIhb
 6+n8gsT9VTpHKZqVH8PxohqrZggOU1tVhyXjq65ePNUaNLTkhVncacA+1JtB6x125dodM+tK9P
 nDhFyrOTKa6lEZbLoxsh3nVJld3VpxqUULVlWpNJu9YMhBeA8/wvXaOqf2QuIkB99btD587GMD
 3l3a8v9e02FZzMr5AVa4ky2FOdWif3ZYG+yxEcYGl6vT5DH7gnRnZYohmrzM12kbLH4a2OsZ43
 Uzg=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Nov 2020 21:54:09 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: Improve blk_revalidate_disk_zones() checks
Date:   Wed, 11 Nov 2020 14:54:06 +0900
Message-Id: <20201111055406.735839-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make sure that the zones checked by blk_revalidate_disk_zones() exactly
cover the entire disk capacity, that is, that there are no missing zones
at the end of the disk sector range.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-zoned.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 6817a673e5ce..2821de36a5a9 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -510,6 +510,13 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 				       blk_revalidate_zone_cb, &args);
 	memalloc_noio_restore(noio_flag);
 
+	/* Make sure that the entire disk capacity has been checked */
+	if (args.sector != get_capacity(disk)) {
+		pr_warn("%s: Missing zones from sector %llu\n",
+			disk->disk_name, args.sector);
+		ret = -ENODEV;
+	}
+
 	/*
 	 * Install the new bitmaps and update nr_zones only once the queue is
 	 * stopped and all I/Os are completed (i.e. a scheduler is not
-- 
2.26.2

