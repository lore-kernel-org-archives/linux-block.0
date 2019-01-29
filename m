Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20675C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 08:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23A220869
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 08:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfA2IoB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:44:01 -0500
Received: from 8bytes.org ([81.169.241.247]:35606 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbfA2Ins (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 03:43:48 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 167044A8; Tue, 29 Jan 2019 09:43:45 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, joro@8bytes.org,
        jroedel@suse.de
Subject: [PATCH 5/5] virtio-blk: Consider virtio_max_dma_size() for maximum segment size
Date:   Tue, 29 Jan 2019 09:43:42 +0100
Message-Id: <20190129084342.26030-6-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129084342.26030-1-joro@8bytes.org>
References: <20190129084342.26030-1-joro@8bytes.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Segments can't be larger than the maximum DMA mapping size
supported on the platform. Take that into account when
setting the maximum segment size for a block device.

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/block/virtio_blk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b16a887bbd02..4bc083b7c9b5 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -723,7 +723,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	struct request_queue *q;
 	int err, index;
 
-	u32 v, blk_size, sg_elems, opt_io_size;
+	u32 v, blk_size, max_size, sg_elems, opt_io_size;
 	u16 min_io_size;
 	u8 physical_block_exp, alignment_offset;
 
@@ -826,14 +826,16 @@ static int virtblk_probe(struct virtio_device *vdev)
 	/* No real sector limit. */
 	blk_queue_max_hw_sectors(q, -1U);
 
+	max_size = virtio_max_dma_size(vdev);
+
 	/* Host can optionally specify maximum segment size and number of
 	 * segments. */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
 				   struct virtio_blk_config, size_max, &v);
 	if (!err)
-		blk_queue_max_segment_size(q, v);
-	else
-		blk_queue_max_segment_size(q, -1U);
+		max_size = min(max_size, v);
+
+	blk_queue_max_segment_size(q, max_size);
 
 	/* Host can optionally specify the block size of the device */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
-- 
2.17.1

