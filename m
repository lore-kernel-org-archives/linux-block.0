Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2258D22A4F1
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760078424; cv=none; b=BqjOeDacL2dEwawSCOiN0y5QZwyv/cv4srcDb5o2QtYXtzfJxtv0jVuTw9LW+ZpWzcamOqirPPqHap6qzBNV8xWgUkp74rIzczGNjMpdqQF+9LMj0TbdXzfm078WdMdXT1VMw7uWT+Z/iNFPOWvJI5Ugq7R3s40HSQ9rKdipgN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760078424; c=relaxed/simple;
	bh=bMrgqdBozNK6AeYWBzFMz+gUaAR2YNtQY7Glg4y8Gfo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=l6SgMXngLmjDJ/oecb4xlX1FOuXn+FJGUo2APt6fxtE6CSCVnjgM5YdO9D04EhczLr4oJqTlkKvhRFs5m7HGequDRY4sjzOvUqB5S9Bt5r79SOWPTjTCyBHLR1RZhvBEaKibu/c5SLEr+bbfToLEUvpYZEazyPiDG8XwBerYJi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=awgrrz4E; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="awgrrz4E"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251010064015epoutp03af447196f8ee35e603fea21549012985~tDf55x6m53095930959epoutp03G
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 06:40:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251010064015epoutp03af447196f8ee35e603fea21549012985~tDf55x6m53095930959epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760078416;
	bh=UGIEXiitJAYS1R0cE+vMBuyTKPBtweIwoCV3iM46DOs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=awgrrz4EnUaeCZwRVx0JMX+ml06jdB+tti+z4lnHbjdwNyJClOhXcX68R+CPhQrN7
	 S/UHQt1P8QoL+gprxxOtAZjfsEbmOP3thY7A061BvXF6i+XQIFJ6+Cyp0lKw8OSJ/I
	 W1d8kAixr9xWnFOIlD01nzdtaQZnUkDc6MLf24+o=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251010064014epcas5p113955a4ba67dc4227fd3fb8704522c6a~tDf47nEzh0666806668epcas5p1j;
	Fri, 10 Oct 2025 06:40:14 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.91]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cjcYp02zKz2SSKj; Fri, 10 Oct
	2025 06:40:14 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251010064008epcas5p3c507d64678fadfb71574050b01357341~tDfzMqHrq0587705877epcas5p3o;
	Fri, 10 Oct 2025 06:40:08 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251010064007epsmtip2edf5675729b3f781186020c0c6469edf~tDfyV5xGU2716227162epsmtip2_;
	Fri, 10 Oct 2025 06:40:07 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: axboe@kernel.dk, akpm@linux-foundation.org, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, hexue <xue01.he@samsung.com>
Subject: [PATCH v4] block: plug attempts to batch allocate tags multiple
 times
Date: Fri, 10 Oct 2025 06:35:38 +0000
Message-Id: <20251010063538.3597-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251010064008epcas5p3c507d64678fadfb71574050b01357341
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251010064008epcas5p3c507d64678fadfb71574050b01357341
References: <CGME20251010064008epcas5p3c507d64678fadfb71574050b01357341@epcas5p3.samsung.com>

This patch aims to enable batch allocation of sufficient tags after
batch IO submission with plug mechanism, thereby avoiding the need for
frequent individual requests when the initial allocation is
insufficient.

------------------------------------------------------------
Perf:
base code: __blk_mq_alloc_requests() 1.31%
patch: __blk_mq_alloc_requests() 0.71%
------------------------------------------------------------

---
changes since v1:
- Modify multiple batch registrations into a single loop to achieve
  the batch quantity

changes since v2:
- Modify the call location of remainder handling
- Refactoring sbitmap cleanup time

changes since v3:
- Add handle operation in loop
- Add helper sbitmap_find_bits_in_word

Signed-off-by: hexue <xue01.he@samsung.com>
---
 block/blk-mq.c | 39 ++++++++++++++++++---------------
 lib/sbitmap.c  | 58 ++++++++++++++++++++++++++++++++++----------------
 2 files changed, 62 insertions(+), 35 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ba3a4b77f578..695ccc72e69f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -458,26 +458,31 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
 	unsigned long tag_mask;
 	int i, nr = 0;
 
-	tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
-	if (unlikely(!tag_mask))
-		return NULL;
+	do {
+		tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
+		if (unlikely(!tag_mask)) {
+			if (nr == 0)
+				return NULL;
+			break;
+		}
+		tags = blk_mq_tags_from_data(data);
+		for (i = 0; tag_mask; i++) {
+			if (!(tag_mask & (1UL << i)))
+				continue;
+			tag = tag_offset + i;
+			prefetch(tags->static_rqs[tag]);
+			tag_mask &= ~(1UL << i);
+			rq = blk_mq_rq_ctx_init(data, tags, tag);
+			rq_list_add_head(data->cached_rqs, rq);
+			data->nr_tags--;
+			nr++;
+		}
+		if (!(data->rq_flags & RQF_SCHED_TAGS))
+			blk_mq_add_active_requests(data->hctx, nr);
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
 	percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
-	data->nr_tags -= nr;
 
 	return rq_list_pop(data->cached_rqs);
 }
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 4d188d05db15..c0a8da1beec9 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -208,6 +208,32 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 	return nr;
 }
 
+static unsigned long sbitmap_find_bits_in_word(struct sbitmap_word *map,
+				    unsigned int depth, unsigned int alloc_hint, bool wrap,
+				    unsigned long *val, int nr_tags, unsigned int map_depth)
+{
+	unsigned long local_val, nr;
+
+	while (1) {
+		local_val = READ_ONCE(map->word);
+		if (local_val == (1UL << (map_depth - 1)) - 1) {
+			if (!sbitmap_deferred_clear(map, depth, alloc_hint, wrap))
+				return -1UL;
+			continue;
+		}
+
+		nr = find_first_zero_bit(&local_val, map_depth);
+		if (nr + nr_tags <= map_depth)
+			break;
+
+		if (!sbitmap_deferred_clear(map, depth, alloc_hint, wrap))
+			return -1UL;
+	};
+
+	*val = local_val;
+	return nr;
+}
+
 static unsigned int __map_depth_with_shallow(const struct sbitmap *sb,
 					     int index,
 					     unsigned int shallow_depth)
@@ -534,26 +560,22 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 		unsigned int map_depth = __map_depth(sb, index);
 		unsigned long val;
 
-		sbitmap_deferred_clear(map, 0, 0, 0);
-		val = READ_ONCE(map->word);
-		if (val == (1UL << (map_depth - 1)) - 1)
+		nr = sbitmap_find_bits_in_word(map, 0, 0, 0, &val, nr_tags, map_depth);
+		if (nr == -1UL)
 			goto next;
 
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
-			}
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

