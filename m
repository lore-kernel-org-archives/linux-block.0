Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561961;
	b=FJZP+w9ipvz7Y/4DXkOys9jzd0C15ZVFVOYP3ywg6uvkJ/mu8Zdla6DmU6TCMn89llVE
	 VZahne5krp4YBMg9QoRPUNuTrUVoKCHdbh3/cZFCbMfKgiUoXYtpo6LUqhKc9a7MFEjuJ
	 Et+UyrFDDWEeMywNEYvGb8GwSs25ZqmBZD/wib2/VllPLg72cTXsBPYuHpk/O7I424kWM
	 sBs1pq8Y01oaKADAwOToC3N2XyhJuVauucFn3Uc05IKZ1b98lP6wgm9s1cntj+73jXjL/
	 /LxFIY5B0iT5Jl4XoJ4kVYG5jrAGGEmolmtipK/zCgvcusV7zTC23W03LG5qUbP7I1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561961;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=nEJKUptRpkIfVSkB95Dm1NK/g/y2LQjeCpcCXm/jlj0=;
	b=o9M1gqlFqm3QuMKZfiydbWXH7eZuspsQBLSts77vDuqAOjU/Y1PK3b0Hdjb7mWE9NTwr
	 jK4Sp00UWEagCMG0vCBXNaPjMCFrSZZYIH2n1FDryKSPRicISb+dUTolDK+BhByiEVpFy
	 wJ+toQZ1mh5zhr9ZWwrEIMJvCnfAfQZ6ADPL+0RBxxgT5rM4J9zBfGyDXBvgTb+yzbmb8
	 O1fr+ZzarzbN0J9DydVCzA3dvEsdnq+fDOjcQNO75+rEBse7zeriQakpjRX0VbhvBiH9G
	 MQrRwRUkFT/B4+znzl5vZMGsLSP1NI/uhMr8n0bQgU1vfYgIFndUoIho5DFFpc94b7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hORDDyEj;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C602C606A319
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 05:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C602C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hORDDyEj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792561959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nEJKUptRpkIfVSkB95Dm1NK/g/y2LQjeCpcCXm/jlj0=;
	b=hORDDyEju5vT706jaXPS19vOs9CQlAD6EkujEa9/xjCqhsCnBOulAU6QVWQo01X0r0Bc+K
	nloI5Ct3IYUHKrBS+v/LcbJzjEdLQCrCToswxWDFREUron071MiaQAslf4VgScmMtLHnka
	OMWF02N3rh0aVGLY7TzsFEoxDjS30xc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-MSvlLl_kPzihUpQajXpeyg-1; Wed,
 21 Oct 2026 01:52:38 -0400
X-MC-Unique: MSvlLl_kPzihUpQajXpeyg-1
X-Mimecast-MFC-AGG-ID: MSvlLl_kPzihUpQajXpeyg_1792561957
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 443C71956044
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 05:52:37 +0000 (UTC)
Received: from desktop (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4AB6D195608C;
	Wed, 21 Oct 2026 05:52:36 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: linux-block@vger.kernel.org
Cc: Alberto Faria <afaria@redhat.com>
Subject: [PATCH 0/2] virtio_blk: add FUA write support
Date: Wed, 21 Oct 2026 06:52:32 +0100
Message-ID: <20261021055235.648957-1-afaria@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

virtio-blk FUA write support has been added to the virtio spec [1]. This series
implements that by adding the new request flag uapi definitions and
corresponding virtio-blk support. It also enables vdpa_sim_blk to handle fua
writes.

[1] https://lore.kernel.org/virtio-comment/20251112055113.62207-1-afaria@redhat.com/

Alberto Faria (2):
  virtio_blk: add fua write support
  vdpa_sim_blk: add support for FUA writes

 drivers/block/virtio_blk.c           | 15 +++++++++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  4 +++-
 include/uapi/linux/virtio_blk.h      | 13 +++++++++++--
 3 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.56.0

