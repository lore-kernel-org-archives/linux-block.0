Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF71ADFE4
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974328; cv=none; b=TKEdZzp2v+8DeizGzZDaVBld5kZ9wiwNKszM4AiPCPYY+InYY9tWBEGzTCRs00D6FAfegtgyC1vQzZlmlQC9EYd0Ikik2fkiiJzopMR1OwbpQXz/iBw3HjE/g/AtDh2lJ6P20Wou9Q6Qdf/v/tu6pIEphdsZO6nlTHt89r6UsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974328; c=relaxed/simple;
	bh=LNovEpmdBuAJVhQM5dgP9MtRGzsCjsrgUCjLGOfPjD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6RP8DNKUopqbPNSrQ5UslKUeqFnY9MJxjUlPwD6pvFScrg6sw7btalnZjjg5uY1D8AfvemwwcMBc5sVSskbHA8MYgFN1bn4SNl2Jahmt4lyb8maPhlK16Bw+IT85pJXN44cKOcQ08/uIfzqmUht9Xm4RGh15QUEJk0Rfv3h+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=AETYhNTP; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AETYhNTP"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 56VE79vK013470
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Kb4ack9vXfOSkVGDHJdpxKswW0fz+d5LtDVd0jctGeE=; b=AETYhNTPO/l2
	ft8xzgYghlqh7x/2pgKhJztIn8gNAwBx+Eg1khhKsbQK1xJQLJwlS4V6FnI0bffG
	EkfEyeMbEV/GnU8z3+/jKN/FN1HfNVeGPEIbyWnw1yC8Tx2TRHzaAWm8gqnfrZyt
	QWXZYjQ3CFnur7Of5Xev8xYcAfVMNHu04vr/WQWflOZeMJ5AwOC3UIkpq0dq0CdU
	kl6v7ar7BagiE09u0ot4mBwqBlk+RTsHdShvkvwYwE/fzAPpze2ajbvcPKD5fq8O
	K5m1Zbpi+qxOEl/eSsd9U2Z4dpRE+IA/wgf7twbj8l0FVaFOjZRAsLsYY2CqYM5G
	zmZbFYIuTw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4886r61mec-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:24 -0700 (PDT)
Received: from twshared25333.08.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 31 Jul 2025 15:05:23 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 1428C231DB0; Thu, 31 Jul 2025 08:05:13 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 5/8] blk-mq-dma: move common dma start code to a helper
Date: Thu, 31 Jul 2025 08:05:10 -0700
Message-ID: <20250731150513.220395-6-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250731150513.220395-1-kbusch@meta.com>
References: <20250731150513.220395-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RO-rJfmVyY5-5Oky5Dcqs3WCcG9A3ixW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMiBTYWx0ZWRfX7gHUnQwBSAru JimtTkwOFcoyRpPFvZkpt08xNVH8Vxf3Wwcf4LtoW33iHm+544PLi6MwD0DI3SDeAmDXCl7tO5V tCBqOwrenRXm3YiZFczzbLEoffb/cqPYQ8Sko7TgpGxhq+m9Z0BQPNoUm1hbve+T97HZLAoB76U
 N5GdiR0aQW2tUMWyFtB0DxRCzAj1eN6AC+rr4SvnutaVUMJzskxW4s0N14Yx35kp8d5h69MfMed qe5Us42IZ9qeEvpSR6DtGiTRX9EMkW5yfm6tdr5S1DeuTpwIiuutyquiAO4vJP0QT6Yc80UJeRm i6NfJgAiy1K7pAHMwGI30eTz4hKTu0Dc3DxOw7v9GSxV+pljKYVins9DL5SdnClJX10qNcO3mpc
 2Yt/dx89Yk/LswrYLE9rAVTm/UOpJRNGxtMWbFLI+bfa6o253MfAXlV3MY4uP4gRjCsnt4Pd
X-Authority-Analysis: v=2.4 cv=BKSzrEQG c=1 sm=1 tr=0 ts=688b8635 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Udg8XZZ2YZ10bUHcV_QA:9
X-Proofpoint-GUID: RO-rJfmVyY5-5Oky5Dcqs3WCcG9A3ixW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01

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

