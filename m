Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D0284B36
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006860; cv=none; b=JnSV6EfqUN47UQHn77t0eH7Z0Srg6h4VGUZHuLPY08fWH2se8ixZ0bMgTS9RqEwHiRswmCvNek+maiA+iHVJJfH+3uj57ynRMcHVc5qRdCAkh68bnxUasO4XLt3ng9jHZvnzOXKJznhWgMGwYHPtw/iP+tUcxTfn//nWsF/bgTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006860; c=relaxed/simple;
	bh=4nSdnsw+PCOPh1Qo6p5poBFfMRXNeWbuU+O+0AbdXT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1fEYwGY6fi9EoPINczUgj7mcRLRzdbeJXMRLhgSunuB5/IkUSZmzU66xgGFVS0FtdBMpEs0dD3Ycbr6FiYR3kn+5sIbS8OJYb4uOtK00u4FyiDxOVPVYNlGii4CdpPag+PdfYRPi5ZFxrpqN0mvcLnRMg9/A8Igv7/UOTciCzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GRiOEGLl; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GRiOEGLl"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDnm3J028246
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 06:54:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=M44hiLMtWYhlTX/r/GleBQm9MkDD2iT6ChaUSd5oMeY=; b=GRiOEGLlokbJ
	WmAIsK2zlQ3ClvETvtK+apfAeK+rTxS5xrjKKm+/yGrEaTffJGFTYuxzpO6ifgKV
	cEVUrWkWdSYhBu3IZZw2+hECep7K5Qzg8pviiIU8WT5uKprBjQZa4Fbt56roDauX
	EOwzILzZxYvdeeKIg37WZKj+myVy4ndB8YP8LrkAlTUFS8XY8Xw+a7yZfmTZb98O
	xX2oGs3pm3dh5/h2iC/EBzYYUOZURsMH6CZt1kbG4q/HILGBbz131dHziD3wD/OP
	X8KNpKHKWgOdmQkyA9pzzsuDyNdmkqoI/GL2NFBAMZjovnkZupJI1OIoaJ275CLa
	lN887HVZsQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48g0jbuf4g-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 06:54:16 -0700 (PDT)
Received: from twshared51809.40.frc1.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 12 Aug 2025 13:52:18 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id D4D6E8D407E; Tue, 12 Aug 2025 06:52:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv6 5/8] blk-mq-dma: move common dma start code to a helper
Date: Tue, 12 Aug 2025 06:52:07 -0700
Message-ID: <20250812135210.4172178-6-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812135210.4172178-1-kbusch@meta.com>
References: <20250812135210.4172178-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=O+w5vA9W c=1 sm=1 tr=0 ts=689b4788 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Udg8XZZ2YZ10bUHcV_QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzNCBTYWx0ZWRfX2AZ04M5+3oyr i6Ewnxy1p9WtpI/BSBvUiBcsIf9V36UZBsYcBz3EJjx2kLUfENOBC29EhkSLq77fnB986HqkLVa JkD7MTz1+gL8VLIPlX46oA1OBK4SzgnkmDKAd21H8LbTgOsaFOVB363DoqaFV76p336ZBeJfyv4
 pfOL8k2RownChyeVJEQM5K1fS36Xe88a/VeGd79OBlI919DemQTzM9aKSQHbYjafe1gt5MGeUfV fgs0Nf+V4CQPjANv+On2yU8oh5HwKenqBRG0uXeTUaDu8wlz22EIyqfr8bugWIyHJI7KrYIiio4 btRofPr20bH5MxfL9jZSUeeZB9LI1wSv21rEyW+8KtD9yW4WWhoyB2sr7Ra2+0ETLmzhJsCylaG
 LojdCEfhqpQVuTZa9B3C+cCwrxDgZbr6AziiQnZnZXTgJtYRKNvdB74JsVGD9YCIOD44xYZK
X-Proofpoint-ORIG-GUID: RDiPlGpvd4BFw8Bse9e5em2aZ3kCvHNZ
X-Proofpoint-GUID: RDiPlGpvd4BFw8Bse9e5em2aZ3kCvHNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

In preparing for dma mapping integrity metadata, move the common dma
setup to a helper.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-dma.c | 59 ++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 58defab218823..31dd8f58f0811 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -141,35 +141,12 @@ static inline void blk_rq_map_iter_init(struct requ=
est *rq,
 	}
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
-	blk_rq_map_iter_init(req, &iter->iter);
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
=20
@@ -201,6 +178,36 @@ bool blk_rq_dma_map_iter_start(struct request *req, =
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
+	blk_rq_map_iter_init(req, &iter->iter);
+	return blk_dma_map_iter_start(req, dma_dev, state, iter,
+				      blk_rq_payload_bytes(req));
+}
 EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
=20
 /**
--=20
2.47.3

