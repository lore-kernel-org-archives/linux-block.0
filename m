Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A11289E06
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 05:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762495038; cv=none; b=Fd7Dm9vPp4XFRyFLU4lJv4LRBCSQxzUtsvP3JtuaL8kxTvMiraszcFRqCcwu842zaXPe6/+x72AwYRoSmRQhckjHCme4uGLnxQWvXvif82Jk5T9JWTMcNfWy38WqB+I1qDIgGkjPslaMPcGeKoYA7ikQMugWmftKJsvtjzlYThg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762495038; c=relaxed/simple;
	bh=w0HIguCZGq66/hpIfsO/+gDy+O2NBUA7A7/P3C5pQu0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=lr+Hw0ok0K9+qL1gyBLs7l0Ld7VcojQolU/+vJR/Y9GqZ7RVE44nu0QUTizAWkhjeCHDU8DYnNlKiPA9VSkUu0VYwqPwwRzijeOX79FsHXqB5H1jSOHR+pKsd1LUwkfM4vN1LWBpAjSpyWM6EmkWt0ea5qor05MFkf1WI7Q6538=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=K/37lqCT; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K/37lqCT"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251107055714epoutp01189565b5d831b187a7ce121cff123d2f~1o_VCUvYZ2569625696epoutp01Q
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 05:57:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251107055714epoutp01189565b5d831b187a7ce121cff123d2f~1o_VCUvYZ2569625696epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1762495034;
	bh=OgA7Y5DjfPg0hts1M8X3QhoQzbRpETJENh9t5f4JWu4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=K/37lqCT4fTxhx6GGh3M85f1jjdxJr05ufzHFAlfqUyLOuCt6QZnMWNIJWr92twat
	 t0qg0CodTawrss3ThbCeqFQ4SIYjLW6T4IkwbUrwJKmynPV/Ttw613WTB03CEt0XyW
	 c2/1F2mLkWYmnA5rInb+QGlSUFml/XATINZ/CHEE=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251107055713epcas5p102eee5533e932af5fda945bb0bad15ac~1o_UyC9f51724917249epcas5p17;
	Fri,  7 Nov 2025 05:57:13 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.87]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4d2pHF1k2bz2SSKf; Fri,  7 Nov
	2025 05:57:13 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251107054709epcas5p318b9d7569f2965a85e0a4486de52ff9a~1o1hrSX0l0045700457epcas5p3N;
	Fri,  7 Nov 2025 05:47:09 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251107054708epsmtip276c339e01557de9c16577d0ca912b52d~1o1g4XctO0497104971epsmtip2W;
	Fri,  7 Nov 2025 05:47:08 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: axboe@kernel.dk, akpm@linux-foundation.org, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, hexue <xue01.he@samsung.com>
Subject: [PATCH] lib/sbitmap: add an helper of sbitmap_find_bits_in_word
Date: Fri,  7 Nov 2025 05:42:43 +0000
Message-Id: <20251107054243.42628-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251107054709epcas5p318b9d7569f2965a85e0a4486de52ff9a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251107054709epcas5p318b9d7569f2965a85e0a4486de52ff9a
References: <CGME20251107054709epcas5p318b9d7569f2965a85e0a4486de52ff9a@epcas5p3.samsung.com>

The original sbitmap performed a cleanup operation before acquiring a bit,
but this was sometimes unnecessary overhead. This patch reduced the
frequency of cleanup operations, executing them only when necessary, and
abstracted a helper function that can acquire multiple free bits in a
single operation.

Signed-off-by: hexue <xue01.he@samsung.com>
---
 lib/sbitmap.c | 71 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 24 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 4d188d05db15..98fd27a896f1 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -208,6 +208,43 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 	return nr;
 }
 
+static unsigned long sbitmap_find_bits_in_word(struct sbitmap_word *map,
+					unsigned int map_depth, int nr_tags, unsigned long *nr)
+{
+	unsigned long val, bit_nr, get_mask;
+
+	while (1) {
+		val = READ_ONCE(map->word);
+		if (val == (1UL << (map_depth - 1)) - 1) {
+			if (!sbitmap_deferred_clear(map, 0, 0, 0))
+				return 0;
+			continue;
+		}
+
+		bit_nr = find_first_zero_bit(&val, map_depth);
+
+		/* Ensure that the lengths of get_mask and val are consistent
+		 * to avoid NULL pointer dereference
+		 */
+		if (bit_nr + nr_tags <= map_depth)
+			break;
+
+		if (!sbitmap_deferred_clear(map, 0, 0, 0))
+			return 0;
+	};
+
+	atomic_long_t *ptr = (atomic_long_t *) &map->word;
+
+	get_mask = ((1UL << nr_tags) - 1) << bit_nr;
+	while (!atomic_long_try_cmpxchg(ptr, &val,
+					  get_mask | val))
+		;
+	get_mask = (get_mask & ~val) >> bit_nr;
+
+	*nr = bit_nr;
+	return get_mask;
+}
+
 static unsigned int __map_depth_with_shallow(const struct sbitmap *sb,
 					     int index,
 					     unsigned int shallow_depth)
@@ -517,7 +554,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 {
 	struct sbitmap *sb = &sbq->sb;
 	unsigned int hint, depth;
-	unsigned long index, nr;
+	unsigned long index;
 	int i;
 
 	if (unlikely(sb->round_robin))
@@ -530,32 +567,18 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 
 	for (i = 0; i < sb->map_nr; i++) {
 		struct sbitmap_word *map = &sb->map[index];
-		unsigned long get_mask;
+		unsigned long get_mask, nr;
 		unsigned int map_depth = __map_depth(sb, index);
-		unsigned long val;
 
-		sbitmap_deferred_clear(map, 0, 0, 0);
-		val = READ_ONCE(map->word);
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
-			}
+		get_mask = sbitmap_find_bits_in_word(map, map_depth, nr_tags, &nr);
+
+		if (get_mask) {
+			*offset = nr + (index << sb->shift);
+			update_alloc_hint_after_get(sb, depth, hint,
+						*offset + nr_tags - 1);
+			return get_mask;
 		}
-next:
+
 		/* Jump to next index. */
 		if (++index >= sb->map_nr)
 			index = 0;
-- 
2.34.1

