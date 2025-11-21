Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23462D8773
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 03:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763695173; cv=none; b=ewv7CWob4huW7H19nF4pceLng91Hjn8luz1AJmCCutNU7hqDfGlThuybgToIQVOr8Hv8hzyZFgdJBtlgfGWYCVpOPLTo5l+5eNNXMELOIvGL+TGatsEippFciw3GsM7sdysbt1oRbDvIWI+wsyqDc8vkTmIkjhSOP/M6XveWu14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763695173; c=relaxed/simple;
	bh=DgsBtqxGQa4wjm9WzZ1LoBOPv18n3Digt4dA6FTpxqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=mr4bTBN5CB0BtdrGUb5BLZ0LBswkAhAozu6q7Tv2ZDGlhTbrz2FTV8DFl/YtykDd2Oukg1c1nosPSuS2y6rXL6i+6gJth1p/sKM0yoVwg3z857419vLTKDHNTGMWoWmHrO8Fp7TUruau5savIdN4RLgqVB9tthONhEevwFBGQAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AtUTB8pP; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AtUTB8pP"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251121031922epoutp04d64c742df0bd8810b7d7b625d3c2b89e~552fpUZYu2217622176epoutp04U
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 03:19:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251121031922epoutp04d64c742df0bd8810b7d7b625d3c2b89e~552fpUZYu2217622176epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763695162;
	bh=H/BBH4ycWODNggkUgW6kGRbq38eHJVYcrzyoZ7ky4hM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=AtUTB8pPsn2YfO4mbdivR9lgtAhMGaZsta362+tByai9kcQVHxcxMG25sYcJNU4HA
	 /4WLce76gAAr8TNIljrh5+y3cABsbVqYyCONd/NWltZLf1zv16d4EBGVUUSFIojEJG
	 +CDh4RL60jVb0YCYy6Pr44N2obHPC5/gdNBGYjFo=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251121031922epcas5p1fa9610b094a8eb6afe5de29f1186344d~552fVe7kV2774027740epcas5p1J;
	Fri, 21 Nov 2025 03:19:22 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.94]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dCL6d3mnRz6B9m5; Fri, 21 Nov
	2025 03:19:21 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20251121031810epcas5p4f6c4b4cd26ea2fa01dea5c7dd3a9572b~551cUbwhq1792617926epcas5p4M;
	Fri, 21 Nov 2025 03:18:10 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251121031809epsmtip217944f4e6633ed22e4fec34fdbb309dc~551boYdUX1355313553epsmtip2A;
	Fri, 21 Nov 2025 03:18:09 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: akpm@linux-foundation.org, axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, hexue
	<xue01.he@samsung.com>
Subject: [PATCH RESEND] lib/sbitmap: add an helper of
 sbitmap_find_bits_in_word
Date: Fri, 21 Nov 2025 03:13:29 +0000
Message-Id: <20251121031329.705663-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251121031810epcas5p4f6c4b4cd26ea2fa01dea5c7dd3a9572b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251121031810epcas5p4f6c4b4cd26ea2fa01dea5c7dd3a9572b
References: <CGME20251121031810epcas5p4f6c4b4cd26ea2fa01dea5c7dd3a9572b@epcas5p4.samsung.com>

From: hexue <xue01.he@samsung.com>

The original sbitmap performed a cleanup operation before acquiring a bit,
but this was sometimes unnecessary overhead. This patch reduced the
frequency of cleanup operations, executing them only when necessary, and
abstracted a helper function that can acquire multiple free bits in a
single operation.
----------------------------------------------------------------------
HW:
16 CPUs/16 poll queues
Disk: Samsung PM9A3 Gen4 3.84T

CMD:
[global]
ioengine=io_uring
group_reporting=1
time_based=1
runtime=1m
refill_buffers=1
norandommap=1
randrepeat=0
fixedbufs=1
registerfiles=1
rw=randread
iodepth=128
iodepth_batch_submit=32
iodepth_batch_complete_min=32
iodepth_batch_complete_max=128
iodepth_low=32
bs=4k
numjobs=1
direct=1
hipri=1

[job1]
filename=/dev/nvme0n1
name=batch_test
-------------------------------------------------------------------
Perf:
base code: __blk_mq_alloc_requests() 0.75%
patch: __blk_mq_alloc_requests() 0.70%
-------------------------------------------------------------------
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

