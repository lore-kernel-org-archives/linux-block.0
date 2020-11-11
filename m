Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C6AC55ABD
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB0A20729
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="STS/Wk0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgKKFQ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 00:16:58 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43941 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgKKFQ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 00:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605071817; x=1636607817;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=KiTQyMnB3LypsCUfUWpdHyWtrnzmVGTAeBxjqequFm8=;
  b=STS/Wk0zKro3XH2N+oj4FhIxd/x4nIc8D8C/qlEpfezA6iJ+5twj00+A
   BG2tR5mpCEbK8lZFOu86/zPdiU2fQhjWpv2iRAUvM+XrMWsYRtYRvyrwA
   /x895trFKlSSguXks8GP0gOHRcOzrHCfzuXpt+gy0s3kbdDR5lbTxG7eV
   qbDv40VwDRZQxX3FeEP0CVYaUWmExNVrJAVTpfWFpblRMKikXoSBWbuPe
   NepnNntXGJeBkqwuUfZwsnx5OpmUA1jnEmu4pgs5jEojCLWkHTvxjoF9Y
   mNSWL57HYxeP8nDlJm3YexG1OyfiprTq/L35mdmEv+yTefZRJMfL1U7ZB
   g==;
IronPort-SDR: 6jSY1gSBuJBF1sJVNLYQojz4n47SJfxeD3v/VGJW8xop3xWls5miQ09hK781lF36YJHzS3SpDx
 R3wIP9ingCR/J+DathdkpSgnOeQWsQOwA9wU2b6f0FFvjQVrnwQ6RaHPk+YjHEdTyt5lLYEnSU
 1udd/G5lYQRbnTh7T2CKoX83PiFJzBv/9v0XhmfT13YSIPu9Nau6QRcuFN+zmjs0mLvyaR6TuC
 FXRUpPMqNtc1TuzMzw3sQ0dT03tB9tB8WWMljNooTNoqS9haZ8gwoDvmiRYlvitfl16JfhyYpv
 l4o=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="152254642"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 13:16:56 +0800
IronPort-SDR: 1kvO49YZGS7rjWauOs5Jg8S1i/gjlMmUsbevhmz4AhLtFTGqHuznI55B0L0+Ktj0tCk3sQUf1i
 KPmlu3YaMB2mq55RF6lZZBSv2WA2wq6ogmo/UShCBdyC2T5BkL39oz6fuMiLuwuVFTes42q5Dk
 HCcX2+uYqQjKeSIPcvRZGRz4kL8es3QXwuFMfS00zB7PBngxxBXO4H7Qi06JjobBeSye0aVtCm
 WtbUjyQlWwgXK401dPyM2T6KAtNdeI19TS6ypQZzv8tCPsTXTDMZd4EoYVBDJSxvb4EJSd0NzB
 dQQVu/FmwrooyoWrj1Kn9tTX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:01:42 -0800
IronPort-SDR: fSdsomnOBC2z/sSjTlh9wQi75VHOCZGagDbbjcnwBuNUhzJxLPisNw2DzIo12GtrLECOraSkGy
 FkKmUMIisHOO/QH4Hmcno97ToA330z/6pLFjwQrhTU39rTay8HPDZt35c2OgHME60bpnXxZGCg
 bkLESeLM/pEzxBkkeCpC7Dbk4ZRpcFTVfY+3+V0kYoIlftg5we0i1xwlO/03i9CXX5HqkuMAoH
 DjNQO+arANfDin06ocvgfIxJSn7Ef4tXfibOiTn+CMGAhTpfIjg8XyIv0rVwtyqUrNyZuHLr3+
 1tc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Nov 2020 21:16:55 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 7/9] null_blk: discard zones on reset
Date:   Wed, 11 Nov 2020 14:16:46 +0900
Message-Id: <20201111051648.635300-8-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111051648.635300-1-damien.lemoal@wdc.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When memory backing is enabled, use null_handle_discard() to free the
backing memory used by a zone when the zone is being reset.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk.h       | 2 ++
 drivers/block/null_blk_main.c  | 4 ++--
 drivers/block/null_blk_zoned.c | 3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 683b573b7e14..76bd190fa185 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -95,6 +95,8 @@ struct nullb {
 	char disk_name[DISK_NAME_LEN];
 };
 
+void null_handle_discard(struct nullb_device *dev, sector_t sector,
+			 sector_t nr_sectors);
 blk_status_t null_process_cmd(struct nullb_cmd *cmd,
 			      enum req_opf op, sector_t sector,
 			      unsigned int nr_sectors);
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 06b909fd230b..fa0bc65bbd1e 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1076,8 +1076,8 @@ static void nullb_fill_pattern(struct nullb *nullb, struct page *page,
 	kunmap_atomic(dst);
 }
 
-static void null_handle_discard(struct nullb_device *dev, sector_t sector,
-				sector_t nr_sectors)
+void null_handle_discard(struct nullb_device *dev, sector_t sector,
+			 sector_t nr_sectors)
 {
 	struct nullb *nullb = dev->nullb;
 	size_t n = nr_sectors << SECTOR_SHIFT;
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 905cab12ee3c..87c9b6ebdccb 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -596,6 +596,9 @@ static blk_status_t null_reset_zone(struct nullb_device *dev, struct blk_zone *z
 
 	null_unlock_zone_res(dev, flags);
 
+	if (dev->memory_backed)
+		null_handle_discard(dev, zone->start, zone->len);
+
 	return BLK_STS_OK;
 }
 
-- 
2.26.2

