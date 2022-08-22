Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBBAC32792
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 06:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiHVGRx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 02:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiHVGRw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 02:17:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DED627177
        for <linux-block@vger.kernel.org>; Sun, 21 Aug 2022 23:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=N+CnLAV4JTUdl0Z3Ex0IYTfZQvcVOJzrNFkh2QOlBLU=; b=OtccteQ/02itQ3QMOu+4CLJpVp
        2xukHkOrJBbnVKQ1X7tC4XwAbmOyXuK4ugljCyjGukBjWRIXwLqI7v3Ufl1v7p9awklbBrsMyMrq9
        ePnqo4Y8mgCTdcV2qs3rP9v59Ct7Id5yxWeaxS+NQQYUCjD3egCNSLAyrdFPgbrPTJKKDHZSn2P+F
        k2j9teGunJKvZQ14AdWUHds23FN7JnUtggLpVO769OSe22r1mcp06iGezFc04teBH2e0kmEYinQTP
        HeR+Ek8s9Nk9e/xo64oC86v7eYpXXjnKwPxuTjmDKVVtU8orknjdDpuwqtBIcvxCpDU/FeY42diR4
        zZc+spNQ==;
Received: from [2001:4bb8:198:6528:7eb3:3a42:932d:eeba] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ0kv-005M9e-ME; Mon, 22 Aug 2022 06:17:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/4] rnbd-srv: simplify rnbd_srv_fill_msg_open_rsp
Date:   Mon, 22 Aug 2022 08:17:42 +0200
Message-Id: <20220822061745.152010-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220822061745.152010-1-hch@lst.de>
References: <20220822061745.152010-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove all the wrappers and just get the information directly from
the block device, or where no such helpers exist the request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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
index 3f6c268e04ef8..db1fe73998703 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -540,34 +540,25 @@ rnbd_srv_get_or_create_srv_dev(struct rnbd_dev *rnbd_dev,
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

