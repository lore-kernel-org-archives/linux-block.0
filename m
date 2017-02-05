Return-Path: <BATV+7c9ed557eb952ccf5513+4914+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: axboe@kernel.dk,
	pbonzini@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] virtio_pci: simplify MSI-X setup
Date: Sun,  5 Feb 2017 18:15:21 +0100
Message-Id: <20170205171526.6224-5-hch@lst.de>
In-Reply-To: <20170205171526.6224-1-hch@lst.de>
References: <20170205171526.6224-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Try to grab the MSI-X vectors early and fall back to the shared one
before doing lots of allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index b83053082875..822f8e5dcee4 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -142,14 +142,13 @@ void vp_del_vqs(struct virtio_device *vdev)
 }
 
 static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
-			      struct virtqueue *vqs[],
-			      vq_callback_t *callbacks[],
-			      const char * const names[],
-			      bool per_vq_vectors)
+		struct virtqueue *vqs[], vq_callback_t *callbacks[],
+		const char * const names[])
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	const char *name = dev_name(&vp_dev->vdev.dev);
 	int i, err = -ENOMEM, allocated_vectors, nvectors;
+	bool shared = false;
 	u16 msix_vec;
 
 	nvectors = 1;
@@ -157,12 +156,16 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 		if (callbacks[i])
 			nvectors++;
 
-	if (per_vq_vectors) {
-		err = pci_alloc_irq_vectors(vp_dev->pci_dev, nvectors, nvectors,
-				PCI_IRQ_MSIX);
-	} else {
+	/* Try one vector per queue first. */
+	err = pci_alloc_irq_vectors(vp_dev->pci_dev, nvectors, nvectors,
+			PCI_IRQ_MSIX);
+	if (err < 0) {
+		/* Fallback to one vector for config, one shared for queues. */
+		shared = true;
 		err = pci_alloc_irq_vectors(vp_dev->pci_dev, 2, 2,
 				PCI_IRQ_MSIX);
+		if (err < 0)
+			return err;
 	}
 	if (err < 0)
 		return err;
@@ -190,7 +193,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 	err = request_irq(pci_irq_vector(vp_dev->pci_dev, 0), vp_config_changed,
 			0, vp_dev->msix_names[0], vp_dev);
 	if (err)
-		goto out_free_irq_vectors;
+		goto out_free_msix_affinity_masks;
 
 	/* Verify we had enough resources to assign the vector */
 	if (vp_dev->config_vector(vp_dev, 0) == VIRTIO_MSI_NO_VECTOR) {
@@ -240,7 +243,11 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 		}
 		vp_dev->msix_vector_map[i] = msix_vec;
 
-		if (per_vq_vectors)
+		/*
+		 * Use a different vector for each queue if they are available,
+		 * else share the same vector for all VQs.
+		 */
+		if (!shared)
 			allocated_vectors++;
 	}
 
@@ -307,15 +314,9 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 {
 	int err;
 
-	/* Try MSI-X with one vector per queue. */
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true);
-	if (!err)
-		return 0;
-	/* Fallback: MSI-X with one vector for config, one shared for queues. */
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names);
 	if (!err)
 		return 0;
-	/* Finally fall back to regular interrupts. */
 	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names);
 }
 
-- 
2.11.0
