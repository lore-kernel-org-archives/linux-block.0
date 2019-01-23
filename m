Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B674DC282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 16:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806C3217D4
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 16:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbfAWQbG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:31:06 -0500
Received: from 8bytes.org ([81.169.241.247]:59242 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfAWQax (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 11:30:53 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C807B450; Wed, 23 Jan 2019 17:30:51 +0100 (CET)
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
Subject: [PATCH 4/5] virtio: Introduce virtio_max_dma_size()
Date:   Wed, 23 Jan 2019 17:30:48 +0100
Message-Id: <20190123163049.24863-5-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123163049.24863-1-joro@8bytes.org>
References: <20190123163049.24863-1-joro@8bytes.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

This function returns the maximum segment size for a single
dma transaction of a virtio device. The possible limit comes
from the SWIOTLB implementation in the Linux kernel, that
has an upper limit of (currently) 256kb of contiguous
memory it can map. Other DMA-API implementations might also
have limits.

Use the new dma_max_mapping_size() function to determine the
maximum mapping size when DMA-API is in use for virtio.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/virtio/virtio_ring.c | 10 ++++++++++
 include/linux/virtio.h       |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cd7e755484e3..9ca3fe6af9fa 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -266,6 +266,16 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
 	return false;
 }
 
+size_t virtio_max_dma_size(struct virtio_device *vdev)
+{
+	size_t max_segment_size = SIZE_MAX;
+
+	if (vring_use_dma_api(vdev))
+		max_segment_size = dma_max_mapping_size(&vdev->dev);
+
+	return max_segment_size;
+}
+
 static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 			      dma_addr_t *dma_handle, gfp_t flag)
 {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index fa1b5da2804e..673fe3ef3607 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -157,6 +157,8 @@ int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
 #endif
 
+size_t virtio_max_dma_size(struct virtio_device *vdev);
+
 #define virtio_device_for_each_vq(vdev, vq) \
 	list_for_each_entry(vq, &vdev->vqs, list)
 
-- 
2.17.1

