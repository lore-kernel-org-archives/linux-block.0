Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1474844E052;
	Fri,  7 Aug 2026 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085896; cv=none; b=gt9ulIi1svExwETltDikxSQmGCNuIk5CvkF3vLilAkMWdPwZUCm9+wTgcG8K6HbWd0MOJB64AVjWL+KgHKWtb4Irhh/wPSR84sCrU/uk4WwY4hq/uAuRUedUHiw3zCmbpiwTtSu41sqCM7GGbsubcHORU2wpkqKk+KeV/pQGBFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085896; c=relaxed/simple;
	bh=qD9Nfdzf+wvkJAvs2pAjSEerQkQAS/I93s9W6hy4nyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTtslghwsPyXviXDm9tKaVipwNkyiJeBa1I5ZiGhTR0F94HzW7z+VVc/C+najk3bR8f66TGZmxy/RHbX9qQrPQG4y69BrkjjwXGQVGFTHSfBtDoemV0o2CxLN13u3SCA3QMflpJf+OxQyrd2j9wY2bCueo1OWIC61AtZsMyhAIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5871b168922d11f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:dee24690-b201-4d9d-a68f-eb4dd53a9422,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:ef23cf8464280d9dd073a5ec32cd394b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5871b168922d11f1aa26b74ffac11d73-20260807
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1863359273; Fri, 07 Aug 2026 14:58:08 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-block@vger.kernel.org
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v3 0/2] virtio: PCI AER error_detected and virtio-blk shutdown
Date: Thu, 6 Aug 2026 09:20:00 +0800
Message-ID: <cover.virtio-blk-ers-v3.1785920716.git.liuxixin@kylinos.cn>
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

Hi,

This series fills in missing PCI AER callbacks on virtio-pci, and adds
matching virtio-blk pieces for queue_rq after VQ removal plus
system-shutdown teardown.

virtio-pci only registered reset_prepare/reset_done.  Without
.error_detected the recovery core votes NO_AER_DRIVER on the first
broadcast, and report_perm_failure_detected skips the driver callback
whenever overall status is not RECOVERED.  Patch 1 registers
.error_detected and .slot_reset: frozen/unknown call
virtio_device_reset_prepare() then NEED_RESET; after a successful PCI
reset, slot_reset restores config and calls virtio_device_reset_done();
perm_failure only virtio_break_device() and DISCONNECT.  AER bus reset
via pci_bus_error_reset does not invoke .reset_prepare, so quiesce and
restore for that path live in error_detected and slot_reset.  The
existing .reset_prepare and .reset_done still serve FLR.

Patch 2 fails new requests early in virtio_queue_rq when vqs were
removed during frozen reset_prepare.  It also registers
virtio_driver.shutdown for reboot and poweroff via virtio_dev_shutdown,
with freeze-before-break reclaim and blk_mark_disk_dead().

Changes since v2, thanks to Michael for the review:
- perm_failure: only virtio_break_device()
- default and frozen share one quiesce then NEED_RESET path
- Add .slot_reset to restore after successful AER PCI reset
- Drop PCI common to drv->shutdown wiring; virtio-blk .shutdown for
  system shutdown via virtio_dev_shutdown

Based on linux-next next-20260730.

Thanks,
Xixin Liu
---
Xixin Liu (2):
  virtio-pci: add error_detected and slot_reset for AER
  virtio-blk: add shutdown and fail queue_rq after VQ teardown

 drivers/block/virtio_blk.c         | 36 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.c | 53 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

-- 
2.43.0

