Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B37344E65F;
	Fri,  7 Aug 2026 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085878; cv=none; b=d4DES4yJ66CaQ0OaNCKuISvoL1SttJGUaIcTLmSAjh2NGPaQAznz9Kgmau1EFppk5CWod37SDzbr/k8lFLJIy5ZWg3BPxmkGZXuinbIYurJWxrbG7W0tJpXVOP0MU3srborTmpxFtAGYJCnW1NbuK99PLmy2/qceYywQmLZ47TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085878; c=relaxed/simple;
	bh=mBGd1DC0UaBbgPeIIlh0f3WFzlzyDvoZyE25XAJDHIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIW0ipVdWmlPfMWmnNCrF2Q2EhGLd+kw+GQNV2exOhHFgGxXPPtv2+9TEUBsyE1LetA/a4Gzym47OrJ9HjuPbaCxX99RtT1hDM8sVoRbYp7nShjNjNzOAkOa3uIee4wYN+/ZKonC1kUBuEXI6KLndsqtvuOmcspeXmN7iVHbX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4dae93b8922d11f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:999e58ee-2282-43b2-bebb-7b08042e0460,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:73cf912af32bf26e5f1c25dc8ed0cca7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|136|865|898,TC:nil,Content:
	0|15|50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4dae93b8922d11f1aa26b74ffac11d73-20260807
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 365645181; Fri, 07 Aug 2026 14:57:49 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: mst@redhat.com
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: Re: [PATCH v2 2/2] virtio-blk: mark disk dead on ERS permanent failure
Date: Fri, 7 Aug 2026 14:16:00 +0800
Message-ID: <reply-v3-mst-2-2.20260807.141600.liuxixin@kylinos.cn>
In-Reply-To: <20260802165703-mutt-send-email-mst@kernel.org>
References: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn> <cover.virtio-blk-ers-v2.1785468000.git.liuxixin@kylinos.cn> <4740ae91d5be.v2.1785468000.git.liuxixin@kylinos.cn> <20260802165703-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

Hi Michael,

Thanks for the review.  I will post a v3 with the following.

On Sun, Aug 02, 2026 at 04:59:08PM -0400, Michael S. Tsirkin wrote:
> what happens with requests already outstanding in the queues?
> e.g. does this leak memory?

virtio_driver.shutdown runs on system shutdown via virtio_dev_shutdown.
It calls blk_mq_freeze_queue() first: every in-flight request holds a
q_usage_counter reference until virtblk_done frees it, so freeze
returns only after those completions have reclaimed the request PDU
and any chained sg.  Only then does it virtio_break_device() and
blk_mark_disk_dead().  Break must come after freeze; after break,
vring callbacks no longer run.

> So this is blk specifically, I am somewhat lost as to why
> is blk treated differently from other drivers here.

virtio-blk owns the gendisk and request_queue itself, so block
teardown and queue lifetime sit in virtio-blk, not in virtio-pci
common code.

In v3, AER perm_failure stays common for every virtio device:
virtio_break_device() and DISCONNECT only.  Patch 2 keeps the
blk-side pieces in virtio-blk: system-shutdown .shutdown does freeze,
break, and mark_disk_dead, plus the queue_rq guard after frozen
del_vqs.  Neither is wired from AER.

Thanks,
Xixin

