Return-Path: <BATV+7c9ed557eb952ccf5513+4914+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: axboe@kernel.dk,
	pbonzini@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] virtio: allow drivers to request IRQ affinity when creating VQs
Date: Sun,  5 Feb 2017 18:15:22 +0100
Message-Id: <20170205171526.6224-6-hch@lst.de>
In-Reply-To: <20170205171526.6224-1-hch@lst.de>
References: <20170205171526.6224-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Add a struct irq_affinity pointer to the find_vqs methods, which if set
is used to tell the PCI layer to create the MSI-X vectors for our I/O
virtqueues with the proper affinity from the start.  Compared to after
the fact affinity hints this gives us an instantly working setup and
allows to allocate the irq descritors node-local and avoid interconnect
traffic.  Last but not least this will allow blk-mq queues are created
based on the interrupt affinity for storage drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Wang <jasowang@redhat.com>
---
 drivers/block/virtio_blk.c                 |  3 ++-
 drivers/char/virtio_console.c              |  2 +-
 drivers/crypto/virtio/virtio_crypto_core.c |  2 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c       |  2 +-
 drivers/misc/mic/vop/vop_main.c            |  2 +-
 drivers/net/caif/caif_virtio.c             |  3 ++-
 drivers/net/virtio_net.c                   |  2 +-
 drivers/remoteproc/remoteproc_virtio.c     |  3 ++-
 drivers/rpmsg/virtio_rpmsg_bus.c           |  2 +-
 drivers/s390/virtio/kvm_virtio.c           |  3 ++-
 drivers/s390/virtio/virtio_ccw.c           |  3 ++-
 drivers/scsi/virtio_scsi.c                 |  3 ++-
 drivers/virtio/virtio_balloon.c            |  3 ++-
 drivers/virtio/virtio_input.c              |  3 ++-
 drivers/virtio/virtio_mmio.c               |  3 ++-
 drivers/virtio/virtio_pci_common.c         | 19 ++++++++++++-------
 drivers/virtio/virtio_pci_common.h         |  5 ++---
 drivers/virtio/virtio_pci_modern.c         |  7 +++----
 include/linux/virtio_config.h              |  9 +++++----
 net/vmw_vsock/virtio_transport.c           |  3 ++-
 20 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 10332c24f961..c54118bdc67d 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -411,7 +411,8 @@ static int init_vq(struct virtio_blk *vblk)
 	}
 
 	/* Discover virtqueues and write information to configuration.  */
-	err = vdev->config->find_vqs(vdev, num_vqs, vqs, callbacks, names);
+	err = vdev->config->find_vqs(vdev, num_vqs, vqs, callbacks, names,
+			NULL);
 	if (err)
 		goto out;
 
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 17857beb4892..6266c0568e1d 100644
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
 
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index fe70ec823b27..0aa2f045543b 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -119,7 +119,7 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 	}
 
 	ret = vi->vdev->config->find_vqs(vi->vdev, total_vqs, vqs, callbacks,
-					 names);
+					 names, NULL);
 	if (ret)
 		goto err_find;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 1235519853f4..e975fa5b0a32 100644
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
index 1a2b67f3183d..c2e29d7f0de8 100644
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
index b306210b02b7..bc0eb47eccee 100644
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
index 765c2d6358da..9be74c2dfb22 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2003,7 +2003,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 	}
 
 	ret = vi->vdev->config->find_vqs(vi->vdev, total_vqs, vqs, callbacks,
-					 names);
+					 names, NULL);
 	if (ret)
 		goto err_find;
 
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 364411fb7734..0142cc3f0c91 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -137,7 +137,8 @@ static void rproc_virtio_del_vqs(struct virtio_device *vdev)
 static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 				 struct virtqueue *vqs[],
 				 vq_callback_t *callbacks[],
-				 const char * const names[])
+				 const char * const names[],
+				 struct irq_affinity *desc)
 {
 	int i, ret;
 
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 3090b0d3072f..5e66e081027e 100644
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
index 5e5c11f37b24..2ce0b3eb2efe 100644
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
index 070c4da95f48..304d3b3cbfd3 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -628,7 +628,8 @@ static int virtio_ccw_register_adapter_ind(struct virtio_ccw_device *vcdev,
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
index ec91bd07f00a..32a16293436b 100644
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
index 181793f07852..36c9c8fcb7f8 100644
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
index 350a2a5a49db..79f1293cda93 100644
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
index c71fde5fe835..ec8ccb21e9b7 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -446,7 +446,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
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
index 822f8e5dcee4..7902e920fc73 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -143,22 +143,28 @@ void vp_del_vqs(struct virtio_device *vdev)
 
 static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[])
+		const char * const names[], struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	const char *name = dev_name(&vp_dev->vdev.dev);
 	int i, err = -ENOMEM, allocated_vectors, nvectors;
+	unsigned flags = PCI_IRQ_MSIX;
 	bool shared = false;
 	u16 msix_vec;
 
+	if (desc) {
+		flags |= PCI_IRQ_AFFINITY;
+		desc->pre_vectors++; /* virtio config vector */
+	}
+
 	nvectors = 1;
 	for (i = 0; i < nvqs; i++)
 		if (callbacks[i])
 			nvectors++;
 
 	/* Try one vector per queue first. */
-	err = pci_alloc_irq_vectors(vp_dev->pci_dev, nvectors, nvectors,
-			PCI_IRQ_MSIX);
+	err = pci_alloc_irq_vectors_affinity(vp_dev->pci_dev, nvectors,
+			nvectors, flags, desc);
 	if (err < 0) {
 		/* Fallback to one vector for config, one shared for queues. */
 		shared = true;
@@ -308,13 +314,12 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
 
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
index 217ca876eed7..a6ad9ec6baef 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -97,9 +97,8 @@ bool vp_notify(struct virtqueue *vq);
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
index e5ce31091953..a7a0981e441c 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -384,13 +384,12 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
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
index 26c155bb639b..2ebe506fe41a 100644
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
index 6788264acc63..9d24c0e958b1 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -532,7 +532,8 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	vsock->vdev = vdev;
 
 	ret = vsock->vdev->config->find_vqs(vsock->vdev, VSOCK_VQ_MAX,
-					    vsock->vqs, callbacks, names);
+					    vsock->vqs, callbacks, names,
+					    NULL);
 	if (ret < 0)
 		goto out;
 
-- 
2.11.0
