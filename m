Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595999;
	b=cn/VwkirIgqWprKVj8GPS8VIXsrat3hTJj7Z7x0RGxNKoVHskTVN8wy0j5ayeAxmFs7P
	 Niuo1sm1kZCbGUBmbAHdangkcJ5oVAFqL5/5cC6amGQ3rten1WNanI5CTj1dwOtRE0M2o
	 Ymn1NxHmUs74B0h6oc8LX0WBo8ojKsJItkjLFVOiYmlFD256tUoAiWIz7rPy27dWZiW9r
	 Ga9d9TsCGkBgBxE6N5BMPts/TV4eTBfQw8ROBI7AbmCxwWNTXBcVQ7fv5ykmz61UaKHUx
	 NMC/AXg2CRiQ0S2K1c3w+MYQukYu1YxPvf43Vfk/V4Yg2Xahh3WT2dW4OHNoAPwAYHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595999;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=AhqkQJldErpJHoP69RFTTJCmt0U1XlD4cZcn77L5GX0=;
	b=I9wByqdNgjx22cMskY55J7HAfh5bmNrTE9JSk6jepBXI4lLviGFtXfSp7p+G9UkxAaHH
	 pNcesdqZn7d2tQu8xzGLVsdP485358l/DoBmeR79XGcWjLSJ7deo6PphgdLJePt+98dcs
	 z6+cZPx2dbyU0Fi8FRfNAyDErm4FFwpsA3J7ignI7NPxuLckh0hlB4zkwfxHJG7UBz7gl
	 skRxrvoq0ikLARX2vR89LjgBqe+9IOZ5RcP3VqV0Jw6Yit1VEoh20Ak6RrVGtdk3c43Hg
	 td9B/ORWOMffh1C7zAohpnomyGqVRo1h/BtgZSEQJVXJPS5AUFhNXd/o1ufoY9W4P7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MrLocNAt;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B479606A32A
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 08:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B479606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MrLocNAt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795595997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AhqkQJldErpJHoP69RFTTJCmt0U1XlD4cZcn77L5GX0=;
	b=MrLocNAtij7DhRC7UYw7eqjuokA2/nmIT8iKrjXzreRxHMKkdc8JQKgfZ3KxnRjG/bjrhC
	ypdV68q/RnGzjiOpiaudpV35qduKLUEPcxePBwJiHMdDxnbLPSR3v10L6AWeYAdgr5gbhu
	alY0De91sdGOlScgKqm2ip+m1OMCaG8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-kn-wrLN3MrSuYnM83BAhEw-1; Wed,
 25 Nov 2026 08:39:53 +0000
X-MC-Unique: kn-wrLN3MrSuYnM83BAhEw-1
X-Mimecast-MFC-AGG-ID: kn-wrLN3MrSuYnM83BAhEw_1795595992
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E3B519540E4;
	Wed, 25 Nov 2026 08:39:51 +0000 (UTC)
Received: from desktop (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DBCE71800548;
	Wed, 25 Nov 2026 08:39:48 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: linux-block@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowangio@gmail.com>,
	Alberto Faria <afaria@redhat.com>
Subject: [PATCH v3 0/2] virtio_blk: add FUA write support
Date: Wed, 25 Nov 2026 08:39:45 +0000
Message-ID: <20261125083947.263216-1-afaria@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

virtio-blk FUA write support has been added to the virtio spec [1]. This series
implements that by adding the new request flag uapi definitions and
corresponding virtio-blk support. It also enables vdpa_sim_blk to handle fua
writes.

[1] https://lore.kernel.org/virtio-comment/20251112055113.62207-1-afaria@redhat.com/

v2:
- Check for VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA when handling requests with REQ_FUA.
- Don't advertise FUA support on zoned devices.
- Restore BLK_FEAT_FUA in cache_type_store().
- vdpa_sim: Reject VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without VIRTIO_BLK_F_REQ_FLAGS.

v3:
- (sashiko) virtio_blK: Check for both VIRTIO_BLK_F_REQ_FLAGS and
  VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA when handling REQ_FUA.
- (sashiko) vdpa_sim: Fix possible ERR_PTR(0) return.

Alberto Faria (2):
  virtio_blk: add fua write support
  vdpa_sim_blk: add support for FUA writes

 drivers/block/virtio_blk.c           | 29 ++++++++++++++++++++++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 15 +++++++++++++-
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  1 +
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 14 +++++++++++++-
 include/uapi/linux/virtio_blk.h      | 13 +++++++++++--
 5 files changed, 66 insertions(+), 6 deletions(-)

-- 
2.56.1

