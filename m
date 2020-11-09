Return-Path: <SRS0=Ui87=EP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4E6C2D0A3
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 12:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269BA20684
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 12:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e38RmTlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgKIMvc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:51:32 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43848 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbgKIMvX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 07:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604926283; x=1636462283;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=m1B39fyrZQP9vQPbD4bKnCrhlI094d+lWIsfKQQf4S4=;
  b=e38RmTlv68PqxFspwlTbm9bsiJSnC9xzRZwkvEYXvLNRualEH5V7wOTH
   TysiyV5D7/+6inp8Yb7YiPkAFr4yppePRFizlB94ztlqIxM33vM2f1f2P
   CbvTPVN5an18nux3xXm0el2kJEQWwqjvq0j/ie42rDywwk1Jwk/T8lZxe
   eTSj+nVw4oxXfOgDgyt35pa57tKsgex2fv7neHKRk9wFPX3S2AKwAa2Tb
   Bj3Rqaik297eACLZMxZxD4wUCbzElu73TSCkTE5wsWSUnF3l9/uDVc6Kh
   kxFJUHA/skup8iFub31MlTUijAeZkZrThCOfTxv0+0oBUGbXjNo4V9neN
   g==;
IronPort-SDR: yh6StRns+47D3T4X8nKuLmzSgF82GtmmyXMujjK72kJZOWA7op2PkJU3VHUsgFxhvZKeAyQIEV
 N57FxCYRl8RoFxwgguQyW3cIut2qD56RdWcTQJqJY2QtZoiJIJhsVtuwb+riPn8A3BCYChDFv2
 GcufakVk2wzyUTOqtBe3+Q6NBGHyWZHCfoxUgjQTuGODbuwb/iRgy0twH3fgXUDtO4hzzYmeM5
 SYeC8+izcsU/NeUrKeBBXEwUyLPi21tfKwPBGCwz10qwHSu2Yax241rNBIiznA0UjqU8RIfl/0
 OtE=
X-IronPort-AV: E=Sophos;i="5.77,463,1596470400"; 
   d="scan'208";a="156668405"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2020 20:51:12 +0800
IronPort-SDR: 9ufbGoQSae1WAGmsGfgf+BAv231GRQ3dJ+khHd3UKCK2qdIBX8oIfqpzk2sq5v3/4c1GM1UPiY
 9MrOxkRSY2uFNAm18sf57Ov3+s05iY9rulzSJV4Mil4ECEQCZzv2h9+czzk0GyFwCIfzamijX8
 nnsfZVNuqp7bMP8l/GYb0htNIZhREJeaNVfzWAnyJpwWN/Docjg99GzpHhcQhI8lk7EDaNBXyD
 4fvs+K0wOVhnB1sZnBcdg8XPXSUPpvnJi4UiO7j6FwYEkMO7v7ppnE/ZS22JSmGJMm+qE2/vPg
 BZtCCMixcURCrxsmjQMxW1r/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 04:37:14 -0800
IronPort-SDR: ZyOIddS9Na/BPUwRiV+cwgsSvgo7VfT2dn8ktasQs5M5mja7w19mLGjr5byAdxXXNPNykrEFEn
 78sux6SynPRKuyQq4kkFTDwdE/QwjcKTj8s+G/Uqet7yAkLefjUHOeAphyKIDNst+LZ4pdR9mc
 Zzf/2wgVpEhmm7V27xkg6z/at+EdJArN5JhUzgCL7CcVmkcwrwq2T6z3T9BxzHfTX9MUOj6A6V
 lhSAEu9+QbF158JQH+Z3h2KU3GGLisioeUwvEz7ykbgao27b2zwsp3cTYgOYAIX0zP2zF/awOF
 Js4=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 04:51:12 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] null_blk: discard zones on reset
Date:   Mon,  9 Nov 2020 21:51:04 +0900
Message-Id: <20201109125105.551734-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109125105.551734-1-damien.lemoal@wdc.com>
References: <20201109125105.551734-1-damien.lemoal@wdc.com>
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
index 1483413a81da..2150d6c7d8cd 100644
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
index 6f2ad14ef213..d9ae69f722e8 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -595,6 +595,9 @@ static blk_status_t null_reset_zone(struct nullb_device *dev, struct blk_zone *z
 
 	null_unlock_zone_res(dev, flags);
 
+	if (dev->memory_backed)
+		null_handle_discard(dev, zone->start, zone->len);
+
 	return BLK_STS_OK;
 }
 
-- 
2.26.2

