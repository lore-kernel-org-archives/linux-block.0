Return-Path: <BATV+c11f2a9076c546b906d6+4834+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: mst@redhat.com
Cc: axboe@kernel.dk,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] virtio: provide a method to get the IRQ affinity mask for a virtqueue
Date: Thu, 17 Nov 2016 11:43:21 +0100
Message-Id: <1479379403-27880-10-git-send-email-hch@lst.de>
In-Reply-To: <1479379403-27880-1-git-send-email-hch@lst.de>
References: <1479379403-27880-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This basically passed up the pci_irq_get_affinity information through
virtio through an optional get_vq_affinity method.  It is only implemented
by the PCI backend for now, and only when we use per-virtqueue IRQs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/virtio/virtio_pci_common.c | 10 ++++++++++
 drivers/virtio/virtio_pci_common.h |  2 ++
 drivers/virtio/virtio_pci_legacy.c |  1 +
 drivers/virtio/virtio_pci_modern.c |  2 ++
 include/linux/virtio_config.h      |  3 +++
 5 files changed, 18 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index df7164e..25622da 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -405,6 +405,16 @@ int vp_set_vq_affinity(struct virtqueue *vq, int cpu)
 	return 0;
 }
 
+const struct cpumask *vp_get_vq_affinity(struct virtio_device *vdev, int index)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	int vec = vp_dev->vqs[index]->msix_vector;
+
+	if (vec == VIRTIO_MSI_NO_VECTOR)
+		return NULL;
+	return pci_irq_get_affinity(vp_dev->pci_dev, vec);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int virtio_pci_freeze(struct device *dev)
 {
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 85010f0..d6c29c5 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -125,6 +125,8 @@ const char *vp_bus_name(struct virtio_device *vdev);
  */
 int vp_set_vq_affinity(struct virtqueue *vq, int cpu);
 
+const struct cpumask *vp_get_vq_affinity(struct virtio_device *vdev, int index);
+
 #if IS_ENABLED(CONFIG_VIRTIO_PCI_LEGACY)
 int virtio_pci_legacy_probe(struct virtio_pci_device *);
 void virtio_pci_legacy_remove(struct virtio_pci_device *);
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index f83829f..4930b23 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -194,6 +194,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.finalize_features = vp_finalize_features,
 	.bus_name	= vp_bus_name,
 	.set_vq_affinity = vp_set_vq_affinity,
+	.get_vq_affinity = vp_get_vq_affinity,
 };
 
 /* the PCI probing function */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 975197b..cd09d78 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -441,6 +441,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.finalize_features = vp_finalize_features,
 	.bus_name	= vp_bus_name,
 	.set_vq_affinity = vp_set_vq_affinity,
+	.get_vq_affinity = vp_get_vq_affinity,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -456,6 +457,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.finalize_features = vp_finalize_features,
 	.bus_name	= vp_bus_name,
 	.set_vq_affinity = vp_set_vq_affinity,
+	.get_vq_affinity = vp_get_vq_affinity,
 };
 
 /**
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 2ebe506..8355bab 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -58,6 +58,7 @@ struct irq_affinity;
  *      This returns a pointer to the bus name a la pci_name from which
  *      the caller can then copy.
  * @set_vq_affinity: set the affinity for a virtqueue.
+ * @get_vq_affinity: get the affinity for a virtqueue (optional).
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
@@ -77,6 +78,8 @@ struct virtio_config_ops {
 	int (*finalize_features)(struct virtio_device *vdev);
 	const char *(*bus_name)(struct virtio_device *vdev);
 	int (*set_vq_affinity)(struct virtqueue *vq, int cpu);
+	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
+			int index);
 };
 
 /* If driver didn't advertise the feature, it will never appear. */
-- 
2.1.4
