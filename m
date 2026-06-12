Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B6B3D1CD1;
	Mon, 15 Jun 2026 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514251; cv=none; b=Na8+nzdZCD0sVJ7SKYeKPiRNsQyQZijHAjIWygEyyfhmxx+vl64QZm4Op79AEoVl9w0fYJM/MQBo7+1JhcEdGvOEkbknwrBar/4J06ST3e3cJU8QMwE4Z0RAIMYh9Otxz7EqJQK6oP+dZondByB031Y+vYwkQE2/YLiasYcmbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514251; c=relaxed/simple;
	bh=iAtwmOg7wdUoByy0Eof5X5C+hGtRexgTcxvOQbhafNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIuEskCAyKc8Ovky7SLieiZ9xX6xSJR0k49TdOKJwwFSHXVnvU2rgWKlLXpfUvAMDD/dU2Pu9Y1pW7feJ9EdIuQ8/l0B4WOgyDFN2J5YOuP458QyZhgjUMJ+OdKsWVwwffWoCut/zRUdQdqDzsZlRwNgTEisZBc/HYJR6YrvKwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 267595b6689911f1aa26b74ffac11d73-20260615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d320fe50-36ab-44d2-aef3-046f29811f54,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:a7ed6b13964eace7a4d9e010cf11a36e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 267595b6689911f1aa26b74ffac11d73-20260615
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2008293629; Mon, 15 Jun 2026 17:04:00 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-block@vger.kernel.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 2/2] virtio-blk: mark disk dead on ERS permanent failure
Date: Thu, 12 Jun 2026 18:00:00 +0800
Message-ID: <4740ae91d5be.1780449274.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn>
References: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: virtio-blk-ers-fail/send-local.py

After ERS reports pci_channel_io_perm_failure, virtio-pci must ask the
virtio driver to tear down the block device — not only mark virtqueues
broken.  Call the virtio driver shutdown hook from virtio-pci on
perm_failure; virtio-blk implements shutdown with blk_mark_disk_dead().
Fail new requests early in virtio_queue_rq when the disk is dead or
virtqueues were removed during frozen reset_prepare.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/block/virtio_blk.c         | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.c | 10 +++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9d..4740ae91d5be 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -435,6 +435,12 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_status_t status;
 	int err;
 
+	/* Fail fast if ERS frozen tore down VQs or the disk was marked dead. */
+	if (unlikely(!disk_live(vblk->disk) || !vblk->vqs || !vblk->vdev)) {
+		blk_mq_start_request(req);
+		return BLK_STS_IOERR;
+	}
+
 	status = virtblk_prep_rq(hctx, vblk, req, vbr);
 	if (unlikely(status))
 		return status;
@@ -1561,6 +1567,29 @@ static int virtblk_probe(struct virtio_device *vdev)
 	return err;
 }
 
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
+	flush_work(&vblk->config_work);
+	virtio_break_device(vdev);
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
@@ -1684,6 +1713,7 @@ static struct virtio_driver virtio_blk = {
 	.probe				= virtblk_probe,
 	.remove				= virtblk_remove,
 	.config_changed			= virtblk_config_changed,
+	.shutdown			= virtblk_shutdown,
 #ifdef CONFIG_PM_SLEEP
 	.freeze				= virtblk_freeze,
 	.restore			= virtblk_restore,
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index e2dda946e70e..924ceead436b 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -845,7 +845,15 @@ static pci_ers_result_t virtio_pci_error_detected(struct pci_dev *pci_dev,
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

