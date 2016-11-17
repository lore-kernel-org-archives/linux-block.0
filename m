Return-Path: <BATV+c11f2a9076c546b906d6+4834+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: mst@redhat.com
Cc: axboe@kernel.dk,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] virtio_pci: remove the call to vp_free_vectors in vp_request_msix_vectors
Date: Thu, 17 Nov 2016 11:43:14 +0100
Message-Id: <1479379403-27880-3-git-send-email-hch@lst.de>
In-Reply-To: <1479379403-27880-1-git-send-email-hch@lst.de>
References: <1479379403-27880-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

vp_request_msix_vectors is only called by vp_try_to_find_vqs, which already
calls vp_free_vectors through vp_del_vqs in the failure case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/virtio/virtio_pci_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index f5e2751..93700c5 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -197,7 +197,6 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 	}
 	return 0;
 error:
-	vp_free_vectors(vdev);
 	return err;
 }
 
-- 
2.1.4
