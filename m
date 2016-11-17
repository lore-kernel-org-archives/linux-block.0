Return-Path: <BATV+c11f2a9076c546b906d6+4834+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: mst@redhat.com
Cc: axboe@kernel.dk,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] virtio_pci: split vp_try_to_find_vqs into INTx and MSI-X variants
Date: Thu, 17 Nov 2016 11:43:16 +0100
Message-Id: <1479379403-27880-5-git-send-email-hch@lst.de>
In-Reply-To: <1479379403-27880-1-git-send-email-hch@lst.de>
References: <1479379403-27880-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

There is basically no shared logic between the INTx and MSI-X case in
vp_try_to_find_vqs, so split the function into two and clean them up
a little bit.

Also remove the fairly pointless vp_request_intx wrapper while we're at it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/virtio/virtio_pci_common.c | 97 ++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 40 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index f6c5499..9a9826e 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -167,18 +167,6 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 	return err;
 }
 
-static int vp_request_intx(struct virtio_device *vdev)
-{
-	int err;
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-
-	err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
-			  IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
-	if (!err)
-		vp_dev->intx_enabled = 1;
-	return err;
-}
-
 static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned index,
 				     void (*callback)(struct virtqueue *vq),
 				     const char *name,
@@ -277,50 +265,44 @@ void vp_del_vqs(struct virtio_device *vdev)
 	vp_dev->vqs = NULL;
 }
 
-static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 			      struct virtqueue *vqs[],
 			      vq_callback_t *callbacks[],
 			      const char * const names[],
-			      bool use_msix,
 			      bool per_vq_vectors)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	u16 msix_vec;
 	int i, err, nvectors, allocated_vectors;
 
-	vp_dev->vqs = kmalloc(nvqs * sizeof *vp_dev->vqs, GFP_KERNEL);
+	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
 		return -ENOMEM;
 
-	if (!use_msix) {
-		/* Old style: one normal interrupt for change and all vqs. */
-		err = vp_request_intx(vdev);
-		if (err)
-			goto error_find;
+	if (per_vq_vectors) {
+		/* Best option: one for change interrupt, one per vq. */
+		nvectors = 1;
+		for (i = 0; i < nvqs; ++i)
+			if (callbacks[i])
+				++nvectors;
 	} else {
-		if (per_vq_vectors) {
-			/* Best option: one for change interrupt, one per vq. */
-			nvectors = 1;
-			for (i = 0; i < nvqs; ++i)
-				if (callbacks[i])
-					++nvectors;
-		} else {
-			/* Second best: one for change, shared for all vqs. */
-			nvectors = 2;
-		}
-
-		err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors);
-		if (err)
-			goto error_find;
+		/* Second best: one for change, shared for all vqs. */
+		nvectors = 2;
 	}
 
+	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors);
+	if (err)
+		goto error_find;
+
 	vp_dev->per_vq_vectors = per_vq_vectors;
 	allocated_vectors = vp_dev->msix_used_vectors;
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
 			vqs[i] = NULL;
 			continue;
-		} else if (!callbacks[i] || !vp_dev->msix_enabled)
+		}
+
+		if (!callbacks[i])
 			msix_vec = VIRTIO_MSI_NO_VECTOR;
 		else if (vp_dev->per_vq_vectors)
 			msix_vec = allocated_vectors++;
@@ -356,6 +338,43 @@ static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	return err;
 }
 
+static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
+		struct virtqueue *vqs[], vq_callback_t *callbacks[],
+		const char * const names[])
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	int i, err;
+
+	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
+	if (!vp_dev->vqs)
+		return -ENOMEM;
+
+	err = request_irq(vp_dev->pci_dev->irq, vp_interrupt, IRQF_SHARED,
+			dev_name(&vdev->dev), vp_dev);
+	if (err)
+		goto out_del_vqs;
+
+	vp_dev->intx_enabled = 1;
+	vp_dev->per_vq_vectors = false;
+	for (i = 0; i < nvqs; ++i) {
+		if (!names[i]) {
+			vqs[i] = NULL;
+			continue;
+		}
+		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
+				VIRTIO_MSI_NO_VECTOR);
+		if (IS_ERR(vqs[i])) {
+			err = PTR_ERR(vqs[i]);
+			goto out_del_vqs;
+		}
+	}
+
+	return 0;
+out_del_vqs:
+	vp_del_vqs(vdev);
+	return err;
+}
+
 /* the config->find_vqs() implementation */
 int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		struct virtqueue *vqs[],
@@ -365,17 +384,15 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	int err;
 
 	/* Try MSI-X with one vector per queue. */
-	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names, true, true);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true);
 	if (!err)
 		return 0;
 	/* Fallback: MSI-X with one vector for config, one shared for queues. */
-	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
-				 true, false);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false);
 	if (!err)
 		return 0;
 	/* Finally fall back to regular interrupts. */
-	return vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
-				  false, false);
+	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names);
 }
 
 const char *vp_bus_name(struct virtio_device *vdev)
-- 
2.1.4
