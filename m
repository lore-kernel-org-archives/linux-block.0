Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E193C2BBA;
	Mon, 15 Jun 2026 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514249; cv=none; b=BgZTrEJG5rfEGo0+0pAIjGuMEceoiWuCVpGee7wIwLU7CRj40D18NNzs0AarIWtWLC0yapKDfQK8nBkRkH/wZKyKprRpKINqL39pJ9mjUJD602E/+S/8teTnslKFO77E3xs/g465+V1qIuIUA38gxDvW4GtOnwUsvEWMc0YOK9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514249; c=relaxed/simple;
	bh=qArThmS7/ydG9qF8SMdEa6jxaVLlTtTM9HlGawOaHkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZL6slVU1MbfAXgyTUFbEx+/o6YpTc5mQNZJrWO/oter6XPwJY25ygSdu3zImtnTRvpPer3UDWHMlRCr2znm1AX/dHWi0zRzq/rQ442nVzatC1o9sHFcNsO+ODNifpll+Wpe/5moMqiKwAXonzIzAlIy74YiRk8qyk0I+OAwuYvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2508e4a8689911f1aa26b74ffac11d73-20260615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:11a617e8-7458-46d7-a9e7-89c5014aa763,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:20b23463bd2e1fa282c6a2944e9fa9ac,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2508e4a8689911f1aa26b74ffac11d73-20260615
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 999309657; Mon, 15 Jun 2026 17:03:58 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-block@vger.kernel.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 1/2] virtio-pci: add error_detected for PCI AER recovery
Date: Tue, 10 Jun 2026 14:20:00 +0800
Message-ID: <e2dda946e70e.1780449274.git.liuxixin@kylinos.cn>
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

virtio-pci only registered reset_prepare/reset_done.  The PCI error
recovery core treats devices without error_detected as NO_AER_DRIVER and
does not deliver pci_channel_io_perm_failure to the driver after a failed
recovery.  Virtio devices therefore miss the normal ERS quiesce/teardown
sequence.

Register error_detected: quiesce on frozen (reset_prepare) before bus
reset; on perm_failure break virtqueues and return DISCONNECT.  Block-layer
cleanup for virtio-blk is handled in the follow-up patch.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/virtio/virtio_pci_common.c | 30 +++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 164f480b18a6..e2dda946e70e 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -828,7 +828,37 @@ static void virtio_pci_reset_done(struct pci_dev *pci_dev)
 		dev_warn(&pci_dev->dev, "Reset done failure: %d", ret);
 }
 
+static pci_ers_result_t virtio_pci_error_detected(struct pci_dev *pci_dev,
+						  pci_channel_state_t state)
+{
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+
+	/*
+	 * PCI ERS error_detected: quiesce on frozen before bus reset; on
+	 * permanent failure ask the virtio driver to shut down (virtio-blk
+	 * marks the disk dead in its .shutdown handler).
+	 */
+	switch (state) {
+	case pci_channel_io_normal:
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	case pci_channel_io_frozen:
+		pci_info(pci_dev, "frozen error detected, quiesce device\n");
+		if (virtio_device_reset_prepare(&vp_dev->vdev))
+			dev_warn(&pci_dev->dev, "frozen: reset prepare failed\n");
+		return PCI_ERS_RESULT_NEED_RESET;
+	case pci_channel_io_perm_failure:
+		dev_warn(&pci_dev->dev,
+			 "permanent failure, disconnecting device\n");
+		virtio_break_device(&vp_dev->vdev);
+		return PCI_ERS_RESULT_DISCONNECT;
+	default:
+		break;
+	}
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
 static const struct pci_error_handlers virtio_pci_err_handler = {
+	.error_detected = virtio_pci_error_detected,
 	.reset_prepare  = virtio_pci_reset_prepare,
 	.reset_done     = virtio_pci_reset_done,
 };

