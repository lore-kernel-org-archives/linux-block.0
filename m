Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC18144E65F;
	Fri,  7 Aug 2026 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085897; cv=none; b=iW2eum/IRe7tId7xKo/fFjea2L9Mp4jP5s+azhwuxPRjglUDtq/aGbaVhrAoKs/ZYkglj8B7cmjkrXNFkQpRUXdBbyNaBVSb3/0a+XIEkozHmmYqH5T/bIjeWJabPKP6kgG7hvxtTy8by/JtDrlCLInaBcBUUyxbOaOuU5Q2eeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085897; c=relaxed/simple;
	bh=4m+EHl2XTR/0uEV/B4HePdgMiDwLkPiJHY5SCOXNQ5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMfi8wJ6yja5Yx4713DPQeolbHZB9VohVMyJhRxPIbk1OOsigYtq4sL/OVxR2L71YKqmg5KNtc5JkIxiWEmrKXMbSQPtTC5p5mAeVR6EI17WB6iIMzBkS4Ux1bbDVnE9DGO2BgKZf3RacnhU3txt/hYIP3HNs/u1/5WK20/pEu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5a013936922d11f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7ed57725-55f1-4dc7-aaae-c7e5e56f3396,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:ae1ced206cde49520b779d84447a9a33,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5a013936922d11f1aa26b74ffac11d73-20260807
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 706926235; Fri, 07 Aug 2026 14:58:10 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-block@vger.kernel.org
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v3 1/2] virtio-pci: add error_detected and slot_reset for AER
Date: Thu, 6 Aug 2026 09:15:00 +0800
Message-ID: <a1b2c3d4e5f0.v3.1785920716.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.virtio-blk-ers-v3.1785920716.git.liuxixin@kylinos.cn>
References: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn> <cover.virtio-blk-ers-v2.1785468000.git.liuxixin@kylinos.cn> <cover.virtio-blk-ers-v3.1785920716.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

virtio-pci only registered reset_prepare/reset_done.  Without
.error_detected the recovery core votes NO_AER_DRIVER on the first
broadcast, and report_perm_failure_detected skips the driver callback
whenever overall status is not RECOVERED.  That skip covers
NO_AER_DRIVER even when subordinate reset succeeded.  Virtio therefore
misses the normal ERS path and pci_channel_io_perm_failure.

AER's aer_root_reset() uses pci_bus_error_reset(), which does a bus or
slot reset without pci_dev_save_and_disable().  The existing
.reset_prepare and .reset_done therefore do not run on that path.
Those hooks still serve FLR and pci_reset_function.

Register error_detected and slot_reset:
- frozen / unknown: virtio_device_reset_prepare() then NEED_RESET
- after a successful PCI reset: restore config, virtio_device_reset_done()
- perm_failure: virtio_break_device() and return DISCONNECT

Assisted-by: DeepSeek:deepseek-v3
Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/virtio/virtio_pci_common.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 164f480b18a6..c0ffeed00004 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -828,7 +828,60 @@ static void virtio_pci_reset_done(struct pci_dev *pci_dev)
 		dev_warn(&pci_dev->dev, "Reset done failure: %d", ret);
 }
 
+static pci_ers_result_t virtio_pci_error_detected(struct pci_dev *pci_dev,
+						  pci_channel_state_t state)
+{
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+
+	/*
+	 * Quiesce on frozen/unknown before AER bus reset.  That path does
+	 * not call .reset_prepare.  On permanent failure only break
+	 * virtqueues.
+	 */
+	switch (state) {
+	case pci_channel_io_normal:
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	case pci_channel_io_perm_failure:
+		dev_warn(&pci_dev->dev,
+			 "permanent failure, disconnecting device\n");
+		virtio_break_device(&vp_dev->vdev);
+		return PCI_ERS_RESULT_DISCONNECT;
+	case pci_channel_io_frozen:
+	default:
+		pci_info(pci_dev, "channel state %u, quiesce device\n", state);
+		if (virtio_device_reset_prepare(&vp_dev->vdev))
+			dev_warn(&pci_dev->dev, "reset prepare failed\n");
+		return PCI_ERS_RESULT_NEED_RESET;
+	}
+}
+
+static pci_ers_result_t virtio_pci_slot_reset(struct pci_dev *pci_dev)
+{
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+	int ret;
+
+	if (pci_enable_device(pci_dev)) {
+		dev_err(&pci_dev->dev,
+			"Cannot re-enable PCI device after reset\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	pci_set_master(pci_dev);
+	pci_restore_state(pci_dev);
+
+	ret = virtio_device_reset_done(&vp_dev->vdev);
+	if (ret && ret != -EOPNOTSUPP) {
+		dev_warn(&pci_dev->dev, "slot reset restore failed: %d\n",
+			 ret);
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
 static const struct pci_error_handlers virtio_pci_err_handler = {
+	.error_detected = virtio_pci_error_detected,
+	.slot_reset     = virtio_pci_slot_reset,
 	.reset_prepare  = virtio_pci_reset_prepare,
 	.reset_done     = virtio_pci_reset_done,
 };
-- 
2.43.0

