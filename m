Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C14C3A5A3
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6CF2173E
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LJ33/fk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfHWAPf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 20:15:35 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30877 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfHWAPe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 20:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566519334; x=1598055334;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Q6TmPmMv56etbAvtxMa6qD+NEnfvcD+6MpqN+p1kTrg=;
  b=LJ33/fk3V3yCcAknkvW6ZWhsZjxpsoFtuOmppLDzqA0U/a/nahgSkV3h
   XGVAfTFWfw/XDMG12yrrPcoI9P5SZrWz9Yk0Qo5WdZYs1A9t8NQVKZqqx
   aQ0OCj+7XakSprAft4Ut8PEFrN3ZMJfV9CXA/3C0tLWzM0BJ2ikZUknpL
   yor692DNL7G9Q2zOBKM9oaDfhnmv3EDggYo7HtHS6BQaTMFR6XfFyzvF9
   JtbvXIJye1uSzREE7ThvyHvWbRCQiLUakTRQ3Zs+8WgM1A/YrQ77OGxJt
   THBJEzNMtiUsBKIoXJ4+9Bkac/P06AB/slRIA+yrkyN3KfMkEZ3OpjeIs
   g==;
IronPort-SDR: C05wipZo27JSYASekDFvGeValGCGsjtBzH+uPuBA5AXGOYgc++Ib4YO0kYXskTZ0f6DETSI7Mb
 ddmvogUEzXX/VuMzdyBqGlXh7HJ8usqUo1W7qb5wCgwwYuVmRQJ+BN/+PfPKN5ILxpQ9GsdkDn
 Er6zuYOsfSFYC3fvmROhCnCHpPvEqfslfC5FNSFVUTaKve4QlFEUB1lgkbfN2H3/I7bvCqYhuE
 oX1Jb6KX12svbQvuiQtoH0ONohgPY3RpLenYdMZ7xq+Q63+pvQgGMGzuz+JdUV90vKvfamJx5r
 X38=
X-IronPort-AV: E=Sophos;i="5.64,419,1559491200"; 
   d="scan'208";a="121063670"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 08:15:33 +0800
IronPort-SDR: v1VwbJmIzF8/4IqUjz43zlaHlQfPEaQQISZGhF9MVxmDMjpZod8a5UywjKOnzdIDcB2kxYEI1a
 jugSPr7mXQn64WJTZjM6gFycaMm4t/v2Ude05swY9aESOkhKUaEtYBnx5/o33tMquHbjcu17BY
 4YqJ9rnvxzFhJdtOy0TDmADnFVRtMjwcQ1+GFl2apdqtJFP7s9StOiARTn2tbIUvrft9RONKQs
 3WqkLGOwCqOg2yg0BADjOZz+7TbJ3YbIvxInRO/RX/lRRLtz9czeo71gXOz3h73sLonylUYRlq
 cpX/57nK0hYE/yh+1TIDHf+P
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 17:12:52 -0700
IronPort-SDR: Qwy5yDA5DDl56sdDPw76iawHJY9rUel09PbIcAHyQhbNaL7+EIUiWZLlgCWbSsktGDuHsxcmYq
 qvqrb+P89BDyAg699QAnSHKF6/uPaKRIBWp6c9Z6SPGJAwfMz1gMGA8PXVMRvEpGlbO8q6jkjp
 LJa/NqvRac1RIK9clDaffiBLBTbEbbZ/RdMCB8jUKbUWcn5/sraG4MRFJblrBV/3APps7bz8EC
 uPAJwpwAZDubtsZ12k06MJ7HxrzFPlVkx8vCD6oC6DQXinplGfIcAz4VZ1UnIMqzzUKv00hO4X
 6aY=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Aug 2019 17:15:33 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/7] block: Introduce zoned block device elevator feature
Date:   Fri, 23 Aug 2019 09:15:26 +0900
Message-Id: <20190823001528.5673-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823001528.5673-1-damien.lemoal@wdc.com>
References: <20190823001528.5673-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the elevator feature ELEVATOR_F_ZONED_BLOCK_DEV to indicate
that an elevator supports zoned block device write ordering control.

Mark the mq-deadline as supporting this feature which is implemented
using zone write locking. SCSI zoned block device scan and null_blk
device creation with zoned mode enabled are also modified to require
this feature using the helper blk_queue_required_elevator_features().

This requirement can always be satisfied as the mq-deadline scheduler is
always selected for in-kernel compilation when CONFIG_BLK_DEV_ZONED
(zoned block device support) is enabled.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/mq-deadline.c           | 1 +
 drivers/block/null_blk_main.c | 5 +++++
 drivers/scsi/sd_zbc.c         | 2 ++
 include/linux/elevator.h      | 7 +++++++
 4 files changed, 15 insertions(+)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 2a2a2e82832e..95e03408f2ac 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -795,6 +795,7 @@ static struct elevator_type mq_deadline = {
 	.elevator_attrs = deadline_attrs,
 	.elevator_name = "mq-deadline",
 	.elevator_alias = "deadline",
+	.elevator_features = ELEVATOR_F_ZONED_BLOCK_DEV,
 	.elevator_owner = THIS_MODULE,
 };
 MODULE_ALIAS("mq-deadline-iosched");
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 99c56d72ff78..253bb7b4443e 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1538,6 +1538,9 @@ static int null_gendisk_register(struct nullb *nullb)
 
 		if (ret != 0)
 			return ret;
+
+		blk_queue_required_elevator_features(disk->queue,
+						ELEVATOR_F_ZONED_BLOCK_DEV);
 	}
 
 	add_disk(disk);
@@ -1691,6 +1694,8 @@ static int null_add_dev(struct nullb_device *dev)
 		blk_queue_chunk_sectors(nullb->q, dev->zone_size_sects);
 		nullb->q->limits.zoned = BLK_ZONED_HM;
 		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, nullb->q);
+		blk_queue_required_elevator_features(nullb->q,
+						ELEVATOR_F_ZONED_BLOCK_DEV);
 	}
 
 	nullb->q->queuedata = nullb;
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 367614f0e34f..983f5d0be902 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -490,6 +490,8 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 		goto err;
 
 	/* The drive satisfies the kernel restrictions: set it up */
+	blk_queue_required_elevator_features(sdkp->disk->queue,
+					     ELEVATOR_F_ZONED_BLOCK_DEV);
 	blk_queue_chunk_sectors(sdkp->disk->queue,
 			logical_to_sectors(sdkp->device, zone_blocks));
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, sdkp->disk->queue);
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index a99ca9979d71..2b667cb23fc0 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -166,5 +166,12 @@ extern struct request *elv_rb_find(struct rb_root *, sector_t);
 #define rq_entry_fifo(ptr)	list_entry((ptr), struct request, queuelist)
 #define rq_fifo_clear(rq)	list_del_init(&(rq)->queuelist)
 
+/*
+ * Elevator features.
+ */
+
+/* Supports zoned block devices sequential write */
+#define ELEVATOR_F_ZONED_BLOCK_DEV	(1UL << 0)
+
 #endif /* CONFIG_BLOCK */
 #endif
-- 
2.21.0

