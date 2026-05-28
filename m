Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8D664
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 00:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929961; cv=none; b=BQDThf0dhmYctl3z4IwxFQLy8xpJQAgeNP2V6EVUlBYuTiPu7SHwscMQTIqUWndpXDo1snjmgeRLfmIiz73JbRSY3APdyWuNoGk+pd69ejHVc2xkXXIghfq8EpZ0P+vrp0XsDgiqN+yndHd72l4QRCADcKiTAUgHs0N4sdfo4bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929961; c=relaxed/simple;
	bh=t7E/ZlFPix3/vl8/o3WSCsfEbspaLQSy9iJxsRQXO7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BNxJIegjttZX5tHbIv/OLktjlRiVSYuw1kJ7DOUiVsldXJkbTY6f3FvDb+Oyb23aocRfaqZ52ioa4ULw6C4nmZ/7bvwc/PlS3CuLHpFpU4c/t3w9kOJyQZgk3m8/ouPKPaPr/9BagF8fmQ7lTRakmj3wUXnfkacY6bXlNrxVSgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=V8xxkH8u; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="V8xxkH8u"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKj3o7094242
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 17:59:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=tdDFrX8lM7K1Y12nbT
	VKb2PxejimTHNOscZLEaHb94s=; b=V8xxkH8ub2lpZHTUrBB/4Yj8grCi/TExBF
	g3ZGlTViECupEYhyNJepX0wZEf3vCXXZB2Cl810q0NFODhjxEAA0tG5SMol0sgLp
	OHF7XfgZvqjf6imA3vH6iQjTPZfWAnOF0gFs2XP6RRHlI0STiyA9gMf0hqjGtaAA
	tspjR3j/9/xPZWkrEOg7urx6zNiSQ2nQllZYJoQftD9e2s6m/8IZuDtF6M+C+Ew/
	CYAj2/FcLpElCI5V0deywPapX0P6ke3d3qG3jyDbJGvd+E2b8BfGvhvFYL47ThSy
	xyEYwyfyGR+r5sZ+DMFcv42DsU+RfDLb491oytc58OzKVBNReLew==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x1982y-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 17:59:17 -0700 (PDT)
Received: from twshared12601.02.snb2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 28 May 2026 00:59:15 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id B88741D39B137; Wed, 27 May 2026 17:58:56 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block, nvme: export and use passthrough stats
Date: Wed, 27 May 2026 17:58:48 -0700
Message-ID: <20260528005848.1517715-1-kbusch@meta.com>
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
X-Proofpoint-GUID: TitkRTuZ-_tIyCxViut83XNoiU72XLax
X-Authority-Analysis: v=2.4 cv=Yu8/gYYX c=1 sm=1 tr=0 ts=6a179365 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VwQbUJbxAAAA:8 a=b18omjuUomqfQ-ouQ7YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDAwNyBTYWx0ZWRfX/QC0DflXRron
 J44mYZNklDdvS9CYGGdO3nXJFaS+/E0TjKpgneNGzCPS3QKfC8PwTd+u4ftPB+fNKTOK4ws74dp
 EmDzKx7qNj4nnxtCU5pmalqbkh9vYYv5Srk++LltVlmx9o7WWA1FsIH+jJJtl4RRpp7isfQooyQ
 uK5WdKmuMhzdPQNn2nDbrORzqL7irE6KmH1PiCVPJGViq3zMttkG4e4WcI2x1cEs1ZuNlw84GKi
 dqGEWFB/UyFxnisvZTOh0CFn8a/bAgJliDyruRZDVtdc91VQDfBcPHuspXsVJhETw5GljPiEwT8
 Ceprae/qLx6UZiQVX/q7IohxudVNax2HBJ/ol1lmU4/Ptq1g9paKUe1rlfW7o8eusxyLEeU+PZe
 R7Qw0YXlpedj/J2X5UGEKf1V8kW/Et1440kOVF9gYE1xveLwYypMnnS3K5h9u18Gsn9tSgWQDa2
 IJNmxf1ApY0ezDxJDRg==
X-Proofpoint-ORIG-GUID: TitkRTuZ-_tIyCxViut83XNoiU72XLax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01

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

