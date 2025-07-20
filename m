Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD1F225760
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753037046; cv=none; b=EAtY8AsldfijfD64sJJ/Ahr60M52T/srV1H9PchD+7XmNpXVIdRUzZi0ID6d/xJNCY7SyefUUUdgzD0bygJQuIel5VnFuPwy9UcXzZDO5WNBf+JEylPJgro3XybP9VPbnpUVTm8iGRckNrD54iYsxtSpr04GbdMUlYyBgbGdwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753037046; c=relaxed/simple;
	bh=9EXYXwlLxATFcAwa5O5TAlqReczL3v3kYzeNglq3JsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XD1TqvTqZ3GBATux5/1PSh+xzoJvC+piwdf+SbwQxFXyMvaVD8JyFW7GS+X8/3YYGKbe47x47mFxwNysM7IZJH15ZrcKRJvDcYJwvQL8gSRMRRnBFTVL/289iKnn8wgpKfx5HyeN7h9XzmJqkm7/xV77qn5QZXISXR4LdFouxyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nbhOEyHe; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nbhOEyHe"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KIDkmg024222
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 11:44:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ZzWc5zu7T+7csqAbFubqfjaxA1/oxXM7ckMOSz1ep3U=; b=nbhOEyHegD2T
	pAXLwPdsfYTGHKNX9iR8Qk0fVixN1dKtokP/3D8tfc616PszLyjSBLiPjZ4A7LkN
	N1kMHHJs8hY/jXIAwLXK/6ughSa8s9j04ns1rYwK+/c4Sfsj0xM9m/RGELQbMhY9
	ozCoNZFIr/yzNRWrFCOoRgjlMHJ54Iha4ise1PDu0plej3A6JHPgPVTttePvSP5B
	1oDEY+sbTr/cqfGK6MiqumaVVJCwClctGvWyPM4av3fFvcHD1uBmmR3oQGCe6xTq
	HGH2WnV1FKbpduVoBJLKfq3XvdgmdrwX2Mdik23qg339VDInM5x75HksPx37YnmZ
	mnajWFchGg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4815hs02a0-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 11:44:04 -0700 (PDT)
Received: from twshared91430.14.prn3.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Sun, 20 Jul 2025 18:44:02 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 4E7A9178C796; Sun, 20 Jul 2025 11:40:50 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 5/7] blk-mq-dma: move common dma start code to a helper
Date: Sun, 20 Jul 2025 11:40:38 -0700
Message-ID: <20250720184040.2402790-6-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250720184040.2402790-1-kbusch@meta.com>
References: <20250720184040.2402790-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=N8QpF39B c=1 sm=1 tr=0 ts=687d38f4 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Udg8XZZ2YZ10bUHcV_QA:9
X-Proofpoint-GUID: 3vW6yI00tHLiDxWbrx3YtLn1Igf-jcCx
X-Proofpoint-ORIG-GUID: 3vW6yI00tHLiDxWbrx3YtLn1Igf-jcCx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MCBTYWx0ZWRfX6IC8333g0X9u aJndys1hH4Xt3n7eV3PXei7sKV24rnBmf07KSpyWZXFqT+HVPFe7kYJNWJvY5NcnWJwQYQ4HPJ7 fVoFi1jfgfyUJ12yDP25vRfvMyuwT4YF4MjSg73oOIRkvkMPbEBxic+xQdvvpiFGG3h5Wrkq4YV
 /1B2O0aRO+1VRbFPNxz+hdUF9roLIc26KK9WhXV6THVmHcukzCiGTzXUtuDHgxOzmS/YvwV6O+t BKiA0oCdnVb2zASTVP27mgGeAJWslAG29rwhc33PMrqwGUPpiC5OgbzKYl01Dhn4G4zvmB09S4m d/nbCl2e+Majry0zQBzoFpzkvI/SVShU+DikPopX7qf1F+tjnocwtofvEJNMJqBpFLWwx4hDHeR
 cuPqQO10zyK3LO6bv0oud+8Ay+9ltoljewj/fAYPltcxxNym7aBNYDIpuVdTauIaR5XnfyxQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

In preparing for dma mapping integrity metadata, move the common dma
setup to a helper.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c | 69 +++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 56158ed504747..1e2e93c1cf5e2 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -120,44 +120,16 @@ static bool blk_rq_dma_map_iova(struct request *req=
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
 	struct phys_vec vec;
=20
 	iter->bio =3D req->bio;
-	iter->iter =3D req->bio->bi_iter;
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
=20
-	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
-		iter->bvec =3D &req->special_vec;
-	else
-		iter->bvec =3D req->bio->bi_io_vec;
-
 	/*
 	 * Grab the first segment ASAP because we'll need it to check for P2P
 	 * transfers.
@@ -186,6 +158,41 @@ bool blk_rq_dma_map_iter_start(struct request *req, =
struct device *dma_dev,
 		return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);
 	return blk_dma_map_direct(req, dma_dev, iter, &vec);
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
+	iter->iter =3D req->bio->bi_iter;
+	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
+		iter->bvec =3D &req->special_vec;
+	else
+		iter->bvec =3D req->bio->bi_io_vec;
+
+	return blk_dma_map_iter_start(req, dma_dev, state, iter,
+				      blk_rq_payload_bytes(req));
+}
 EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
=20
 /**
--=20
2.47.1

