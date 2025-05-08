Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721B128F4
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663600; cv=none; b=b8RIz1rVfB3M9ErQ/76JIWyoVrxRjRRQiFK8vgiN8amL95fk/4QrOSr3ct74Hsm6HGfMLJmSA6zHOWvFpdlZSwAts6lwTQm97UJeSzG9dyLOQD4d+pI8g3G0jL9aeA//cuXVllY3EvmdJtnYd5jPETp2UnyBPEZRTJtCO8jOvqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663600; c=relaxed/simple;
	bh=2pOEYQNSsN3KFximQlRwXK9kspvMkUjOAHIJCXQzT1s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Vk6gwl299HDBeyX0232V3/HXUZPEyt3TnKqh4Eqem43GBHbfCS98j2E+5EX1tUPY4H47JAYjNlM5+Lkg4ebyVEZveW4rcopMn4Wv+x20gpGrJxxlRCTMgTP9TonujFSwkfvs2vjGA0CAiEldhA3by8g2LgbtnstoiAPFjK+oUCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ilWGcark; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilWGcark"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746663596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TCXAAe8jzZnNZes648pKVI+HTUJK8HBwQWi49tmgw1g=;
	b=ilWGcarkjx52Xb8bmr1KH9A4Xd6ReWYBYOL1EZXGQh840X+CoeSetAeeqRePyY38/xHnJy
	q9fMnCySoN2MTxRd5vJBdkzuhtQBRyJvBUKfPLsXpAQ09fYxTOMs2QbNqQpzO1bwYAr870
	e+zEu1wX4eLW/+UMOUv6z1Y5yo9dtf4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-aW3li0OYNPyBkCQgYsckdA-1; Wed,
 07 May 2025 20:19:54 -0400
X-MC-Unique: aW3li0OYNPyBkCQgYsckdA-1
X-Mimecast-MFC-AGG-ID: aW3li0OYNPyBkCQgYsckdA_1746663594
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00BF81800447
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 00:19:54 +0000 (UTC)
Received: from desktop.redhat.com (unknown [10.45.224.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B413819560A7;
	Thu,  8 May 2025 00:19:52 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: linux-block@vger.kernel.org
Cc: Alberto Faria <afaria@redhat.com>
Subject: [RFC 0/2] virtio_blk: add fua write support
Date: Thu,  8 May 2025 01:19:49 +0100
Message-ID: <20250508001951.421467-1-afaria@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

There is a proposal to introduce virtio-blk fua write support to the virtio spec
[1]. This series implements that by adding VIRTIO_BLK_{F,T}_OUT_FUA uapi
definitions and corresponding virtio-blk support. It also enables vdpa_sim_blk
to handle fua writes.

[1] https://lore.kernel.org/virtio-comment/20250507152602.3993258-1-afaria@redhat.com/

Alberto Faria (2):
  virtio_blk: add fua write support
  vdpa_sim_blk: add support for fua write commands

 drivers/block/virtio_blk.c           | 10 +++++++---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  6 ++++--
 include/uapi/linux/virtio_blk.h      |  4 ++++
 3 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.49.0

