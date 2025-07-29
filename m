Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8D156C6A
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799705; cv=none; b=VzmM7SQVRedbtzWEJMtVq4/g8og9PtIzedPRpQ3ccsHZuwLzZvpKwQ5R+He836+CV+aaueByhQIj3fouCHFo/IyOMPNfcyCJE3MrInj2ahG8oTEswXSxsaOyGCeI748cvgawv70O4jIywuEPxpISmdyWe8AGeozldiiAiWA00gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799705; c=relaxed/simple;
	bh=u5o3RhspqkfHPuml2GBMKkN6r5ijrXyG4zUtonlJcck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAwFqMcl6UFm+Zy6eTdztN5go6PnTI3oXE4jkpTIxnrtK5buxyInRN6/D9V0W/7Z0toNFarfph3BftUbRLBDpZzCVKT6rKzOimW+74GJ11G7f1/g10TS3zXzmRwFTvbrN6uLHUqilJrvAEn0wvEx48E17QZdLvYR7XglgwhT75M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=C0gDCf+s; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="C0gDCf+s"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T6Xuab006367
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 07:35:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ygphMWvAPZzH8NDnv0HqS/6M7HTBMhdXRZqUAEkSfW8=; b=C0gDCf+sB/a8
	gJsrHYWf8+bKJKbACHEjGljKQfRpyuCPjAnrNywF6jtf4OrwJ/CyZo+9+ARpNFAC
	TE4/x+mFyoGKivffW3yNL2o9/KM2k4/P9S+7UI/wk4SouWD9vAS8CBE7ROt/9w80
	v2Ch3CS+8Eik6MPFBwoJmZRZaFSBScRkrxE8dkvexv8OGjizlbOr2gPf58y5a/uq
	KrCE6E6YWxRu0R8fGUxL0D4NKla0MzO8Wp7NTsEQdQXwYF5NquR0tnle6GfVSPUZ
	c3CniFKg24GFoCXLKGHfaN6TEzZaT5UN1SnIIUn729RW9AA3Fq+KWq6Dsq0RoPgG
	njLUC8RcGg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 486ne9kgej-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 07:35:02 -0700 (PDT)
Received: from twshared57752.46.prn1.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 29 Jul 2025 14:34:56 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 2F3EE1CC4204; Tue, 29 Jul 2025 07:34:45 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 3/7] blk-mq-dma: require unmap caller provide p2p map type
Date: Tue, 29 Jul 2025 07:34:38 -0700
Message-ID: <20250729143442.2586575-4-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=JPs7s9Kb c=1 sm=1 tr=0 ts=6888dc16 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=lg-0pX42I_tHtCv8E8UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExMiBTYWx0ZWRfXyzkKhC0GWSHX jFfQf1CeZlNhy/zO9yl0T8nG3zSKqjMGt2KrugnFwVi8Bk9tOTUFxs5iIqlNFNcrRFnJQlwreqI wxaiACJcOpUPsHEINg9Xv+USUqLQygsoWsJ1oqxswNn2l+aQZ2x4LYXAYKWo/H61+x035b3mzve
 Zy3cJGWCJjDYsZFJEBdVuURe30BVNJle63/8FxWWEkVgRrU+mkGYpVohLb67PjpuI2oo80V8a1Y ih72Cz2TYggdwyrZOP15cgR8QEVbv5qVPJF/MGUR2h99ltrUbAX7QFLSxhQ0qgjfeNV/d6Ptboc QhyPvIBYLZNeTOysfTSo52P22keNiFiOHdbb/I+99GhwCeto+XK4tp2w21y0yIbowOViDsgk8K8
 YwlC6KCgrrB9pCw53OvQXTi8UluBBRR2ii36urN6pm0XmDcU/dNtXnY7TdjdfRGaon2UTtVT
X-Proofpoint-GUID: myGQwbkvJ4UVk4FXscL7Y0hXKJKeD9FJ
X-Proofpoint-ORIG-GUID: myGQwbkvJ4UVk4FXscL7Y0hXKJKeD9FJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

In preparing for integrity dma mappings, we can't rely on the request
flag because data and metadata may have different mapping types.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c    | 9 ++++++++-
 include/linux/blk-mq-dma.h | 5 +++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 071efec25346f..6cefa8344f670 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -261,6 +261,9 @@ enum nvme_iod_flags {
=20
 	/* single segment dma mapping */
 	IOD_SINGLE_SEGMENT	=3D 1U << 2,
+
+	/* DMA mapped with PCI_P2PDMA_MAP_BUS_ADDR */
+	IOD_P2P_BUS_ADDR	=3D 1U << 3,
 };
=20
 struct nvme_dma_vec {
@@ -725,7 +728,8 @@ static void nvme_unmap_data(struct request *req)
 		return;
 	}
=20
-	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
+	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len,
+				iod->flags & IOD_P2P_BUS_ADDR)) {
 		if (nvme_pci_cmd_use_sgl(&iod->cmd))
 			nvme_free_sgls(req);
 		else
@@ -1000,6 +1004,9 @@ static blk_status_t nvme_map_data(struct request *r=
eq)
 	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
 		return iter.status;
=20
+	if (iter.p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
+		iod->flags |=3D IOD_P2P_BUS_ADDR;
+
 	if (use_sgl =3D=3D SGL_FORCED ||
 	    (use_sgl =3D=3D SGL_SUPPORTED &&
 	     (sgl_threshold && nvme_pci_avg_seg_size(req) >=3D sgl_threshold)))
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index c82f880dee914..aef8d784952ff 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -49,14 +49,15 @@ static inline bool blk_rq_dma_map_coalesce(struct dma=
_iova_state *state)
  * @dma_dev:	device to unmap from
  * @state:	DMA IOVA state
  * @mapped_len: number of bytes to unmap
+ * @is_p2p:	true if mapped with PCI_P2PDMA_MAP_BUS_ADDR
  *
  * Returns %false if the callers need to manually unmap every DMA segmen=
t
  * mapped using @iter or %true if no work is left to be done.
  */
 static inline bool blk_rq_dma_unmap(struct request *req, struct device *=
dma_dev,
-		struct dma_iova_state *state, size_t mapped_len)
+		struct dma_iova_state *state, size_t mapped_len, bool is_p2p)
 {
-	if (req->cmd_flags & REQ_P2PDMA)
+	if (is_p2p)
 		return true;
=20
 	if (dma_use_iova(state)) {
--=20
2.47.3

