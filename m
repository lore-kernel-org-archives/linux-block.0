Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C236E330B1C
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763021316; cv=none; b=uEcBR+VtFL1rvBemhq5yoI/bIcA5K28R3Q4O44eTjLscPDKE3zBfaIo/OhR0qgQManqb1RMEDu8Y93TVLArLj8XwB8RrHn+SIUH8OthxzKyC1py34Gyx+5m73P/TfbeWDxfudPZXe2IU7rvdBnQ6XBwfCSC8mVJFE6st8tRdWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763021316; c=relaxed/simple;
	bh=w0HIguCZGq66/hpIfsO/+gDy+O2NBUA7A7/P3C5pQu0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=izSdgfeJYV2czGAcapUo0YZqRs6CB28o3qoEZKrr+IXQgpEw2w9clMa7YlcUUPRoAVG4truiXl07L1iwbZUxfwdTPuKXGeBkkkoExOHD/X9Za8c1HFeBAlqxZYcxVW/6j01boQlReACrGzgWuOB6pmTWbVs//ZpEiHcKRLC65ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MHTu7IFM; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MHTu7IFM"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251113080831epoutp046611b4a1c4a3b0d3f142cb6371c5e5b7~3gorMci4D2609026090epoutp04H
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 08:08:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251113080831epoutp046611b4a1c4a3b0d3f142cb6371c5e5b7~3gorMci4D2609026090epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763021311;
	bh=OgA7Y5DjfPg0hts1M8X3QhoQzbRpETJENh9t5f4JWu4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=MHTu7IFMj/xBx/2uvBTb55fGkPt/bcY5uHjoTWeDiZIwiIxfLNncPbLcZ7cQh7z59
	 VKf1llHllTEUudBjNio5NQbQ/eDM5kYJiVf/9cGvUDbKt2sb81vedm6UF+aTN/Kxre
	 iwvRVCYHL8YxJ5zLzGFZuOi7b+aYm7r0YkjW4TCY=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20251113080831epcas5p2a43488fa43492cc5189553b606497f69~3goqwrZGr2415924159epcas5p23;
	Thu, 13 Nov 2025 08:08:31 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.88]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4d6Xvy3GVRz3hhTB; Thu, 13 Nov
	2025 08:08:30 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20251113080818epcas5p10f6bcc1b54ad71ad55aa3c7df1357f1d~3gofQp4q-1761917619epcas5p19;
	Thu, 13 Nov 2025 08:08:18 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251113080818epsmtip1b022e1be3488e1f60bcbf912ca7fb0f5~3goeicXLF2049420494epsmtip1Y;
	Thu, 13 Nov 2025 08:08:18 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: axboe@kernel.dk, yukuai@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hexue
	<xue01.he@samsung.com>
Subject: [PATCH RESEND] lib/sbitmap: add an helper of
 sbitmap_find_bits_in_word
Date: Thu, 13 Nov 2025 08:03:41 +0000
Message-Id: <20251113080341.193553-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251113080818epcas5p10f6bcc1b54ad71ad55aa3c7df1357f1d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251113080818epcas5p10f6bcc1b54ad71ad55aa3c7df1357f1d
References: <CGME20251113080818epcas5p10f6bcc1b54ad71ad55aa3c7df1357f1d@epcas5p1.samsung.com>

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

