Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69031C2D0E6
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 18:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F32B2074D
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 18:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VEMCsO1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCYSzW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:55:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44174 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgCYSzW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 14:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585162521; x=1616698521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SMqrVIxmyvYEcdfWLdY4bxb+aY3Ae9gNUDcSxMsnEZw=;
  b=VEMCsO1rYFFOjoVkIdub6wYHAVL4233DfKiOZQA2dzq04bI39F1tx4uH
   awdj+EIKzuC5U37x1DbCLrSQGmheU388Buuyaml+71EcR/udtNY0jeDRy
   YmTFLugqBZT+6CUlYw4W2fG6x5Dmc/dHE4bL1qnrAhAHSGGtNBXuvEhfM
   sB1tTU7VaFxGHCxa4pauO4ASbeNB8YGvayR+nzTe2jT6zARuPPhKIQBEZ
   tjccPE7SJTCZUlwlx6Y8NyhUvh6YDXugTlZv++UyDLNqREIWGaewKp2xQ
   JxozThUF+ooaTDbzl73NDPUlTGbaeK3OZHTBvYt7bd48p7tZ2TwLr5mVE
   Q==;
IronPort-SDR: TcC9jFpMxsU6qA/iU95ks46ss0ADUC37Ukm5Sg9fhg2naL8Sofd2NfjIcC5+2hiBORkDh7WtJD
 h/+lKqXon7/2EuLe0UsfnLVYkN6cnNekfsrcMQq+UIrNmm5zW0gFozipei1tSFRRp+pq5vTKbv
 IjArFgEQKoU9s0OHiSsrmlUzgjxYzX25bZQfO730wt/AyVljEHPkMqx00ukGcysNtaOgXxxLvh
 ct3VljDdmbMbNS5Hv6YeMgufv5MaLNIpi6X/cUTtY+PVvXyHUBmYb7BzbVqkhRdOt7RFWW1VN4
 WIw=
X-IronPort-AV: E=Sophos;i="5.72,305,1580745600"; 
   d="scan'208";a="133494483"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2020 02:55:21 +0800
IronPort-SDR: UiKs4zX1bW/Rcdz3Vs77itZllb7Mw0XMo2wLZ7HpnWPWOZIasinaNG0ADi8Oi7DonHHSRvUDkE
 sJcEz3XLNdRbPZYI08/7QbIGL0ZnWva5agGxw7iibzQlTl7iUWLr2Jei3RUvICWtxJFBPK6ep0
 NU+gWF6eZneRnLIuoKVnXv3SIbD3Ue2IuWcIDCBnW4fWpKgIPcY9Z9Tz4Y0vKzeTNET1j9Qmte
 +GHmL5/ckZwFT5nQmofXPsVf6RRRtR+HRTk3Zql9+FOIefpZyR2IGNS3dHZik3wjsOmpL4XoiH
 QI6msuf3sV+SrLcnaPV3ERJd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 11:46:32 -0700
IronPort-SDR: NOFjULn9ceRjRiDFEhpfnVCdLEWQCs1MIXnVFZkdirhBuRpYs2W3XZXjxx9axGmBMVhRRFL9Gw
 m/bY3RVDz1qdSST/tqZxLXuH/x4eZGchcPecvulnxKI/F4wmtlJlCfURzR3frbaRxkHkF07uW9
 OykDknPKUB5Jxj+ndyL6/TnWfe6oD45rPnTuXMBEXT+Su8UAUBopUNcpZRwZ2cvqKB7LZTMwfY
 KI3gYHZ/bviM2+sJDZlGuIhsoVQA22AsItXgJITPDQ3wEtMxVqsszHiibkHOwRUYfCkQuIEII8
 gEQ=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Mar 2020 11:55:22 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 3/3] null_blk: add trace in null_blk_zoned.c
Date:   Wed, 25 Mar 2020 10:49:56 -0700
Message-Id: <20200325174956.16719-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200325174956.16719-1-chaitanya.kulkarni@wdc.com>
References: <20200325174956.16719-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the help of previously added tracepoints we can now trace
report-zones, zone-write and zone-mgmt ops in null_blk_zoned.c.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
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
2.22.0

