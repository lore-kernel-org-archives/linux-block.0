Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BB430568A;
	Mon, 15 Jun 2026 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514247; cv=none; b=iC20WoZGV3X5qi9qHRMJlEr7gBO9l64bMHKFVc3tuwtLgLtufCp0272H2zOjplCAdYJWOKipdvo9UsF+/FHBvsdpyc+zX3d9dKRKJ0a+wz7AvTXXvjtUfGAM3yKdurplLQsbMI64TkZkBkb22jx+QagzBIdCWKQ3sKW1VCiyKu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514247; c=relaxed/simple;
	bh=GTulr1gK2vhkw34Olfbq9I3UM2f0II08bz76Zm7aprg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oOGwm5urdZGafEMdzpQyggsIBOTt+F2s71Pb6gh7RRS+KwQfgOrKV7ZHVtTr6d51Jp1Wpf1NuvPjhSsREMKyJOPtCgCnKP71zX3c11KDmnKI3gmIddMTGloMgiQCCBEhaYW5rRCcQRkdbHoTkZnwUST0tuuaZu7LEyaZPLF/GPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 23193922689911f1aa26b74ffac11d73-20260615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c5b22c33-74cf-4047-a96a-1c0caaab80df,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:340b5297f8c2808e660dfe9201e26d4c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 23193922689911f1aa26b74ffac11d73-20260615
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1776089975; Mon, 15 Jun 2026 17:03:55 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-block@vger.kernel.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 0/2] virtio: PCI ERS permanent failure teardown for virtio-blk
Date: Mon, 15 Jun 2026 10:00:00 +0800
Message-ID: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: virtio-blk-ers-fail/send-local.py

Hi,

This series adds proper PCI AER error recovery handling for virtio-pci and
completes virtio-blk teardown when ERS reports pci_channel_io_perm_failure.

virtio-pci only registered reset_prepare/reset_done.  The recovery core
treats devices without error_detected as NO_AER_DRIVER and does not
deliver perm_failure to the driver after a failed recovery.  When bus
reset fails (reproduced on QEMU with DLLLA not set within 100 ms after
secondary bus reset), virtio-blk disks stay live even though virtqueues
may already have been torn down during the frozen phase.

Patch 1 registers error_detected (frozen quiesce + perm_failure notify).
Patch 2 calls the virtio driver shutdown hook from virtio-pci on
perm_failure, implements virtio-blk shutdown with blk_mark_disk_dead(),
and fail-fast guards in virtio_queue_rq.

Thanks,
Xixin Liu

---

Xixin Liu (2):
  virtio-pci: add error_detected for PCI AER recovery
  virtio-blk: mark disk dead on ERS permanent failure

 drivers/block/virtio_blk.c         | 39 +++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.c | 47 ++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

-- 
2.43.0

