Return-Path: <BATV+c11f2a9076c546b906d6+4834+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: mst@redhat.com
Cc: axboe@kernel.dk,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] virtio_pci: use msix_enable flag in struct pci_dev
Date: Thu, 17 Nov 2016 11:43:18 +0100
Message-Id: <1479379403-27880-7-git-send-email-hch@lst.de>
In-Reply-To: <1479379403-27880-1-git-send-email-hch@lst.de>
References: <1479379403-27880-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Instead of duplicating it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/virtio/virtio_pci_common.c | 7 ++-----
 drivers/virtio/virtio_pci_common.h | 2 --
 drivers/virtio/virtio_pci_legacy.c | 2 +-
 drivers/virtio/virtio_pci_modern.c | 2 +-
 include/uapi/linux/virtio_pci.h    | 2 +-
 5 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 9e6c9d8..03d3a3b 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -133,7 +133,6 @@ static int vp_setup_msix_vectors(struct virtio_device *vdev, int nvectors)
 			PCI_IRQ_MSIX);
 	if (err < 0)
 		goto error;
-	vp_dev->msix_enabled = 1;
 
 	/* Set the vector used for configuration */
 	snprintf(vp_dev->msix_names[0], sizeof(*vp_dev->msix_names),
@@ -225,12 +224,10 @@ void vp_del_vqs(struct virtio_device *vdev)
 		if (vp_dev->msix_affinity_masks[i])
 			free_cpumask_var(vp_dev->msix_affinity_masks[i]);
 
-	if (vp_dev->msix_enabled) {
+	if (vp_dev->pci_dev->msix_enabled) {
 		/* Disable the vector used for configuration */
 		vp_dev->config_vector(vp_dev, VIRTIO_MSI_NO_VECTOR);
-
 		pci_free_irq_vectors(vp_dev->pci_dev);
-		vp_dev->msix_enabled = 0;
 	}
 
 	vp_dev->msix_vectors = 0;
@@ -391,7 +388,7 @@ int vp_set_vq_affinity(struct virtqueue *vq, int cpu)
 	if (!vq->callback)
 		return -EINVAL;
 
-	if (vp_dev->msix_enabled) {
+	if (vp_dev->pci_dev->msix_enabled) {
 		mask = vp_dev->msix_affinity_masks[info->msix_vector];
 		irq = pci_irq_vector(vp_dev->pci_dev, info->msix_vector);
 		if (cpu == -1)
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 93f3e4f..d041cce 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -82,8 +82,6 @@ struct virtio_pci_device {
 	/* array of all queues for house-keeping */
 	struct virtio_pci_vq_info **vqs;
 
-	/* MSI-X support */
-	int msix_enabled;
 	cpumask_var_t *msix_affinity_masks;
 	/* Name strings for interrupts. This size should be enough,
 	 * and I'm too lazy to allocate each name separately. */
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 6d9e517..f83829f 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -169,7 +169,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
 
 	iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
 
-	if (vp_dev->msix_enabled) {
+	if (vp_dev->pci_dev->msix_enabled) {
 		iowrite16(VIRTIO_MSI_NO_VECTOR,
 			  vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
 		/* Flush the write out to device */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index e76bd91..e18d0b0 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -416,7 +416,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
 
 	vp_iowrite16(vq->index, &vp_dev->common->queue_select);
 
-	if (vp_dev->msix_enabled) {
+	if (vp_dev->pci_dev->msix_enabled) {
 		vp_iowrite16(VIRTIO_MSI_NO_VECTOR,
 			     &vp_dev->common->queue_msix_vector);
 		/* Flush the write out to device */
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 90007a1..15b4385 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -79,7 +79,7 @@
  * configuration space */
 #define VIRTIO_PCI_CONFIG_OFF(msix_enabled)	((msix_enabled) ? 24 : 20)
 /* Deprecated: please use VIRTIO_PCI_CONFIG_OFF instead */
-#define VIRTIO_PCI_CONFIG(dev)	VIRTIO_PCI_CONFIG_OFF((dev)->msix_enabled)
+#define VIRTIO_PCI_CONFIG(dev)	VIRTIO_PCI_CONFIG_OFF((dev)->pci_dev->msix_enabled)
 
 /* Virtio ABI version, this must match exactly */
 #define VIRTIO_PCI_ABI_VERSION		0
-- 
2.1.4
