Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D59C2ED
	for <linux-block@vger.kernel.org>; Thu,  9 May 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274140; cv=none; b=QzG6nxitjaSORydXjqGDzYVnw2x/rnuBKQytwUlMRF1lwepI1f8aoZn4AGREub/nW/5/iGip7k+voUUUgnXi3gTcVbHDJnRk9e134D5+AW6w63g0OvV6UgxDM5v1S9enpZumVbpVHOLH+kNKhXM6wrfYs+Lkx4rntBbJPrdxILs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274140; c=relaxed/simple;
	bh=jhUZnInkrjo+riCu4qEmDel7/Cn84rpXdlBkKQXyCKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsFv5Xf/tEQ3RCBrjq2KCRqJz+AXYTIZcuSbxEYsg67cURY86sXay27o3VGO2G7IEUahgTg7U0qKhDx8siNcXhQB0znRUY/S98CNP596TQwHZd+U5Lg4iZ2qvh9ygOFEVdJZY63zRtcmHQWGYktsqDMwfj0opxR7S5sre83E1UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=bP1jzvZ1; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="bP1jzvZ1"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VZyx63KRZz6Cnk8t;
	Thu,  9 May 2024 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1715274134; x=1717866135; bh=vfS5r
	xu/jVyPDLMfwcKKUVf4Usik4EvYrIok0TYMcWw=; b=bP1jzvZ1Z3TbQGSkeD/UI
	K3XWtg4mff/g81ggoEng+9hLt1k9TxCLMxHZojQz3ah3AvvAY6WSez1xq5rpXeIe
	3x00yNWaTq5TuuiK05jBq+rOnE6yOBkfU30OJiJspjg4uAbltLTzs1roznD6Z229
	V4d+HYyYDRVwjBS0P2Nrm46elr/Dj2ksOAPu3Kkh6xJsKEFYAi8IA77fHLrLK8wH
	xd5NAqtEMNAvnIpYfOEOUKiigIyGFgS8FLH89IL96ITrSHsUQj3H+yJXRBTtzrLl
	spfT4nqThcIWxjJkj2Jjedny1wiqPQDJhx5OOLsdCHf7U61i9b0ew7a5LWjzEHxi
	A==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dJjVa4Aq2-WX; Thu,  9 May 2024 17:02:14 +0000 (UTC)
Received: from asus.hsd1.ca.comcast.net (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VZyx06DdCz6Cnk8s;
	Thu,  9 May 2024 17:02:12 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: [PATCH v2 2/2] block/mq-deadline: Fix the tag reservation code
Date: Thu,  9 May 2024 10:01:49 -0700
Message-ID: <20240509170149.7639-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509170149.7639-1-bvanassche@acm.org>
References: <20240509170149.7639-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current tag reservation code is based on a misunderstanding of the
meaning of data->shallow_depth. Fix the tag reservation code as follows:
* By default, do not reserve any tags for synchronous requests because
  for certain use cases reserving tags reduces performance. See also
  Harshit Mogalapalli, [bug-report] Performance regression with fio
  sequential-write on a multipath setup, 2024-03-07
  (https://lore.kernel.org/linux-block/5ce2ae5d-61e2-4ede-ad55-5511126024=
01@oracle.com/)
* Reduce min_shallow_depth to one because min_shallow_depth must be less
  than or equal any shallow_depth value.
* Scale dd->async_depth from the range [1, nr_requests] to [1,
  bits_per_sbitmap_word].

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>
Fixes: 07757588e507 ("block/mq-deadline: Reserve 25% of scheduler tags fo=
r synchronous requests")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 94eede4fb9eb..acdc28756d9d 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -487,6 +487,20 @@ static struct request *dd_dispatch_request(struct bl=
k_mq_hw_ctx *hctx)
 	return rq;
 }
=20
+/*
+ * 'depth' is a number in the range 1..INT_MAX representing a number of
+ * requests. Scale it with a factor (1 << bt->sb.shift) / q->nr_requests=
 since
+ * 1..(1 << bt->sb.shift) is the range expected by sbitmap_get_shallow()=
.
+ * Values larger than q->nr_requests have the same effect as q->nr_reque=
sts.
+ */
+static int dd_to_word_depth(struct blk_mq_hw_ctx *hctx, unsigned int qde=
pth)
+{
+	struct sbitmap_queue *bt =3D &hctx->sched_tags->bitmap_tags;
+	const unsigned int nrr =3D hctx->queue->nr_requests;
+
+	return ((qdepth << bt->sb.shift) + nrr - 1) / nrr;
+}
+
 /*
  * Called by __blk_mq_alloc_request(). The shallow_depth value set by th=
is
  * function is used by __blk_mq_get_tag().
@@ -503,7 +517,7 @@ static void dd_limit_depth(blk_opf_t opf, struct blk_=
mq_alloc_data *data)
 	 * Throttle asynchronous requests and writes such that these requests
 	 * do not block the allocation of synchronous requests.
 	 */
-	data->shallow_depth =3D dd->async_depth;
+	data->shallow_depth =3D dd_to_word_depth(data->hctx, dd->async_depth);
 }
=20
 /* Called by blk_mq_update_nr_requests(). */
@@ -513,9 +527,9 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hc=
tx)
 	struct deadline_data *dd =3D q->elevator->elevator_data;
 	struct blk_mq_tags *tags =3D hctx->sched_tags;
=20
-	dd->async_depth =3D max(1UL, 3 * q->nr_requests / 4);
+	dd->async_depth =3D q->nr_requests;
=20
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_depth);
+	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
 }
=20
 /* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */
