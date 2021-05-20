Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C627C43460
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3B6611BD
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhETEX4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 00:23:56 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63405 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhETEX4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 00:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621484555; x=1653020555;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=mJtdvFpXsZHL3tsBZuMYjJqXEQBTOjo23wrT4soN/3I=;
  b=AZ384J7lpTcsivhfEk1103jLyEoK/1rR1qY/z9lHZlJpoPllpwhdl/By
   xVrRa3zDNrg9RzuwSYzPUW7sM5lRHEf4AiuRyLqmAWgmXSQOqUUF5JVyk
   li6cMlFUiNo7tMGg/uhBQnDCdCm9JWo+ykFBov9ZPuLOIcUmBhCfPudy2
   jePLz/zZjB6BlkDUSBpC6pLAxgLmpqz0vavaMcfK+5Lm0yFSAp/+mfwDb
   lEtJpB2w/mpW6ONsv2DPJ8uYYcfAAmDvGwg132Q1lyTtCSSc1o1aM/x6e
   7Nzq7SC2toIQsiGkFSrC1nIhNOI8J0AurP34q0OW39Xk6h4QewHx74J1M
   Q==;
IronPort-SDR: bL2JtEr65HmuibeJrAlsD1FgEsmUaqDg6n7tfC1nXIsl4xG2aXtAgh5LUIjYHqcYfJK25JU/3H
 Dw7EhFy/NOqayR7gjauqFzR+la4AjGphbhO4So+kJQ1AkQagUCRhkTB6Tp9RsjbMqxCoMveIoj
 pzyF4rk0PcQrNErD1STnsR5eHvBQGlsaSVuZ573x3LN0XYxA/uItNqS3wLnhTMNi/sC0DpIgcF
 yOKyVhnPJUkV84fYChfYq73fPacKR/Oj1V88mslnwigq3evCQVCMKgjnvL+OlIks8+L/NWMEfe
 RoY=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168105842"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 12:22:35 +0800
IronPort-SDR: fa7LPvfmF7sRa3d2wD6EOSJjZrDSnQMPc5TqufVDBpXdVUE1i3PMLjWYuS8Ul+X7kE3lWMT6rs
 QJYfV1N80aNlDDeJtNjjZuqei55s/6tFvAbn3j4wFLIprdJJSY7/+5U8Oeuml6MiWMgtdhssn+
 1Fjz1XZQyhiCcszOhfyTmAIG0s05QBQY8zMzmOg2sThv3Kv1Nw23ta21E51ooKyDPhUhWEZB3/
 joXDXm1D508TlhCGLmXIQ/KgqhltF559F2z/0occuDSy3/tWRpiZhyVChcUpdicS5BXFA7faQm
 XHkf/gfhd7cGiwhGFMIy2oWi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 21:02:12 -0700
IronPort-SDR: 6kNOHqXrru0/CddEeEBMWKY14E7If5+84cgNhp8D/5XGKZ1yOqXB0WBBrgGWbvYPZOK+iFtJ+c
 ooqEd9ivvptwZC9IGLDSl8/FAlzAn4Yjl+FJo45XtC3jxbQwsgZxlI6/AqwrbttYhJQMA57B4W
 ufs6e8zTLtxqhchXNUNfyexTCivuTA86KhbCytPVZXZQgtYLHu9QC8IyENgm48Iao7GY1utEpQ
 U7wfIAH1A4EYDVQxH8V0nsBcfkuQ+/YIbs3xzM0Phbu/aFxFZ/FwsWGhsCdu2XIM/YdOEY/RJ1
 TUI=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 May 2021 21:22:34 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 05/11] dm: cleanup device_area_is_invalid()
Date:   Thu, 20 May 2021 13:22:22 +0900
Message-Id: <20210520042228.974083-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520042228.974083-1-damien.lemoal@wdc.com>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In device_area_is_invalid(), use bdev_is_zoned() instead of open
coding the test on the zoned model returned by bdev_zoned_model().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index ee47a332b462..21fd9cd4da32 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -249,7 +249,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 	 * If the target is mapped to zoned block device(s), check
 	 * that the zones are not partially mapped.
 	 */
-	if (bdev_zoned_model(bdev) != BLK_ZONED_NONE) {
+	if (bdev_is_zoned(bdev)) {
 		unsigned int zone_sectors = bdev_zone_sectors(bdev);
 
 		if (start & (zone_sectors - 1)) {
-- 
2.31.1

