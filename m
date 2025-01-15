Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E51DCB2D
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981229; cv=none; b=UlKMtolqwfFJrdEk6s27ARE1EZpSTt49b7CpOi1QHyEflMF75K1TZqQO/r3XELmBXabrn8Y+YK3BmXt+gNeK7ezO3Po7M34XuFNTKsjH/8rwaBHfO0pEI4ef0GanM15Mn83PuMVK0RqboSDd9MQxMX+Z+7aIAiuwNbBGeEDNVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981229; c=relaxed/simple;
	bh=Vl376vBzbC3818vHqyrU+BG0ANdndjucMMWz/Ja/Jus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVOmedWklXUnGk857uvv1FJVUN9bgk1Tq+C9nyWsZC3GVZVrmMgJQoDCGGWmmoO/3QX9P7g+2KNzSEOHuBdVDgcpTjC0thlZhmzrlKr8r7DjupbmbvwZJwZ4syOK687BndyornkhV/8zfTKb6stng9oC5+Rh9x8PljJK7WAE07s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=dGA4I5X7; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="dGA4I5X7"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YYLj62wQ0z6CmQyl;
	Wed, 15 Jan 2025 22:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1736981221; x=1739573222; bh=2oQci
	tnXPB1PGgSCEGuTk8GRrlHVH4EXutGmUuz0FuU=; b=dGA4I5X7DTz10cSqUKI89
	vBvdk4HbBLKqyEcSmGPfrJoDG7/TUHwbZEC+ZuUmCCGrW2beiR+EfrA1BA+83aAz
	2wRchEdKueequfGH1+66MZwMd8hl6FEHqA+8ucn54KnLEclpnYlm6wCaiOlGkftL
	vENIHCGDMMLLjeK0RGQjpDZOcFJgUMUex1lGR7dgVmEnjVuxIj0EEJaTM+bRW3Ov
	upba1BnaU1JZPeseOb7RSuQGOC8E6kQD3rNhdJOeiuxYVnIaFG+zd6a6JfryqTaA
	toP3yBduyJz+sCTLzBQgKWumhXe7IVPN415fxY8asyoEUH2NkcSzHcNUc8n3UQKP
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1hb4lZKh1uDK; Wed, 15 Jan 2025 22:47:01 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YYLhy59qwz6CmQtQ;
	Wed, 15 Jan 2025 22:46:58 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v17 01/14] block: Support block drivers that preserve the order of write requests
Date: Wed, 15 Jan 2025 14:46:35 -0800
Message-ID: <20250115224649.3973718-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
In-Reply-To: <20250115224649.3973718-1-bvanassche@acm.org>
References: <20250115224649.3973718-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some storage controllers preserve the request order per hardware queue.
Introduce the request queue limit member variable
'driver_preserves_write_order' to allow block drivers to indicate that
the order of write commands is preserved per hardware queue and hence
that serialization of writes per zone is not required if all pending
writes are submitted to the same hardware queue.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-settings.c   | 2 ++
 include/linux/blkdev.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index c8368ee8de2e..18bcf6e6dc60 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -796,6 +796,8 @@ int blk_stack_limits(struct queue_limits *t, struct q=
ueue_limits *b,
 	}
 	t->max_secure_erase_sectors =3D min_not_zero(t->max_secure_erase_sector=
s,
 						   b->max_secure_erase_sectors);
+	t->driver_preserves_write_order =3D t->driver_preserves_write_order &&
+		b->driver_preserves_write_order;
 	t->zone_write_granularity =3D max(t->zone_write_granularity,
 					b->zone_write_granularity);
 	if (!(t->features & BLK_FEAT_ZONED)) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7ac153e4423a..df9887412a9e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -399,6 +399,11 @@ struct queue_limits {
=20
 	unsigned int		max_open_zones;
 	unsigned int		max_active_zones;
+	/*
+	 * Whether or not the block driver preserves the order of write
+	 * requests. Set by the block driver.
+	 */
+	bool			driver_preserves_write_order;
=20
 	/*
 	 * Drivers that set dma_alignment to less than 511 must be prepared to
