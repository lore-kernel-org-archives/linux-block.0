Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34EDDC5
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779930068; cv=none; b=nMTV28R4S8cVvLlOLL83mb3JDajIxRYUxdLQffaa+eVaEc2tTIByLBOzoWD57gqGT0yvL4of+b3LdWxUEPMy8Ra6Ybo8zr//PX/oqaBu333lq2f+azqOwPnkVemy/OsLcVmGIMgPx1vtqehGYC3Pt6mcrxgifBgulpSouTlYRBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779930068; c=relaxed/simple;
	bh=XDyJ/Ra2In9HFZK2Z9O2gg+0tvhB5+OjWN3blCYtaMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wp+InBH+SfehJkctXioEp7t1kRGavuUala5mUgq7NmHju9zW+e3WGm6LH7V3X4u0hCs7CnaGbyemtX5E7tgsumNjju76ttBI95f7QATcvpzQE9fXSNwXGIA+aQo2sT0A/eGeA0yY9gGaO46wKpi/FQodhqsMFBPY/jYtjmrD3Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hq6ukkfO; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hq6ukkfO"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKita8093838
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 18:01:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=xZvbxEnuRPHG8YjILxzVfHLsU7XT1tNyIlSqTCxaaEU=; b=hq6ukkfODvR+
	zCUYZgxFJgdZBIvdfTSu7bmNkTMwda4RfPcrHnWS8DSqOGJwEr5pOi4mEKSPaM80
	aMgISyvavsduuuamnQVEUBLBgMyaNVRRVZFYuxLqUr7/j9fCph9cWVgupC+J5LUv
	KJvN+RmXNZR/fZaQhY7HjFBIN/6ThjlmsoUYXwDTd1ofR6nPUMsyyxtHirT4BAQw
	ywQAsvEtctkxhoMlWYBGgI7S4S0zpv7RiYxKzrmLufTh3cKTScYY8AexSgVkV1RS
	WsA1LcKd34uQ2/e6Wkg3a57PXTyL74ftvlYHk218h0n15WnFHv7t/DEcl3X6Bwan
	0fx4NFIDKQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x198c3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 18:01:05 -0700 (PDT)
Received: from twshared34426.16.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 28 May 2026 01:01:04 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 0F3411D39B575; Wed, 27 May 2026 18:00:58 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Nilay
 Shroff <nilay@linux.ibm.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCHv3 1/2] block: export passthrough stats enabled
Date: Wed, 27 May 2026 18:00:40 -0700
Message-ID: <20260528010041.1533124-2-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528010041.1533124-1-kbusch@meta.com>
References: <20260528010041.1533124-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: MHsAzNCIloe5DVc5Hiq40hOKNczpOWmJ
X-Authority-Analysis: v=2.4 cv=Yu8/gYYX c=1 sm=1 tr=0 ts=6a1793d1 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=hD80L64hAAAA:8
 a=EHD5-2HmoPCg4FQ8pjcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDAwNyBTYWx0ZWRfX8X5Lz/Pqch5I
 hyioWZb9F9Hw8lb2jOoWD9xWImXv/7ppDgvSYSAKrAQeW5W51RUStS79zhNcxKSrol/O4p8qksp
 EK43ZEtpTSzM+tFkzAg81R4UTZJ5A7IkKwQ66nUUZ9f7iFVZFYIkqMuEXHeqb9Wy0FVCoctU89b
 8rQxzrRbMO9mU1dAwmUdIncz59tICkjDTGcncKG5Pr5eD7v/oGdEraCgL9ytnLHVxIaVpHCR7tq
 mOaib9y/S8WqkeQfcfHPAkgvAJtnRmySwPLmk8YA88s4la6gzR60MoNM8DI9mPE2T1lGe+E3QMQ
 qL4397feZBhPsqVPWVQ/CsmWEmtagD14mPBpUYhhMmJ6Vh7d+fNi9Hl6kknBncxzG4j9Ztk3Qab
 jT5weH2it864aZL1e7+UeIcyhi2Mld+JhJHCPhuDmewEB7LIgY8YzpBHK0TVybFv0BCWo6X0ZoF
 GJvKqnriPNwi0rMQ3WQ==
X-Proofpoint-ORIG-GUID: MHsAzNCIloe5DVc5Hiq40hOKNczpOWmJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

A user can enable io accounting for passthrough requests, so export the
helper that checks if the request should be tracked. This will enable
stacking drivers to to report iostats for passthrough workloads. Since
the stacking request_queue may not be the one providing the request, the
API has to add a parameter for the caller to specify which one to check.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c         | 32 +-------------------------------
 include/linux/blk-mq.h | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a24175441380e..8ab6fa59f8d54 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1088,43 +1088,13 @@ static inline void blk_account_io_done(struct req=
uest *req, u64 now)
 	}
 }
=20
-static inline bool blk_rq_passthrough_stats(struct request *req)
-{
-	struct bio *bio =3D req->bio;
-
-	if (!blk_queue_passthrough_stat(req->q))
-		return false;
-
-	/* Requests without a bio do not transfer data. */
-	if (!bio)
-		return false;
-
-	/*
-	 * Stats are accumulated in the bdev, so must have one attached to a
-	 * bio to track stats. Most drivers do not set the bdev for passthrough
-	 * requests, but nvme is one that will set it.
-	 */
-	if (!bio->bi_bdev)
-		return false;
-
-	/*
-	 * We don't know what a passthrough command does, but we know the
-	 * payload size and data direction. Ensuring the size is aligned to the
-	 * block size filters out most commands with payloads that don't
-	 * represent sector access.
-	 */
-	if (blk_rq_bytes(req) & (bdev_logical_block_size(bio->bi_bdev) - 1))
-		return false;
-	return true;
-}
-
 static inline void blk_account_io_start(struct request *req)
 {
 	trace_block_io_start(req);
=20
 	if (!blk_queue_io_stat(req->q))
 		return;
-	if (blk_rq_is_passthrough(req) && !blk_rq_passthrough_stats(req))
+	if (blk_rq_is_passthrough(req) && !blk_rq_passthrough_stats(req, req->q=
))
 		return;
=20
 	req->rq_flags |=3D RQF_IO_STAT;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 24b4160aeaad3..af878597afb8c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1252,4 +1252,44 @@ static inline int blk_rq_map_sg(struct request *rq=
, struct scatterlist *sglist)
 }
 void blk_dump_rq_flags(struct request *, char *);
=20
+/**
+ * blk_rq_passthrough_stats - check if this request should account stats
+ * @rq: request to check
+ * @q: the queue accumulating the stats
+ *
+ * Note, @q does not necessarily need to be the request_queue that provi=
des
+ * @rq.
+ *
+ * Return: true if stats should be accounted.
+ */
+static inline bool blk_rq_passthrough_stats(struct request *rq,
+					    struct request_queue *q)
+{
+	struct bio *bio =3D rq->bio;
+
+	if (!blk_queue_passthrough_stat(q))
+		return false;
+
+	/* Requests without a bio do not transfer data. */
+	if (!bio)
+		return false;
+
+	/*
+	 * Stats are accumulated in the bdev, so must have one attached to a
+	 * bio to track stats. Most drivers do not set the bdev for passthrough
+	 * requests, but nvme is one that will set it.
+	 */
+	if (!bio->bi_bdev)
+		return false;
+
+	/*
+	 * We don't know what a passthrough command does, but we know the
+	 * payload size and data direction. Ensuring the size is aligned to the
+	 * block size filters out most commands with payloads that don't
+	 * represent sector access.
+	 */
+	if (blk_rq_bytes(rq) & (bdev_logical_block_size(bio->bi_bdev) - 1))
+		return false;
+	return true;
+}
 #endif /* BLK_MQ_H */
--=20
2.53.0-Meta

