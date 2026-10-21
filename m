Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561968;
	b=DxJ0Yq/Lhr02nNaIRqbj1aaB5oEyONBel67Bjvu7gLhv3wb6Owzl9VlVrPhiUS0Zm72h
	 UONLq0ZrQVmt+IkCFWJ6fxlvNmsOuRZ5QIvMlDhaRob6v6RAa4pW9jyvPee3uQ/rOrXWf
	 lFYw9bEf7iimsRz7+dWcb3gZwHKLmj4m/gxx2um0WGnsTQzPf9qnh27MHmEc/h2RSsSxB
	 j1vASMXLk/C3y6GZTPWVQ4ginG1Jv/56erNAMaY+UP8d3D0lqWAxzxyT3z1iDqWz7j2HK
	 sKJSoc85TayEO/k7lQTXWWddlRswy/hFkNe3ZFmNUmlZh839/UygzslNqNq4lDP1h0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561968;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=N2NaRZgBo7GnZt6uGi+5yQs7ZXk06OM+Y17cnBq0WsQ=;
	b=T1xBKmhDlez9Haq7nCd+xwyX9umyjp97js5XN8ipEVDv8kOSuBIu4Cw3RW5Xjy/tvDiF
	 THU4itV01/BtOCekcmhnlczvR7AJdpyn1YpDkmbefNkJGLD78DcupXh+bN9WtZIHpfagl
	 uh3zFcwYDtsDXg2TVWDqwmP3m1v252fB0i6TQ6xePHbQe7voGwyMK6A/APnmNbZzHr3j/
	 tigq8iMZgiiObp0jONO0b5mTnvQz6cNaEv1PG05Eo5Xi2/0Pj5qrl3jAK03W8UIOVOAgA
	 HFejzBX+NO+FXbz6s+CVzc7GegQuKLmX95Ivzcj4WnJPJtQL2/EMYWc9woXgRE2TEEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Br4VIv1M;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4069606A319
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 05:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4069606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Br4VIv1M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792561966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2NaRZgBo7GnZt6uGi+5yQs7ZXk06OM+Y17cnBq0WsQ=;
	b=Br4VIv1MU6hYw5b50ny4yjTNn6MxWrZsZmpsm8LpAfdyvWX4i1x0Taqrpxd1+f5iE5YxJc
	rbmEES//imBtsXtDcQrdPp/q6KbrF0IIuTC1axGM7lPtobcK0j9xNSsfCo/YI89yxK/bVx
	UNlOlIZ6sEdl0UZcFRfNeHHFM1q4gAc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-w8kVzoWxMLCoEBN5XfMIxA-1; Wed,
 21 Oct 2026 01:52:40 -0400
X-MC-Unique: w8kVzoWxMLCoEBN5XfMIxA-1
X-Mimecast-MFC-AGG-ID: w8kVzoWxMLCoEBN5XfMIxA_1792561959
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 800DC1800869
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 05:52:39 +0000 (UTC)
Received: from desktop (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1A9F1956088;
	Wed, 21 Oct 2026 05:52:38 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: linux-block@vger.kernel.org
Cc: Alberto Faria <afaria@redhat.com>
Subject: [PATCH 2/2] vdpa_sim_blk: add support for FUA writes
Date: Wed, 21 Oct 2026 06:52:34 +0100
Message-ID: <20261021055235.648957-3-afaria@redhat.com>
In-Reply-To: <20261021055235.648957-1-afaria@redhat.com>
References: <20261021055235.648957-1-afaria@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Expose VIRTIO_BLK_F_REQ_FLAGS and VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA to
drivers. The simulator is a ramdisk, so it handles FUA and non-FUA
writes in the same way.

Signed-off-by: Alberto Faria <afaria@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 76dd5b0828d7a..bfdb2de4d6807 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -31,7 +31,9 @@
 				 (1ULL << VIRTIO_BLK_F_TOPOLOGY) | \
 				 (1ULL << VIRTIO_BLK_F_MQ)       | \
 				 (1ULL << VIRTIO_BLK_F_DISCARD)  | \
-				 (1ULL << VIRTIO_BLK_F_WRITE_ZEROES))
+				 (1ULL << VIRTIO_BLK_F_WRITE_ZEROES)  | \
+				 (1ULL << VIRTIO_BLK_F_REQ_FLAGS)  | \
+				 (1ULL << VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA))
 
 #define VDPASIM_BLK_CAPACITY	0x40000
 #define VDPASIM_BLK_SIZE_MAX	0x1000
-- 
2.56.0

