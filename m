Return-Path: <SRS0=WMYH=YK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43256ECE58D
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 21:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB3F21835
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 21:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UI3G9PE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732930AbfJQVTr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Oct 2019 17:19:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26230 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732097AbfJQVTr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Oct 2019 17:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571347187; x=1602883187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XQ31N7rspkIiMqzSHO9IPQLQSyakS3MI/R+iVClkynU=;
  b=UI3G9PE/yJUrgElC634/oawnKcSezhy3B43c227dYtFn5CVe580cG/lB
   DKuF/zuaPB4MXqk3PWX9x4Ct8nHO8wA68eNwioXPMk29vC7WfnZoc08/P
   wbglBEqBRSgLeadkdcPNf5QRHdzrLYy0uDAq2hrs9Iif3RM+3TmvkotC9
   p/bhjBChcfZ5zH0qjek+8yj/slwix9GlUF0o9GuTMBvRdfW1NNQW0R93g
   +bdAxWetNt95z9Ycx3idmEcb5ISqCRM6+OS220NPyGci5sApV5BRCy6sy
   e1IcO4ZZ4v723QFriCRRZ9I2Cl0mbmHqw4aMt5WtWYfHcesNRyDvUiUR5
   Q==;
IronPort-SDR: E/qlVQ5y7rU6scokDexWiJJMA1aY5FWxWzLWGcTMDhZnrsn/AytK5SyrQ2lAyUUgPxr2+ro7OK
 qfd9PtNrV50vTbl4SwccA1dDMvsE8y6y8H9FM8uZ+KQ1SFes7QUKwryjzO78tOd2a5BWjOvO/J
 F6pCVbYO8s+zZvF0pc3scr0BibYnnyi9cFGYiKzZUoAHnksapafY8oGo9fIYz79KzN1hagBqj1
 38CQ8cqnk9rvu/AvvB73/fhaHyQzsC5eMJUn1cynlpeIkis5yFwAo9d0aDDS3J+zMCO1ZDRcZE
 SL0=
X-IronPort-AV: E=Sophos;i="5.67,309,1566835200"; 
   d="scan'208";a="121556847"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2019 05:19:46 +0800
IronPort-SDR: HN9ym4J+S2qFlJXV6IadIt/LQHUe8g36+mUcANdZFBJlks8br9cP1Ea/0Sy+MX2H0UaCztf/ek
 fkJvQMxcwDTJs1Y6bNOCQzlxrwCMkLhwyp883r0Tbs8VXtCGq8wCKOg2gUo3wwAcvshcJprgXz
 2xDCiEqk4m0D6zWKm1DZaGqKcCcrUYkyuYLQbwk7VMVSLNYwb1OPquRWFAe85DwIvbXSvUzZls
 +v0R0rpK8bQbbA9iRzCu4ggIT8jTrcF1ereV9aHEmu1pz37dVwcoSCl23uoUhQaoKTQWMBirCX
 twbnLiH638rIGga4/yJwCnMT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 14:15:24 -0700
IronPort-SDR: RmGYtMpEtR9n5sX6n/hKxS/reGIFz5kb5St/WYqnWl0Ptj1AeC8nBv4NEdeb5ucjkJgYSj5RIE
 c7bxnsOgxSL+u3685vaW9Lv9mLr9JZscjLP8bKVTk60OIIn1bP7xHmxUB2XrsUgdbcBh26mYb8
 dltgCl0pdQkifVrSZFN10nHbgHlmIpIlQeoJT5I2a8vyCyerg8p5ON3e9DLT27s77YIVleHw6L
 OCYTtALnoR59yg5jFu3aA/KptUNpfXilK2Q087ALTv2hjqtMsciy++NRwXq/STxZDPqlf+gQUQ
 N9E=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Oct 2019 14:19:46 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Ajay Joshi <ajay.joshi@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH RESEND] null_blk: return fixed zoned reads > write pointer
Date:   Thu, 17 Oct 2019 14:19:43 -0700
Message-Id: <20191017211943.4608-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ajay Joshi <ajay.joshi@wdc.com>

A zoned block device maintains a write pointer within a zone, and reads
beyond the write pointer are undefined. Fill data buffer returned above
the write pointer with 0xFF.

Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Hi,

This patch is originally posted in July :-
https://www.spinics.net/lists/linux-block/msg42403.html.
Resending this patch based on latest linux-block tree for-next branch.

-Chaitanya
---
 drivers/block/null_blk.h       |  8 ++++++++
 drivers/block/null_blk_main.c  | 26 +++++++++++++++++++++++++-
 drivers/block/null_blk_zoned.c | 21 +++++++++++++++++++--
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index a235c45e22a7..93c2a3d403da 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -96,6 +96,8 @@ int null_zone_report(struct gendisk *disk, sector_t sector,
 blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
 				enum req_opf op, sector_t sector,
 				sector_t nr_sectors);
+size_t null_zone_valid_read_len(struct nullb *nullb,
+				sector_t sector, unsigned int len);
 #else
 static inline int null_zone_init(struct nullb_device *dev)
 {
@@ -115,5 +117,11 @@ static inline blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
 {
 	return BLK_STS_NOTSUPP;
 }
+static inline size_t null_zone_valid_read_len(struct nullb *nullb,
+					      sector_t sector,
+					      unsigned int len)
+{
+	return len;
+}
 #endif /* CONFIG_BLK_DEV_ZONED */
 #endif /* __NULL_BLK_H */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index f5e0dffb4624..ea7a4d6b7848 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1022,6 +1022,16 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 	return 0;
 }
 
+static void nullb_fill_pattern(struct nullb *nullb, struct page *page,
+			       unsigned int len, unsigned int off)
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
@@ -1062,10 +1072,24 @@ static int null_transfer(struct nullb *nullb, struct page *page,
 	unsigned int len, unsigned int off, bool is_write, sector_t sector,
 	bool is_fua)
 {
+	struct nullb_device *dev = nullb->dev;
+	unsigned int valid_len = len;
 	int err = 0;
 
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
index eabc116832a7..e020f17dac9f 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -84,6 +84,24 @@ int null_zone_report(struct gendisk *disk, sector_t sector,
 	return 0;
 }
 
+size_t null_zone_valid_read_len(struct nullb *nullb,
+				sector_t sector, unsigned int len)
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
 static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		     unsigned int nr_sectors)
 {
@@ -121,8 +139,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 static blk_status_t null_zone_reset(struct nullb_cmd *cmd, sector_t sector)
 {
 	struct nullb_device *dev = cmd->nq->dev;
-	unsigned int zno = null_zone_no(dev, sector);
-	struct blk_zone *zone = &dev->zones[zno];
+	struct blk_zone *zone = &dev->zones[null_zone_no(dev, sector)];
 	size_t i;
 
 	switch (req_op(cmd->rq)) {
-- 
2.22.1


