Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D40F3CA4A1;
	Fri, 31 Jul 2026 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486494; cv=none; b=HVFwRuH8W78Mg1S7w6X7WHkxxn4dBngJhT7tW6I5CzD1VacIeTzF8Zlag7nPGt4CoO3nATnNnbEK+aTT89i6onbtpm2IkaduEski3VQ6YC+vwuiNNYOQAK3k8FiEFkokESJMCwkw2ig9+rAHIcBC40z4M6uOGw71WhRRzDrv6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486494; c=relaxed/simple;
	bh=FQUPIAbssfpQ9jLczp7dPjjNnSntGlBzBK6tvTkXyR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMAHQiSBETedgiV3bHmekrV+Kv5y+aGPQDFVqMjInNGNo7hEBlNYO4xrP1lRqkSq4wv1Uo446BcPHXhPqlc7P+DkmezqmrA2R3PAa1daUWDTKSpnABFrJ50nqesfjdGwbYHknaiNn5Nmse3uJJLZDsMM39ioylKS9/g6E1AI0kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c0f33cb28cb911f1aa26b74ffac11d73-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3bff46a1-0fd1-4718-9f95-36be00e2dfd5,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:406ff3e5adb88fbb9168c29cee2fced8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c0f33cb28cb911f1aa26b74ffac11d73-20260731
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1694241203; Fri, 31 Jul 2026 16:28:05 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-block@vger.kernel.org
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v2 2/2] virtio-blk: mark disk dead on ERS permanent failure
Date: Fri, 31 Jul 2026 11:19:00 +0800
Message-ID: <4740ae91d5be.v2.1785468000.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.virtio-blk-ers-v2.1785468000.git.liuxixin@kylinos.cn>
References: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn> <cover.virtio-blk-ers-v2.1785468000.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

After ERS reports pci_channel_io_perm_failure, virtio-pci must ask the
virtio driver to tear down the block device, not only mark virtqueues
broken.  Call the virtio driver shutdown hook from virtio-pci on
perm_failure; virtio-blk implements shutdown with blk_mark_disk_dead().

Fail new requests early in virtio_queue_rq when virtqueues were removed
during frozen reset_prepare (vqs == NULL).  A broken vq already fails in
virtqueue_add; no separate disk_live() check is needed.

Assisted-by: DeepSeek:deepseek-v3
Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/block/virtio_blk.c         | 31 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.c | 10 +++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9d..fda2d4f3c7c6 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -435,6 +435,12 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_status_t status;
 	int err;
 
+	/* VQs may be gone after frozen reset_prepare; avoid NULL deref. */
+	if (unlikely(!vblk->vqs || !vblk->vdev)) {
+		blk_mq_start_request(req);
+		return BLK_STS_IOERR;
+	}
+
 	status = virtblk_prep_rq(hctx, vblk, req, vbr);
 	if (unlikely(status))
 		return status;
@@ -1561,6 +1567,30 @@ static int virtblk_probe(struct virtio_device *vdev)
 	return err;
 }
 
+
+/* Stop I/O and mark the gendisk dead (ERS perm_failure or system shutdown). */
+static void virtblk_shutdown(struct virtio_device *vdev)
+{
+	struct virtio_blk *vblk = vdev->priv;
+	struct request_queue *q;
+	unsigned int memflags;
+
+	if (!vblk || !vblk->disk)
+		return;
+
+	virtio_break_device(vdev);
+	flush_work(&vblk->config_work);
+
+	q = vblk->disk->queue;
+	memflags = blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue_nowait(q);
+
+	blk_mark_disk_dead(vblk->disk);
+
+	blk_mq_unquiesce_queue(q);
+	blk_mq_unfreeze_queue(q, memflags);
+}
+
 static void virtblk_remove(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
@@ -1684,6 +1714,7 @@ static struct virtio_driver virtio_blk = {
 	.probe				= virtblk_probe,
 	.remove				= virtblk_remove,
 	.config_changed			= virtblk_config_changed,
+	.shutdown			= virtblk_shutdown,
 #ifdef CONFIG_PM_SLEEP
 	.freeze				= virtblk_freeze,
 	.restore			= virtblk_restore,
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index fff6b6e2d0c5..957b3282865c 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -849,7 +849,15 @@ static pci_ers_result_t virtio_pci_error_detected(struct pci_dev *pci_dev,
 	case pci_channel_io_perm_failure:
 		dev_warn(&pci_dev->dev,
 			 "permanent failure, disconnecting device\n");
-		virtio_break_device(&vp_dev->vdev);
+		{
+			struct virtio_driver *drv =
+				drv_to_virtio(vp_dev->vdev.dev.driver);
+
+			if (drv && drv->shutdown)
+				drv->shutdown(&vp_dev->vdev);
+			else
+				virtio_break_device(&vp_dev->vdev);
+		}
 		return PCI_ERS_RESULT_DISCONNECT;
 	default:
 		break;
-- 
2.43.0

