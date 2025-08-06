Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678DA1D88D0
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491916; cv=none; b=MKBM+29jL9fi0dF+ecEoC1K/gi31tHJv6bSuaOquc1ahWXQBEuMnn1E2eC2ItaODauF9yDKit3Rvv57FKCBXWFE5kfOUuWG8kx3XOZNQ4OV1N0Vojc2hst0g4Xa7QKfVHJUY69c7sfZp10nIIJEDvG0NdyMxPvyP/7CqpUJez7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491916; c=relaxed/simple;
	bh=crQ0edu59VV64K0posb+TKKkZ81ksybhftCDeUUjJAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcMWq6LctGgr9MrDR5zcujZTCv1QTo2MZX9TLVGIs7IZNWMk0EJB7yws/fILt152orNQFuKZPHcp0bm3yc8X+n+gyDQ6dRQMqYj/zD+glNF/NhWL4QZ+lNMtulYUOGzK/Pye/JNqXHtVNk/aCgNAx08wq9YQhk/lNhTA3aaZf1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Qu1reuk6; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Qu1reuk6"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5764kiPt031067
	for <linux-block@vger.kernel.org>; Wed, 6 Aug 2025 07:51:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=OR8V1g2kekJLUt4/olLqEFa65962gjh4uVi0h4g0s9I=; b=Qu1reuk6yYvq
	smkiNPXKnsO2bPuYSz+/gdYKZEzZr/Hdv9nhzcW6VcyjdKEYZcXBICU9L9dJzSHP
	O9IiQF0DOHNS/ku6Mm6A5a1Ad0mNpgPsy2d9o5rMia/1+OvVvzTa1pXa3REnr1lL
	+lHtEjAqKRqh20CpsNMkxXWwWwdA6RIBg/GuxJdTURuKyY7z8RJSKTBL6B90K8j/
	MIvdN98XfZfoScaKGYtqhHChRIi7BpddddNfIqP3NEY2K4D4ng0cbEVf64OY3Mip
	oRO+luABc9rwBAHAsyECUmKrY/BRF6zbAIZvOKpV42shvE25Fwokbxe1BaJvc/yO
	9m4j6PyyZg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48c0aqk7gg-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 06 Aug 2025 07:51:52 -0700 (PDT)
Received: from twshared25333.08.ash9.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 6 Aug 2025 14:51:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id EC33059F463; Wed,  6 Aug 2025 07:51:37 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/2] nvme: remove virtual boundary for sgl capable devices
Date: Wed, 6 Aug 2025 07:51:36 -0700
Message-ID: <20250806145136.3573196-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250806145136.3573196-1-kbusch@meta.com>
References: <20250806145136.3573196-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: V0gFNvihWGFWdY-HYJf0CnzIak1MMJr6
X-Authority-Analysis: v=2.4 cv=duHbC0g4 c=1 sm=1 tr=0 ts=68936c09 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=fOxSldyNN8qU9nhN34UA:9
X-Proofpoint-GUID: V0gFNvihWGFWdY-HYJf0CnzIak1MMJr6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5MiBTYWx0ZWRfX4qqawTmJKuGG 8b5pJ0dhFA9a6QkfX5Di1yVK6urHZ24pHtk7m+WZInnUnRhwilRqxzsM53flSyb4rtjqm8APBWT ea1nVUHdeMi1Y0xPz6P+s8sj6hMgR6usBvTmxJ9k6DCRBajQWnkhEAm+ghJpqtaHBgZo/vsWkXF
 oLwG9Ru7dMUvPsJNJgD2kUciioOFyrIPwNBT00yrX5OKhKBh9nBb+z8fLu2qVMCn3XP7YjJ2qQQ QPXsE8879osp5239uprBRqaxmmH9w5lV35l3dMHo5CFKwfG26nMYuX6WdGTlDen+3xLfsjintm7 DXcI3FSXhCe3Dk7ocxsBh3DbPUkNrxw0Ydi6oiMGl3VthIDmJSSlrs3k96F1mrDkjDElOfSYFHq
 5DKpS6xtyF1ZfK3mdg1uuikr3scW4vsNQw9+5rGdZWRwYOI8CWXYij1VxBLQQOELJyOJPDnR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The nvme virtual boundary is only for the PRP format. Devices that can
use the SGL format don't need it for IO queues. Drop reporting it for
such PCIe devices; fabrics target will continue to use the limit.

Applications can still continue to align to it for optimization
purposes, and the driver will still decide whether to use the PRP format
if the IO allows it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 15 ++++++++++-----
 drivers/nvme/host/pci.c  |  6 +++---
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 812c1565114fd..39c74e3a18a04 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2065,13 +2065,18 @@ static u32 nvme_max_drv_segments(struct nvme_ctrl=
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
+	lim->max_segment_size =3D UINT_MAX;
+	if (!nvme_ctrl_sgl_supported(ctrl) || admin ||
+	    ctrl->ops->flags & NVME_F_FABRICS)
+		lim->virt_boundary_mask =3D NVME_CTRL_PAGE_SIZE - 1;
+	else
+		lim->virt_boundary_mask =3D 0;
 	lim->max_segment_size =3D UINT_MAX;
 	lim->dma_alignment =3D 3;
 }
@@ -2173,7 +2178,7 @@ static int nvme_update_ns_info_generic(struct nvme_=
ns *ns,
 	int ret;
=20
 	lim =3D queue_limits_start_update(ns->disk->queue);
-	nvme_set_ctrl_limits(ns->ctrl, &lim);
+	nvme_set_ctrl_limits(ns->ctrl, &lim, false);
=20
 	memflags =3D blk_mq_freeze_queue(ns->disk->queue);
 	ret =3D queue_limits_commit_update(ns->disk->queue, &lim);
@@ -2377,7 +2382,7 @@ static int nvme_update_ns_info_block(struct nvme_ns=
 *ns,
 	ns->head->lba_shift =3D id->lbaf[lbaf].ds;
 	ns->head->nuse =3D le64_to_cpu(id->nuse);
 	capacity =3D nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
-	nvme_set_ctrl_limits(ns->ctrl, &lim);
+	nvme_set_ctrl_limits(ns->ctrl, &lim, false);
 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm, info);
 	nvme_set_chunk_sectors(ns, id, &lim);
 	if (!nvme_update_disk_info(ns, id, &lim))
@@ -3580,7 +3585,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctr=
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
index 4a23729f399ac..3da9e4a584682 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -619,9 +619,9 @@ static inline enum nvme_use_sgl nvme_pci_use_sgls(str=
uct nvme_dev *dev,
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
=20
 	if (nvmeq->qid && nvme_ctrl_sgl_supported(&dev->ctrl)) {
-		if (nvme_req(req)->flags & NVME_REQ_USERCMD)
-			return SGL_FORCED;
-		if (req->nr_integrity_segments > 1)
+		if (blk_rq_page_gaps(req) & (NVME_CTRL_PAGE_SIZE - 1) ||
+		    nvme_req(req)->flags & NVME_REQ_USERCMD ||
+		    req->nr_integrity_segments > 1)
 			return SGL_FORCED;
 		return SGL_SUPPORTED;
 	}
--=20
2.47.3

