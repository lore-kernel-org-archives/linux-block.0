Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705A8C433FF
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 21:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A102064A
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 21:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E/zCpMvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfGaVBu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:01:50 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:43351 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfGaVBu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 17:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564606946; x=1596142946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=xXRosNBom12mbtTqvIaHnPn0dojKd2BQd5wS5bKFIJ8=;
  b=E/zCpMvKZQpmz1QDzv1HQft8AesVAQaCtD+8jvWMS7DnycQScKzKiEnQ
   cIlM7UKKP2GvJ2eZwIdGN0ZAXvNJDfq1BahCQnRLrHL5qEQjJj4d/diD9
   WpMCZIc67gl/TmONqYQfF0ZCoIbqLGAUgYcrQ8mnYtHHqdlxxH1fofYNT
   XF3iwxb1dDHNqphEta6e+OK8A8i9ZgZBHbBG5lCse4Bpx1MxlZlcS5HN5
   QG1QwYd0Fi52G5EJNNrmIMEkfHK/ogSbSURvM3moPSkQVKUi01FojD0Wh
   hhjDFKvXG6RqVgAXHXmBzpTDghXcVnp827IKqLxl1kJ4LFhOecm5NyxZT
   g==;
IronPort-SDR: pNwUQG4hG3Qlb4mn7YIeVOAMyrS+nbG+wVrDEmvgqp138qf3VbuOn53MkjqqwcwUmit+JkgDSa
 Q1Ti8ZXP5tlkCJCLunCfJV2H1lAAz8lFNdAMFkPZ4kdZEm/K8ccJ0/zPpDPutRkXTJSRghGiNw
 Ic3qPCaYmOR+K58BooWIqyf8R3BulEPec2k64IgUONWIllLfbgvgSVyeLYA4HOBfJFo9kAd3iU
 Wt3OUPySXi2oJKUEe7E7ENVq4u3Dp7nODegWnv9Y7mO8JgfaCsrW1NcXkHr5HEOAq0qJCzAYKb
 GGc=
X-IronPort-AV: E=Sophos;i="5.64,331,1559491200"; 
   d="scan'208";a="214835129"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 05:02:14 +0800
IronPort-SDR: uwUuUOFRD/TdPYPjTZBrcscYv9RJO3lPurnKk/J27oSCoBW3Q5HrAxn/N91cZ7c9mV5QLv2y9h
 TvdbWOO5alVjUTuJr8SK/DXxnXM/rRGJMdp47J2Rk8JoiPjkRzrhvpzygi0A7I8RnEjgzQoulP
 a3DJ1fC1XbBNgPI/gkvx3C1L4Honti6d/So1wmocKYG25pNaZqHw0e5mJidW9V13G1nLvAtjd1
 k5s9laMS2YonlfMe7CZIqWR/8OnqBQDv1lIAJeHPFUYxilivput+WGHm2Ru/Pfdtik7fvKgbKN
 rt5NunTv4YTx0TV/Kf6om0zg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 13:59:42 -0700
IronPort-SDR: ej4UU8wzu99DbkrE3CX7QsAXE9xPZeJwNOA5PwTw8iz+LfCOLz/mEcMP3wAHYQgjv3KTxvcUAD
 Qm0+bm6U24UN4Lgh+NM0y0AEs+u7wVW3xBmGZwDDPPhq7Sb6siHu1kQBpu0gLJMUKeCTCkzry6
 oJUo/7t5k8CZW2Bq8IM1e9OU+6dC/BC1H6puIXXxrwinr3dbRTPUy4d33gkglrwM1Sp8pZHoOd
 N8oDcX8H/XmdO/bTVl2/Czrnrxc+S5QoSlzcnFwgIjedXQDzyoNg2pmPeaXYW75DPmmQSNTcos
 buE=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2019 14:01:42 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, dennis@kernel.org,
        hare@suse.com, damien.lemoal@wdc.com, sagi@grimberg.me,
        dennisszhou@gmail.com, jthumshirn@suse.de, osandov@fb.com,
        ming.lei@redhat.com, tj@kernel.org, bvanassche@acm.org,
        martin.petersen@oracle.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/4] blk-zoned: implement REQ_OP_ZONE_RESET_ALL
Date:   Wed, 31 Jul 2019 14:01:00 -0700
Message-Id: <20190731210102.3472-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190731210102.3472-1-chaitanya.kulkarni@wdc.com>
References: <20190731210102.3472-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This implements REQ_OP_ZONE_RESET_ALL as a special case of the block
device zone reset operations where we just simply issue bio with the
newly introduced req op.

We issue this req op when the number of sectors is equal to the device's
partition's number of sectors and device has no partitions.

We also add support so that blk_op_str() can print the new reset-all
zone operation.

This patch also adds a generic make request check for newly
introduced REQ_OP_ZONE_RESET_ALL req_opf. We simply return error
when queue is zoned and reset-all flag is not set for
REQ_OP_ZONE_RESET_ALL.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c  |  5 +++++
 block/blk-zoned.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index d0cc6e14d2f0..1b53ab56228b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -129,6 +129,7 @@ static const char *const blk_op_name[] = {
 	REQ_OP_NAME(DISCARD),
 	REQ_OP_NAME(SECURE_ERASE),
 	REQ_OP_NAME(ZONE_RESET),
+	REQ_OP_NAME(ZONE_RESET_ALL),
 	REQ_OP_NAME(WRITE_SAME),
 	REQ_OP_NAME(WRITE_ZEROES),
 	REQ_OP_NAME(SCSI_IN),
@@ -931,6 +932,10 @@ generic_make_request_checks(struct bio *bio)
 		if (!blk_queue_is_zoned(q))
 			goto not_supported;
 		break;
+	case REQ_OP_ZONE_RESET_ALL:
+		if (!blk_queue_is_zoned(q) || !blk_queue_zone_resetall(q))
+			goto not_supported;
+		break;
 	case REQ_OP_WRITE_ZEROES:
 		if (!q->limits.max_write_zeroes_sectors)
 			goto not_supported;
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 6c503824ba3f..d1ed728b7464 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -202,6 +202,43 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL_GPL(blkdev_report_zones);
 
+/*
+ * Special case of zone reset operation to reset all zones in one command,
+ * useful for applications like mkfs.
+ */
+static int __blkdev_reset_all_zones(struct block_device *bdev, gfp_t gfp_mask)
+{
+	struct bio *bio = NULL;
+	int ret;
+
+	/* across the zones operations, don't need any sectors */
+	bio = bio_alloc(gfp_mask, 0);
+	bio_set_dev(bio, bdev);
+	bio_set_op_attrs(bio, REQ_OP_ZONE_RESET_ALL, 0);
+
+	ret = submit_bio_wait(bio);
+	bio_put(bio);
+
+	return ret;
+}
+
+static inline bool blkdev_allow_reset_all_zones(struct block_device *bdev,
+						sector_t nr_sectors)
+{
+	if (!blk_queue_zone_resetall(bdev_get_queue(bdev)))
+		return false;
+
+	if (nr_sectors != part_nr_sects_read(bdev->bd_part))
+		return false;
+	/*
+	 * REQ_OP_ZONE_RESET_ALL can be executed only if the block device is
+	 * the entire disk, that is, if the blocks device start offset is 0 and
+	 * its capacity is the same as the entire disk.
+	 */
+	return get_start_sect(bdev) == 0 &&
+	       part_nr_sects_read(bdev->bd_part) == get_capacity(bdev->bd_disk);
+}
+
 /**
  * blkdev_reset_zones - Reset zones write pointer
  * @bdev:	Target block device
@@ -235,6 +272,9 @@ int blkdev_reset_zones(struct block_device *bdev,
 		/* Out of range */
 		return -EINVAL;
 
+	if (blkdev_allow_reset_all_zones(bdev, nr_sectors))
+		return  __blkdev_reset_all_zones(bdev, gfp_mask);
+
 	/* Check alignment (handle eventual smaller last zone) */
 	zone_sectors = blk_queue_zone_sectors(q);
 	if (sector & (zone_sectors - 1))
-- 
2.17.0

