Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D541DD872
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981235; cv=none; b=LNidF9C5zJt0zUls9f6PQJL0HP3flVSj6UI3ktCu/CMJdHn3FpMpcrK/Nysm4neJBNtVuorWhzSxUjvjc0f/KDS7s+UFnP47zIsYtsjwW//kizVSUxCWpIaaNcPYheKPhEoxbwIRCaWGiqPs5PYtP3nZw56E4GnuEEpEKhM3cA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981235; c=relaxed/simple;
	bh=4GCCqIDZujNuQ4iOfAV76l8g6eZ5Wo0+bzJlP+ck8vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kz6DYNTZRRvLChM3zU/roEr4vo1Zzm/IlRgynqe77dYUjo7+131hOLW/l1D6vDy+wnvGAdQekNbiGlE/Ymz8xJIyVKhx9UVyyvNvpvS+rBhkB6zMDQzgRWNQT1wUrRbQjV+aglNu43IxNzMuzhHOLAruaIv0XMKDOBszBuw8qWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=diUOB4Bp; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="diUOB4Bp"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YYLjG0k43z6CmM6Q;
	Wed, 15 Jan 2025 22:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1736981229; x=1739573230; bh=1meVa
	6+cXI2xhPzQYIN+eJ30Zh47fE3MjJOPmo1Kd0U=; b=diUOB4BpU3eA8KXLpdVBr
	yvacROE3VeAQOp6/NJWsleCKEJI0g7hMMyM0wS/S+e47wmE+dYGNJOLgtpe2T4fV
	05WPvwlF9tf4rPOpZCpkqTH1r6HTAxZvwBhct62DPvKc0NdS8L7JeBg1qWxLUgeq
	ePx0Ik3PWIIo6X9VVr8ucE6jrzUzk/T4+3Zb5UlPUO9K+ojRk1Ggf0DlqOM2Wq11
	wmvyD9fgW65sOeUplslRQ4n36sGGrNMJgQFq+TnmInEjdCkE+1GEqejj16KLrttW
	5yeAYmQQHxhnGv4Jfy76QRYnvReX6mS1iFjlIKMpbGh6LxO40sAJvGGNHinOXDJT
	g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id HePNhly0cOUx; Wed, 15 Jan 2025 22:47:09 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YYLj773Wkz6CmQvG;
	Wed, 15 Jan 2025 22:47:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v17 04/14] block: Support allocating from a specific software queue
Date: Wed, 15 Jan 2025 14:46:38 -0800
Message-ID: <20250115224649.3973718-5-bvanassche@acm.org>
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

A later patch will preserve the order of pipelined zoned writes by
submitting all zoned writes per zone to the same software queue as
previously submitted zoned writes. Hence support allocating a request
from a specific software queue.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 18 ++++++++++++++----
 block/blk-mq.h |  1 +
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 666e6e6ba143..4262c85be206 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -495,6 +495,7 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_dat=
a *data)
 static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data =
*data)
 {
 	struct request_queue *q =3D data->q;
+	int swq_cpu =3D data->swq_cpu;
 	u64 alloc_time_ns =3D 0;
 	struct request *rq;
 	unsigned int tag;
@@ -507,7 +508,8 @@ static struct request *__blk_mq_alloc_requests(struct=
 blk_mq_alloc_data *data)
 		data->flags |=3D BLK_MQ_REQ_NOWAIT;
=20
 retry:
-	data->ctx =3D blk_mq_get_ctx(q);
+	data->swq_cpu =3D swq_cpu >=3D 0 ? swq_cpu : raw_smp_processor_id();
+	data->ctx =3D __blk_mq_get_ctx(q, data->swq_cpu);
 	data->hctx =3D blk_mq_map_queue(q, data->cmd_flags, data->ctx);
=20
 	if (q->elevator) {
@@ -587,6 +589,7 @@ static struct request *blk_mq_rq_cache_fill(struct re=
quest_queue *q,
 		.cmd_flags	=3D opf,
 		.nr_tags	=3D plug->nr_ios,
 		.cached_rqs	=3D &plug->cached_rqs,
+		.swq_cpu	=3D -1,
 	};
 	struct request *rq;
=20
@@ -648,6 +651,7 @@ struct request *blk_mq_alloc_request(struct request_q=
ueue *q, blk_opf_t opf,
 			.flags		=3D flags,
 			.cmd_flags	=3D opf,
 			.nr_tags	=3D 1,
+			.swq_cpu	=3D -1,
 		};
 		int ret;
=20
@@ -2964,12 +2968,14 @@ static bool blk_mq_attempt_bio_merge(struct reque=
st_queue *q,
 }
=20
 static struct request *blk_mq_get_new_requests(struct request_queue *q,
+					       int swq_cpu,
 					       struct blk_plug *plug,
 					       struct bio *bio,
 					       unsigned int nsegs)
 {
 	struct blk_mq_alloc_data data =3D {
 		.q		=3D q,
+		.swq_cpu	=3D swq_cpu,
 		.nr_tags	=3D 1,
 		.cmd_flags	=3D bio->bi_opf,
 	};
@@ -2993,7 +2999,8 @@ static struct request *blk_mq_get_new_requests(stru=
ct request_queue *q,
  * Check if there is a suitable cached request and return it.
  */
 static struct request *blk_mq_peek_cached_request(struct blk_plug *plug,
-		struct request_queue *q, blk_opf_t opf)
+						  struct request_queue *q,
+						  int swq_cpu, blk_opf_t opf)
 {
 	enum hctx_type type =3D blk_mq_get_hctx_type(opf);
 	struct request *rq;
@@ -3003,6 +3010,8 @@ static struct request *blk_mq_peek_cached_request(s=
truct blk_plug *plug,
 	rq =3D rq_list_peek(&plug->cached_rqs);
 	if (!rq || rq->q !=3D q)
 		return NULL;
+	if (swq_cpu >=3D 0 && rq->mq_ctx->cpu !=3D swq_cpu)
+		return NULL;
 	if (type !=3D rq->mq_hctx->type &&
 	    (type !=3D HCTX_TYPE_READ || rq->mq_hctx->type !=3D HCTX_TYPE_DEFAU=
LT))
 		return NULL;
@@ -3061,6 +3070,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int nr_segs;
 	struct request *rq;
+	int swq_cpu =3D -1;
 	blk_status_t ret;
=20
 	/*
@@ -3109,7 +3119,7 @@ void blk_mq_submit_bio(struct bio *bio)
 		goto queue_exit;
=20
 new_request:
-	rq =3D blk_mq_peek_cached_request(plug, q, bio->bi_opf);
+	rq =3D blk_mq_peek_cached_request(plug, q, swq_cpu, bio->bi_opf);
 	if (rq) {
 		blk_mq_use_cached_rq(rq, plug, bio);
 		/*
@@ -3119,7 +3129,7 @@ void blk_mq_submit_bio(struct bio *bio)
 		 */
 		blk_queue_exit(q);
 	} else {
-		rq =3D blk_mq_get_new_requests(q, plug, bio, nr_segs);
+		rq =3D blk_mq_get_new_requests(q, swq_cpu, plug, bio, nr_segs);
 		if (unlikely(!rq)) {
 			if (bio->bi_opf & REQ_NOWAIT)
 				bio_wouldblock_error(bio);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 44979e92b79f..d5536dcf2182 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -158,6 +158,7 @@ struct blk_mq_alloc_data {
 	struct rq_list *cached_rqs;
=20
 	/* input & output parameter */
+	int swq_cpu;
 	struct blk_mq_ctx *ctx;
 	struct blk_mq_hw_ctx *hctx;
 };
