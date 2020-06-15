Return-Path: <SRS0=pdd5=74=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976F7C433E1
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 23:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76381206DB
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 23:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pGvx2XoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgFOXfR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:35:17 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40431 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgFOXfR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 19:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592264115; x=1623800115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ts4aTclmB4oUq4++RrNc9NTK0M6BPwdTxbFaUukEoc0=;
  b=pGvx2XoZUJccxdhjwEAptm/usX2iV6dNBJD3kRsc+iC32M0TAq3K3RIR
   ATFoYexfQjzXxj5I1HKvzgdyMCyu0p0F8tMLEoz52+rqHt2fo1giqYvAU
   2yVBUQfoV5lV0dEWw7TDPzquojgjmB1MHhSdpT4vvUnPuuA/4mSwH2gy0
   CVkpMb6ltWQ3ItBZpZdDYlUSiJ/COxIQua5a1AnNr/6shqNOgIdzQkurI
   0nmCo/DuHLLMG3q0NdbJXe+dCp9szZNh+hlHATmA2fjRCioD7S5FaIeLu
   COLqsUcnNZLLUHkWX/7I/YXN24OhSAWzs5wqwhZUwhQLnIPRN2VS2kmYK
   Q==;
IronPort-SDR: MYbzfwQ65g/Cfbhup64zqYg/SqtoNDxFGKmGmK8Oo13ePdH5Y2Bau40aw7KMkPM1Skpu7MF0im
 tO+MSEJCpOYeZTk1mPRExDFC7K45DeYU88DguKOi8e+BgZQp9svLwIQjOW25Re6BJWVPwPAE31
 cDj+b6zPYs1LrajLJ9IDY6O/ko7pLOBMhbZ/T/4If3IQuY8kbIey53jYiwUSQxcE0xsvENl2ra
 XfceYoLvr8tMUYKC5Mj0Q3dPq0I+ISK8AZDxbMq4DEUhLQHT9kjPxMAd6y0MKvpaHHeUV+Fr1R
 7Ss=
X-IronPort-AV: E=Sophos;i="5.73,516,1583164800"; 
   d="scan'208";a="249248743"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 07:35:15 +0800
IronPort-SDR: sMIh2aUE8qOAkhJWQqDOUc2cspQ5XIj5lOFbgxzm2ja5L8FLg33jnAUeYWNW3g3Z+K34ljjKt2
 rYlPZg86zfx1FRAqqpzKki1sRtsrd+3bc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 16:24:33 -0700
IronPort-SDR: KNSQXFIT00Han6jm05uaHhwi67rlhVKWeJbiOXiZRkbJKJKcQYwlAQyksmuSy6r/96Ev+eUSzH
 XPgpgy3o0LvA==
WDCIronportException: Internal
Received: from unknown (HELO redsun51.ssa.fujisawa.hgst.com) ([10.149.66.26])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Jun 2020 16:35:14 -0700
From:   Keith Busch <keith.busch@wdc.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] block: add capacity field to zone descriptors
Date:   Tue, 16 Jun 2020 08:34:20 +0900
Message-Id: <20200615233424.13458-2-keith.busch@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200615233424.13458-1-keith.busch@wdc.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Matias Bjørling <matias.bjorling@wdc.com>

In the zoned storage model, the sectors within a zone are typically all
writeable. With the introduction of the Zoned Namespace (ZNS) Command
Set in the NVM Express organization, the model was extended to have a
specific writeable capacity.

Extend the zone descriptor data structure with a zone capacity field to
indicate to the user how many sectors in a zone are writeable.

Introduce backward compatibility in the zone report ioctl by extending
the zone report header data structure with a flags field to indicate if
the capacity field is available.

Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
---
 block/blk-zoned.c              |  1 +
 drivers/block/null_blk_zoned.c |  2 ++
 drivers/scsi/sd_zbc.c          |  1 +
 include/uapi/linux/blkzoned.h  | 15 +++++++++++++--
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 23831fa8701d..81152a260354 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -312,6 +312,7 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 		return ret;
 
 	rep.nr_zones = ret;
+	rep.flags = BLK_ZONE_REP_CAPACITY;
 	if (copy_to_user(argp, &rep, sizeof(struct blk_zone_report)))
 		return -EFAULT;
 	return 0;
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index cc47606d8ffe..624aac09b005 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -47,6 +47,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 
 		zone->start = sector;
 		zone->len = dev->zone_size_sects;
+		zone->capacity = zone->len;
 		zone->wp = zone->start + zone->len;
 		zone->type = BLK_ZONE_TYPE_CONVENTIONAL;
 		zone->cond = BLK_ZONE_COND_NOT_WP;
@@ -59,6 +60,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 
 		zone->start = zone->wp = sector;
 		zone->len = dev->zone_size_sects;
+		zone->capacity = zone->len;
 		zone->type = BLK_ZONE_TYPE_SEQWRITE_REQ;
 		zone->cond = BLK_ZONE_COND_EMPTY;
 
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 6f7eba66687e..183a20720da9 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -59,6 +59,7 @@ static int sd_zbc_parse_report(struct scsi_disk *sdkp, u8 *buf,
 		zone.non_seq = 1;
 
 	zone.len = logical_to_sectors(sdp, get_unaligned_be64(&buf[8]));
+	zone.capacity = zone.len;
 	zone.start = logical_to_sectors(sdp, get_unaligned_be64(&buf[16]));
 	zone.wp = logical_to_sectors(sdp, get_unaligned_be64(&buf[24]));
 	if (zone.type != ZBC_ZONE_TYPE_CONV &&
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index 0cdef67135f0..42c3366cc25f 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -73,6 +73,15 @@ enum blk_zone_cond {
 	BLK_ZONE_COND_OFFLINE	= 0xF,
 };
 
+/**
+ * enum blk_zone_report_flags - Feature flags of reported zone descriptors.
+ *
+ * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
+ */
+enum blk_zone_report_flags {
+	BLK_ZONE_REP_CAPACITY	= (1 << 0),
+};
+
 /**
  * struct blk_zone - Zone descriptor for BLKREPORTZONE ioctl.
  *
@@ -99,7 +108,9 @@ struct blk_zone {
 	__u8	cond;		/* Zone condition */
 	__u8	non_seq;	/* Non-sequential write resources active */
 	__u8	reset;		/* Reset write pointer recommended */
-	__u8	reserved[36];
+	__u8	resv[4];
+	__u64	capacity;	/* Zone capacity in number of sectors */
+	__u8	reserved[24];
 };
 
 /**
@@ -115,7 +126,7 @@ struct blk_zone {
 struct blk_zone_report {
 	__u64		sector;
 	__u32		nr_zones;
-	__u8		reserved[4];
+	__u32		flags;
 	struct blk_zone zones[0];
 };
 
-- 
2.24.1

