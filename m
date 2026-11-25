Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593262;
	b=fvafbngOc+zMFsYNoRyqpE/osTvrqpYyK7apBmpIvchuioZ+MSRgh0qkVcziSY0xD9n4
	 OF+GabSrTihIZDWR1e4u6wCH2xrrwSNycH0/DMlqgTyBZOCzfwKFYm7DCYsiSmXFXtmFc
	 Xrr7XGJiv5WkItXrEq3ENNfwNF6mZ0m7vHmzkJRgbWAoo37+shPLfPe1km8uaE3d+gezg
	 USFhS5Ed3BlbzFfmFrLtbFFOCbHtjj6HTLL6LDDLr4CcTBW1EVFN3ZtCT+F3f1eoiojiA
	 FfuNXs9j0P3v6WfpP919stdOg214bGz+192NJap/b8Lqq5VvTkyyIUT6786cWP69FoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593262;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=nzfuELwfbCWCG9kJTniiJOjkP4vR0DKnq77Jf0as+ns=;
	b=E8AgB5iPXAGz/c3Kq/mNKmEyxoQSk4XiLMxDXOD9p2Bj+rijdYYspMudLlgn8yn866Dy
	 4aGHeANxRxQ+EcYNF5AXW6zAkRiYJSqhlZkzXTr2jxFtcy63n25haQ4dSfhqLl06MQul3
	 y8nrrk/rROW4hXEcFFr5BttpqnBKR/Jwg4W1BKa/6D45SOdElbQmKYTGkkAoYGVySxtm2
	 3xLHMUXSyC2tTvcFQ6WHI4cq4k3beJ3X7celY0AiYmfFd3LDTEQil5rU3DD8kFMnVQiyv
	 BRDUBSbWkMdbv7pGC6RfrdPsSPqaMXUMKsJl0F61gShqf7V7VVip+kDhdoFZJEIpUpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CPJe5YZU;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71564606A31E
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 07:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71564606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CPJe5YZU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795593260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nzfuELwfbCWCG9kJTniiJOjkP4vR0DKnq77Jf0as+ns=;
	b=CPJe5YZUymbemRPXiPXZ2oi466YeYt3auf0qEDUK43FWwJdLe/S1BIhx01kK/SVIzgp8Yl
	xqk/4Sa/gq2nOZhGApRJLmQkdciMhNsQkpnNg3ixaF0u05RCs+/bMpjfZHbl1St2GVID77
	sJy/Jv6HrIDgfSZ12D8HsJokmnt0QrM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-VATS0YWgOSuX37SXgcce9Q-1; Wed,
 25 Nov 2026 07:54:16 +0000
X-MC-Unique: VATS0YWgOSuX37SXgcce9Q-1
X-Mimecast-MFC-AGG-ID: VATS0YWgOSuX37SXgcce9Q_1795593255
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48C67195608E;
	Wed, 25 Nov 2026 07:54:14 +0000 (UTC)
Received: from desktop (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 352771801971;
	Wed, 25 Nov 2026 07:54:09 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: linux-block@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowangio@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alberto Faria <afaria@redhat.com>
Subject: [PATCH v2 0/2] virtio_blk: add FUA write support
Date: Wed, 25 Nov 2026 07:54:06 +0000
Message-ID: <20261125075408.226762-1-afaria@redhat.com>
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

Alberto Faria (2):
  virtio_blk: add fua write support
  vdpa_sim_blk: add support for FUA writes

 drivers/block/virtio_blk.c           | 28 ++++++++++++++++++++++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 13 +++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  1 +
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 14 +++++++++++++-
 include/uapi/linux/virtio_blk.h      | 13 +++++++++++--
 5 files changed, 64 insertions(+), 5 deletions(-)

-- 
2.56.1

