Return-Path: <SRS0=Oz6T=VB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327FAC0650E
	for <linux-block@archiver.kernel.org>; Thu,  4 Jul 2019 04:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAEB218A3
	for <linux-block@archiver.kernel.org>; Thu,  4 Jul 2019 04:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zvr2tXb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbfGDECd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jul 2019 00:02:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16860 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfGDECd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jul 2019 00:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562212953; x=1593748953;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4PG5+NwavyTTLqZLy5KLGEK7dNykDbZQkLP4AGMCXRg=;
  b=Zvr2tXb0GqECIjbTA2j4UR3fyv00jGmYX0Pp/E3bbpwOk1Y2xGwMo+0J
   +5kqhSe4YaOME3JOtcAa+kohAG0dTFROfWsv0xrRBcHqrAtQZ8gF3QLjt
   NduToeugD2wfugxqSu6IUPhOluiNckBLo/zq7tcgc17U3eA4Y07fvD/xk
   GaiowwQgNosuOiuyh1IJWvPFmNCUlSViwaaFQ4eAtSjpNTrtJBeQXK22Y
   C8Rn6vRZ/xLTIs54PcbwnDpCt5xFhdkHvXEUiYTWjhrDeD3FmA1LVSmDI
   0o00ucdy1BkD/rgcK1aISTYSPsr7vC7y38rTnNeRQp5f3bSo7wO664KXH
   A==;
IronPort-SDR: 0N3KtKmTdGP0f6pR4O9bo9G8PqULg51/DyxZANEcDOOlS72duQjQxEv8kgkDRc8RAbv1mCalOo
 fTQMmIgBcs2taFu1BQoOPBgAJOyI0n/mpz3hD4suERsaGgT/9tN436x0YS2sC1GPRl5pIVvqDK
 sguzli1vprty5B/zKmCA0EUn53SEomAqEXM7oiGAran+GJtcChCaSHlo5vYf8k8XlBGD25nbwa
 yasc9WxBceb7u6ybNtvf6C+upRdo7SCUXNKFliCFqekm38QkxcebdC7P1ofByZdQgKNXvMc8oe
 PPU=
X-IronPort-AV: E=Sophos;i="5.63,449,1557158400"; 
   d="scan'208";a="112201882"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2019 12:02:33 +0800
IronPort-SDR: nZBVDTYTYcAahXR53W2j4qpgjI4apH0slr+qVwdICx3MRcABq9gn1z4yYHVhWm7KyaiQXz2s8I
 6EDillys2qPe6mU3pPhSFiqFXjf99foNuyS2Gft7QaHs38Z8qwDBo5FV2SxX/p0017R5PlZgcO
 WSnggyfq+78YQJdpXp3DpyDZUwt3bLdFOh8GmHcNF4afIvaScXNxuNM5a4jfl1PuA7RoBdMTa0
 4IHG3PH7xBj8OuvuEf/2jJIC+FBFGO+CPIU5ifpIBlL0gRutJa/4h6bwNy2xXgVw81zsKQApoa
 kYirIQ3qL5MI1YToTGs/F3nI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 03 Jul 2019 21:01:32 -0700
IronPort-SDR: qP4T9eKyvNuPdJnNSuED0gXpNJoIsnakbyYNmokt2S2cYhWVs/FMSEZz8vrBcaaf8gQKS5GZtL
 HWlrDBVnWCzetkR+3UZrrcXoC4Be84w6jeBo4mhA75QSdbO6w1hwXiGTnp6AhXQHaOHl/guFgQ
 1Apq/elIxeykykiKfCKc+GaqZGZOqkIVpAldBEcjHIjnQ8j0YVghy8tGxD2jn3uyNbm/8Tf3mV
 ovbjn8W7eEpz8t3vaBFBf8SFwl6H4JH9YHRhkdIK8xhkw2pLme6Fq18+rq1bBR0wxq30Z6sSj3
 3vo=
Received: from ajay-ubuntu-18-10.sdcorp.global.sandisk.com ([10.206.7.28])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Jul 2019 21:02:30 -0700
From:   Ajay Joshi <ajay.joshi@wdc.com>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        damien.lemoal@wdc.com, matias.bjorling@wdc.com,
        Ajay Joshi <ajay.joshi@wdc.com>
Subject: [PATCH] null_blk: return fixed data for reads greater than zone write pointer
Date:   Thu,  4 Jul 2019 09:32:27 +0530
Message-Id: <20190704040227.23467-1-ajay.joshi@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A zoned block device maintains a write pointer within a zone, and
reads beyond the write pointer are undefined.

Fill data buffer returned above the write pointer with 0xFF.

Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>
---
 drivers/block/null_blk.h       |  7 +++++++
 drivers/block/null_blk_main.c  | 26 +++++++++++++++++++++++++-
 drivers/block/null_blk_zoned.c | 18 ++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 34b22d6523ba..fa82c4d96c8a 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -94,6 +94,8 @@ int null_zone_report(struct gendisk *disk, sector_t sector,
 void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 			unsigned int nr_sectors);
 void null_zone_reset(struct nullb_cmd *cmd, sector_t sector);
+size_t null_zone_valid_read_len(struct nullb *nullb,
+		     sector_t sector, unsigned int len);
 #else
 static inline int null_zone_init(struct nullb_device *dev)
 {
@@ -112,5 +114,10 @@ static inline void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 {
 }
 static inline void null_zone_reset(struct nullb_cmd *cmd, sector_t sector) {}
+static inline size_t null_zone_valid_read_len(struct nullb *nullb,
+		     sector_t sector, unsigned int len)
+{
+	return len;
+}
 #endif /* CONFIG_BLK_DEV_ZONED */
 #endif /* __NULL_BLK_H */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 99328ded60d1..ce66f4e6268a 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -996,6 +996,16 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 	return 0;
 }
 
+static void nullb_fill_pattern(struct nullb *nullb,
+	struct page *page, unsigned int len, unsigned int off)
+{
+	void *dst;
+
+	dst = kmap_atomic(page);
+	memset(dst + off, 0xFF, len);
+	kunmap_atomic(dst);
+}
+
 static void null_handle_discard(struct nullb *nullb, sector_t sector, size_t n)
 {
 	size_t temp;
@@ -1037,9 +1047,23 @@ static int null_transfer(struct nullb *nullb, struct page *page,
 	bool is_fua)
 {
 	int err = 0;
+	struct nullb_device *dev = nullb->dev;
+	unsigned int valid_len = len;
 
 	if (!is_write) {
-		err = copy_from_nullb(nullb, page, off, sector, len);
+		if (dev->zoned)
+			valid_len = null_zone_valid_read_len(nullb,
+				sector, len);
+
+		if (valid_len) {
+			err = copy_from_nullb(nullb, page, off,
+				sector, valid_len);
+			off += valid_len;
+			len -= valid_len;
+		}
+
+		if (len)
+			nullb_fill_pattern(nullb, page, len, off);
 		flush_dcache_page(page);
 	} else {
 		flush_dcache_page(page);
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index fca0c97ff1aa..20a3c08e628c 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -85,6 +85,24 @@ int null_zone_report(struct gendisk *disk, sector_t sector,
 	return 0;
 }
 
+size_t null_zone_valid_read_len(struct nullb *nullb,
+		     sector_t sector, unsigned int len)
+{
+	struct nullb_device *dev = nullb->dev;
+	struct blk_zone *zone = &dev->zones[null_zone_no(dev, sector)];
+	unsigned int nr_sectors = len >> SECTOR_SHIFT;
+
+	/* Read must be below the write pointer position */
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL ||
+	    sector + nr_sectors <= zone->wp)
+		return len;
+
+	if (sector > zone->wp)
+		return 0;
+
+	return (zone->wp - sector) << SECTOR_SHIFT;
+}
+
 void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		     unsigned int nr_sectors)
 {
-- 
2.19.1

