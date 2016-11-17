Return-Path: <BATV+c11f2a9076c546b906d6+4834+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: mst@redhat.com
Cc: axboe@kernel.dk,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] virtio_pci: simplify MSI-X setup
Date: Thu, 17 Nov 2016 11:43:19 +0100
Message-Id: <1479379403-27880-8-git-send-email-hch@lst.de>
In-Reply-To: <1479379403-27880-1-git-send-email-hch@lst.de>
References: <1479379403-27880-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Try to grab the MSI-X vectors early and fall back to the shared one
before doing tons of allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/virtio/virtio_pci_common.c | 52 +++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 03d3a3b..90d7975 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -114,6 +114,18 @@ static int vp_setup_msix_vectors(struct virtio_device *vdev, int nvectors)
 	unsigned i;
 	int err = -ENOMEM;
 
+	/* Try one vector per queue first. */
+	err = pci_alloc_irq_vectors(vp_dev->pci_dev, nvectors, nvectors,
+			PCI_IRQ_MSIX);
+	if (err < 0) {
+		/* Fallback to one vector for config, one shared for queues. */
+		err = pci_alloc_irq_vectors(vp_dev->pci_dev, 2, 2,
+				PCI_IRQ_MSIX);
+		if (err < 0)
+			goto error;
+		nvectors = 2;
+	}
+
 	vp_dev->msix_vectors = nvectors;
 	vp_dev->msix_names = kmalloc(nvectors * sizeof *vp_dev->msix_names,
 				     GFP_KERNEL);
@@ -129,11 +141,6 @@ static int vp_setup_msix_vectors(struct virtio_device *vdev, int nvectors)
 					GFP_KERNEL))
 			goto error;
 
-	err = pci_alloc_irq_vectors(vp_dev->pci_dev, nvectors, nvectors,
-			PCI_IRQ_MSIX);
-	if (err < 0)
-		goto error;
-
 	/* Set the vector used for configuration */
 	snprintf(vp_dev->msix_names[0], sizeof(*vp_dev->msix_names),
 		 "%s-config", name);
@@ -149,7 +156,7 @@ static int vp_setup_msix_vectors(struct virtio_device *vdev, int nvectors)
 		goto error;
 	}
 
-	return 0;
+	return nvectors;
 error:
 	return err;
 }
@@ -242,8 +249,7 @@ void vp_del_vqs(struct virtio_device *vdev)
 static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 			      struct virtqueue *vqs[],
 			      vq_callback_t *callbacks[],
-			      const char * const names[],
-			      bool per_vq_vectors)
+			      const char * const names[])
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	u16 msix_vec;
@@ -253,20 +259,16 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 	if (!vp_dev->vqs)
 		return -ENOMEM;
 
-	if (per_vq_vectors) {
-		/* Best option: one for change interrupt, one per vq. */
-		nvectors = 1;
-		for (i = 0; i < nvqs; ++i)
-			if (callbacks[i])
-				++nvectors;
-	} else {
-		/* Second best: one for change, shared for all vqs. */
-		nvectors = 2;
+	nvectors = 1;
+	for (i = 0; i < nvqs; i++) {
+		if (callbacks[i])
+			nvectors++;
 	}
 
 	err = vp_setup_msix_vectors(vdev, nvectors);
-	if (err)
+	if (err < 0)
 		goto error_find;
+	nvectors = err;
 
 	allocated_vectors = 1; /* vector 0 is the config interrupt */
 	for (i = 0; i < nvqs; ++i) {
@@ -300,7 +302,11 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 			goto error_find;
 		}
 
-		if (per_vq_vectors)
+		/*
+		 * Use a different vector for each queue if they are available,
+		 * else share the same vector for all VQs.
+		 */
+		if (nvectors == nvqs + 1)
 			allocated_vectors++;
 	}
 	return 0;
@@ -353,15 +359,9 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
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
2.1.4
