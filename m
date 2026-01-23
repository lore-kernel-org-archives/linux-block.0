Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF61CAA68
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176343; cv=none; b=gvttMhqWMEiL4Lyc4wpNcR8jg6uzEEjrKNEcVqhxXcPq9CedSIQbla6ZDxPD/DGpXYVr5XZ/VB7vgwq1k0Bbc7Xg2+yIzcdXC9zoq32ow8UiYPMIMPSwC3UA9lDSVsV7o5DxAS9ubPxOj8Iw8Vx0wDElkX8Cvdgy0pKWEQ7NKF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176343; c=relaxed/simple;
	bh=xle0T0g6rh6Ez6fPdPdOlAT/j3y3ufnmMFsmGVjVCj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VeUMFBiAdZ3e0147UkC1EE6B5TSAVayYXM3gqRSTlUMZKlieuUEF/6SbQTq6UUyzoR+am1o9c6KTayA1yqV7+IU+TUv/FczIKY8VSsST4er4QWxTDEjN39u9+VJu7GIXVR4uU/h8QbOQAm2kV1GPVEz0njrUHszV12NWY6awFI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4+BOhgS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4+BOhgS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769176341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v2UHTZdl+mIaj4pex5sOKO8SJpehY+jumXhMtum5V1o=;
	b=G4+BOhgS0awqOw2tmRCm0e4Qi2seGnioC0cNzXcXHdcFXKqL7fL+H86XhGaH2ya+tOPxif
	qVpNQksX6Z9DPUw9BSBaaMgkQ4oE1ofD9uVTpNzG+2AyClWFaJKX/AofJ/DvPGY7GwCfxE
	Tcp2zKDi5W5goMioigSIM9S38WJL/XU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-zYM29ky8NjS2J54G6OITLQ-1; Fri,
 23 Jan 2026 08:52:19 -0500
X-MC-Unique: zYM29ky8NjS2J54G6OITLQ-1
X-Mimecast-MFC-AGG-ID: zYM29ky8NjS2J54G6OITLQ_1769176338
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B2881891B29;
	Fri, 23 Jan 2026 13:52:17 +0000 (UTC)
Received: from localhost (unknown [10.72.116.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FA42180099D;
	Fri, 23 Jan 2026 13:52:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] ublk: auto buffer helpers rename & document io reference
Date: Fri, 23 Jan 2026 21:51:57 +0800
Message-ID: <20260123135205.2202474-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Jens,

The 1st patch improves auto buffer helpers naming, and improve
documentation.

The 2nd patch documents ublk io reference counting design, given it isn't
very straightforward.

Thanks,


Ming Lei (2):
  ublk: rename auto buffer registration helpers
  ublk: document IO reference counting design

 drivers/block/ublk_drv.c | 103 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 13 deletions(-)

-- 
2.47.0

