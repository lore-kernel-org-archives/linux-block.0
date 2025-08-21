Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A91435FC1D
	for <linux-block@vger.kernel.org>; Thu, 21 Aug 2025 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755809070; cv=none; b=KpohYdXmL2r5FpCplpqv5/aRRwa6lOWM2oZ4mpdv4+faNBVJmT4fz+mgejISSoOR9iAOQkHQZlW/ByOicjVqiXuAwCpv7vQn/KRMlgkR/Qqa1xBINr1/Sa+Aljg7yqJdEKAxzBMETzzVQU9BpF76JiDoTVrbOhROf/3cH+kEA/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755809070; c=relaxed/simple;
	bh=X0odbx0mjTZvAvW5z57Iqzp48R5SMyQ0Q6vD+D8nUN4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5isCrtybAmC5XmXBziGHyGrGGxaGfNo8Muer623ji+5HLYiBxTAi5giCY3Z1U6h0zlasLss2A0jsNykVva5brhQRszV36lx8Xk9cqD89UEGK46n+ujMjI31SvyEehwwBdtkwUFIw4Xh80VdsS7SxK7/1HnTXqsqUmBCTW330t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=YOPqtQMw; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YOPqtQMw"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57LKUBLx016918
	for <linux-block@vger.kernel.org>; Thu, 21 Aug 2025 13:44:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=SpF7gDfNfdb16tfYdO08gdnfGgq/XJWxuudJ21yq/RA=; b=YOPqtQMwVkCo
	DauA3wSxahwIFVEYxMpQM4G+cK5XYqamIaVEjqHPFF2hgaq7gf7oFqAiWreLsiaX
	8cVFrp5KcH3BuFWWZ1a9nuhBZHPs2jf8wNOFptBjRnaH+jjDDbsyxqjvCuNkv2HQ
	FsMZlI/eTRVn0hSTEI/MMyzlENWGEMMP302efNd4shAx6H94lnTuEkfHqhdjE6zy
	zu6JxfnaSJUexkcMOz+78cal3aitn68mkxOuygKKXs6D5FOoQRvrlbsYEwSkdpp0
	ciRHhxMGv1uwG/lmwXoDMWHP9anS/LwmxaHerOOncONpnSZVATVp3VaxEdP15Xxc
	x7qx9wIHvQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48p6fcjc6k-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 21 Aug 2025 13:44:28 -0700 (PDT)
Received: from twshared17671.07.ash8.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 21 Aug 2025 20:44:27 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 36A03DAAF51; Thu, 21 Aug 2025 13:44:23 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 2/2] nvme: remove virtual boundary for sgl capable devices
Date: Thu, 21 Aug 2025 13:44:20 -0700
Message-ID: <20250821204420.2267923-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250821204420.2267923-1-kbusch@meta.com>
References: <20250821204420.2267923-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fKQPHXpa-oXV3st6cISz08mlyMAvwEv5
X-Authority-Analysis: v=2.4 cv=SayutvRu c=1 sm=1 tr=0 ts=68a7852c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=DE5RKVN6jYQ7jVVW-c4A:9
X-Proofpoint-GUID: fKQPHXpa-oXV3st6cISz08mlyMAvwEv5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDE3NyBTYWx0ZWRfX+IBQS1Bvd2VY
 RimZcu1SJ7Oh6wMWhZs0MU6bGR7lzIqhm0w0uhrWIciKYwtrJod3H3aO1x08UytjEv1rRJHtPli
 CQ6S2Sh/FpJJy1EBAvwXvfC2nLuvuNXvWYN7F6Pzonft3R1eH0XZ+J4Q/LDdMvKMwng0mUnUfvP
 u2JW0fd3HAog9QS6TuZ4lc/AJUhdK4HI3EQQmssp58CmWsfWkx46GVhnMefXCZutqBKIl4NIhtK
 DFM60NHWJVVxWcI0c+6P4tl297c86McH4HMblcpxchyZPo3cNV2U+9oS/mZ8NJ/vMyEIiNnBnE0
 h95s53neXEt6MOWhT331eu59tdnr86hY6mYIVXVY6MKMn5YAtdVQaLtan9atzyT65D5yeVX8Zj0
 vTrdlueJLqn1Q9COrQcnSUVc5y191jUK22wrJ0anRsLuDsO6N7rlvfpL8AQbdiIWfbDsmDOi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The nvme virtual boundary is only required for the PRP format. Devices
that can use SGL for DMA don't need it for IO queues. Drop reporting it
for such PCIe devices; fabrics controllers will continue to use the
limit as they currently don't report any boundary requirements.

Applications may continue to align to the same virtual boundaries for
optimization purposes if they want, and the driver will continue to
decide whether to use the PRP format the same as before if the IO allows
it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 21 ++++++++++++++++-----
 drivers/nvme/host/pci.c  | 16 +++++++++++++---
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 812c1565114fd..cce1fbf2becd8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2065,13 +2065,24 @@ static u32 nvme_max_drv_segments(struct nvme_ctrl=
 *ctrl)
 }
=20
 static void nvme_set_ctrl_limits(struct nvme_ctrl *ctrl,
-		struct queue_limits *lim)
+		struct queue_limits *lim, bool admin)
 {
 	lim->max_hw_sectors =3D ctrl->max_hw_sectors;
 	lim->max_segments =3D min_t(u32, USHRT_MAX,
 		min_not_zero(nvme_max_drv_segments(ctrl), ctrl->max_segments));
 	lim->max_integrity_segments =3D ctrl->max_integrity_segments;
-	lim->virt_boundary_mask =3D NVME_CTRL_PAGE_SIZE - 1;
+
+	/*
+	 * The virtual boundary mask is not necessary for PCI controllers that
+	 * support SGL for DMA. It's only necessary when using PRP. Admin
+	 * queues only support PRP, and fabrics drivers currently don't report
+	 * what boundaries they require, so set the virtual boundary for
+	 * either.
+	 */
+	if (!nvme_ctrl_sgl_supported(ctrl) || admin ||
+	    ctrl->ops->flags & NVME_F_FABRICS)
+		lim->virt_boundary_mask =3D NVME_CTRL_PAGE_SIZE - 1;
+
 	lim->max_segment_size =3D UINT_MAX;
 	lim->dma_alignment =3D 3;
 }
@@ -2173,7 +2184,7 @@ static int nvme_update_ns_info_generic(struct nvme_=
ns *ns,
 	int ret;
=20
 	lim =3D queue_limits_start_update(ns->disk->queue);
-	nvme_set_ctrl_limits(ns->ctrl, &lim);
+	nvme_set_ctrl_limits(ns->ctrl, &lim, false);
=20
 	memflags =3D blk_mq_freeze_queue(ns->disk->queue);
 	ret =3D queue_limits_commit_update(ns->disk->queue, &lim);
@@ -2377,7 +2388,7 @@ static int nvme_update_ns_info_block(struct nvme_ns=
 *ns,
 	ns->head->lba_shift =3D id->lbaf[lbaf].ds;
 	ns->head->nuse =3D le64_to_cpu(id->nuse);
 	capacity =3D nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
-	nvme_set_ctrl_limits(ns->ctrl, &lim);
+	nvme_set_ctrl_limits(ns->ctrl, &lim, false);
 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm, info);
 	nvme_set_chunk_sectors(ns, id, &lim);
 	if (!nvme_update_disk_info(ns, id, &lim))
@@ -3580,7 +3591,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctr=
l)
 		min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
=20
 	lim =3D queue_limits_start_update(ctrl->admin_q);
-	nvme_set_ctrl_limits(ctrl, &lim);
+	nvme_set_ctrl_limits(ctrl, &lim, true);
 	ret =3D queue_limits_commit_update(ctrl->admin_q, &lim);
 	if (ret)
 		goto out_free;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d8a9dee55de33..6e848aa4531b6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -619,9 +619,19 @@ static inline enum nvme_use_sgl nvme_pci_use_sgls(st=
ruct nvme_dev *dev,
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
=20
 	if (nvmeq->qid && nvme_ctrl_sgl_supported(&dev->ctrl)) {
-		if (nvme_req(req)->flags & NVME_REQ_USERCMD)
-			return SGL_FORCED;
-		if (req->nr_integrity_segments > 1)
+		/*
+		 * A request with page gaps within the controller's mask can
+		 * not use the PRP format.
+		 *
+		 * We force user commands to use SGL because that lets the
+		 * device validate the requested transfer lengths.
+		 *
+		 * Multiple integrity segments must use SGL as that's the only
+		 * way to describe such a command.
+		 */
+		if (req->page_gap & (NVME_CTRL_PAGE_SIZE - 1) ||
+		    nvme_req(req)->flags & NVME_REQ_USERCMD ||
+		    req->nr_integrity_segments > 1)
 			return SGL_FORCED;
 		return SGL_SUPPORTED;
 	}
--=20
2.47.3

