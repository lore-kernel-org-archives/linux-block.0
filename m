Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FAFC54FD2
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 03:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24502074D
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 03:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TfCgyS+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgCYDVx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 23:21:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:50127 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgCYDVx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 23:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585106512; x=1616642512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SMqrVIxmyvYEcdfWLdY4bxb+aY3Ae9gNUDcSxMsnEZw=;
  b=TfCgyS+D0xHTkum22P6AO61iR8Ztb7Ebtk0tAfRqKpkAVSbF2i77fvzG
   CaKS7BwZOA/W4AOrraBCf2M4AJiJ2SthMeJqai3fGrLii/vogHZ3AC6Sm
   an4c3MHk7VWCZSrkoDIbn8VGeT/16hmbJwMVWLnPwzULD6hd0NadsBjx9
   9mg+VrFd0jBWQX4WK3unUEi0hw+fqWdEMHuscoUA/s6VWNINTfWK6dyhb
   +27lVSSPFxEYsBVwF+Z/jXeiaEmYnPOfs1cEwEJm8lN1CLJRgM7VF0z7s
   FDMLxZCUp5jBq4KmyTNZ0xb5bkzFt+2ao1ot53gISb7G4hb8eM3y8RXAj
   w==;
IronPort-SDR: 0t0641aLsDpC5NI6XjuDFf/w46pI0hdSh+MgOhWFLsogoEOrNkOwv800dKT0jL9NlO8sh6xmDT
 cWk7SpHskDOqcvIHevW8jZgsRMyk/pSdhSYNxZhvc9h86mTwSPW2MHZD9OiQOLW8k6tsm37g1k
 FfI/0jjerrwPPWmtHrg023c/idJhTqxc4sqTQ3AbWBFWk3yR2IR1A7fFLgB/qFDyn0/IGLxAHc
 V6GttfS/sI2yXzC9LiG65N10XOJWc7EtFczcGMloRxYfcDA71jJNro/2Ksso7t+EkW1TO/EeiA
 X6c=
X-IronPort-AV: E=Sophos;i="5.72,302,1580745600"; 
   d="scan'208";a="133423820"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 11:21:52 +0800
IronPort-SDR: fGu1bca/AyvdWhRA7smarwnJHIfTTwrXcpOXtOeEQNVK1CbheG7QyixIZ1QPPeoVA18OUqw2m/
 i6S7elXIxNLYxvB97tOxjTeMbsG1WDMMtB7Negt24L/nPEATx+s+KFAlakScBOGYhL22Cn/TtT
 1hKXZdXmWckfkzLXwimsD9PWqDaRBZsO2aAnSX52VDshFojKiCNif4HHgpoF2jiI9P7f0dzuWx
 KL3ja2NUQaz21gFGRxmnj1o+Oimm3l0En21OgKXcq7Wowz7i4QQvwXb/1A92kla6nuYzJqv4V9
 6pyxo9deN/wqOAa5d+6qQCDc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 20:13:31 -0700
IronPort-SDR: ShhJ5xC0ZEaDiv1ON+E7EypYO4i0Ngn5F3rIp8RqMrGmznlhcvS6QheKAfeA/c635asKoP/lLo
 aU5NNPk3b9hi8OFNTzQg48rNptMPDCdugx1p5EqiLAnUnDUil1SLOZagyFEDYY5hIxtZ6NoObY
 ctbf1OgEZel9fBsO9STmCq8C3JEjro0o1OA7wsI7X9bc2F0DbktP/JS8R/DXnoP1FrCgt9dir3
 /OEOgscVVqng/idia2LYpEeZFu1qUKE5TOmpVGLEH4UOBTCzHSRXr4C0JapU8e3vbUJldcGTD9
 VuI=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2020 20:21:52 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 3/3] null_blk: add trace in null_blk_zoned.c
Date:   Tue, 24 Mar 2020 19:16:29 -0700
Message-Id: <20200325021629.15103-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200325021629.15103-1-chaitanya.kulkarni@wdc.com>
References: <20200325021629.15103-1-chaitanya.kulkarni@wdc.com>
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

