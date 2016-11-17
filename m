Return-Path: <BATV+c11f2a9076c546b906d6+4834+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: mst@redhat.com
Cc: axboe@kernel.dk,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] virtio: allow drivers to request IRQ affinity when creating VQs
Date: Thu, 17 Nov 2016 11:43:20 +0100
Message-Id: <1479379403-27880-9-git-send-email-hch@lst.de>
In-Reply-To: <1479379403-27880-1-git-send-email-hch@lst.de>
References: <1479379403-27880-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Add a struct irq_affinity pointer to the find_vqs methods, which if set
is used to tell the PCI layer to create the MSI-X vectors for our I/O
virtqueues with the proper affinity from the start.  Compared to after
the fact affinity hints this gives us an instantly working setup and
allows to allocate the irq descritors node-local and avoid interconnect
traffic.  Last but not least this will allow blk-mq queues are created
based on the interrupt affinity for storage drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c             |  3 ++-
 drivers/char/virtio_console.c          |  2 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c   |  2 +-
 drivers/misc/mic/vop/vop_main.c        |  2 +-
 drivers/net/caif/caif_virtio.c         |  3 ++-
 drivers/net/virtio_net.c               |  2 +-
 drivers/remoteproc/remoteproc_virtio.c |  3 ++-
 drivers/rpmsg/virtio_rpmsg_bus.c       |  2 +-
 drivers/s390/virtio/kvm_virtio.c       |  3 ++-
 drivers/s390/virtio/virtio_ccw.c       |  3 ++-
 drivers/scsi/virtio_scsi.c             |  3 ++-
 drivers/virtio/virtio_balloon.c        |  3 ++-
 drivers/virtio/virtio_input.c          |  3 ++-
 drivers/virtio/virtio_mmio.c           |  3 ++-
 drivers/virtio/virtio_pci_common.c     | 31 +++++++++++++++++--------------
 drivers/virtio/virtio_pci_common.h     |  5 ++---
 drivers/virtio/virtio_pci_modern.c     |  7 +++----
 include/linux/virtio_config.h          |  9 +++++----
 net/vmw_vsock/virtio_transport.c       |  3 ++-
 19 files changed, 52 insertions(+), 40 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 5545a67..689e790 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -409,7 +409,8 @@ static int init_vq(struct virtio_blk *vblk)
 	}
 
 	/* Discover virtqueues and write information to configuration.  */
-	err = vdev->config->find_vqs(vdev, num_vqs, vqs, callbacks, names);
+	err = vdev->config->find_vqs(vdev, num_vqs, vqs, callbacks, names,
+			NULL);
 	if (err)
 		goto out;
 
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 5649234..18d0681 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1939,7 +1939,7 @@ static int init_vqs(struct ports_device *portdev)
 	/* Find the queues. */
 	err = portdev->vdev->config->find_vqs(portdev->vdev, nr_queues, vqs,
 					      io_callbacks,
-					      (const char **)io_names);
+					      (const char **)io_names, NULL);
 	if (err)
 		goto free;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 036b0fb..d62ad53 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -172,7 +172,7 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
 		 vgdev->has_virgl_3d ? "enabled" : "not available");
 
 	ret = vgdev->vdev->config->find_vqs(vgdev->vdev, 2, vqs,
-					    callbacks, names);
+					    callbacks, names, NULL);
 	if (ret) {
 		DRM_ERROR("failed to find virt queues\n");
 		goto err_vqs;
diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 1a2b67f3..c2e29d7 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -374,7 +374,7 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 static int vop_find_vqs(struct virtio_device *dev, unsigned nvqs,
 			struct virtqueue *vqs[],
 			vq_callback_t *callbacks[],
-			const char * const names[])
+			const char * const names[], struct irq_affinity *desc)
 {
 	struct _vop_vdev *vdev = to_vopvdev(dev);
 	struct vop_device *vpdev = vdev->vpdev;
diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index b306210..bc0eb47 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -679,7 +679,8 @@ static int cfv_probe(struct virtio_device *vdev)
 		goto err;
 
 	/* Get the TX virtio ring. This is a "guest side vring". */
-	err = vdev->config->find_vqs(vdev, 1, &cfv->vq_tx, &vq_cbs, &names);
+	err = vdev->config->find_vqs(vdev, 1, &cfv->vq_tx, &vq_cbs, &names,
+			NULL);
 	if (err)
 		goto err;
 
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fad84f3..08c9ee5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1601,7 +1601,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 	}
 
 	ret = vi->vdev->config->find_vqs(vi->vdev, total_vqs, vqs, callbacks,
-					 names);
+					 names, NULL);
 	if (ret)
 		goto err_find;
 
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 01870a1..49c73ce 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -142,7 +142,8 @@ static void rproc_virtio_del_vqs(struct virtio_device *vdev)
 static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 				 struct virtqueue *vqs[],
 				 vq_callback_t *callbacks[],
-				 const char * const names[])
+				 const char * const names[],
+				 struct irq_affinity *desc)
 {
 	int i, ret;
 
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 3090b0d..5e66e08 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -869,7 +869,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	init_waitqueue_head(&vrp->sendq);
 
 	/* We expect two virtqueues, rx and tx (and in this order) */
-	err = vdev->config->find_vqs(vdev, 2, vqs, vq_cbs, names);
+	err = vdev->config->find_vqs(vdev, 2, vqs, vq_cbs, names, NULL);
 	if (err)
 		goto free_vrp;
 
diff --git a/drivers/s390/virtio/kvm_virtio.c b/drivers/s390/virtio/kvm_virtio.c
index 5e5c11f..2ce0b3e 100644
--- a/drivers/s390/virtio/kvm_virtio.c
+++ b/drivers/s390/virtio/kvm_virtio.c
@@ -255,7 +255,8 @@ static void kvm_del_vqs(struct virtio_device *vdev)
 static int kvm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			struct virtqueue *vqs[],
 			vq_callback_t *callbacks[],
-			const char * const names[])
+			const char * const names[],
+			struct irq_affinity *desc)
 {
 	struct kvm_device *kdev = to_kvmdev(vdev);
 	int i;
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 8688ad4..8b9c3a5 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -636,7 +636,8 @@ static int virtio_ccw_register_adapter_ind(struct virtio_ccw_device *vcdev,
 static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			       struct virtqueue *vqs[],
 			       vq_callback_t *callbacks[],
-			       const char * const names[])
+			       const char * const names[],
+			       struct irq_affinity *desc)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	unsigned long *indicatorp = NULL;
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index ec91bd0..32a1629 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -932,7 +932,8 @@ static int virtscsi_init(struct virtio_device *vdev,
 	}
 
 	/* Discover virtqueues and write information to configuration.  */
-	err = vdev->config->find_vqs(vdev, num_vqs, vqs, callbacks, names);
+	err = vdev->config->find_vqs(vdev, num_vqs, vqs, callbacks, names,
+			NULL);
 	if (err)
 		goto out;
 
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 181793f..36c9c8f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -413,7 +413,8 @@ static int init_vqs(struct virtio_balloon *vb)
 	 * optionally stat.
 	 */
 	nvqs = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ) ? 3 : 2;
-	err = vb->vdev->config->find_vqs(vb->vdev, nvqs, vqs, callbacks, names);
+	err = vb->vdev->config->find_vqs(vb->vdev, nvqs, vqs, callbacks, names,
+			NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index 350a2a5..79f1293 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -173,7 +173,8 @@ static int virtinput_init_vqs(struct virtio_input *vi)
 	static const char * const names[] = { "events", "status" };
 	int err;
 
-	err = vi->vdev->config->find_vqs(vi->vdev, 2, vqs, cbs, names);
+	err = vi->vdev->config->find_vqs(vi->vdev, 2, vqs, cbs, names,
+			NULL);
 	if (err)
 		return err;
 	vi->evt = vqs[0];
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 48bfea9..64c87be 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -445,7 +445,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		       struct virtqueue *vqs[],
 		       vq_callback_t *callbacks[],
-		       const char * const names[])
+		       const char * const names[],
+		       struct irq_affinity *desc)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	unsigned int irq = platform_get_irq(vm_dev->pdev, 0);
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 90d7975..df7164e 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -107,20 +107,25 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 	return vp_vring_interrupt(irq, opaque);
 }
 
-static int vp_setup_msix_vectors(struct virtio_device *vdev, int nvectors)
+static int vp_setup_msix_vectors(struct virtio_device *vdev, int nvectors,
+		struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	const char *name = dev_name(&vp_dev->vdev.dev);
-	unsigned i;
+	unsigned flags = PCI_IRQ_MSIX, i;
 	int err = -ENOMEM;
 
+	if (desc) {
+		flags |= PCI_IRQ_AFFINITY;
+		desc->pre_vectors++; /* virtio config vector */
+	}
+
 	/* Try one vector per queue first. */
-	err = pci_alloc_irq_vectors(vp_dev->pci_dev, nvectors, nvectors,
-			PCI_IRQ_MSIX);
+	err = pci_alloc_irq_vectors_affinity(vp_dev->pci_dev, nvectors,
+			nvectors, flags, desc);
 	if (err < 0) {
 		/* Fallback to one vector for config, one shared for queues. */
-		err = pci_alloc_irq_vectors(vp_dev->pci_dev, 2, 2,
-				PCI_IRQ_MSIX);
+		err = pci_alloc_irq_vectors(vp_dev->pci_dev, 2, 2, flags);
 		if (err < 0)
 			goto error;
 		nvectors = 2;
@@ -247,9 +252,8 @@ void vp_del_vqs(struct virtio_device *vdev)
 }
 
 static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
-			      struct virtqueue *vqs[],
-			      vq_callback_t *callbacks[],
-			      const char * const names[])
+		struct virtqueue *vqs[], vq_callback_t *callbacks[],
+		const char * const names[], struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	u16 msix_vec;
@@ -265,7 +269,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 			nvectors++;
 	}
 
-	err = vp_setup_msix_vectors(vdev, nvectors);
+	err = vp_setup_msix_vectors(vdev, nvectors, desc);
 	if (err < 0)
 		goto error_find;
 	nvectors = err;
@@ -353,13 +357,12 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
 
 /* the config->find_vqs() implementation */
 int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-		struct virtqueue *vqs[],
-		vq_callback_t *callbacks[],
-		const char * const names[])
+		struct virtqueue *vqs[], vq_callback_t *callbacks[],
+		const char * const names[], struct irq_affinity *desc)
 {
 	int err;
 
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, desc);
 	if (!err)
 		return 0;
 	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names);
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index d041cce..85010f0 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -114,9 +114,8 @@ bool vp_notify(struct virtqueue *vq);
 void vp_del_vqs(struct virtio_device *vdev);
 /* the config->find_vqs() implementation */
 int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-		       struct virtqueue *vqs[],
-		       vq_callback_t *callbacks[],
-		       const char * const names[]);
+		struct virtqueue *vqs[], vq_callback_t *callbacks[],
+		const char * const names[], struct irq_affinity *desc);
 const char *vp_bus_name(struct virtio_device *vdev);
 
 /* Setup the affinity for a virtqueue:
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index e18d0b0..975197b 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -387,13 +387,12 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 }
 
 static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-			      struct virtqueue *vqs[],
-			      vq_callback_t *callbacks[],
-			      const char * const names[])
+		struct virtqueue *vqs[], vq_callback_t *callbacks[],
+		const char * const names[], struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtqueue *vq;
-	int rc = vp_find_vqs(vdev, nvqs, vqs, callbacks, names);
+	int rc = vp_find_vqs(vdev, nvqs, vqs, callbacks, names, desc);
 
 	if (rc)
 		return rc;
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 26c155b..2ebe506 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -7,6 +7,8 @@
 #include <linux/virtio_byteorder.h>
 #include <uapi/linux/virtio_config.h>
 
+struct irq_affinity;
+
 /**
  * virtio_config_ops - operations for configuring a virtio device
  * @get: read the value of a configuration field
@@ -68,9 +70,8 @@ struct virtio_config_ops {
 	void (*set_status)(struct virtio_device *vdev, u8 status);
 	void (*reset)(struct virtio_device *vdev);
 	int (*find_vqs)(struct virtio_device *, unsigned nvqs,
-			struct virtqueue *vqs[],
-			vq_callback_t *callbacks[],
-			const char * const names[]);
+			struct virtqueue *vqs[], vq_callback_t *callbacks[],
+			const char * const names[], struct irq_affinity *desc);
 	void (*del_vqs)(struct virtio_device *);
 	u64 (*get_features)(struct virtio_device *vdev);
 	int (*finalize_features)(struct virtio_device *vdev);
@@ -169,7 +170,7 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 	vq_callback_t *callbacks[] = { c };
 	const char *names[] = { n };
 	struct virtqueue *vq;
-	int err = vdev->config->find_vqs(vdev, 1, &vq, callbacks, names);
+	int err = vdev->config->find_vqs(vdev, 1, &vq, callbacks, names, NULL);
 	if (err < 0)
 		return ERR_PTR(err);
 	return vq;
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 936d7ee..09906db 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -489,7 +489,8 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	vsock->vdev = vdev;
 
 	ret = vsock->vdev->config->find_vqs(vsock->vdev, VSOCK_VQ_MAX,
-					    vsock->vqs, callbacks, names);
+					    vsock->vqs, callbacks, names,
+					    NULL);
 	if (ret < 0)
 		goto out;
 
-- 
2.1.4
