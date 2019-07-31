Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B289C433FF
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 21:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709CD2064A
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 21:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pJ83vmct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfGaVCK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:02:10 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41878 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfGaVCK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 17:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564606931; x=1596142931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=NSomUKo7kGp1ISvH1icFd6X5WQMDjpWSwgevf/PzYy0=;
  b=pJ83vmctxZaJomgd1VFVSo5KKWWchYnh+pT5+DToNcanP2J1IzTWrLBd
   mrBz2PAQyR/MwjQjH8mfLbZ1FAT+SEcFxm7DVFZ4AcxEjcpQy2vfeHE4P
   yuhgflFJUQAuklui/i+lG4ZA051n6/nSrZIP1W+uBgIHXbOTFymEpA7vZ
   muV6KUSgVk7eHDHpC8wd0bwG+11FT9W7ckiIV/MwVhWyM/ANYFDfYb00/
   P8Ilo73WYvVRmanfVFL9IFvr2EDC70Vl6VWnyxdTU74zaASJebkHaQ0ue
   irLnIekIrbvk6XbdiHvEPz9maPUBCB/4zqVMOXH425WF8J67dJzOxzs2k
   A==;
IronPort-SDR: v51SlOvX79Tp5a6YYZKzN2d6NF4pGXx2a1UdcdmA5+9U+mbc1uy95kqvNVy8Mv7VIDRE0EpviD
 7J0k0lzAEwEXHqeOBinrgD9NoEnRzFs80bxg94UwiQLzoMvmqSPVf2r6vWGrA4yXs5HdJ1PXQU
 pr/FEqXGDs4LpWzrau+0xmrl2gkKpOHw/mVz2iytzgiNkX73P3Qw+HUw0lL9TcCEcvvXzPrZam
 kUJsrLSMK8jnk71MhLICM/gcOYRWMVmIYaBh3LdbQsm9yXxO2OYljK47J7aAzTjIfoWy7zwwKG
 AwI=
X-IronPort-AV: E=Sophos;i="5.64,331,1559491200"; 
   d="scan'208";a="119303865"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 05:02:07 +0800
IronPort-SDR: luzbxR8g/CenbYOAkcDZZFORQgqlEhOO7DljDf6Pmps2aQAXDVxP/4IzhhXLizpt0Ai+xU0/m7
 D+3l0/+TYkwKlh+5jY7OMGHO6NX5096Tps4ti4kNoqrf/jhtLDX/npSEGHh2GkK0UZgz8spz0x
 y5ZTeQ+ngidH/3BPlYUc5T52+YCuJXOjOGpE2mVhqPLXNGGn0Pg3zwh8vb4VpeRjwv1sKMirce
 aw5WAFk/YFuP23HviNhEsbBu48e4CKQjxDrYvFhrh+73yAMevoMQc9kuwlbUxI9K65vRYddGaP
 cb2C9AF+f2WD8+ibGRq38nfR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 14:00:06 -0700
IronPort-SDR: EIf/bz18sWQ5oKgdcNXtK/+/6sB3XfeDvjnP+iV/h4SdMlQBJ4AK0O+9oUBHmGf5YCOnr/iAn+
 3KUx9r4eCSeKO35hri4x6vu5A05BDe64+dHtnXplehg9cZOKwkZJcgQlB27CttGUJHTxqZO1h1
 1ZGejDYuV1GcC288RWYFpPgn1erkkRIMfw61ERNiiIRtfn78AL42aM7byyAPTwb0Hx+DGucVGU
 2npTa9S8dA77EBLbBrzZRlowZB6GWegMV8kA6U3Vjq7ZyERqk1olRy74HsT5mRSUbYYn8mSFpA
 g44=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2019 14:02:05 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, dennis@kernel.org,
        hare@suse.com, damien.lemoal@wdc.com, sagi@grimberg.me,
        dennisszhou@gmail.com, jthumshirn@suse.de, osandov@fb.com,
        ming.lei@redhat.com, tj@kernel.org, bvanassche@acm.org,
        martin.petersen@oracle.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 4/4] null_blk: implement REQ_OP_ZONE_RESET_ALL
Date:   Wed, 31 Jul 2019 14:01:02 -0700
Message-Id: <20190731210102.3472-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190731210102.3472-1-chaitanya.kulkarni@wdc.com>
References: <20190731210102.3472-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch implements newly introduced zone reset all operation for
null_blk driver.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c  |  3 +++
 drivers/block/null_blk_zoned.c | 28 ++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 99328ded60d1..99c56d72ff78 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1214,6 +1214,8 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 			null_zone_write(cmd, sector, nr_sectors);
 		else if (op == REQ_OP_ZONE_RESET)
 			null_zone_reset(cmd, sector);
+		else if (op == REQ_OP_ZONE_RESET_ALL)
+			null_zone_reset(cmd, 0);
 	}
 out:
 	/* Complete IO by inline, softirq or timer */
@@ -1688,6 +1690,7 @@ static int null_add_dev(struct nullb_device *dev)
 
 		blk_queue_chunk_sectors(nullb->q, dev->zone_size_sects);
 		nullb->q->limits.zoned = BLK_ZONED_HM;
+		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, nullb->q);
 	}
 
 	nullb->q->queuedata = nullb;
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index cb28d93f2bd1..8c7f5bf81975 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -125,12 +125,28 @@ void null_zone_reset(struct nullb_cmd *cmd, sector_t sector)
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
 	struct blk_zone *zone = &dev->zones[zno];
+	size_t i;
+
+	switch (req_op(cmd->rq)) {
+	case REQ_OP_ZONE_RESET_ALL:
+		for (i = 0; i < dev->nr_zones; i++) {
+			if (zone[i].type == BLK_ZONE_TYPE_CONVENTIONAL)
+				continue;
+			zone[i].cond = BLK_ZONE_COND_EMPTY;
+			zone[i].wp = zone[i].start;
+		}
+		break;
+	case REQ_OP_ZONE_RESET:
+		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
+			cmd->error = BLK_STS_IOERR;
+			return;
+		}
 
-	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
-		cmd->error = BLK_STS_IOERR;
-		return;
+		zone->cond = BLK_ZONE_COND_EMPTY;
+		zone->wp = zone->start;
+		break;
+	default:
+		cmd->error = BLK_STS_NOTSUPP;
+		break;
 	}
-
-	zone->cond = BLK_ZONE_COND_EMPTY;
-	zone->wp = zone->start;
 }
-- 
2.17.0

