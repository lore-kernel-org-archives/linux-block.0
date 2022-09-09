Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7653EECAAD3
	for <linux-block@archiver.kernel.org>; Fri,  9 Sep 2022 13:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIINPW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Sep 2022 09:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiIINPV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2022 09:15:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AA656B92
        for <linux-block@vger.kernel.org>; Fri,  9 Sep 2022 06:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=f/qSe/ewwVjCWJuLNKF5WYJ01aPuYxmYyddhXht9Lm4=; b=rGQ0nCRp2n8rm7jiVrraHWU8yD
        kZVKtdsPIbRD+lwKxHIhSmHzqZZ8yrq/dd4BcvRtz+Q6S8CHS5QlWyKTsz/+hv+YQd/CD58keNbnB
        yzeZL/hDIGhESpamkAFYzqjapCuKcX7y++sngvZ0O0h8EPU/7Ch6xhMxyfPYg3MOLo2NRRY/DhzEQ
        zsfFPR3JukYDx6QHLGgAdzPAflpx4um6pMEqH+ls78nX1k/ZDcQBFqTS4sIjo1eAhT6NrsjiyUfa+
        S3UmSrdK8nXxV+3AqxrgW6h5gP5Oyri6hSaOOv9CKUThpxAz+C8lvO7cEI+lPvxdRGgxFQelerF+g
        SqrTudIg==;
Received: from [2001:4bb8:198:38af:a077:6a38:dc23:be2c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWdqp-00GGuD-AD; Fri, 09 Sep 2022 13:15:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/4] rnbd-srv: simplify rnbd_srv_fill_msg_open_rsp
Date:   Fri,  9 Sep 2022 15:15:06 +0200
Message-Id: <20220909131509.3263924-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220909131509.3263924-1-hch@lst.de>
References: <20220909131509.3263924-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove all the wrappers and just get the information directly from
the block device, or where no such helpers exist the request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/rnbd-srv-dev.h | 30 --------------------------
 drivers/block/rnbd/rnbd-srv.c     | 35 ++++++++++++-------------------
 2 files changed, 13 insertions(+), 52 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
index 8407d12f70afe..8eeb3d607e7b5 100644
--- a/drivers/block/rnbd/rnbd-srv-dev.h
+++ b/drivers/block/rnbd/rnbd-srv-dev.h
@@ -31,34 +31,4 @@ void rnbd_dev_close(struct rnbd_dev *dev);
 
 void rnbd_endio(void *priv, int error);
 
-static inline int rnbd_dev_get_max_segs(const struct rnbd_dev *dev)
-{
-	return queue_max_segments(bdev_get_queue(dev->bdev));
-}
-
-static inline int rnbd_dev_get_max_hw_sects(const struct rnbd_dev *dev)
-{
-	return queue_max_hw_sectors(bdev_get_queue(dev->bdev));
-}
-
-static inline int rnbd_dev_get_secure_discard(const struct rnbd_dev *dev)
-{
-	return bdev_max_secure_erase_sectors(dev->bdev);
-}
-
-static inline int rnbd_dev_get_max_discard_sects(const struct rnbd_dev *dev)
-{
-	return bdev_max_discard_sectors(dev->bdev);
-}
-
-static inline int rnbd_dev_get_discard_granularity(const struct rnbd_dev *dev)
-{
-	return bdev_get_queue(dev->bdev)->limits.discard_granularity;
-}
-
-static inline int rnbd_dev_get_discard_alignment(const struct rnbd_dev *dev)
-{
-	return bdev_discard_alignment(dev->bdev);
-}
-
 #endif /* RNBD_SRV_DEV_H */
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 8d011652a15c2..735d3f8d923e4 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -544,34 +544,25 @@ rnbd_srv_get_or_create_srv_dev(struct rnbd_dev *rnbd_dev,
 static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 					struct rnbd_srv_sess_dev *sess_dev)
 {
-	struct rnbd_dev *rnbd_dev = sess_dev->rnbd_dev;
+	struct block_device *bdev = sess_dev->rnbd_dev->bdev;
 
 	rsp->hdr.type = cpu_to_le16(RNBD_MSG_OPEN_RSP);
-	rsp->device_id =
-		cpu_to_le32(sess_dev->device_id);
-	rsp->nsectors =
-		cpu_to_le64(get_capacity(rnbd_dev->bdev->bd_disk));
-	rsp->logical_block_size	=
-		cpu_to_le16(bdev_logical_block_size(rnbd_dev->bdev));
-	rsp->physical_block_size =
-		cpu_to_le16(bdev_physical_block_size(rnbd_dev->bdev));
-	rsp->max_segments =
-		cpu_to_le16(rnbd_dev_get_max_segs(rnbd_dev));
+	rsp->device_id = cpu_to_le32(sess_dev->device_id);
+	rsp->nsectors = cpu_to_le64(bdev_nr_sectors(bdev));
+	rsp->logical_block_size	= cpu_to_le16(bdev_logical_block_size(bdev));
+	rsp->physical_block_size = cpu_to_le16(bdev_physical_block_size(bdev));
+	rsp->max_segments = cpu_to_le16(bdev_max_segments(bdev));
 	rsp->max_hw_sectors =
-		cpu_to_le32(rnbd_dev_get_max_hw_sects(rnbd_dev));
+		cpu_to_le32(queue_max_hw_sectors(bdev_get_queue(bdev)));
 	rsp->max_write_same_sectors = 0;
-	rsp->max_discard_sectors =
-		cpu_to_le32(rnbd_dev_get_max_discard_sects(rnbd_dev));
-	rsp->discard_granularity =
-		cpu_to_le32(rnbd_dev_get_discard_granularity(rnbd_dev));
-	rsp->discard_alignment =
-		cpu_to_le32(rnbd_dev_get_discard_alignment(rnbd_dev));
-	rsp->secure_discard =
-		cpu_to_le16(rnbd_dev_get_secure_discard(rnbd_dev));
+	rsp->max_discard_sectors = cpu_to_le32(bdev_max_discard_sectors(bdev));
+	rsp->discard_granularity = cpu_to_le32(bdev_discard_granularity(bdev));
+	rsp->discard_alignment = cpu_to_le32(bdev_discard_alignment(bdev));
+	rsp->secure_discard = cpu_to_le16(bdev_max_secure_erase_sectors(bdev));
 	rsp->cache_policy = 0;
-	if (bdev_write_cache(rnbd_dev->bdev))
+	if (bdev_write_cache(bdev))
 		rsp->cache_policy |= RNBD_WRITEBACK;
-	if (bdev_fua(rnbd_dev->bdev))
+	if (bdev_fua(bdev))
 		rsp->cache_policy |= RNBD_FUA;
 }
 
-- 
2.30.2

