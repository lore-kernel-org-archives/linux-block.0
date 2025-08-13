Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D061C6FE5
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099132; cv=none; b=UwUY9VJ5DW957sFNCXs7wFNmtBlAua3T1vsQ5492xf/38tp2ug9ISMPSSD/vXLXepXythdTWcnPLxhCqW3o6TIyy7O6jz4A/MOFBl9KGMhQgH7PnlFwG830dR2nAHIqMvcaz9iNE1Urb93BFrIRjXZYRA8hnPxLklI7llI4FZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099132; c=relaxed/simple;
	bh=7pi4vQRqI0sF9vu0Gd4oZQ2vzdRuvduqzqqgIDE/Xsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6cKQHbrOMImdoXHHuKEKC46qeP/yhCnmeTjUPI+d5rGYlwfSn/ZpJp0+dMTkPdJ9VDAdW55InzEmLvAYudYmWkQbDLW0bEMRjHTB9/CRv1g2ChV0qzRdyfhGSSGrIk4tF3FKDdRrmvJ5IDL2O9zTh4MlQiU9rsPYOg/RKDYQN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kWIFd/jd; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kWIFd/jd"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DFBkiC020949
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 08:32:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=fu775ERXyyhMSnUAZLp53PfqsKVY+yKYmm/lA44sjjo=; b=kWIFd/jdvT5o
	yXH5h6lZovxhLWKoT8GNFfy78QHcwYltsFHSlYwR1p9JrAfku05G1EcT83fFKXVY
	+tbEWGQvvCwMmSSP/yzaOGkPc/F/ADU6fb5odYEtV9psWKta77lWrVUZ12o5LykF
	y66C4aWp/05WDul/OlmIY6iBQaMOrGn4TTvTF0O6jOPjd/Slx7DqoS+Gjhsovffd
	bjRSRAxEBDcXAXL7IjNqNIEZSlq10qEq4DwZ8kLhPqjD8/KR7YNZiNnwPhyEa531
	X2vDuZ5Kze++bXb5mqKWz7tE9EI1kXVTfBian7nJnSZUSks3egrUHm8jFHL6fTBt
	lVEHm9pnMg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48gt29hp7j-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 08:32:10 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 13 Aug 2025 15:32:04 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 7EF1F97CD84; Wed, 13 Aug 2025 08:32:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv7 5/9] blk-mq-dma: move common dma start code to a helper
Date: Wed, 13 Aug 2025 08:31:49 -0700
Message-ID: <20250813153153.3260897-6-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813153153.3260897-1-kbusch@meta.com>
References: <20250813153153.3260897-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KfUe4cC57Ts_vP1-KSn-Fq3QED9uUiVJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0NiBTYWx0ZWRfX2r+EuClmohsR 46TNN788Sg+XNNbZ3178dWf0hnqgOFRWZgXOhmJ30WvUNY50B+OaKss82YZhrAIbfZPiBZt1CWI vXnI6Khqbt/IOzBjof9lScPgB/WyZJVX8+ey8r6MoaCFyWOfU7HLZbdphMmx7neC9iO0N9FvM4u
 WS4btY1Xx8z4cnX2m57xPgWW/Lz5jgkKfmaJO1A2PqK/0NpLT+zKO74gFGl29uhEpNlI2jstf0P cMwCvFQ078+lGcbCg0+VpSOdBqX+8YuaICb1qUYC85X33AgeED3tnQpyo9wHcuGHTJob7UklHlk j4fjq/F/pnCrnMeAeDGk6R859LVJ8nD0QwLQPxj9frZ9PfvW585y3coJXbbyrOEWrWILAZGQrjg
 /DZDNMEGQ1qA9wH2oalxuX2jhX/MonJX7ow+y66OovIQ7JtzuAjGd6apPdNkR46EBcqGygBn
X-Proofpoint-ORIG-GUID: KfUe4cC57Ts_vP1-KSn-Fq3QED9uUiVJ
X-Authority-Analysis: v=2.4 cv=Oe+YDgTY c=1 sm=1 tr=0 ts=689caffa cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Udg8XZZ2YZ10bUHcV_QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

In preparing for dma mapping integrity metadata, move the common dma
setup to a helper.

Signed-off-by: Keith Busch <kbusch@kernel.org>
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

