Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C22C0F78
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 04:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763441476; cv=none; b=kB5wFC6ihUt9LM04t0dFk78tZPwvUvKxJuv8l9zhZdhs31TI7wsKUIIJC2cWXunhsmTiZZ1bsh9aeL5Y2jEZ0+r0EO1bQI160QCqbYRC2C3wGikHoGtPJOKf47X5Zlr6WzPb8fvSI5NLM7yKi0oIgtaFKLsF7ACtQTLUMJYwVfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763441476; c=relaxed/simple;
	bh=XMsgAM46vQo1Ia7mYbyq1QNRJVY9tIxi9LcoV73a3Ek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=QRfdNIGNzrIGB6Jp6MYw97JV6Lkz55yVg31aU/ve6t55b4N0FdTti0XZ9LKVbpBN3t3lm3A0i/dO8+dtpr78JmRVZ3MnJFqWOBg9Wg+UE4Su3HRGmVkAeEU6uRZjgPGDN947i3xPNQOTKjwMw3JH7Zot3UHptDn2RiNXukh53UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ijlqUxK1; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ijlqUxK1"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251118045111epoutp039da8d24b7efccfc21d187644428714e0~5AKztmNC91239012390epoutp03g
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 04:51:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251118045111epoutp039da8d24b7efccfc21d187644428714e0~5AKztmNC91239012390epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763441471;
	bh=rqkWUQNGsKQuSUMikJwmkOX/OyuaE6ZnYponxrANvRs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ijlqUxK1yGjihVoZBp1dpyK464kV7qOZ/wV4zFpNPsZOGlSg3UFAAu8Qh2RbAUO/s
	 95JvnF7DDBTzeE3w+IVBNF/7VG7hnA7vgrh0Nh4quCDBwzQA62+WneoaFTABU0h7Wc
	 uiQXIkopcPGT0I7HLU1x7QdqPCGV4/MTauC4yEi0=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20251118045111epcas5p4ea26ae19e7f2b5cd2d4901f455e18e3b~5AKzdwqqL0546505465epcas5p4l;
	Tue, 18 Nov 2025 04:51:11 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.89]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4d9XHy4b6gz3hhTB; Tue, 18 Nov
	2025 04:51:10 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251117124706epcas5p3fdd6ad73879a7df293504000e55675ee~4zBDC6BQ42962429624epcas5p36;
	Mon, 17 Nov 2025 12:47:06 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251117124705epsmtip1ca106d6fc2e28ab920d7980211d233a1~4zBCO6eOm1943219432epsmtip1t;
	Mon, 17 Nov 2025 12:47:05 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ming.lei@redhat.com, yukuai@fnnas.com, hexue <xue01.he@samsung.com>
Subject: [PATCH v7] block: plug attempts to batch allocate tags multiple
 times
Date: Mon, 17 Nov 2025 12:42:29 +0000
Message-Id: <20251117124229.255796-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251117124706epcas5p3fdd6ad73879a7df293504000e55675ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251117124706epcas5p3fdd6ad73879a7df293504000e55675ee
References: <CGME20251117124706epcas5p3fdd6ad73879a7df293504000e55675ee@epcas5p3.samsung.com>

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
 block/blk-mq.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d626d32f6e57..dc3176639a59 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -467,23 +467,28 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
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
+		if (!(data->rq_flags & RQF_SCHED_TAGS))
+			blk_mq_add_active_requests(data->hctx, nr);
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
-	if (!(data->rq_flags & RQF_SCHED_TAGS))
-		blk_mq_add_active_requests(data->hctx, nr);
 	/* caller already holds a reference, add for remainder */
 	percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
 	data->nr_tags -= nr;
-- 
2.34.1

