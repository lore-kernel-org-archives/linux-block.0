Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7649B1D6DDA
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981233; cv=none; b=cOwb47v496sjMtmnez76yR6ljLQD9o1vfVtEPpFxsLblRvGKk3M63NlSD47slee9uC+cvtqqw730f5y8Z2VRYoWCXYRZDJtV7zE4KOwudqLOjwGI9M0sJJnoDPZpV6DVn9poufrTPgnhb3EWHozXIsFcBLzMZOXxSNqlJWZ3GI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981233; c=relaxed/simple;
	bh=7aoVsMoZlsLW7EJlpr4POdBKg9vaNycginxTxbD6T3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+wGScTefvvmAfbQM430AEUq4wzGCWPuzNkadTckk6uR1bp/wo57zp1zoYj/eIgCgQ2tDlqqnBJoWgMdclemlmZcNl6f/YCgXbGTZAoxIosZR4MJTI6OgdjJ1c1PxxicFrlPBVSTD91k8d/6NoNB7xUvl7yOR8Wrqtmr6OJcF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=VXUQ0ONL; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="VXUQ0ONL"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YYLjB6T3Hz6CmM6M;
	Wed, 15 Jan 2025 22:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1736981227; x=1739573228; bh=9s7d8
	rrG+cc742a+hcMtRaEbguqVpvsYL0SH0n3FdHw=; b=VXUQ0ONLczNlsYac56/2L
	XXObHyuXBP+cCreN/EOndv4HQcliDeJC/s162DDDWsMlhCoaw83ahU0vzhBb9jX6
	NogbXEUP/8pJLaoq68oRgJzNTjRPBnT0JLEX7D1RagdOqQh8KIwKMV9hlfz9FfeZ
	WG7QJQAubQSvNfxkeCF4Tbg98rDzrmXeiXKnp6FjX9HOLCbUOhrBNnDpO8MP7kck
	wCbLQjnMU5rMsBA4VctsSSbQwtWI4Id89iZBjVppbLTnm7ZiFgq3iKzvnecr3Ucl
	gCSCgkq02SRTHE1Iao74oNjpXTGQkNMH8huY/SSkWlf/LCNQ3CuebMVCs7ckwja9
	A==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8PItihEJGSeU; Wed, 15 Jan 2025 22:47:07 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YYLj53mmWz6CmR5y;
	Wed, 15 Jan 2025 22:47:05 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v17 03/14] block: Rework request allocation in blk_mq_submit_bio()
Date: Wed, 15 Jan 2025 14:46:37 -0800
Message-ID: <20250115224649.3973718-4-bvanassche@acm.org>
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

Prepare for allocating a request from a specific hctx by making
blk_mq_submit_bio() allocate a request later.

The performance impact of this patch on the hot path is small: if a
request is cached, one percpu_ref_get(&q->q_usage_counter) call and one
percpu_ref_put(&q->q_usage_counter) call are added to the hot path.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index da39a1cac702..666e6e6ba143 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3063,11 +3063,6 @@ void blk_mq_submit_bio(struct bio *bio)
 	struct request *rq;
 	blk_status_t ret;
=20
-	/*
-	 * If the plug has a cached request for this queue, try to use it.
-	 */
-	rq =3D blk_mq_peek_cached_request(plug, q, bio->bi_opf);
-
 	/*
 	 * A BIO that was released from a zone write plug has already been
 	 * through the preparation in this function, already holds a reference
@@ -3076,21 +3071,13 @@ void blk_mq_submit_bio(struct bio *bio)
 	 */
 	if (bio_zone_write_plugging(bio)) {
 		nr_segs =3D bio->__bi_nr_segments;
-		if (rq)
-			blk_queue_exit(q);
 		goto new_request;
 	}
=20
 	bio =3D blk_queue_bounce(bio, q);
=20
-	/*
-	 * The cached request already holds a q_usage_counter reference and we
-	 * don't have to acquire a new one if we use it.
-	 */
-	if (!rq) {
-		if (unlikely(bio_queue_enter(bio)))
-			return;
-	}
+	if (unlikely(bio_queue_enter(bio)))
+		return;
=20
 	/*
 	 * Device reconfiguration may change logical block size or reduce the
@@ -3122,8 +3109,15 @@ void blk_mq_submit_bio(struct bio *bio)
 		goto queue_exit;
=20
 new_request:
+	rq =3D blk_mq_peek_cached_request(plug, q, bio->bi_opf);
 	if (rq) {
 		blk_mq_use_cached_rq(rq, plug, bio);
+		/*
+		 * Here we hold two references: one because of the
+		 * bio_queue_enter() call and a second one as the result of
+		 * request allocation. Drop one.
+		 */
+		blk_queue_exit(q);
 	} else {
 		rq =3D blk_mq_get_new_requests(q, plug, bio, nr_segs);
 		if (unlikely(!rq)) {
@@ -3169,12 +3163,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	return;
=20
 queue_exit:
-	/*
-	 * Don't drop the queue reference if we were trying to use a cached
-	 * request and thus didn't acquire one.
-	 */
-	if (!rq)
-		blk_queue_exit(q);
+	blk_queue_exit(q);
 }
=20
 #ifdef CONFIG_BLK_MQ_STACKING
