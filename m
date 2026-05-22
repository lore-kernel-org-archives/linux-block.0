Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500554218AC
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462972; cv=none; b=hgnglRsgxzRleZiuSFjW//mrLT9zxPgt9YFYJZI6FkYYDFnJ0lLimNrevXRHjIcQzODwhH9AbGuoPJfA+PNzjhTkjJiAktqh7goOnqSsJy8CkTcgb5SeWbtSGSqOE/JToj4r1GI/MEn6YHNJIcahAX8DH/oyme9/IzTBN383IDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462972; c=relaxed/simple;
	bh=t7E/ZlFPix3/vl8/o3WSCsfEbspaLQSy9iJxsRQXO7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V1VK4Uea9Y0xoRYvojysVaPznx8lf2sNH4QrwU5LJFcm5k8XYuUVxPIhav7tUAggtsftoy2DWgPURECpJt0PO9DqudXJISsxzUZscCyob0a8cF6Te26XD0sQmI6qVvkTrMvpO5r2HQWU7qqPeVcGhuDwoFcCAprtQUEHANxw2v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=g6I/MGc+; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="g6I/MGc+"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M6aFLl3506982
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 08:16:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=tdDFrX8lM7K1Y12nbT
	VKb2PxejimTHNOscZLEaHb94s=; b=g6I/MGc+B11xPtKXs0AQkKiyegLSc9eRt9
	a6vWxD+rE4E8+SheqXXDfcntUsdJWX0Dsz7QyT6NM1ycjokYcQahdkVT1t6qoTW1
	yVGsEVMyw/QY16kF/Lxza+wPiz4iGbZskogGstd06x4F4y3ICitY6XyUrOAT7dn4
	eTExWGswXxDlZZZuFH35xnYpJJWHLJ3m9GznyxT0rN0plPPZSerf2MvPOoBPlTwT
	JsEknVLPjFK206kSQXJwcLJELkdWM/GMeQPyLfzCs7cA4FRXt8DGpdKGgtIBZweT
	aCP8WgkFd7ZDGKYD8cceSznfS5FT44ZL+4YVyWM0n90W43z8PCQA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ea30w80hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 08:16:00 -0700 (PDT)
Received: from twshared124658.16.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Fri, 22 May 2026 15:15:59 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 105CA1B7550E2; Fri, 22 May 2026 08:15:43 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <nilay@linux.ibm.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH] block, nvme: export and use passthrough stats
Date: Fri, 22 May 2026 08:15:37 -0700
Message-ID: <20260522151537.1509784-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: o76ya4GT7iLjoU7j9E6KGq3WHjD7Zdeg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE1MiBTYWx0ZWRfX4rON0OfOOVKZ
 UfyHNRZ8JTA9gSvq/gRtXACkLF99ObNOk33fHyIV8Zruc4D0GjgP+wam7aWvwBtw4nZ8fVjbVOL
 1oKS9lm8rNEh13+k18f+ER92gtdegR9Soy3mJTLxKkDWQh4oONOGLNk3YUDTHClKyVLROkUQL3w
 K3TrbHSnxKINGFDz1lBRa18emolafJ2j02BEDyhjDy1GZ+jrTn3lxm9D/M0VLcCiLw2kIR4JT4O
 Y01y5KO1XrL3ZccDZa0wNS0L68BO8PpmHPx3suR8NfvA8qvrhsOQ4Rdyt/zSkaSo6mIyRvRD5ys
 rv+fJSfeTkcaV6UXyppIogiX6WayPu3uFWrs1TtJH2awwHyMzuiDlDN0euT60XWFshlBOBHRr3m
 C3//M/923pro/Jhkb4Ji25Lvtvp2KZOgtPXctwqfmhyyPC+EYsOGOHsk+Krbma9wunrGnT2FsHV
 42Re3uodONmRabXMSXg==
X-Authority-Analysis: v=2.4 cv=R7oz39RX c=1 sm=1 tr=0 ts=6a107330 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8 a=b18omjuUomqfQ-ouQ7YA:9
X-Proofpoint-ORIG-GUID: o76ya4GT7iLjoU7j9E6KGq3WHjD7Zdeg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

So stacking drivers can also report passthrough workloads through
iostat.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c                | 30 ------------------------------
 drivers/nvme/host/multipath.c |  4 +++-
 include/linux/blk-mq.h        | 29 +++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 28c2d931e75ea..c794b70fefe26 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1088,36 +1088,6 @@ static inline void blk_account_io_done(struct requ=
est *req, u64 now)
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
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index 263161cb8ac06..435fab0be6401 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -175,9 +175,11 @@ void nvme_mpath_start_request(struct request *rq)
 		nvme_req(rq)->flags |=3D NVME_MPATH_CNT_ACTIVE;
 	}
=20
-	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
+	if (!blk_queue_io_stat(disk->queue) ||
 	    (nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
+	if (blk_rq_is_passthrough(rq) && !blk_rq_passthrough_stats(rq))
+		return;
=20
 	nvme_req(rq)->flags |=3D NVME_MPATH_IO_STATS;
 	nvme_req(rq)->start_time =3D bdev_start_io_acct(disk->part0, req_op(rq)=
,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581d..8301830ece8b7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1243,4 +1243,33 @@ static inline int blk_rq_map_sg(struct request *rq=
, struct scatterlist *sglist)
 }
 void blk_dump_rq_flags(struct request *, char *);
=20
+static inline bool blk_rq_passthrough_stats(struct request *req)
+{
+	struct bio *bio =3D req->bio;
+
+	if (!blk_queue_passthrough_stat(req->q))
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
+	if (blk_rq_bytes(req) & (bdev_logical_block_size(bio->bi_bdev) - 1))
+		return false;
+	return true;
+}
 #endif /* BLK_MQ_H */
--=20
2.53.0-Meta

