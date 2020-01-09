Return-Path: <SRS0=+EVs=26=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40E3C32771
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 05:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963D4206ED
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 05:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kwEma+4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgAIFD5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jan 2020 00:03:57 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:62026 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgAIFD5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jan 2020 00:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578546257; x=1610082257;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ObIcwdZj7I0ZMhphbtS1B1y5id4rLf/Jh3fUKqYV/Uc=;
  b=kwEma+4P/GYhJ9d5FxNV6Gu8s6Mxlv6lfNwXZUFkQksxnD7YAQSBBavF
   H4sbuTZsFIyN82c6HOCy0ucgLRc503z0x6J4/YinxO4x9y0GuZCZaqpLi
   nYWQIKYk9w87++ueM5iCdi7d18Iyct4jdQSFg7v8mKEGKpDOX+01Irvc8
   2QgZk8LNE/bHw3B0p8JBOxc2IE/ng3zGsxmOsPrJi9n+wTrr/EHJMO+wa
   2S8V+2U/er/jtfAL0mYe500/ipxm6fI3EnVrOmjpM4e7LO4cUXkOHCR7E
   TK8Akpak+tDNLSRxpFDF+Pz4eIdX2GJ36vuc+ZEHq061y+rZmX46NC4qG
   w==;
IronPort-SDR: V0vDBUbJW5HjyRHDuuuuMefQStztJRy6iYsoWaMMyoPAoBMhGek4Lybt9ZYymHpMCLVIIzyiAt
 o8HZpFnp20hB4fAfXxrNJWhDI0DIj0b6tmhK2h8PFQwdANcFP5rPPWvomE7pBfbxfb2nudqyO2
 khnCA8C4v+Rgj2ZwAz9Xo27ejXsCmZXXhnEDsyWp6xSp55VGN3zjC3amLNWDzRkuGKC+MgATJH
 GExOg87rWMaS/BQqdPqWni0rSWCUUjT6Q8N+kyVlxcq+Hmn/hkAYZV1d18ydQ5aJO3fJsa7cj3
 VLs=
X-IronPort-AV: E=Sophos;i="5.69,412,1571673600"; 
   d="scan'208";a="228719467"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2020 13:04:17 +0800
IronPort-SDR: Hj7tkNgchBmmKG4sBlhvYsy29H1z/hqnX5WcCi9oSFofuZ+/9tRfd53AMWV6d/YIgtstY+bRSh
 ou7y+gjGJDrSKn3AQBKrD5c+bBOevRNqsK8KPMSE0MZH8fwrBhBxhXWt6zAaTb6N6t7vVREfu7
 fBMBRD1XKUrmct2CEIBpayW95bqZluFvS++cRDxCxsFfeIesorWWUKJOpkYY2jbcBJGGJvsSUh
 XWMIrotB+kuGWfH8DwEkPcbJ2Hl7AkrYzIzns8f60Os4BmKuZuJDikQqmVi12w4YwAu8fin+LV
 41p9Q9HQ4sA7mHG2xNj2dXfV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 20:57:43 -0800
IronPort-SDR: P69WlmoLD3nbC9zI4WWMPWZbiXWT9NfmMiLYDt7yLflQsDr4S5SF9YpBBtcDTrIUQ/DpyARWOf
 oWE7zFmi7hFQnunWd8gM27F9hNCyl5vYiuWzQKoFW6d+iRAcGoxj5oinQL4bssuu3FHgdpn7yD
 0wnK8TicmnDf0iDHV87hDL+8PupxnqpgLB4rbhkUqpqyiii+f+7i6hj8RlB5iTUlsdP/EjEBFC
 4B4PBG5f3/0VXuHV1Qj8AAzfRh3QSM2AygAVbTqHRBzzXd8C6g4jinnnW+R/CNCQvD4ESfX28c
 wFA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jan 2020 21:03:56 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] null_blk: Fix zone write handling
Date:   Thu,  9 Jan 2020 14:03:55 +0900
Message-Id: <20200109050355.585524-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

null_zone_write() only allows writing empty and implicitly opened zones.
Writing to closed and explicitly opened zones must also be allowed and
the zone condition must be transitioned to implicit open if the zone
is not explicitly opened already.

Fixes: da644b2cc1a4 ("null_blk: add zone open, close, and finish support")
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk_zoned.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 5cf49d9db95e..ed34785dd64b 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -129,11 +129,13 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		return BLK_STS_IOERR;
 	case BLK_ZONE_COND_EMPTY:
 	case BLK_ZONE_COND_IMP_OPEN:
+	case BLK_ZONE_COND_EXP_OPEN:
+	case BLK_ZONE_COND_CLOSED:
 		/* Writes must be at the write pointer position */
 		if (sector != zone->wp)
 			return BLK_STS_IOERR;
 
-		if (zone->cond == BLK_ZONE_COND_EMPTY)
+		if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
 			zone->cond = BLK_ZONE_COND_IMP_OPEN;
 
 		zone->wp += nr_sectors;
-- 
2.24.1

