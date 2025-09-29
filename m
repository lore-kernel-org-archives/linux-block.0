Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3B283C87
	for <linux-block@vger.kernel.org>; Mon, 29 Sep 2025 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137048; cv=none; b=K4+Uc2niwAJXU8BVJnwI71QRN8Ygvgrn1WIQXTQh5pbypyU4h4c66M94D347j4MNhA6lA+y/3kI8Up4426dWGvQWnoUFV10EeeLVSDWocurJPcPNoqfSOeaUflurl/ZeEIdZrTex1VNety0GmB9qXHI4ScSbnO5sRvP4RXaPmJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137048; c=relaxed/simple;
	bh=LtUDNAtNKd11Kkgrls0OcB1yWDPkY+qSSLNoeZqzEEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=uAUBA7UwyI2RWnAUIWuWOM02kbhmEvLyyCH8LK7ow8LmGXCoC4CjIMAG1Xf4s1JwpOKiKV6XvlqfNv1jzWDRfI+6Ru16ijlNQKmN5pUTeYhjzT8hvvLAKgTv3zeyaz3OP1mP/TZEgvRQPyBzRThsCkk4lm/ACHnNDzRIPhJZkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=c31oG+E8; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c31oG+E8"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250929091042epoutp01231b492d02056dc6baaf2cf28d29c233~ptdH11-Vt0815408154epoutp012
	for <linux-block@vger.kernel.org>; Mon, 29 Sep 2025 09:10:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250929091042epoutp01231b492d02056dc6baaf2cf28d29c233~ptdH11-Vt0815408154epoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759137042;
	bh=YxwWVv9gj+XnelO3Tx2MRqO2rpbzcoAAX+qcwnYQYj4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=c31oG+E8HUYenVuYRwjxJcJvqrz/mcGf1dTOQaYDnDWpc/iEhS2+Cb0yuvHluGaJS
	 t7WkcAnUiKA7+jhhgDPWJrBuemkXwkx6fnrbJAx36EPrHzeZFhbAqeDpKHhCbzx+b3
	 4dZzq0W0vc8tWy9jsMQl63GuQWPa5iL8/JumnnHs=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250929091042epcas5p146a8d7a07bdbfdb86dadeafa5bca7346~ptdHeoUn02587225872epcas5p13;
	Mon, 29 Sep 2025 09:10:42 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cZwQT34cXz2SSKX; Mon, 29 Sep
	2025 09:10:41 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250929091034epcas5p2810fc25ca2fec7a640d4121ec61478f4~ptdAS1i412305023050epcas5p2_;
	Mon, 29 Sep 2025 09:10:34 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250929091033epsmtip2d4caa16f3d082af28178bc973ccc08a4~ptc-dmt_h0072400724epsmtip2M;
	Mon, 29 Sep 2025 09:10:33 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: axboe@kernel.dk, akpm@linux-foundation.org, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, hexue <xue01.he@samsung.com>
Subject: [PATCH v3] block: plug attempts to batch allocate tags multiple
 times
Date: Mon, 29 Sep 2025 09:06:02 +0000
Message-Id: <20250929090602.6102-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250929091034epcas5p2810fc25ca2fec7a640d4121ec61478f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250929091034epcas5p2810fc25ca2fec7a640d4121ec61478f4
References: <CGME20250929091034epcas5p2810fc25ca2fec7a640d4121ec61478f4@epcas5p2.samsung.com>

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
base code: __blk_mq_alloc_requests() 1.35%
patch:__blk_mq_alloc_requests() 0.73%
-------------------------------------------------------------------

---
changes since v1:
- Modify multiple batch registrations into a single loop to achieve
  the batch quantity

changes since v2:
- Modify the call location of remainder handling
- Refactoring sbitmap cleanup time

Signed-off-by: hexue <xue01.he@samsung.com>
---
 block/blk-mq.c | 44 +++++++++++++++++++++++++-------------------
 lib/sbitmap.c  | 44 ++++++++++++++++++++++++++------------------
 2 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ba3a4b77f578..bf9d288e3411 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -456,28 +456,34 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
 	struct blk_mq_tags *tags;
 	struct request *rq;
 	unsigned long tag_mask;
-	int i, nr = 0;
+	int nr_tags = data->nr_tags;
 
-	tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
-	if (unlikely(!tag_mask))
-		return NULL;
+	do {
+		int i, nr = 0;
+
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
+
+		data->nr_tags -= nr;
+	} while (data->nr_tags);
 
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
 	/* caller already holds a reference, add for remainder */
-	percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
-	data->nr_tags -= nr;
+	percpu_ref_get_many(&data->q->q_usage_counter, nr_tags - 1);
 
 	return rq_list_pop(data->cached_rqs);
 }
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 4d188d05db15..457d18650950 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -534,26 +534,34 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 		unsigned int map_depth = __map_depth(sb, index);
 		unsigned long val;
 
-		sbitmap_deferred_clear(map, 0, 0, 0);
 		val = READ_ONCE(map->word);
-		if (val == (1UL << (map_depth - 1)) - 1)
-			goto next;
-
-		nr = find_first_zero_bit(&val, map_depth);
-		if (nr + nr_tags <= map_depth) {
-			atomic_long_t *ptr = (atomic_long_t *) &map->word;
-
-			get_mask = ((1UL << nr_tags) - 1) << nr;
-			while (!atomic_long_try_cmpxchg(ptr, &val,
-							  get_mask | val))
-				;
-			get_mask = (get_mask & ~val) >> nr;
-			if (get_mask) {
-				*offset = nr + (index << sb->shift);
-				update_alloc_hint_after_get(sb, depth, hint,
-							*offset + nr_tags - 1);
-				return get_mask;
+		while (1) {
+			if (val == (1UL << (map_depth - 1)) - 1) {
+				if (!sbitmap_deferred_clear(map, 0, 0, 0))
+					goto next;
+				val = READ_ONCE(map->word);
 			}
+			nr = find_first_zero_bit(&val, map_depth);
+			if (nr + nr_tags <= map_depth)
+				break;
+
+			if (!sbitmap_deferred_clear(map, 0, 0, 0))
+				goto next;
+
+			val = READ_ONCE(map->word);
+		}
+		atomic_long_t *ptr = (atomic_long_t *) &map->word;
+
+		get_mask = ((1UL << nr_tags) - 1) << nr;
+		while (!atomic_long_try_cmpxchg(ptr, &val,
+						  get_mask | val))
+			;
+		get_mask = (get_mask & ~val) >> nr;
+		if (get_mask) {
+			*offset = nr + (index << sb->shift);
+			update_alloc_hint_after_get(sb, depth, hint,
+						*offset + nr_tags - 1);
+			return get_mask;
 		}
 next:
 		/* Jump to next index. */
-- 
2.34.1

