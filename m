Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186D28D8F4
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762495036; cv=none; b=j4vdna/wrjFtEZ8ssRDHBKKxbE+uibbhn7ZUx3WVZvTNhPcEe6jKvLEzBGHjMMIooMBtljR4JrX5siNy46/BW6XGEmLO+dUnmYqS67wljDo7tBcQJ3q7bD2YbNHQuPUGcXhcjMgXaG+zOB88peDVLj16nBfOxtuvidxMU8mq3y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762495036; c=relaxed/simple;
	bh=GiY2H6YUcm7j5bH09sMB3P65y4M3A34GJjQH79Bc6/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=TL1R8Hi4IzmI9ONzSLvf4NxLlH1QCu1xJMNha7BHIfwAq/sV769VhFkyuAVcBS0yxSQj4N31MHdVuhVjZAg+oSa4jnx73dhMfiui0J7d90bOtxUEOrXXE/Y2QFrjJKury2rdFwE83UcXXte4qETyCQHrckpQt/FZRsxqMGdQFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Sti/zTAv; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Sti/zTAv"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251107055709epoutp01a94ce1d182dd212c2848d1be9538ab06~1o_QfHI512569825698epoutp01L
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 05:57:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251107055709epoutp01a94ce1d182dd212c2848d1be9538ab06~1o_QfHI512569825698epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1762495029;
	bh=qWZYwU/U8X18N7fGL8PcZJbaNWhXtqDpgvhOSFQ3vAE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Sti/zTAvj6ze1QymBNdy7GUSJMSikr6nYbYxbTelaf/LcCepi2q9/RTvky9m2HifG
	 Jh8se23/pVQb+lv8HgOhSyw2t1FJd7EBkOKok/OLODFjeMyMjXxO8SqUep6p5w2ftX
	 RAEi02L8A7mEQk2N9jrONZzIMI8tJOVqF+MSlMLk=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20251107055709epcas5p3efda005cb005791499ef2d6bfca78a6a~1o_QOhChH1130711307epcas5p3L;
	Fri,  7 Nov 2025 05:57:09 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.91]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4d2pH80gnrz3hhTH; Fri,  7 Nov
	2025 05:57:08 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20251107054645epcas5p4362017054e991cede4eabfe806aeb911~1o1Le8WU-0390103901epcas5p4D;
	Fri,  7 Nov 2025 05:46:45 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251107054644epsmtip133fbce907b52b2551ec583b3380c2dc7~1o1KuKyH90293102931epsmtip1S;
	Fri,  7 Nov 2025 05:46:44 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, hexue <xue01.he@samsung.com>
Subject: [PATCH v5] block: plug attempts to batch allocate tags multiple
 times
Date: Fri,  7 Nov 2025 05:42:19 +0000
Message-Id: <20251107054219.42615-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251107054645epcas5p4362017054e991cede4eabfe806aeb911
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251107054645epcas5p4362017054e991cede4eabfe806aeb911
References: <CGME20251107054645epcas5p4362017054e991cede4eabfe806aeb911@epcas5p4.samsung.com>

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

