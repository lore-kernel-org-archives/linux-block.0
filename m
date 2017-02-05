Return-Path: <BATV+7c9ed557eb952ccf5513+4914+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: axboe@kernel.dk,
	pbonzini@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] virtio_pci: don't duplicate the msix_enable flag in struct pci_dev
Date: Sun,  5 Feb 2017 18:15:20 +0100
Message-Id: <20170205171526.6224-4-hch@lst.de>
In-Reply-To: <20170205171526.6224-1-hch@lst.de>
References: <20170205171526.6224-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 5 ++---
 drivers/virtio/virtio_pci_common.h | 2 --
 drivers/virtio/virtio_pci_legacy.c | 2 +-
 drivers/virtio/virtio_pci_modern.c | 2 +-
 include/uapi/linux/virtio_pci.h    | 2 +-
 5 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 274dc1ff09c0..b83053082875 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -125,7 +125,7 @@ void vp_del_vqs(struct virtio_device *vdev)
 
 	vp_remove_vqs(vdev);
 
-	if (vp_dev->msix_enabled) {
+	if (vp_dev->pci_dev->msix_enabled) {
 		for (i = 0; i < vp_dev->msix_vectors; i++)
 			free_cpumask_var(vp_dev->msix_affinity_masks[i]);
 
@@ -244,7 +244,6 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 			allocated_vectors++;
 	}
 
-	vp_dev->msix_enabled = 1;
 	return 0;
 
 out_remove_vqs:
@@ -340,7 +339,7 @@ int vp_set_vq_affinity(struct virtqueue *vq, int cpu)
 	if (!vq->callback)
 		return -EINVAL;
 
-	if (vp_dev->msix_enabled) {
+	if (vp_dev->pci_dev->msix_enabled) {
 		int vec = vp_dev->msix_vector_map[vq->index];
 		struct cpumask *mask = vp_dev->msix_affinity_masks[vec];
 		unsigned int irq = pci_irq_vector(vp_dev->pci_dev, vec);
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 85593867e712..217ca876eed7 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -64,8 +64,6 @@ struct virtio_pci_device {
 	/* the IO mapping for the PCI config space */
 	void __iomem *ioaddr;
 
-	/* MSI-X support */
-	int msix_enabled;
 	cpumask_var_t *msix_affinity_masks;
 	/* Name strings for interrupts. This size should be enough,
 	 * and I'm too lazy to allocate each name separately. */
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 47292dad0ff9..2ab6aee51bf6 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -165,7 +165,7 @@ static void del_vq(struct virtqueue *vq)
 
 	iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
 
-	if (vp_dev->msix_enabled) {
+	if (vp_dev->pci_dev->msix_enabled) {
 		iowrite16(VIRTIO_MSI_NO_VECTOR,
 			  vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
 		/* Flush the write out to device */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 00e6fc1df407..e5ce31091953 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -412,7 +412,7 @@ static void del_vq(struct virtqueue *vq)
 
 	vp_iowrite16(vq->index, &vp_dev->common->queue_select);
 
-	if (vp_dev->msix_enabled) {
+	if (vp_dev->pci_dev->msix_enabled) {
 		vp_iowrite16(VIRTIO_MSI_NO_VECTOR,
 			     &vp_dev->common->queue_msix_vector);
 		/* Flush the write out to device */
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 90007a1abcab..15b4385a2be1 100644
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
2.11.0
