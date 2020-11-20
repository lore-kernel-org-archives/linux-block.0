Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F48C6379F
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C17A22255
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iuZOP/QV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgKTBzn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 20:55:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6553 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKTBzn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 20:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605837343; x=1637373343;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=V7oCjS3GKfR7wtIyMbYqgVSC3/fcLyOTBkS3KX7Wx2w=;
  b=iuZOP/QVpsXLDyueyQ+5PnUAndElZmr1PNMcWT6+URZ9Vngnq0IYO69D
   lcjcAWJ7ja0JmhxQf8/BnN9lZyEw4YFJ/1lKxlHcVG6ZerXMEtVcXeO04
   HG7gYirDhpBdOutv36Kdbh1goU+kDP/1Q/Umd3Au9G7uJs3PbVfvXjxZ6
   UpP9yCVBZBEyxbQ2lFzdCYUDFxSisu7XsdgbU5TKOW3Ufbc1Pxqvs9XcA
   cITwTB8ZtapvqWewvVEUai9SiMMFNPVAHbSOHkxLDPOqX76SLZfiH1vHC
   XSv4froUMJO++B4EeZoC7vEzk2CvVXityyHkEAemW3P8fu77FXOLDTJyc
   A==;
IronPort-SDR: H8zj/vn2Oec4YeJvHJEn1WrUYb/I7EqyZR5E3PPmo1Vxt0hzLcxfyMx2rDx6vy8x+W2/rkK4AC
 zrZ5+J6OoYueo8f5ndkinGn9+ToXS4hetcvlzgxWZMLQDXFqFOerkNpvM5AYzm1iHC6fDDEDnI
 +EkbXfFBPRE6QErEsKxt9PcOm+ObJT7t5p58UQnijpHj0ctBhTLcKWd8Gu7z5MmSdNXBf4JoUB
 xotmfdeYgGfu0sU949Vam0Tu2AEtpxbDRfhejfyQHPI8bcCd6hA8QeA9bPsn9sCamil+3kdJg4
 FAg=
X-IronPort-AV: E=Sophos;i="5.78,354,1599494400"; 
   d="scan'208";a="157516402"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2020 09:55:43 +0800
IronPort-SDR: bh1lrH1W/2doieuMDUmzeAvH0mzT15rSdbp5o3uDs2yrqS+0XAWd1VqwT43ShN9C9c+c0WExNC
 4rV5LKl7VSQFPi7xXJUc7FgCNGTzBPFQBIwlZoII+5SeXvSmsVqUtZMFm8OapvQRalZN2cEehd
 BeYsuDsdNfKioVs9dsKTHyHMn1HQTCMr9woXi9PqB93nK6e7mL3B2PV6Ist9/kdnVf8uSkzL71
 BdJg9xwrk0V/B2XQQ8mjNdvfygogwsqyks0rqkqfDtgKrq7v6E4mm/Twq78xP5VbFx+q/67NR0
 UakN3FggTqnK/7Y7DnAYL6uY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 17:41:32 -0800
IronPort-SDR: xXUnY0CASWKklHxNjTp+5jkWjJZDohBixDj3FFJP4tR8xe4QyZLGu7QNWXPwhUKroteeFxCK2L
 MNuSoO+LglJogJOq2t5Vw/kuDwUtm4+owdClw1uKYrRuVSTLlZToDFE/tGwcvJdYXzX/mVPvSe
 jk/Hxn/Xdz1bIhlrxJ3GSWdLe2g+HShMETfXzgt+JlgJlfoiUhLD0+oko35cbA8mlBi/b8nTul
 MzoendEwl5rdL0xff21CUWEXvtwYfwmA72BlwHW2snzWsMh6QLRTPvZXniuOQbjUmj9KnJ3nfb
 sT8=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2020 17:55:42 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 3/9] block: Align max_hw_sectors to logical blocksize
Date:   Fri, 20 Nov 2020 10:55:13 +0900
Message-Id: <20201120015519.276820-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201120015519.276820-1-damien.lemoal@wdc.com>
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Block device drivers do not have to call blk_queue_max_hw_sectors() to
set a limit on request size if the default limit BLK_SAFE_MAX_SECTORS
is acceptable. However, this limit (255 sectors) may not be aligned
to the device logical block size which cannot be used as is for a
request maximum size. This is the case for the null_blk device driver.

Modify blk_queue_max_hw_sectors() to make sure that the request size
limits specified by the max_hw_sectors and max_sectors queue limits
are always aligned to the device logical block size. Additionally, to
avoid introducing a dependence on the execution order of this function
with blk_queue_logical_block_size(), also modify
blk_queue_logical_block_size() to perform the same alignment when the
logical block size is set after max_hw_sectors.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9741d1d83e98..dde5c2e9a728 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -157,10 +157,16 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 		       __func__, max_hw_sectors);
 	}
 
+	max_hw_sectors = round_down(max_hw_sectors,
+				    limits->logical_block_size >> SECTOR_SHIFT);
 	limits->max_hw_sectors = max_hw_sectors;
+
 	max_sectors = min_not_zero(max_hw_sectors, limits->max_dev_sectors);
 	max_sectors = min_t(unsigned int, max_sectors, BLK_DEF_MAX_SECTORS);
+	max_sectors = round_down(max_sectors,
+				 limits->logical_block_size >> SECTOR_SHIFT);
 	limits->max_sectors = max_sectors;
+
 	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
 }
 EXPORT_SYMBOL(blk_queue_max_hw_sectors);
@@ -321,13 +327,20 @@ EXPORT_SYMBOL(blk_queue_max_segment_size);
  **/
 void blk_queue_logical_block_size(struct request_queue *q, unsigned int size)
 {
-	q->limits.logical_block_size = size;
+	struct queue_limits *limits = &q->limits;
 
-	if (q->limits.physical_block_size < size)
-		q->limits.physical_block_size = size;
+	limits->logical_block_size = size;
 
-	if (q->limits.io_min < q->limits.physical_block_size)
-		q->limits.io_min = q->limits.physical_block_size;
+	if (limits->physical_block_size < size)
+		limits->physical_block_size = size;
+
+	if (limits->io_min < limits->physical_block_size)
+		limits->io_min = limits->physical_block_size;
+
+	limits->max_hw_sectors =
+		round_down(limits->max_hw_sectors, size >> SECTOR_SHIFT);
+	limits->max_sectors =
+		round_down(limits->max_sectors, size >> SECTOR_SHIFT);
 }
 EXPORT_SYMBOL(blk_queue_logical_block_size);
 
-- 
2.28.0

