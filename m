Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13C53921C0
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774646048; cv=none; b=g50YcM2pQBYjh6NZvbE8TI54azh8S321trxDARbMAR+xBBjQKbCaIaM5GM7XffCrTzloo5CMFQIZ4MMcdbcC8AvngtEzQiOm9mF/U5WnHYBF8hUW+zLgFdv0uo3SjPp090SNP2uiohIUDDE3+prBR5gQj1JP0Hgh09sWkA4Ydzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774646048; c=relaxed/simple;
	bh=645WcOIpk4thXijx0oGT/99zZOEprAzMIePhu+OJMoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNJ1JG2UIewHTI0Ikihpqb7rM1CwyW45vy1wgNLWApQ4yyfpgVBVxLKfmQFG8HAJs4YEgTGcAR0KGNm359mXpPIJSMbrA6tZFVz0NpBlST3go4mnFv2YRrofVVbOw/T2jmH5r8idal6xwvNtYigkddgZSrJoj66QU3SEIH0tEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Q/xjnq3X; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Q/xjnq3X"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fjD0b2H44zlgyGT;
	Fri, 27 Mar 2026 21:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774646044; x=1777238045; bh=US7PN
	UyYzLge1PO4gFlu0Vx5s+RX5gLv8bIhQJ8m6WY=; b=Q/xjnq3XRicdCAChgaG1U
	DfR6edVd4IWhKasqPk2v1JYYeYpjOs59QXs/eBWCFh6KI5MhCMRo2VXVwK4kCWkZ
	cTg7RUVZ9osgmwXodvNKEy7UeRyQkGnTwpItnVkM7iBm+1pFQFmXndxaUHvK+8HM
	cdoaK4Lb7yh5WMbCkRVLdVByutSo490KlhNsGcKlMZIMYHCcmEMdI99OnWoz1A7h
	pcMqLIzI62WJdlev2rtcvk+UW4eIhoAwPMQO7mo3q4P0PH5UxE9vCTfu2C5ckOFd
	E9bzqI/zwyS1Yhp8prSzPCPSz/QC8qeKMYlwU3Oi3exasMwQYTg/4DaWOMLBHcHu
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vt_6ItqmvXf9; Fri, 27 Mar 2026 21:14:04 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fjD0V5QDDzlfvq4;
	Fri, 27 Mar 2026 21:14:02 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 1/6] block: Fix a source code comment
Date: Fri, 27 Mar 2026 14:13:41 -0700
Message-ID: <20260327211349.2239633-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260327211349.2239633-1-bvanassche@acm.org>
References: <20260327211349.2239633-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix a source code comment that is no longer correct since commit
889c57066cee ("block: make segment size limit workable for > 4K
PAGE_SIZE").

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-settings.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 78c83817b9d3..87724d30be4f 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -470,8 +470,8 @@ int blk_validate_limits(struct queue_limits *lim)
 	} else {
 		/*
 		 * The maximum segment size has an odd historic 64k default that
-		 * drivers probably should override.  Just like the I/O size we
-		 * require drivers to at least handle a full page per segment.
+		 * drivers probably should override. The maximum DMA segment
+		 * size may be less than the virtual memory page size.
 		 */
 		if (!lim->max_segment_size)
 			lim->max_segment_size =3D BLK_MAX_SEGMENT_SIZE;
