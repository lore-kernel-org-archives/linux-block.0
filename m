Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A46014EC62
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715338; cv=none; b=JMCc7lRCMzgqad+HVxXIrKYz0QTKdKepHZOtuks7LBW2slyFW/aie9IY++M07ls9d+1JlTRpcK58vRowDWvlTz5QL1OKpRIRZTEcI0zYxi567tWq1tXgVmeolobDKi8pgf0EIj4AaS6JQbzIrHkV/5hkMaPoiDtXTCgWxH1EtGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715338; c=relaxed/simple;
	bh=hNTcDabg0IyRDTQ72OSli/AH71ZJC7W1EeSe4SKGd64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kMYp9CBj4HtWfq965/zfmAbTYbt/dspA/0Qb0mmYSDeJRsKrRFgo9wR/F/7gqA/EjV+3DlRjp0nFYUO7H96E+Wx9ZbUR2Tp2e5ArU3uFuY9y+phUEdy7fvFmNgEou6P2caUMZIG9QPKPWt0R+tD2jJq/otYi6sbXEkQyphQulAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NjnUX7ki; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NjnUX7ki"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XYgcS0F6FzlgMVX;
	Wed, 23 Oct 2024 20:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1729715334; x=1732307335; bh=rHr34/GqPQFevhREox8MksjSlRZ/juaa04V
	Wer/6K7Y=; b=NjnUX7kirG/inSCWMxLO2BOP4/l5p1uoUkojk9nRqjMxR9puW1a
	QfOD1KQODhnXaB7P7e2ybdq2E99l83aIRYlrlLMqGrQgbbhh+Gm5PIMD66lHTH8I
	1EdezyMgRCBBAsduStvbCrUua8o5teiQBkKnBGFiXsqlRDO+QHFpWc8ysM4Ovy9+
	O2hHMqJ+v367bvzS6+QogWMl9qkQIISQ2zoBUDrRRT+przkWC3QOO85wlM22m7ZW
	3MwtuJhkofN46wMBegsjrpkhvXoazWq5MfnIWtusaxMWA++PvK8HHMST5+3rpUuT
	0gbK1TTCboXSs72q0VPtwGSV23W9peJ0Ldg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id g_f5G4H2vERV; Wed, 23 Oct 2024 20:28:54 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XYgcQ0x56zlgT1K;
	Wed, 23 Oct 2024 20:28:53 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] blk-mq: Unexport blk_mq_flush_busy_ctxs()
Date: Wed, 23 Oct 2024 13:28:50 -0700
Message-ID: <20241023202850.3469279-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit a6088845c2bf ("block: kyber: make kyber more friendly with merging=
")
removed the only blk_mq_flush_busy_ctxs() call from outside the block lay=
er
core. Hence unexport blk_mq_flush_busy_ctxs().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7482e682deca..9abe6b9dd2ea 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1716,7 +1716,6 @@ void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *h=
ctx, struct list_head *list)
=20
 	sbitmap_for_each_set(&hctx->ctx_map, flush_busy_ctx, &data);
 }
-EXPORT_SYMBOL_GPL(blk_mq_flush_busy_ctxs);
=20
 struct dispatch_rq_data {
 	struct blk_mq_hw_ctx *hctx;
