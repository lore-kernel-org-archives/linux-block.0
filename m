Return-Path: <BATV+c11f2a9076c546b906d6+4834+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: mst@redhat.com
Cc: axboe@kernel.dk,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] virtio_pci: use pci_alloc_irq_vectors
Date: Thu, 17 Nov 2016 11:43:13 +0100
Message-Id: <1479379403-27880-2-git-send-email-hch@lst.de>
In-Reply-To: <1479379403-27880-1-git-send-email-hch@lst.de>
References: <1479379403-27880-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This avoids the separate allocation for the msix_entries structures, and
instead allows us to use pci_irq_vector to find a given IRQ vector.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/virtio/virtio_pci_common.c | 42 +++++++++++++++-----------------------
 drivers/virtio/virtio_pci_common.h |  1 -
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index d9a9058..f5e2751 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -37,7 +37,7 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
 		synchronize_irq(vp_dev->pci_dev->irq);
 
 	for (i = 0; i < vp_dev->msix_vectors; ++i)
-		synchronize_irq(vp_dev->msix_entries[i].vector);
+		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
 }
 
 /* the notify function used when creating a virt queue */
@@ -113,7 +113,7 @@ static void vp_free_vectors(struct virtio_device *vdev)
 	}
 
 	for (i = 0; i < vp_dev->msix_used_vectors; ++i)
-		free_irq(vp_dev->msix_entries[i].vector, vp_dev);
+		free_irq(pci_irq_vector(vp_dev->pci_dev, i), vp_dev);
 
 	for (i = 0; i < vp_dev->msix_vectors; i++)
 		if (vp_dev->msix_affinity_masks[i])
@@ -123,7 +123,7 @@ static void vp_free_vectors(struct virtio_device *vdev)
 		/* Disable the vector used for configuration */
 		vp_dev->config_vector(vp_dev, VIRTIO_MSI_NO_VECTOR);
 
-		pci_disable_msix(vp_dev->pci_dev);
+		pci_free_irq_vectors(vp_dev->pci_dev);
 		vp_dev->msix_enabled = 0;
 	}
 
@@ -131,8 +131,6 @@ static void vp_free_vectors(struct virtio_device *vdev)
 	vp_dev->msix_used_vectors = 0;
 	kfree(vp_dev->msix_names);
 	vp_dev->msix_names = NULL;
-	kfree(vp_dev->msix_entries);
-	vp_dev->msix_entries = NULL;
 	kfree(vp_dev->msix_affinity_masks);
 	vp_dev->msix_affinity_masks = NULL;
 }
@@ -147,10 +145,6 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 
 	vp_dev->msix_vectors = nvectors;
 
-	vp_dev->msix_entries = kmalloc(nvectors * sizeof *vp_dev->msix_entries,
-				       GFP_KERNEL);
-	if (!vp_dev->msix_entries)
-		goto error;
 	vp_dev->msix_names = kmalloc(nvectors * sizeof *vp_dev->msix_names,
 				     GFP_KERNEL);
 	if (!vp_dev->msix_names)
@@ -165,12 +159,9 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 					GFP_KERNEL))
 			goto error;
 
-	for (i = 0; i < nvectors; ++i)
-		vp_dev->msix_entries[i].entry = i;
-
-	err = pci_enable_msix_exact(vp_dev->pci_dev,
-				    vp_dev->msix_entries, nvectors);
-	if (err)
+	err = pci_alloc_irq_vectors(vp_dev->pci_dev, nvectors, nvectors,
+			PCI_IRQ_MSIX);
+	if (err < 0)
 		goto error;
 	vp_dev->msix_enabled = 1;
 
@@ -178,7 +169,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 	v = vp_dev->msix_used_vectors;
 	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
 		 "%s-config", name);
-	err = request_irq(vp_dev->msix_entries[v].vector,
+	err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
 			  vp_config_changed, 0, vp_dev->msix_names[v],
 			  vp_dev);
 	if (err)
@@ -197,7 +188,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 		v = vp_dev->msix_used_vectors;
 		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
 			 "%s-virtqueues", name);
-		err = request_irq(vp_dev->msix_entries[v].vector,
+		err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
 				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
 				  vp_dev);
 		if (err)
@@ -276,14 +267,15 @@ void vp_del_vqs(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtqueue *vq, *n;
-	struct virtio_pci_vq_info *info;
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
-		info = vp_dev->vqs[vq->index];
-		if (vp_dev->per_vq_vectors &&
-			info->msix_vector != VIRTIO_MSI_NO_VECTOR)
-			free_irq(vp_dev->msix_entries[info->msix_vector].vector,
-				 vq);
+		if (vp_dev->per_vq_vectors) {
+			int v = vp_dev->vqs[vq->index]->msix_vector;
+
+			if (v != VIRTIO_MSI_NO_VECTOR)
+				free_irq(pci_irq_vector(vp_dev->pci_dev, v),
+					vq);
+		}
 		vp_del_vq(vq);
 	}
 	vp_dev->per_vq_vectors = false;
@@ -356,7 +348,7 @@ static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			 sizeof *vp_dev->msix_names,
 			 "%s-%s",
 			 dev_name(&vp_dev->vdev.dev), names[i]);
-		err = request_irq(vp_dev->msix_entries[msix_vec].vector,
+		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
 				  vring_interrupt, 0,
 				  vp_dev->msix_names[msix_vec],
 				  vqs[i]);
@@ -419,7 +411,7 @@ int vp_set_vq_affinity(struct virtqueue *vq, int cpu)
 
 	if (vp_dev->msix_enabled) {
 		mask = vp_dev->msix_affinity_masks[info->msix_vector];
-		irq = vp_dev->msix_entries[info->msix_vector].vector;
+		irq = pci_irq_vector(vp_dev->pci_dev, info->msix_vector);
 		if (cpu == -1)
 			irq_set_affinity_hint(irq, NULL);
 		else {
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 2826320..b2f6662 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -85,7 +85,6 @@ struct virtio_pci_device {
 	/* MSI-X support */
 	int msix_enabled;
 	int intx_enabled;
-	struct msix_entry *msix_entries;
 	cpumask_var_t *msix_affinity_masks;
 	/* Name strings for interrupts. This size should be enough,
 	 * and I'm too lazy to allocate each name separately. */
-- 
2.1.4
