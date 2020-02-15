Return-Path: <SRS0=Iyu6=4D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A75C35242
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 00:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDBA20726
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 00:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oFEvn2gZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgBOA6G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:58:06 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49846 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgBOA6F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 19:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581728285; x=1613264285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DYyJ+E40k/e4I8+PSANvrJI06g/bZ7Q5iQX0Tcyb2mk=;
  b=oFEvn2gZgQqyxtagxeNgwtDFM3O43GRBqKkGFg5eBcFRZFwTnrPHUbeF
   XuGsaK+P3/Ax3FZuPKx6F93SM1Yzko06CnmRZYoEuOtM+qMhHSm0T3sxq
   9aFbWdP53DsH3nmoHV1fW5QBRCwCQ9GpJlx6lpHW8E1nf6hybZKbhyLIN
   kRe1JiJ+01zG1tuZof1PKJbl46WxXC4XCJhSiqzuWPX4Mgmyto97YVIIm
   4Bd+9IXkIkLAf8wBdpKT3yQZ3N8xvN4XVTe6tDIMvP6JAx5ZGi2s48i/i
   neEBx2dFTa0bkk+4Sr4LpYwYv4WII4Bx385476pPB/LnalVuONvdDepPs
   A==;
IronPort-SDR: il27ZXHrjt+kL4BiGymH5hlyJ1mEP8KsLg+VMpq620aGX6MEeVC8zSHLzQZhMXffz+5oqDaRSc
 1UAPcHIq3hC7InUC/lODqvRcksequb8LfOtYfaFHk4+zE5hOWs4133rNqbvcSBYQQ9myAZy+Si
 Hwd1OyHL7D97k3yH6IO91sasiUYAw/pe+eghyo/Qmr1P/k0NBw1Mk1uDkO72elalpTkn5eYQ/1
 9ONXsCHlTa/eU7dvYA7UGKufOHp2MazYYlM+Q6Uxdpw8SBFoP+E7c4tePI59+fUc1/iuUmFmAv
 jWE=
X-IronPort-AV: E=Sophos;i="5.70,442,1574092800"; 
   d="scan'208";a="129905405"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2020 08:58:05 +0800
IronPort-SDR: hkQMpJQ6oF6RyL6KaBFmosV7dIqjLH5jtoOIqMq1RCxm1FX+El7ZrcrBvi7t6jwmVHojDnYXZ9
 N8H6sH0/V29BrDpKVgWjBUJmFo/MbGg79mLPWae94B2Sa+1lhd+LzYrtTzXnZWTrF2ovID/cEt
 HZktPJrlY9xHHaicWPHp+L9F6nrKqlcU1qv06GPe5kiUPWSiMovFaYkdMZeoaawoBixjMNW8hv
 AFkIiW3yueS5FvImAU+lrWj2ZhDNqiOYsTPHpslYDfyW4vCz1oxwEoACpX5ETiBmRlrVsmmn0u
 boVoUS3Y0CxVbDGVKSELiyCR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 16:50:50 -0800
IronPort-SDR: hThJ9weKWzCzB4Kv9hCUQ6DQeLyig+4A1hooySwEwdsDCnY0JTrUejxqaAVpjsi35qZSOA9EqZ
 T3ciZXYPEeBY+0cjBfBTQ+MGv739iWfHnJO0I7lhOQVgIoN5bJtRgxcl8GpCozkTAz4Oua/r4O
 o10Ryyd3/z9WwGvi4FsEqW+GEotpf92eVdMsYigOl7PM5omKCejNV18OjXi86DSrKart4vAhdH
 0IA3brj1go7y+qWXoNBGlnINm447XJ1OZKaStCWxANwbDYYtr+Kx+1RY7vTwln2jAXQ/OVufOG
 ms4=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Feb 2020 16:58:05 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, damien.lemoal@wdc.com
Cc:     kbusch@kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/3] null_blk: add trace in null_blk_zoned.c
Date:   Fri, 14 Feb 2020 16:57:58 -0800
Message-Id: <20200215005758.3212-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200215005758.3212-1-chaitanya.kulkarni@wdc.com>
References: <20200215005758.3212-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the help of previously added tracepoints we can now trace
report-zones, zone-write and zone-mgmt ops in null_blk_zoned.c.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_zoned.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index ed34785dd64b..673618d8222a 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -2,6 +2,9 @@
 #include <linux/vmalloc.h>
 #include "null_blk.h"
 
+#define CREATE_TRACE_POINTS
+#include "null_blk_trace.h"
+
 /* zone_size in MBs to sectors. */
 #define ZONE_SIZE_SHIFT		11
 
@@ -80,6 +83,8 @@ int null_report_zones(struct gendisk *disk, sector_t sector,
 		return 0;
 
 	nr_zones = min(nr_zones, dev->nr_zones - first_zone);
+	trace_nullb_report_zones(nullb, nr_zones);
+
 	for (i = 0; i < nr_zones; i++) {
 		/*
 		 * Stacked DM target drivers will remap the zone information by
@@ -148,6 +153,8 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		/* Invalid zone condition */
 		return BLK_STS_IOERR;
 	}
+
+	trace_nullb_zone_op(cmd, zno, zone->cond);
 	return BLK_STS_OK;
 }
 
@@ -155,7 +162,8 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 				   sector_t sector)
 {
 	struct nullb_device *dev = cmd->nq->dev;
-	struct blk_zone *zone = &dev->zones[null_zone_no(dev, sector)];
+	unsigned int zone_no = null_zone_no(dev, sector);
+	struct blk_zone *zone = &dev->zones[zone_no];
 	size_t i;
 
 	switch (op) {
@@ -203,6 +211,8 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 	default:
 		return BLK_STS_NOTSUPP;
 	}
+
+	trace_nullb_zone_op(cmd, zone_no, zone->cond);
 	return BLK_STS_OK;
 }
 
-- 
2.22.1

