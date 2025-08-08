Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8024286422
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668715; cv=none; b=i/j2+d7dH0CIoTBKzUBJTAZpUvsMFMjYd5qiv8yn5DaFN3bX5qlEsrx8zN0+aaTgQZVTlagWbfZOfY9EfSbVPINR/JpXg8xc5IKdExMVDzifDpKbkQZusImM84GleLV0tdA2dqPd/Mx1K6S9LnZngoNC0aIN/tF7tN9OJzmTXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668715; c=relaxed/simple;
	bh=LNovEpmdBuAJVhQM5dgP9MtRGzsCjsrgUCjLGOfPjD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qb7gdpHiO//6vCDUw1DMw9VTXL12slp3A5GA7yid9au6zhOOpdPFzKPz8jh3LMvxxhp8FwxtaAeydK8Rl4rJuALeY2c9wYMCRAtuEwZ2RmTxKxBwVHwSWLZwGYapfOvf4vyIEFW9UPhOO4HtDuAY303FwnYQoXAOKERvnrlVcd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=csFkBI1+; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="csFkBI1+"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578FKBb6021638
	for <linux-block@vger.kernel.org>; Fri, 8 Aug 2025 08:58:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Kb4ack9vXfOSkVGDHJdpxKswW0fz+d5LtDVd0jctGeE=; b=csFkBI1+fT9S
	jT8enHvgiuYhvaFkvQpOj1qbFEAWWd6Fqr7jxTGHp9qp3sbuUkUbKZXYFDqSmSsd
	i7BhPLh9pVZssE/ufcA6oOi4ROTLQMds00piI10+VMXByFclowA6FwqzdUhsU0Mw
	QOs6Zh/m5/pHDb8GW0O7Oac8NzzFTG1vaoUFL4n+bOWamdy9hKCi2Z6wLGch7Kuh
	ofLoL1UWy8vb1E053t4f4DrskD0bZo4gdMu6IxKQpmHDGXPXyvqqtou3hntgKYh/
	ADnD5SXyiOaOQX1YNlQBcMPp57KS/A7Nw6W1XMiNbtycjS/l6n8RmxKicKGR5nVH
	U2CBgWdsRQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48dbwck3f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 08 Aug 2025 08:58:32 -0700 (PDT)
Received: from twshared10560.01.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 8 Aug 2025 15:58:31 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id DB4976C76C5; Fri,  8 Aug 2025 08:58:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 5/8] blk-mq-dma: move common dma start code to a helper
Date: Fri, 8 Aug 2025 08:58:23 -0700
Message-ID: <20250808155826.1864803-6-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250808155826.1864803-1-kbusch@meta.com>
References: <20250808155826.1864803-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyOSBTYWx0ZWRfX+eYSTGOeTU5H 0Q53AyrcN7jUa32sBxpQSzRqZqLqOR4mnVw3+9cb96oQ0XRAtRhm4o91DYlzWwjNDgj26CQ4+Gl +0kuaGREWzGkBgqyBnGmCpDXfMpWJWp8Cg6Fb5yULfccuasp9sq7PqGNEwkwDY3pvxNkGwv6hH6
 FI/oEbgmAZoBM21wFA/pZZzGfpCF9OVdTYvScI8ATnyxeGcUryE7wn59l+FFD/ktXAEhG+VONFy HEGApsuQDOBBXMWzjQBrgxi5l77/D0GtK1fZEq3L3jl+kmNTLilfQNMPe+sgizx3HA24+ulypKB YaktGh5Gl0azCLUEdFTjIN6MOPR3gQ92L99+SIFrAP4xiy+qeC5xtdxx9PvTXVOXXubpvLYikCH
 Lj/wEkhP7J48Z0OrOyuF4Jvyhorzt80J9qW2ukajqmOBJKNhX64O4I/CaJCI4rW2cNzJZGak
X-Proofpoint-GUID: vYFFWMFADsHiERQE8Aoj0pjJczYBa4nK
X-Authority-Analysis: v=2.4 cv=DthW+H/+ c=1 sm=1 tr=0 ts=68961ea8 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Udg8XZZ2YZ10bUHcV_QA:9
X-Proofpoint-ORIG-GUID: vYFFWMFADsHiERQE8Aoj0pjJczYBa4nK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

In preparing for dma mapping integrity metadata, move the common dma
setup to a helper.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c | 60 +++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 988c27667df67..bc694fecb39dc 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -135,36 +135,12 @@ static struct blk_map_iter blk_rq_map_iter(struct r=
equest *rq)
 	};
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
-
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
-	iter->iter =3D blk_rq_map_iter(req);
=20
 	/*
 	 * Grab the first segment ASAP because we'll need it to check for P2P
@@ -194,6 +170,36 @@ bool blk_rq_dma_map_iter_start(struct request *req, =
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
+	iter->iter =3D blk_rq_map_iter(req);
+	return blk_dma_map_iter_start(req, dma_dev, state, iter,
+				      blk_rq_payload_bytes(req));
+}
 EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
=20
 /**
--=20
2.47.3

