Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DE5C19759
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 17:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5419D20838
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 17:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IVBqXIe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbfHAR1m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:27:42 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:51031 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfHAR1m (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 13:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564680462; x=1596216462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IgUzTAowEehxVPy1GjSbTQ+bVkESBVQsvVByDFqex5Q=;
  b=IVBqXIe8mTf3a2OSazl0XeF5+zIVUdJr9GAjJihObEKaBYcnE2XUi0dH
   iwvkqVec/Q7VGBadA/QWIl9rkCnpzRB0U/iQP8aFjaTToDxBcOLWqqfEs
   ygSVU7Fi2LfQhubKugh4/z0x1TwaV5qxSdVYoaj4kc+X8ThKY60mkLCRh
   O/Kcu1kndJhc95pdLcYEhZs9Fmd12YRal4hEYZzTdldN9FYajsHH7iELf
   tbfH5lSw8d7ynci6NvayDRYE3ZLHm61TjfuyLhIwVyQdMHugld2Di4FRb
   3MU6q+xEOQ6XnO6/p3gj5D8aX8bvgIphOmW66EdzAlVYV9Kt9K47tYIfq
   A==;
IronPort-SDR: eSYnRvgxiL+/F7P8Wqc6SDkYaknp41qWsJ31FTmfsc54wWJ1UURkflut1eAbVgOk36oarUQ8+f
 E59uxLfKFX/SDm0UANZyu/zxWIhVTDfw0Oq5bSviq0XnxQkZMI0ER9tB5wxGzZZ0abtlKI25kG
 FRvAv67DkrSYa6P4NpVuirFKPH7IbERpQtq3no+Vs9aHZxgHKg+6FxDvAsxCSYzNDVWfGQSk7Z
 YB+8RoXeRXqx+Pa0i98M246DD0pb9tewIEtNlcbaju5wXB29Osaa4HKhIcVlEyLIRAbwJm/1a4
 RrQ=
X-IronPort-AV: E=Sophos;i="5.64,334,1559491200"; 
   d="scan'208";a="116323343"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2019 01:27:38 +0800
IronPort-SDR: gQgFn+iUy/qpOac/no4D9fBpn0XhbarUz7A3tpKAWRm1LG+2C+3NwJQmIif0o/tdCN2B2RTnIQ
 Kn/kCypcy67GYveNZqmTm6ny/RToRiDAiKoOVUwQLQfXC24JgXICH2v0PEmtBVdEMI+riA3de8
 h069sftsyIqXyPyDOYWaW8xaR5phqaMgZVZa1VpOQHtno+qC94a1l4k72T98OJX2ikbBVh9HyM
 xoEldhYhUxMTh3n9GGi7zBweLoIPOCl7zNvrt+VjMfMvCrT4Om0vqq5UDo5Q1/4JA0H2fMyZT+
 2QxCkCIM1Q11ckv/sWBr5n/z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 10:25:37 -0700
IronPort-SDR: Fx5zpqxzUinEvFvpUg9ulqrpVDgeXiuzbALQ9GbOllbA9p/VJ4S9rCLHO/bljnIxiZc+5C78DR
 fNguOp4tFzKoKcSTyaqsGk+Pjyfws9WFcFGwufEAP6L/uofwWKN2F2oiDvuBzDfLb2OtJHuvFD
 bBj3gREjvxlCC4uvCl8G3kYeKmffJrPSH5Waq55w3CoYJY4Fy7wq664GvaB6oQMQ163wC/RITj
 rbM11PLvv3tVfJ5ZEd78dVcoJDoPV7Pk0GiK4+aOVTfuwMhGChh6OeEfpXhLohGP0bexVbjyKX
 xDs=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Aug 2019 10:27:38 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, dennis@kernel.org,
        hare@suse.com, damien.lemoal@wdc.com, sagi@grimberg.me,
        dennisszhou@gmail.com, jthumshirn@suse.de, osandov@fb.com,
        ming.lei@redhat.com, tj@kernel.org, bvanassche@acm.org,
        martin.petersen@oracle.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 4/4] null_blk: implement REQ_OP_ZONE_RESET_ALL
Date:   Thu,  1 Aug 2019 10:26:38 -0700
Message-Id: <20190801172638.4060-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
References: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch implements newly introduced zone reset all operation for
null_blk driver.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
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

