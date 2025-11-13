Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973EE32F762
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763021241; cv=none; b=XksF2o0iK2KGPJsjnwnNx3f9PKW/qIhEyox6f+46C89QJQf6VfsgPOQ/VviJSQzdlM6GptlEvOu3sQNreZ5DaDE2CSrGwq3t4ibNFJCCnlhuohoE0NIzOYFmkksGSP9mv0ULLzx8QYF9/pgmlQNMJAqyeQEhD1XfTq5d3ZZy2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763021241; c=relaxed/simple;
	bh=GiY2H6YUcm7j5bH09sMB3P65y4M3A34GJjQH79Bc6/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=rOPJ76RF5at7X/1zncuPqrTCJU2jrG42X5oZDDVbCCS4fpgfbV4B2B9R0YZKMMzrwRJzFXxOvfavl/MG4kdvgiwLIz6hSVn/JsUn7osZwVVRlNNywyjdFBslOU+PadEF6JXkdWf3mu8GMlt5cZ58cZ/ojAmR36RbFyflOMGMhjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SzkZrGib; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SzkZrGib"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251113080717epoutp03b36f7db0af65b399221dd48e1e48d79f~3gnmC-8iw3135631356epoutp03N
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 08:07:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251113080717epoutp03b36f7db0af65b399221dd48e1e48d79f~3gnmC-8iw3135631356epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763021237;
	bh=qWZYwU/U8X18N7fGL8PcZJbaNWhXtqDpgvhOSFQ3vAE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=SzkZrGibUD/UCvNokJ1+A88JrYxWUBJtNfRXaNee1auIabhBr4toTlnO1KI2uvrHw
	 H1rNxpgptcm7DTtruIVBb7E9gJv53qad6ijD9mSDBQHuAZJQCIl7WQu7tJJFXg8FVH
	 bqKqBrm6TfMqsiAXw1C7W+EV5NntABO/LrMb3nQE=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251113080717epcas5p13032d82d441a5b5f47dcd340e0f8fc8b~3gnlzUc5x0433104331epcas5p1R;
	Thu, 13 Nov 2025 08:07:17 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4d6XtX1Zhqz2SSKh; Thu, 13 Nov
	2025 08:07:16 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20251113080643epcas5p154d9edfbf0f99e0d4c08408ad6cf68f4~3gnGLeT700887708877epcas5p1E;
	Thu, 13 Nov 2025 08:06:43 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251113080642epsmtip203b555b8854a50fd10e9e727c11be64b~3gnFfzjEf2229122291epsmtip2H;
	Thu, 13 Nov 2025 08:06:42 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: axboe@kernel.dk, yukuai@fnnas.com
Cc: akpm@linux-foundation.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, hexue <xue01.he@samsung.com>
Subject: [PATCH v5 RESEND] block: plug attempts to batch allocate tags
 multiple times
Date: Thu, 13 Nov 2025 08:02:02 +0000
Message-Id: <20251113080202.193508-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251113080643epcas5p154d9edfbf0f99e0d4c08408ad6cf68f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251113080643epcas5p154d9edfbf0f99e0d4c08408ad6cf68f4
References: <CGME20251113080643epcas5p154d9edfbf0f99e0d4c08408ad6cf68f4@epcas5p1.samsung.com>

This patch aims to enable batch allocation of sufficient tags after
batch IO submission with plug mechanism, thereby avoiding the need for
frequent individual requests when the initial allocation is
insufficient.

------------------------------------------------------------
Perf:
base code: __blk_mq_alloc_requests() 1.31%
patch: __blk_mq_alloc_requests() 0.7%
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

changes since v4:
- Split blk-mq.c changes from sbitmap

Signed-off-by: hexue <xue01.he@samsung.com>
---
 block/blk-mq.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 09f579414161..64cd0a3c7cbf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -467,26 +467,31 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
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
-- 
2.34.1

