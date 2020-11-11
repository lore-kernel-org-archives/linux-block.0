Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D773C56202
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C226B20729
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MVy9JT3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgKKFQy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 00:16:54 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43928 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKKFQx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 00:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605071813; x=1636607813;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=45yYfoe96qdeI81oKyZ9SDAYSoxixi+7/tPmyx2lzg4=;
  b=MVy9JT3Pyg8t+vVZtxs7h/s3ckOyCHjPXbcD1zB4j1H0ndtnjoFG0uE5
   vU4OJ8axTvBRGkdRTTWD1TQTzz0Yg9nZr5R3btDzMZJs4+wBfJwZFF0Y1
   v4v55cD4hnnqGRP45bYgnZAj3fnjqtYWbrNxA6B7nOSDeJlRjs4tPm/Ag
   vaRQKSsx03OQpYNlwUETqxV33yoVVYEgatiP3kpMn5zFklW3zu6q/weMi
   gaxYIlKKHMmTyqlBRRMyHbxvLKaQsIweEmPTO1hlraG13wQK/12nB981p
   GcqGN70s72dWe/g7X5J7ZJ4yBBJvNYCd/a2Ocpq222iydsbxVIIr65jKx
   Q==;
IronPort-SDR: pb07ApsooYceaqW/fA8NVmB8Hic5BeAwf+mSVFMSBK615E7PcdusvSQyRIWsKvQt+Q5jp5oNRc
 06t3O8eaXGOLad9LRIg6aJx3du8GFxgzajMnVo3eoIYoxoSu6+cYndYBbELXfRkon36IZYXRVw
 il3PLkV7CtETPUAQMxGje8U0VxvIkU7Zyd0JNYYlXZa/MQsu5yxtUwQC9HCMmfMxmMZime7Pn6
 yekmUQWiqZ3eCkqNUsGs7FyooQ1jgRxMM2fnNJRpnhBOUS3ume/BsXrx1F4IhmVJjGalinfY8D
 EUE=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="152254626"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 13:16:52 +0800
IronPort-SDR: 52U0JGWmkQQo///n8dKb+SC2ZTgj87nggeoDiOBeir6snghm65k6fS3UF1B5NnSmOqktB7i0MD
 lY5T5aJUgpiY1p+UBbnJruzIRsPQsdV6YWK4QBE5Bh9O01VwFY/aZyrBzi3x1JwPs6S2pY0zVw
 t4FA8Kxrcpn/ZYEKJa++XvISWm6sY+xbinqAUj7sTsbprHFxWJOQrwXBefJB56W4+4JjuHabyZ
 WgBMql0OYkpiaSXOsCaKiKi/JwV+or/b01WVEj/r6cVVkIsECQ6xk8MUxxLRr0H61xJEZQcsQP
 m0H7V44sdJrHF6BUgd/e5ae9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:01:38 -0800
IronPort-SDR: NP7cKZZmHD7eiwpqBZOqiNqrlRMA1oubl1NXd9f3UltQltixqM24kTPJCJbi2zwTqkF3rWXELD
 8h2gqDWUkxeuDGvWxempAyENYbQx22xyYJL9qJJ+Q7PxaPi/qoTzInNkXFcmPEtGRnhJ+JPWgl
 Xlfq5hMIIhjTdXe7yMnHxf8h9KWR9uzdH2yzvmu9cP8CzPMT1cTafC7U/iGERNMJCDlKY/AdYw
 89OFuBDSMISNnIPPujj2mW3FpyDeq/SLJyguKMX2N8Cu3qP0DtDbTJCpeUmoee6aDda+IpxzDy
 9fw=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Nov 2020 21:16:51 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 2/9] null_blk: Fail zone append to conventional zones
Date:   Wed, 11 Nov 2020 14:16:41 +0900
Message-Id: <20201111051648.635300-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111051648.635300-1-damien.lemoal@wdc.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Conventional zones do not have a write pointer and so cannot accept zone
append writes. Make sure to fail any zone append write command issued to
a conventional zone.

Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
Fixes: e0489ed5daeb ("null_blk: Support REQ_OP_ZONE_APPEND")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk_zoned.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 1d0370d91fe7..172f720b8d63 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -339,8 +339,11 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 
 	trace_nullb_zone_op(cmd, zno, zone->cond);
 
-	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		if (append)
+			return BLK_STS_IOERR;
 		return null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
+	}
 
 	null_lock_zone(dev, zno);
 
-- 
2.26.2

