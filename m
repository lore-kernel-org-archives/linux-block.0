Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E255288C25
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006865; cv=none; b=RYkL/2BRCeZNcVOpL/apuwmE7Ni8XR0Wu8Zc83AF+V/Fu64saUMQuZm4+7M3SNv9eYSbFQVeB34kWZP16nMR/VHCuZAerwyroFJa4z8wJbTcJ5w4cdsTYzcQyVLKgDoN7a4emtPk5yh9Pi8RRYdpczcbvSCLJk+k6MSHNFJUNDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006865; c=relaxed/simple;
	bh=JzMbqLPP/dhbF4+Dq6IscHG82XpeLYbfWBHfjCfIN6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FM54O8s2c3UUF2sJpC9dZ53gk2asdTNhsubOBQi2xk/U1ID/kpBymozfGPAHjKKWVDHYz+TzXfwM3Ow9dCEJQAKDeYFhp4pz2n8JLWo6eQ2E7fWUefDiCOyu5vBqecFet9yvLVBjfGh2xPPICWO4LIrvF3BlBNG8F7tvtk3eJ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RZfdn/+x; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RZfdn/+x"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDpjkn006845
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 06:54:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=oZjy9qmDyJ9N8Kjq9alhx8rDCTwySWdnaJuLkKVMHfU=; b=RZfdn/+xXo1u
	oEQmi/YBa3Jv3XfPzRXm5bdY9cpt7PdoEDbyd+AcahUI1dILEN1+6ZED0xqPAy1u
	onZioK0t0KC6YlO0Oj4xiMwh1AEN3d15Gmg0W12WtLocezGTSm+TNE6qCxSziGmy
	vUNXGtoarH7lLzpcyvHZ7dA6vK4tJNzEECltreVIMx1okdBHX0ZyVNoUaI96lPAK
	t746u7Y126uVwn7A822ac6N4w1J/ym2qHwKHYdwqEhFZ80RfSOWqp7pOJHGf5UsS
	XKXktY3pt0I9YkDL7DyA3Rc37WqmYVk0z0B/8igji9bIhyYdjrOKqG9xWiyIjKyS
	7TM/5Ih1PA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48g120b14n-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 06:54:22 -0700 (PDT)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 12 Aug 2025 13:52:23 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id DE3A08D4081; Tue, 12 Aug 2025 06:52:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv6 7/8] nvme-pci: create common sgl unmapping helper
Date: Tue, 12 Aug 2025 06:52:09 -0700
Message-ID: <20250812135210.4172178-8-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=KJdaDEFo c=1 sm=1 tr=0 ts=689b478e cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=r3bDFXGCrlSiSwDhwTUA:9
X-Proofpoint-ORIG-GUID: 5jhRMmn3gyeAo3cnwp5ooFuQ01rT0Fo6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzNCBTYWx0ZWRfX32GPWtHCWxmX FFNopXRGpkdd1sdc28rdDwn4hivJ1Z/qTDoZJvDYLhRiWfsIp9pGSI+GlWn/gNP5Wr74PDQW6oi t6HXhj7XOsgfJWl7+7cQVDzmpNF98yQYpCqydxyEBZfhjInrNidlDalU8EY9HumWFAtnHP193rP
 3l1oTYb5/x/K72xc9h9FXcJ6UflbITohA84PJ18qPAkt59xHPPH7qnDyIs07YRzJ36cxUcP+A2m KAgDEDQ0heFR6djamZY1rGkqwL7KPB9JE/k/s4zt53AvPYs3yzKlQdWkZtKEPdETl8RQm3zcMdl Kzqv21w52D/cy6VX5V62CF0D6LjtR7Fdgrtq5KEV4cjfFK44tpeKef5/ijk4MOW2WqVI0QuGpxK
 MtdXq8tBUyj1djkdSvw4GCDSR426MlYoU1FNaXiY99FzJiY1BtGNMafY11aXT3oC9+0vyscW
X-Proofpoint-GUID: 5jhRMmn3gyeAo3cnwp5ooFuQ01rT0Fo6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

This can be reused by metadata sgls once that starts using the blk-mq
dma api.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 111b6bc6c93eb..2b89e74d1fa73 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -693,25 +693,33 @@ static void nvme_free_prps(struct request *req)
 	mempool_free(iod->dma_vecs, nvmeq->dev->dmavec_mempool);
 }
=20
-static void nvme_free_sgls(struct request *req)
+
+static void __nvme_free_sgls(struct request *req, struct nvme_sgl_desc *=
sge,
+		struct nvme_sgl_desc *sg_list)
 {
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
-	struct device *dma_dev =3D nvmeq->dev->dev;
-	dma_addr_t sqe_dma_addr =3D le64_to_cpu(iod->cmd.common.dptr.sgl.addr);
-	unsigned int sqe_dma_len =3D le32_to_cpu(iod->cmd.common.dptr.sgl.lengt=
h);
-	struct nvme_sgl_desc *sg_list =3D iod->descriptors[0];
 	enum dma_data_direction dir =3D rq_dma_dir(req);
+	unsigned int len =3D le32_to_cpu(sge->length);
+	struct device *dma_dev =3D nvmeq->dev->dev;
+	unsigned int i;
=20
-	if (iod->nr_descriptors) {
-		unsigned int nr_entries =3D sqe_dma_len / sizeof(*sg_list), i;
-
-		for (i =3D 0; i < nr_entries; i++)
-			dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
-				le32_to_cpu(sg_list[i].length), dir);
-	} else {
-		dma_unmap_page(dma_dev, sqe_dma_addr, sqe_dma_len, dir);
+	if (sge->type =3D=3D (NVME_SGL_FMT_DATA_DESC << 4)) {
+		dma_unmap_page(dma_dev, le64_to_cpu(sge->addr), len, dir);
+		return;
 	}
+
+	for (i =3D 0; i < len / sizeof(*sg_list); i++)
+		dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
+			le32_to_cpu(sg_list[i].length), dir);
+}
+
+static void nvme_free_sgls(struct request *req)
+{
+	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct nvme_sgl_desc *sg_list =3D iod->descriptors[0];
+	struct nvme_sgl_desc *sge =3D &iod->cmd.common.dptr.sgl;
+
+	__nvme_free_sgls(req, sge, sg_list);
 }
=20
 static void nvme_unmap_data(struct request *req)
--=20
2.47.3

