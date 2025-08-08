Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C3286894
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668726; cv=none; b=SPwc+1bszeOXXurGNr3RFzeIaCGQM7jiHGD208zt6ISvd/AefR2dPpICAzjhhIt0okOP71kDu+VMz4O3PPj2I+a/2EeFj4sXwmeJKHihmqwvFbVIWrV5iqDSd/GoGW3rns7nVNVcm/IBGhvR0HGJcc7gRUsel7lhevEGmgJ/11E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668726; c=relaxed/simple;
	bh=SulBtO2WLEB8yiWxu8UJufeMcebtOml0MbwG57EqkZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrEfOlIytsT63AoieiHL7DJIQqGQBqwGPrEYHsSY8+ABOytMvFVDIk8UFcWj5lqcOmLL7AgiMDF8wlTchY05SMOq/W8rjEzSy0nBerksb4iyjdmKDPdObcUxC7EW4HFrLmCToUDbfphdnjUXQkn5E26UKxpwkHhfnnZoTC2zun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=PF4dCi34; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="PF4dCi34"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578FKBbO021638
	for <linux-block@vger.kernel.org>; Fri, 8 Aug 2025 08:58:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ut48uWJtSD/GPhmg0N8X2KhVkgcEnwTLCf0dr8KqeYs=; b=PF4dCi34NY3M
	3tBLEaduklOMj6PpW70+ioKg4hR/Da/syL7aE6Vzts9WCzPHiEJ5+Y1paBj4nDJc
	JLanF1uzXhAqbkadt2D2Xq6C5/5agokXAMue7zHkYlt8I2s+vQsPkb7+u9pf7gcB
	6x2chywrxU69TjbGX7o0tpSJDZPXQoZZ4lReYEcdOAszdVLzcNxrDtz1pcTMGK7o
	ytxlHswOzSX0975M8linJkgVnAMjODkT3tZi8HIVketofseTMVbIxGhh0mG4BC4e
	ZvrA/FX99IBBO/woiRoSY6uqitkgrSlNsw9EQ2WlCf83modLIDeoNsMIJm9OkCrk
	afW2RHfZ3Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48dbwck3f3-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 08 Aug 2025 08:58:44 -0700 (PDT)
Received: from twshared60001.02.ash8.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 8 Aug 2025 15:58:36 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 422316C76CC; Fri,  8 Aug 2025 08:58:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 7/8] nvme-pci: create common sgl unmapping helper
Date: Fri, 8 Aug 2025 08:58:25 -0700
Message-ID: <20250808155826.1864803-8-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyOSBTYWx0ZWRfX94H+IekrtFbw NWe7nnntXKB5ru5aa9A4mgYX+AuQt8rL7Cz0Q2vlrs+Pp4T9/ozAkZbiDlq7rhoSfrvrjBZLERb 5Wq5nIMGoONkVeAu+l3qCxgSDj26nEbR0tQ5p+id+gnVpVWMg5v4gcmpQmqqpZKI0NVDeInIZQz
 itxo1hrW+LpEQ9lgM/z1M8uPJ3Is/NBxnJopZjjq/aaXDnHZ7wZnVtKSEyrUBa0ma4QbTjBwUYW Hm9Oljj/LOiDam6/DNQJ4L6smLXr4q8SD606lQwNGpygkXBMkuSj18a/FAIW1zh3ogi5b0yXZGe Kp9G5CipPJJFzpeR4cSpA7A9T7UsP3idRMgTbLt5GjGQNe0S5amjhaOEdS/YLLT6qQ/0JvFb8OY
 q354wfhxmolO+Oz5MZyh6dOK0ENNvAIWwYn0RwB6INooMW1ht9rk0MdZVaWmOKYJs4hFT636
X-Proofpoint-GUID: o6am4UR5hfZeHt49Fr7BO6rzXlD11YAY
X-Authority-Analysis: v=2.4 cv=DthW+H/+ c=1 sm=1 tr=0 ts=68961eb4 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Duz19Zw78js5DzQJfkIA:9
X-Proofpoint-ORIG-GUID: o6am4UR5hfZeHt49Fr7BO6rzXlD11YAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

This can be reused by metadata sgls once that starts using the blk-mq
dma api.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 111b6bc6c93eb..decb3ad1508a7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -693,25 +693,34 @@ static void nvme_free_prps(struct request *req)
 	mempool_free(iod->dma_vecs, nvmeq->dev->dmavec_mempool);
 }
=20
+
+static void __nvme_free_sgls(struct device *dma_dev, struct nvme_sgl_des=
c *sge,
+		struct nvme_sgl_desc *sg_list, enum dma_data_direction dir)
+{
+	unsigned int len =3D le32_to_cpu(sge->length);
+	unsigned int i, nr_entries;
+
+	if (sge->type =3D=3D (NVME_SGL_FMT_DATA_DESC << 4)) {
+		dma_unmap_page(dma_dev, le64_to_cpu(sge->addr), len, dir);
+		return;
+	}
+
+	nr_entries =3D len / sizeof(*sg_list);
+	for (i =3D 0; i < nr_entries; i++)
+		dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
+			le32_to_cpu(sg_list[i].length), dir);
+}
+
 static void nvme_free_sgls(struct request *req)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
 	struct device *dma_dev =3D nvmeq->dev->dev;
-	dma_addr_t sqe_dma_addr =3D le64_to_cpu(iod->cmd.common.dptr.sgl.addr);
-	unsigned int sqe_dma_len =3D le32_to_cpu(iod->cmd.common.dptr.sgl.lengt=
h);
 	struct nvme_sgl_desc *sg_list =3D iod->descriptors[0];
+	struct nvme_sgl_desc *sge =3D &iod->cmd.common.dptr.sgl;
 	enum dma_data_direction dir =3D rq_dma_dir(req);
=20
-	if (iod->nr_descriptors) {
-		unsigned int nr_entries =3D sqe_dma_len / sizeof(*sg_list), i;
-
-		for (i =3D 0; i < nr_entries; i++)
-			dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
-				le32_to_cpu(sg_list[i].length), dir);
-	} else {
-		dma_unmap_page(dma_dev, sqe_dma_addr, sqe_dma_len, dir);
-	}
+	__nvme_free_sgls(dma_dev, sge, sg_list, dir);
 }
=20
 static void nvme_unmap_data(struct request *req)
--=20
2.47.3

