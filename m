Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D42E736D;
	Fri, 31 Jul 2026 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486491; cv=none; b=t1flEmr3kTRoKO303VFAnOGATZcU8bBUcvpscqMCcyNC9ECkeumPXNyxc7kroH2lEANK7wCAsvinDwClWBb58njS2tA6AiYgJu9Zns68Qxa+e+cB4h1+uXFQm4WdAvp+a6uR8VgbfQLMnHA52Rnpt6wgbXDjSgObj69ivjPw/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486491; c=relaxed/simple;
	bh=Ovqaphgx8e1OrNNTtZild4bVHHv5mJu8ezq/mwyVUys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbE3dbQcEiTCmMRHBFNmkJrY284u9Q0ovNzRhNG3BfpXKeSRBBnLs/f9lBP0sJwYoASag90aTgLW3Xgz7ZJp+zXhM064viLRfefpVaP+/8DH5yjq/xcGLXL4dkht3McDMY6lnTUzkTWn9bk7f6lhDJgENKyOj/xlx0JcCFNwTK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: be3f52268cb911f1aa26b74ffac11d73-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a109df68-ae3e-47c5-a0e2-ef11b5de36aa,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:d655bc3827d0f28e0ac990f09578468e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: be3f52268cb911f1aa26b74ffac11d73-20260731
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1342367032; Fri, 31 Jul 2026 16:28:01 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-block@vger.kernel.org
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v2 0/2] virtio: PCI ERS permanent failure teardown for virtio-blk
Date: Fri, 31 Jul 2026 11:20:00 +0800
Message-ID: <cover.virtio-blk-ers-v2.1785468000.git.liuxixin@kylinos.cn>
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
X-Mailer: patches/scripts/send-local.py

Hi,

This series adds PCI AER error_detected for virtio-pci and completes
virtio-blk teardown when ERS reports pci_channel_io_perm_failure.

virtio-pci only registered reset_prepare/reset_done.  The recovery core
treats devices without error_detected as NO_AER_DRIVER and does not
deliver perm_failure to the driver after a failed recovery.  When bus
reset fails (reproduced on QEMU with DLLLA not set within 100 ms after
secondary bus reset), virtio-blk disks stay live even though virtqueues
may already have been torn down during the frozen phase.

Patch 1 registers error_detected (frozen quiesce + perm_failure notify).
Patch 2 calls the virtio driver shutdown hook from virtio-pci on
perm_failure and implements virtio-blk shutdown with blk_mark_disk_dead().

Changes since v1 (thanks for the review on v1):
- Disclose LLM help on the commit message (Assisted-by); ASCII only
- virtblk_shutdown: virtio_break_device() before flush_work()
- virtio_queue_rq: drop disk_live(); keep NULL vqs/vdev guards only
  (broken vq already fails in virtqueue_add)

Based on linux-next next-20260730.

Thanks,
Xixin Liu
---
Xixin Liu (2):
  virtio-pci: add error_detected for PCI AER recovery
  virtio-blk: mark disk dead on ERS permanent failure

 drivers/block/virtio_blk.c         | 31 ++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.c | 38 ++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

-- 
2.43.0

