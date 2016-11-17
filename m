Return-Path: <BATV+c11f2a9076c546b906d6+4834+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: mst@redhat.com
Cc: axboe@kernel.dk,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] virtio_pci: merge vp_free_vectors into vp_del_vqs
Date: Thu, 17 Nov 2016 11:43:15 +0100
Message-Id: <1479379403-27880-4-git-send-email-hch@lst.de>
In-Reply-To: <1479379403-27880-1-git-send-email-hch@lst.de>
References: <1479379403-27880-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/virtio/virtio_pci_common.c | 61 +++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 93700c5..f6c5499 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -102,39 +102,6 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 	return vp_vring_interrupt(irq, opaque);
 }
 
-static void vp_free_vectors(struct virtio_device *vdev)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	int i;
-
-	if (vp_dev->intx_enabled) {
-		free_irq(vp_dev->pci_dev->irq, vp_dev);
-		vp_dev->intx_enabled = 0;
-	}
-
-	for (i = 0; i < vp_dev->msix_used_vectors; ++i)
-		free_irq(pci_irq_vector(vp_dev->pci_dev, i), vp_dev);
-
-	for (i = 0; i < vp_dev->msix_vectors; i++)
-		if (vp_dev->msix_affinity_masks[i])
-			free_cpumask_var(vp_dev->msix_affinity_masks[i]);
-
-	if (vp_dev->msix_enabled) {
-		/* Disable the vector used for configuration */
-		vp_dev->config_vector(vp_dev, VIRTIO_MSI_NO_VECTOR);
-
-		pci_free_irq_vectors(vp_dev->pci_dev);
-		vp_dev->msix_enabled = 0;
-	}
-
-	vp_dev->msix_vectors = 0;
-	vp_dev->msix_used_vectors = 0;
-	kfree(vp_dev->msix_names);
-	vp_dev->msix_names = NULL;
-	kfree(vp_dev->msix_affinity_masks);
-	vp_dev->msix_affinity_masks = NULL;
-}
-
 static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 				   bool per_vq_vectors)
 {
@@ -266,6 +233,7 @@ void vp_del_vqs(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtqueue *vq, *n;
+	int i;
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
 		if (vp_dev->per_vq_vectors) {
@@ -279,7 +247,32 @@ void vp_del_vqs(struct virtio_device *vdev)
 	}
 	vp_dev->per_vq_vectors = false;
 
-	vp_free_vectors(vdev);
+	if (vp_dev->intx_enabled) {
+		free_irq(vp_dev->pci_dev->irq, vp_dev);
+		vp_dev->intx_enabled = 0;
+	}
+
+	for (i = 0; i < vp_dev->msix_used_vectors; ++i)
+		free_irq(pci_irq_vector(vp_dev->pci_dev, i), vp_dev);
+
+	for (i = 0; i < vp_dev->msix_vectors; i++)
+		if (vp_dev->msix_affinity_masks[i])
+			free_cpumask_var(vp_dev->msix_affinity_masks[i]);
+
+	if (vp_dev->msix_enabled) {
+		/* Disable the vector used for configuration */
+		vp_dev->config_vector(vp_dev, VIRTIO_MSI_NO_VECTOR);
+
+		pci_free_irq_vectors(vp_dev->pci_dev);
+		vp_dev->msix_enabled = 0;
+	}
+
+	vp_dev->msix_vectors = 0;
+	vp_dev->msix_used_vectors = 0;
+	kfree(vp_dev->msix_names);
+	vp_dev->msix_names = NULL;
+	kfree(vp_dev->msix_affinity_masks);
+	vp_dev->msix_affinity_masks = NULL;
 	kfree(vp_dev->vqs);
 	vp_dev->vqs = NULL;
 }
-- 
2.1.4
