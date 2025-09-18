Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDA02EFD81
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182415; cv=none; b=gNDedxszTwNQL9ctSj3o2YxqTbeyZc5AA6ZUsD8i5kENmcMeLdgmUbotFYsSUNvgJPf4cVe/rmd4csUQ+0UolH3IgaP+xhXoBkU8WZJqdny/q5SMZVPQRb0gcMXQI+17RnrNdPybQ+BFCCo6S6Tmjpm8YBwF8iVgtT8XzibqmNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182415; c=relaxed/simple;
	bh=yQaq1MtJUWsdSFkn8PxoOTJVgpr0gdM/z5Z+Dy+SxNI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=QlHJ7qOQzxWRbbtq+/ypVWTSGkyDd0HjRC0Lm/oJmN/DJ4wNknEmfapNX6MMfVlFW0IBj603qW5CKcDO8R9l0PzmTV2fREnT40smHepxJYpJqzOIp11PhQ8WjD21X4VUBmZmA9sPL2kpRWOZzMnf+FQiA5NTYSnmS/sXm/a9ytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Px6qwM72; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Px6qwM72"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250918080004epoutp03efce957f33ea16b7374325a9e46906f4~mUZTaw1Vy2193821938epoutp03w
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 08:00:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250918080004epoutp03efce957f33ea16b7374325a9e46906f4~mUZTaw1Vy2193821938epoutp03w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758182404;
	bh=BQWuvDQWOorSsGfg30AXf3ZBtNtFugfs8ir2Lk4ezOU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Px6qwM72SlAV9PC03JAPyMsHLQj+YKsSc+sfE87tqhZuiE3p0+KrxZa20s/jVcldg
	 ZCpMAfPUvqe79UP94eJf39Hm7GwNa81aoedibbo5dHGZKPAlSrBHiEdendm/EivAdQ
	 bpeJfxCt+ruy25Am7E1GgnTMi+U8w2oXP6ErsyHI=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250918080003epcas5p4d00862289c2c5671655763a12eb126b1~mUZTC4DmI2542825428epcas5p4i;
	Thu, 18 Sep 2025 08:00:03 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.94]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cS7N2672wz6B9mF; Thu, 18 Sep
	2025 08:00:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250918075946epcas5p39a6793513e02e446b3e4801ba66b6925~mUZC34nsw0085400854epcas5p3-;
	Thu, 18 Sep 2025 07:59:46 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250918075945epsmtip1d3121fffe60c85673fe20eba33ba7c5c~mUZCM4NO22598225982epsmtip1R;
	Thu, 18 Sep 2025 07:59:45 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: axboe@kernel.dk, akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hexue
	<xue01.he@samsung.com>
Subject: [PATCH v2] block: plug attempts to batch allocate tags multiple
 times
Date: Thu, 18 Sep 2025 07:55:11 +0000
Message-Id: <20250918075511.8197-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250918075946epcas5p39a6793513e02e446b3e4801ba66b6925
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250918075946epcas5p39a6793513e02e446b3e4801ba66b6925
References: <CGME20250918075946epcas5p39a6793513e02e446b3e4801ba66b6925@epcas5p3.samsung.com>

In the existing plug mechanism, tags are allocated in batches based on
the number of requests. However, testing has shown that the plug only
attempts batch allocation of tags once at the beginning of a batch of
I/O operations. Since the tag_mask does not always have enough available
tags to satisfy the requested number, a full batch allocation is not
guaranteed to succeed each time. The remaining tags are then allocated
individually (occurs frequently), leading to multiple single-tag
allocation overheads.

This patch aims to retry batch allocation of tags when the initial batch
allocation fails to reach the requested number, thereby reducing the
overhead of individual allocation attempts.

--------------------------------------------------------------------
perf:
base code: __blk_mq_alloc_requests() 1.33%
patch:__blk_mq_alloc_requests() 0.72%
-------------------------------------------------------------------

Signed-off-by: hexue <xue01.he@samsung.com>
---
 block/blk-mq.c | 43 +++++++++++++++++++++++--------------------
 lib/sbitmap.c  |  7 ++++---
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ba3a4b77f578..3ed8da176831 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -456,28 +456,31 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
 	struct blk_mq_tags *tags;
 	struct request *rq;
 	unsigned long tag_mask;
-	int i, nr = 0;
 
-	tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
-	if (unlikely(!tag_mask))
-		return NULL;
+	do {
+		int i, nr = 0;
 
-	tags = blk_mq_tags_from_data(data);
-	for (i = 0; tag_mask; i++) {
-		if (!(tag_mask & (1UL << i)))
-			continue;
-		tag = tag_offset + i;
-		prefetch(tags->static_rqs[tag]);
-		tag_mask &= ~(1UL << i);
-		rq = blk_mq_rq_ctx_init(data, tags, tag);
-		rq_list_add_head(data->cached_rqs, rq);
-		nr++;
-	}
-	if (!(data->rq_flags & RQF_SCHED_TAGS))
-		blk_mq_add_active_requests(data->hctx, nr);
-	/* caller already holds a reference, add for remainder */
-	percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
-	data->nr_tags -= nr;
+		tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
+		if (unlikely(!tag_mask))
+			return NULL;
+
+		tags = blk_mq_tags_from_data(data);
+		for (i = 0; tag_mask; i++) {
+			if (!(tag_mask & (1UL << i)))
+				continue;
+			tag = tag_offset + i;
+			prefetch(tags->static_rqs[tag]);
+			tag_mask &= ~(1UL << i);
+			rq = blk_mq_rq_ctx_init(data, tags, tag);
+			rq_list_add_head(data->cached_rqs, rq);
+			nr++;
+		}
+		if (!(data->rq_flags & RQF_SCHED_TAGS))
+			blk_mq_add_active_requests(data->hctx, nr);
+		/* caller already holds a reference, add for remainder */
+		percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
+		data->nr_tags -= nr;
+	} while (data->nr_tags);
 
 	return rq_list_pop(data->cached_rqs);
 }
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 4d188d05db15..4ac303842aec 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -534,10 +534,11 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 		unsigned int map_depth = __map_depth(sb, index);
 		unsigned long val;
 
-		sbitmap_deferred_clear(map, 0, 0, 0);
 		val = READ_ONCE(map->word);
-		if (val == (1UL << (map_depth - 1)) - 1)
-			goto next;
+		if (val == (1UL << (map_depth - 1)) - 1) {
+			if (!sbitmap_deferred_clear(map, map_depth, 0, 0))
+				goto next;
+		}
 
 		nr = find_first_zero_bit(&val, map_depth);
 		if (nr + nr_tags <= map_depth) {
-- 
2.34.1

