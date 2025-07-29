Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3E156C6A
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799696; cv=none; b=Scsjdqi1wgu7X5DIFim/ggVFwdrrSwWkB2wEtzwVVnbWSFaqSJjlusLTZLGif4d5I3sjhA2u2DtRTflxsjT0u8zbzfa8O2YifxNgaofUjqj3TZGMfbecHFzcB8cK5IJ51ZZMFLwLFbNgc7C3JKntRtPYdfYdZF6/O/DtbNdgFds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799696; c=relaxed/simple;
	bh=TddFDa0H7GMLCxFCOb6+TzxcTDfRGDBbUxY6YyswNqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAHJwn9UmRYah/1lrSfYdTJf1Psd/2LTn2nzpVad+U0uL4sJSHmR0xKF7XRCzbgLYUV4kgZZ46IcNBQsrjwP6bBwjcNOyijWFuD8M6edlc9L6JuSaAq9bbXmPa5+QxVJ7k/kZumsOD8oQIdAbN0ikq7UOi4qWBLYzAvWW9eqZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Zxnu0Mcy; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Zxnu0Mcy"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T6XuaN006367
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 07:34:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=rWcOUUH4gNWfSVl+4Zn5zUI/DOVwq/a1WcFru8zTPUE=; b=Zxnu0Mcy+qZ2
	A1SWbPvE+43S39PIgS2p5mCJOxNNRq6Fzr04kfxttAD/c1eBE38gpfh0WfVCAj2v
	7WSazrTPl00b7gD7PuPTRWdVfiryfsXeoxJad7wYibM6H211pyu0iyFjJkimfHJd
	5ADmYJ9fWoF7nejYbn0KVV9SVOzG7YujA2kwyCHN2Nj9t4o4k0wISmcCcB0YUMWY
	5HJP8DlgpgqxwxD6J+imrefCO9MxLIOqOGExRdwI/WbnCPhiP0UfuZx5vTshZaeo
	gx4Lujuj48btHDtj79f7t8nARr6OH7LJTj6mjc1DL5BHMvFlynHDaC31wNRazq1q
	cj/gIkw85g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 486ne9kgej-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 07:34:54 -0700 (PDT)
Received: from twshared78382.04.prn6.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 29 Jul 2025 14:34:51 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 809CB1CC420A; Tue, 29 Jul 2025 07:34:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 5/7] blk-mq-dma: move common dma start code to a helper
Date: Tue, 29 Jul 2025 07:34:40 -0700
Message-ID: <20250729143442.2586575-6-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250729143442.2586575-1-kbusch@meta.com>
References: <20250729143442.2586575-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=JPs7s9Kb c=1 sm=1 tr=0 ts=6888dc0e cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Udg8XZZ2YZ10bUHcV_QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExMiBTYWx0ZWRfX5mA34X6d0zUg Q49YgqMmyI/+n5V/nUrYCuGLUqJpbAx+DVTuylt/ZNsqoxaJsXT3IRTjcYZEZDuRFNEvIVTvrAY OMvBI5t0IRC44NsLIQtYz2mV6BfSwr3cXOvZrfBoDoCXaKMBbMFL0P/TItd9iHJ0Wj2Bg78fekr
 H5yQPVODQnq9gkEe+InsWEZWnwc0xyonspYXkQIzz8gE7ALt9TfbrlGrsrs4jqQxZmqsT1q7v1B G512TpxpB2FlJyZZoK8Q+Xd3/U0i/ZvuWldWYMMExBW74Lqm829lf78W7msSYSnHy6wjCoen+D9 qFucfTWcFdoaoznmhhfjSe/1yKA+b6LN9HQJHD1JT6JF8w7M0v53AI9LcuO4AimDuv1s/KdLtVl
 3Tmqfy/QonSFm9rXRSHMapgCxJmvS1DM2Std3qAAnLvwITGDf5DWlzSkEJCIj4mqSd4zUFfB
X-Proofpoint-GUID: lUJMJO6rwV68KQDyIeb18xiUJsXzvLvz
X-Proofpoint-ORIG-GUID: lUJMJO6rwV68KQDyIeb18xiUJsXzvLvz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

In preparing for dma mapping integrity metadata, move the common dma
setup to a helper.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c | 69 +++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 87c9a7bfa090d..646caa00a0485 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -113,44 +113,16 @@ static bool blk_rq_dma_map_iova(struct request *req=
, struct device *dma_dev,
 	return true;
 }
=20
-/**
- * blk_rq_dma_map_iter_start - map the first DMA segment for a request
- * @req:	request to map
- * @dma_dev:	device to map to
- * @state:	DMA IOVA state
- * @iter:	block layer DMA iterator
- *
- * Start DMA mapping @req to @dma_dev.  @state and @iter are provided by=
 the
- * caller and don't need to be initialized.  @state needs to be stored f=
or use
- * at unmap time, @iter is only needed at map time.
- *
- * Returns %false if there is no segment to map, including due to an err=
or, or
- * %true ft it did map a segment.
- *
- * If a segment was mapped, the DMA address for it is returned in @iter.=
addr and
- * the length in @iter.len.  If no segment was mapped the status code is
- * returned in @iter.status.
- *
- * The caller can call blk_rq_dma_map_coalesce() to check if further seg=
ments
- * need to be mapped after this, or go straight to blk_rq_dma_map_iter_n=
ext()
- * to try to map the following segments.
- */
-bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_d=
ev,
-		struct dma_iova_state *state, struct blk_dma_iter *iter)
+static bool blk_dma_map_iter_start(struct request *req, struct device *d=
ma_dev,
+		struct dma_iova_state *state, struct blk_dma_iter *iter,
+		unsigned int total_len)
 {
-	unsigned int total_len =3D blk_rq_payload_bytes(req);
 	struct blk_map_iter *map_iter =3D &iter->iter;
=20
 	map_iter->bio =3D req->bio;
-	map_iter->iter =3D req->bio->bi_iter;
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
=20
-	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
-		iter->iter.bvec =3D &req->special_vec;
-	else
-		iter->iter.bvec =3D req->bio->bi_io_vec;
-
 	/*
 	 * Grab the first segment ASAP because we'll need it to check for P2P
 	 * transfers.
@@ -179,6 +151,41 @@ bool blk_rq_dma_map_iter_start(struct request *req, =
struct device *dma_dev,
 		return blk_rq_dma_map_iova(req, dma_dev, state, iter);
 	return blk_dma_map_direct(req, dma_dev, iter);
 }
+
+/**
+ * blk_rq_dma_map_iter_start - map the first DMA segment for a request
+ * @req:	request to map
+ * @dma_dev:	device to map to
+ * @state:	DMA IOVA state
+ * @iter:	block layer DMA iterator
+ *
+ * Start DMA mapping @req to @dma_dev.  @state and @iter are provided by=
 the
+ * caller and don't need to be initialized.  @state needs to be stored f=
or use
+ * at unmap time, @iter is only needed at map time.
+ *
+ * Returns %false if there is no segment to map, including due to an err=
or, or
+ * %true ft it did map a segment.
+ *
+ * If a segment was mapped, the DMA address for it is returned in @iter.=
addr and
+ * the length in @iter.len.  If no segment was mapped the status code is
+ * returned in @iter.status.
+ *
+ * The caller can call blk_rq_dma_map_coalesce() to check if further seg=
ments
+ * need to be mapped after this, or go straight to blk_rq_dma_map_iter_n=
ext()
+ * to try to map the following segments.
+ */
+bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_d=
ev,
+		struct dma_iova_state *state, struct blk_dma_iter *iter)
+{
+	iter->iter.iter =3D req->bio->bi_iter;
+	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
+		iter->iter.bvec =3D &req->special_vec;
+	else
+		iter->iter.bvec =3D req->bio->bi_io_vec;
+
+	return blk_dma_map_iter_start(req, dma_dev, state, iter,
+				      blk_rq_payload_bytes(req));
+}
 EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
=20
 /**
--=20
2.47.3

