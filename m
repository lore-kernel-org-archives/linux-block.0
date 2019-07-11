Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF799C74260
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AA120872
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z0MwpfaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfGKRyl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:54:41 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53317 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfGKRyl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 13:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562867781; x=1594403781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=0kR/LVp4gkK7dEG1CCXX7pXv456iO8kz4Pv9gPI+EsM=;
  b=Z0MwpfaEpiYibZaE7UoklfoLLD/VCN2sSit7AdvRog8Cfas4SI7RVhJ3
   KRlFz4vazPE+DPBd8ODcOdhIn0YprQfd+d9aZtxjeE2+n3hXh7yAwJwRv
   99dsEm+IQFKT55bjCLSoO06uos3GN0eEI+ku6dmT6LA0bj1nCabRLTWoL
   IdVdm5UgWJeHTIrsEE5UtgP/zx5KzksNhzPfuwGeLzsonkMnhCHTYzmct
   6xyGXoytLsrRsB/zcVegraZQtA8pu5BJ1vx1wpjqZo/Q/d64n0CczBP1j
   iDwKjPspepjMUWlAa+Cqhi9sUlAnB9b3TWH7+z6LYBfTBBbQcNVT/134f
   g==;
IronPort-SDR: PDikRJ7bDr/KZFo7LGKvKb5BCoOlVZ2JbTMIIgvkRo4dC2b6fNIKrT2IyIKC0UNpCmnpKwcWvO
 qcvbBl/8eZv27Do//OWCVwJUbkGVzANdchDwdjMQm2V/p3SfjpgsXAL3PM/k/9//p2rznMfbiF
 7cEklCkzQOgcImbp8EtvteAKWYo4LZr2neZ5T4mBWZAW0bM9gOjbrlFzm48fzTD5rzKeOwBAOG
 zUQJgofChjBAcqLRT03Uh/WKI/aDVpKyHvhGF5Z9Eu8uX68wKpw3Gmxw7SUP8ehDh9cAe9vXyF
 +HE=
X-IronPort-AV: E=Sophos;i="5.63,479,1557158400"; 
   d="scan'208";a="212743457"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 01:56:21 +0800
IronPort-SDR: marXlQ5+XwECqVPBUMoocqVjQsuMoVE6Kq763GtAzTAD4wocXQMhPMXWKbUmxn5RBjiL582Ltp
 nVVFU0n/LU1vpDl25K6nspMjv6dDlAHMTyE9wagLVNGXoUVQYEDcr83zcoJ8Jw/ez2o11G4Iw1
 tpAnERptYVPXgw9JNjXB0di6ZbxssDnDBqRCNJHZyiiKcBdh9CENjil4wNotXCX/PdgqYSSmoo
 BSfaON+QMnqqrMbfxF9r8YhPlYEKytKxWRElm2k4X3GFc1kwif4jFiWxYRux7Y/Mpl33AtVjKG
 7/Kd3oiLafONaRh2t74H06sY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 11 Jul 2019 10:53:17 -0700
IronPort-SDR: qI3xwlKL3Y0mzoBWFCOUX962FlyEf26e/QeDjsupfoxlnGJNjEnGXZscuSdMzRrN/LJkdUFUgs
 WcSeJSu4rOPw8XPr/bgAlaxezMF8WHXprKRkV1Ypsrim7SyJ8papAfah7eU1aEg/EEcxNY+aXF
 Fa8IKBGxnQBSFBSNLOr7LzB75plBwIm7HjCuvroRtZR8Ol9JTc5pHtngfx193fJfhY/XOzq+GU
 M0BxQ4+xovOlV7hYIotVRH3cEN2kfAw0XkLjVKrPFEI3eFh22Ubk+S/BkgojJQTPjLuOyzglrc
 8Ps=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jul 2019 10:54:40 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 7/8] null_blk: add support for configfs write_zeroes
Date:   Thu, 11 Jul 2019 10:53:27 -0700
Message-Id: <20190711175328.16430-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
References: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds a new configfs parameter to enable REQ_OP_WRITE_ZEROES
feature for null_blk similar to REQ_OP_DISCARD when device is memory
backed.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 30cb90553167..c734ddaa697f 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -308,6 +308,7 @@ NULLB_DEVICE_ATTR(blocking, bool);
 NULLB_DEVICE_ATTR(use_per_node_hctx, bool);
 NULLB_DEVICE_ATTR(memory_backed, bool);
 NULLB_DEVICE_ATTR(discard, bool);
+NULLB_DEVICE_ATTR(write_zeroes, bool);
 NULLB_DEVICE_ATTR(mbps, uint);
 NULLB_DEVICE_ATTR(cache_size, ulong);
 NULLB_DEVICE_ATTR(zoned, bool);
@@ -423,6 +424,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_power,
 	&nullb_device_attr_memory_backed,
 	&nullb_device_attr_discard,
+	&nullb_device_attr_write_zeroes,
 	&nullb_device_attr_mbps,
 	&nullb_device_attr_cache_size,
 	&nullb_device_attr_badblocks,
@@ -481,7 +483,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size\n");
+	return snprintf(page, PAGE_SIZE, "memory_backed,discard,write_zeroes,bandwidth,cache,badblocks,zoned,zone_size\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
-- 
2.17.0

