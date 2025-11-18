Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3303054C8
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451457; cv=none; b=JCupCQvMNEL7z32uN7QgTFMONi/U25rzyoY2hxrXgV2KZ8m7J7fQxi3ErRh6bUKJCjfholduJJValPNR1P7kdvdP/Y7wllHJN+ziV3H0NTvrfLA4FA4oe36fxsqgUBBsMSGLrWu/OZcBqs9HzdGHdBSkZROokbYiWOqczZ3Jb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451457; c=relaxed/simple;
	bh=XOOlkN0aL+OoJdRPCT5xyLVacHRYC1wT1iuJsoUkXBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=sxEFKJ7otw8cJH29oXWLUU7E6eAhQq4CoUktfe43Xr8XubcO7S60tW4fMcjWjY5JbckA2nd4C4y1reNNthcTnWGOcDjVwBrM0OpA6sJoOSpmn53hoPW4MnzHqIoil+Ek9s4/V1hpGBZU7oKi0UIABqC9lmBcjF5PZtiEtPACkpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MZDdfZsK; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MZDdfZsK"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251118073727epoutp015df97f6f75807026161c1211ca1f0f5a~5Cb937vHC2095320953epoutp01H
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:37:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251118073727epoutp015df97f6f75807026161c1211ca1f0f5a~5Cb937vHC2095320953epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763451447;
	bh=BHaUIBoD00HUcf0qQiEBwUpSb7I9GehLZfnyc20IQeY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=MZDdfZsKLgKAO+/avpc9dlQDlgSHm/PqnQp6ms5ASeQDL5wf4Sb2kM7jfaXx9qo1Z
	 vt9eE/tXUGygUUu59sqiFh9CoiXZMYtSlcZgfwlon2uwv1F7/s4f6pHqFDHQUTwUSP
	 JzHaC0ZUrTZN4ISaVwM1FzEAh6GUDlvXUCU8dQl8=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20251118073726epcas5p281a7d55af3b1f3a5c9963d838ffc9138~5Cb9cQ6i72821028210epcas5p2E;
	Tue, 18 Nov 2025 07:37:26 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.95]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4d9bzn3flmz6B9mY; Tue, 18 Nov
	2025 07:37:25 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20251118073708epcas5p141bfdb82151031d41cc4c6c5e606a90f~5CbscGup92808228082epcas5p1g;
	Tue, 18 Nov 2025 07:37:08 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251118073707epsmtip298ad79e250cc38692bf1805ded76e91b~5Cbr0uHvf2316923169epsmtip2I;
	Tue, 18 Nov 2025 07:37:07 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hexue
	<xue01.he@samsung.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v7 RESEND] block: plug attempts to batch allocate tags
 multiple times
Date: Tue, 18 Nov 2025 07:32:30 +0000
Message-Id: <20251118073230.261693-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251118073708epcas5p141bfdb82151031d41cc4c6c5e606a90f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251118073708epcas5p141bfdb82151031d41cc4c6c5e606a90f
References: <CGME20251118073708epcas5p141bfdb82151031d41cc4c6c5e606a90f@epcas5p1.samsung.com>

This patch aims to enable batch allocation of sufficient tags after
batch IO submission with plug mechanism, thereby avoiding the need for
frequent individual requests when the initial allocation is
insufficient.
-----------------------------------------------------------
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
------------------------------------------------------------
Perf:
base code: __blk_mq_alloc_requests() 1.47%
patch: __blk_mq_alloc_requests() 0.75%
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

changes since v5:
- Add workload with perf
- Modify over-counting bug

changes since v6:
- Modify parameters

Signed-off-by: hexue <xue01.he@samsung.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d626d32f6e57..6b22c2c4eb4e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -467,21 +467,26 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
 	unsigned long tag_mask;
 	int i, nr = 0;
 
-	tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
-	if (unlikely(!tag_mask))
-		return NULL;
+	do {
+		tag_mask = blk_mq_get_tags(data, data->nr_tags - nr, &tag_offset);
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
+			nr++;
+		}
+	} while (data->nr_tags > nr);
 
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
 	if (!(data->rq_flags & RQF_SCHED_TAGS))
 		blk_mq_add_active_requests(data->hctx, nr);
 	/* caller already holds a reference, add for remainder */
-- 
2.34.1

