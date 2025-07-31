Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FC781E
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974323; cv=none; b=nfxSmxQgXSq6shDry7h+rmpKtZkCgFgDIMHqk6xF8rLRRCKx7InUiMIjcEus9AX6HLNFZYLmlk9c8OOuAlVyqojXBMjea0H+17r7eaJMCgHiyUHYC0RqhRCzJUXoDBZzkFmYPwfUlIEfoRdMsSzjmFwAOVqzvG6gYLnSgTmoHXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974323; c=relaxed/simple;
	bh=SulBtO2WLEB8yiWxu8UJufeMcebtOml0MbwG57EqkZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0POBedUxdeIzECM9R0P+0VQY9E+aEU7Al1dfB29S5oqx2+5FIiAdU0BtyUn1pXiFuNaR90gsjacd2ycTii2qw0B9g+RXT3lQpM13sbOGS9XQL7Ec+CbRyyx98PFXNu9P5zI8NuYLiP9NYQ1UhVRfigQ/Lh+1T6gb8LVn+0rYd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=F5aCkAL9; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="F5aCkAL9"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VE75KM029919
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ut48uWJtSD/GPhmg0N8X2KhVkgcEnwTLCf0dr8KqeYs=; b=F5aCkAL9D/5o
	jwa0c1BJg3mcCiFfIJ4rYualp1lVHBnu/LVZpyJpKHIW2rVMiekhrtC96l9zr8Fc
	oKPQZDI1E76iH+M4vZd3tB68vKwH//GX0xJGHjoCdwH/szIAJCh3w0eYpN+OXD9k
	OcKNoyqen/neh5ntzXKgZWcn0UUTzo9KuB10RIVkyqshoWw1fe+dDgYg31Z5sk/G
	6+GdF4Ie7lWiQ/7bJWOZXT/VetARje1mOD36yh6p3u57wqOZXTRYCXktMViYzsMJ
	oB/mFyNvgnxbw3I2ovBfoJebyaN+cpZD7cG5DY15a3y35J8CrwaIKMWgiQxP5PfS
	lksKAOWxog==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4883m52mb3-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:19 -0700 (PDT)
Received: from twshared21625.15.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 31 Jul 2025 15:05:18 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 2C638231DB3; Thu, 31 Jul 2025 08:05:14 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 7/8] nvme-pci: create common sgl unmapping helper
Date: Thu, 31 Jul 2025 08:05:12 -0700
Message-ID: <20250731150513.220395-8-kbusch@meta.com>
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
X-Proofpoint-GUID: GFjjlWlg59KAsmGT080cWsk0gvB_xdqN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMiBTYWx0ZWRfX49+OJjMbqrXb 5gQ76h5WCMrqZJQbzD8dDJZP3LiICmsgM3oJ+Vs2Wz1E3SX0t4h/RBflw9VX4JfM3wm6zF1wodT HNx8qifFapARORyPfQKMKjzV09EKhrrW2X1bTDBiqh3cRUWGv8AF61fjYm9xIoBEmnynB+e9bvE
 4yR0nLy/coo2cpeMW5AXocjbtO4DtfQmdDiS81qCxWBNNZVLKgBW38EyTQhuNsrPeq08Op1BkSg gywNbAqfmFUO/XN/L9cFpf9xA4fNT98azGSVgg8dzrGFgpRHM0pXgGskQ3JfHCIlLmYJIBzXhDT uPbEpXV8A9V716cdUS7/Bjazh7uQJIHuAEgiG35pdvwqjU2MRGYeeVAn4wMVqVNALTyWzVWlonS
 w5Paz+P1Jxt/COShe2/7MOGGRVRjdSQL9ebmJgT+Ts1DYunOKGQYAS7KgExkJpPUTzfJPIRM
X-Authority-Analysis: v=2.4 cv=FNwbx/os c=1 sm=1 tr=0 ts=688b862f cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Duz19Zw78js5DzQJfkIA:9
X-Proofpoint-ORIG-GUID: GFjjlWlg59KAsmGT080cWsk0gvB_xdqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01

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

