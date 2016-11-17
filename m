Return-Path: <BATV+c11f2a9076c546b906d6+4834+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: mst@redhat.com
Cc: axboe@kernel.dk,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] virtio_pci: use shared interrupts for virtqueues
Date: Thu, 17 Nov 2016 11:43:17 +0100
Message-Id: <1479379403-27880-6-git-send-email-hch@lst.de>
In-Reply-To: <1479379403-27880-1-git-send-email-hch@lst.de>
References: <1479379403-27880-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This lets IRQ layer handle dispatching IRQs to separate handlers for the
case where we don't have per-VQ MSI-X vectors, and allows us to greatly
simplify the code based on the assumption that we always have interrupt
vector 0 (legacy INTx or config interrupt for MSI-X) available, and
any other interrupt is request/freed throught the VQ, even if the
actual interrupt line might be shared in some cases.

This allows removing a great deal of variables keeping track of the
interrupt state in struct virtio_pci_device, as we can now simply walk the
list of VQs and deal with per-VQ interrupt handlers there, and only treat
vector 0 special.  As a little caveat this means we have to check if VQs
have been set up before calling vp_synchronize_vectors, as otherwise
the initial reset will trip over the uninitialized ->vqs array.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/virtio/virtio_pci_common.c | 95 ++++++++++++++------------------------
 drivers/virtio/virtio_pci_common.h | 18 +-------
 2 files changed, 36 insertions(+), 77 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 9a9826e..9e6c9d8 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -31,13 +31,18 @@ MODULE_PARM_DESC(force_legacy,
 void vp_synchronize_vectors(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	int i;
+	struct virtqueue *vq, *n;
+
+	if (!vp_dev->vqs)
+		return;
 
-	if (vp_dev->intx_enabled)
-		synchronize_irq(vp_dev->pci_dev->irq);
+	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
+		int vec = vp_dev->vqs[vq->index]->msix_vector;
+		if (vec != VIRTIO_MSI_NO_VECTOR)
+			synchronize_irq(pci_irq_vector(vp_dev->pci_dev, vec));
+	}
 
-	for (i = 0; i < vp_dev->msix_vectors; ++i)
-		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
+	synchronize_irq(pci_irq_vector(vp_dev->pci_dev, 0));
 }
 
 /* the notify function used when creating a virt queue */
@@ -102,16 +107,14 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 	return vp_vring_interrupt(irq, opaque);
 }
 
-static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
-				   bool per_vq_vectors)
+static int vp_setup_msix_vectors(struct virtio_device *vdev, int nvectors)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	const char *name = dev_name(&vp_dev->vdev.dev);
-	unsigned i, v;
+	unsigned i;
 	int err = -ENOMEM;
 
 	vp_dev->msix_vectors = nvectors;
-
 	vp_dev->msix_names = kmalloc(nvectors * sizeof *vp_dev->msix_names,
 				     GFP_KERNEL);
 	if (!vp_dev->msix_names)
@@ -133,35 +136,20 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 	vp_dev->msix_enabled = 1;
 
 	/* Set the vector used for configuration */
-	v = vp_dev->msix_used_vectors;
-	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
+	snprintf(vp_dev->msix_names[0], sizeof(*vp_dev->msix_names),
 		 "%s-config", name);
-	err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
-			  vp_config_changed, 0, vp_dev->msix_names[v],
+	err = request_irq(pci_irq_vector(vp_dev->pci_dev, 0),
+			  vp_config_changed, 0, vp_dev->msix_names[0],
 			  vp_dev);
 	if (err)
 		goto error;
-	++vp_dev->msix_used_vectors;
 
-	v = vp_dev->config_vector(vp_dev, v);
 	/* Verify we had enough resources to assign the vector */
-	if (v == VIRTIO_MSI_NO_VECTOR) {
+	if (vp_dev->config_vector(vp_dev, 0) == VIRTIO_MSI_NO_VECTOR) {
 		err = -EBUSY;
 		goto error;
 	}
 
-	if (!per_vq_vectors) {
-		/* Shared vector for all VQs */
-		v = vp_dev->msix_used_vectors;
-		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
-			 "%s-virtqueues", name);
-		err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
-				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
-				  vp_dev);
-		if (err)
-			goto error;
-		++vp_dev->msix_used_vectors;
-	}
 	return 0;
 error:
 	return err;
@@ -224,24 +212,14 @@ void vp_del_vqs(struct virtio_device *vdev)
 	int i;
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
-		if (vp_dev->per_vq_vectors) {
-			int v = vp_dev->vqs[vq->index]->msix_vector;
+		int vec = vp_dev->vqs[vq->index]->msix_vector;
 
-			if (v != VIRTIO_MSI_NO_VECTOR)
-				free_irq(pci_irq_vector(vp_dev->pci_dev, v),
-					vq);
-		}
+		if (vec != VIRTIO_MSI_NO_VECTOR)
+			free_irq(pci_irq_vector(vp_dev->pci_dev, vec), vq);
 		vp_del_vq(vq);
 	}
-	vp_dev->per_vq_vectors = false;
-
-	if (vp_dev->intx_enabled) {
-		free_irq(vp_dev->pci_dev->irq, vp_dev);
-		vp_dev->intx_enabled = 0;
-	}
 
-	for (i = 0; i < vp_dev->msix_used_vectors; ++i)
-		free_irq(pci_irq_vector(vp_dev->pci_dev, i), vp_dev);
+	free_irq(pci_irq_vector(vp_dev->pci_dev, 0), vp_dev);
 
 	for (i = 0; i < vp_dev->msix_vectors; i++)
 		if (vp_dev->msix_affinity_masks[i])
@@ -256,7 +234,6 @@ void vp_del_vqs(struct virtio_device *vdev)
 	}
 
 	vp_dev->msix_vectors = 0;
-	vp_dev->msix_used_vectors = 0;
 	kfree(vp_dev->msix_names);
 	vp_dev->msix_names = NULL;
 	kfree(vp_dev->msix_affinity_masks);
@@ -273,7 +250,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	u16 msix_vec;
-	int i, err, nvectors, allocated_vectors;
+	int i, err, allocated_vectors, nvectors;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
@@ -290,46 +267,44 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 		nvectors = 2;
 	}
 
-	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors);
+	err = vp_setup_msix_vectors(vdev, nvectors);
 	if (err)
 		goto error_find;
 
-	vp_dev->per_vq_vectors = per_vq_vectors;
-	allocated_vectors = vp_dev->msix_used_vectors;
+	allocated_vectors = 1; /* vector 0 is the config interrupt */
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
 			vqs[i] = NULL;
 			continue;
 		}
 
-		if (!callbacks[i])
-			msix_vec = VIRTIO_MSI_NO_VECTOR;
-		else if (vp_dev->per_vq_vectors)
-			msix_vec = allocated_vectors++;
+		if (callbacks[i])
+			msix_vec = allocated_vectors;
 		else
-			msix_vec = VP_MSIX_VQ_VECTOR;
+			msix_vec = VIRTIO_MSI_NO_VECTOR;
+
 		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i], msix_vec);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
 		}
 
-		if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
+		if (msix_vec == VIRTIO_MSI_NO_VECTOR)
 			continue;
 
-		/* allocate per-vq irq if available and necessary */
 		snprintf(vp_dev->msix_names[msix_vec],
-			 sizeof *vp_dev->msix_names,
-			 "%s-%s",
+			 sizeof(*vp_dev->msix_names), "%s-%s",
 			 dev_name(&vp_dev->vdev.dev), names[i]);
 		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
-				  vring_interrupt, 0,
-				  vp_dev->msix_names[msix_vec],
-				  vqs[i]);
+				  vring_interrupt, IRQF_SHARED,
+				  vp_dev->msix_names[msix_vec], vqs[i]);
 		if (err) {
 			vp_del_vq(vqs[i]);
 			goto error_find;
 		}
+
+		if (per_vq_vectors)
+			allocated_vectors++;
 	}
 	return 0;
 
@@ -354,8 +329,6 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
 	if (err)
 		goto out_del_vqs;
 
-	vp_dev->intx_enabled = 1;
-	vp_dev->per_vq_vectors = false;
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
 			vqs[i] = NULL;
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index b2f6662..93f3e4f 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -84,18 +84,12 @@ struct virtio_pci_device {
 
 	/* MSI-X support */
 	int msix_enabled;
-	int intx_enabled;
 	cpumask_var_t *msix_affinity_masks;
 	/* Name strings for interrupts. This size should be enough,
 	 * and I'm too lazy to allocate each name separately. */
 	char (*msix_names)[256];
-	/* Number of available vectors */
-	unsigned msix_vectors;
-	/* Vectors allocated, excluding per-vq vectors if any */
-	unsigned msix_used_vectors;
-
-	/* Whether we have vector per vq */
-	bool per_vq_vectors;
+	/* Total Number of MSI-X vectors (including per-VQ ones). */
+	int msix_vectors;
 
 	struct virtqueue *(*setup_vq)(struct virtio_pci_device *vp_dev,
 				      struct virtio_pci_vq_info *info,
@@ -108,14 +102,6 @@ struct virtio_pci_device {
 	u16 (*config_vector)(struct virtio_pci_device *vp_dev, u16 vector);
 };
 
-/* Constants for MSI-X */
-/* Use first vector for configuration changes, second and the rest for
- * virtqueues Thus, we need at least 2 vectors for MSI. */
-enum {
-	VP_MSIX_CONFIG_VECTOR = 0,
-	VP_MSIX_VQ_VECTOR = 1,
-};
-
 /* Convert a generic virtio device to our structure */
 static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
 {
-- 
2.1.4
