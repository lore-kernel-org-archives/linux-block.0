Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF92DE6EB
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488750; cv=none; b=TXqcKwgarDnkuEBhWGSHEwYrvnkUMs7YlSDZBSUzJAvKebd1RWgwUnkYQtre5o5wS0QvXP2bCbYm3AbhslgblrbfXqGH5ht5aiOlDH/8i+QE1JpmnZCzbJhNqvXlWXw/yyZlmKuRh2+9wlwJ/0My+s2SoV6MHsZOp+dXztmGYkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488750; c=relaxed/simple;
	bh=TtMDpR1NrFQ260CqaqURUVx3wfcjE0ylSfQwHNSeidE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FngFRruaiWfJXJfbDxLFvWcmkDjHHbnL8wFRX9AJ93oO67UOq9JSbUi3J64lW3k/lVO7A/0Wke73VMhDwk39JVIcMbOyOpo7J7rRYC5Ow3T3cCocCPktRVEVLC1X9OprIBTdMSfRtEmoRQ3DdxjXBJbtJin527POFh0/LKU9vMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=X+3T0pWf; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="X+3T0pWf"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bXWvw1kvpzm1Zf3;
	Wed,  2 Jul 2025 20:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1751488746; x=1754080747; bh=Jd9gQ
	yfC695hO4BCEC4sPoqU2DkAOUPSIaXUvBbx/QM=; b=X+3T0pWfUzT1sm9N+8StP
	c3MvTFOdmpqJGrtNHVy+r7eFCDAiJMTyQTIsPLhBZmFkcMsAx+JV+6H/s0jFWIqA
	ptTXmFM0c0DyKhdmL5cBSVc1wwCJXUrcoCRNsN19jk3C1XsJl8v4Wn00Cf0EFVQ/
	FNtJoSoQq3jkO27XSgD32GuP0hwe7f9Lm751AYSOTpECWMQkqwdQUz5MGo2Kfraz
	izBdANWOCGDerI66vDJVrh6+Jvlrl56nZsNg/0ZUH1kpavW85o+2lUne77cgnUBn
	g3duoDpu+1NpSJX/jhJCI5erIQsRDy6IwfOZW6wDjbRd6oSg3HLwdGGs4n80QpAV
	g==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2Agc5XiDLxcx; Wed,  2 Jul 2025 20:39:06 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bXWvq5zXSzm0Hqf;
	Wed,  2 Jul 2025 20:39:03 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/8] block: Do not run frozen queues
Date: Wed,  2 Jul 2025 13:38:37 -0700
Message-ID: <20250702203845.3844510-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250702203845.3844510-1-bvanassche@acm.org>
References: <20250702203845.3844510-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a request queue is frozen there are no requests pending and hence it
is not necessary to run a request queue.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7919607c1aeb..91b9fc1a7ddb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2298,16 +2298,16 @@ static inline bool blk_mq_hw_queue_need_run(struc=
t blk_mq_hw_ctx *hctx)
 	bool need_run;
=20
 	/*
-	 * When queue is quiesced, we may be switching io scheduler, or
-	 * updating nr_hw_queues, or other things, and we can't run queue
-	 * any more, even blk_mq_hctx_has_pending() can't be called safely.
-	 *
-	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
-	 * quiesced.
+	 * The request queue is frozen when the e.g. the I/O scheduler is
+	 * changed and also when nr_hw_queues is updated. Neither running the
+	 * queue nor calling blk_mq_hctx_has_pending() is safe during these
+	 * operations. Hence, check whether the queue is frozen before checking
+	 * whether any requests are pending.
 	 */
 	__blk_mq_run_dispatch_ops(hctx->queue, false,
-		need_run =3D !blk_queue_quiesced(hctx->queue) &&
-		blk_mq_hctx_has_pending(hctx));
+		need_run =3D !blk_queue_frozen(hctx->queue) &&
+			   !blk_queue_quiesced(hctx->queue) &&
+			   blk_mq_hctx_has_pending(hctx));
 	return need_run;
 }
=20
