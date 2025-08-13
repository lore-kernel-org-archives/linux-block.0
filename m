Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A57D1E570B
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099312; cv=none; b=a4VGZuSVWcANxIcNgLTwPla7PNiPqh2jXaWALPP0xdoscVjdYTxdIYhZ7I3fMFMNSH3rNWp0NjUKJ5l/9JHnsOJ3nTESYAYTOAB1ncsmvwk3tH7zk9GoBxjbjg1qqrIdp9T3yTjP6wF1nkZCIKG/uJfM08RgoOMLhYN+huwT89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099312; c=relaxed/simple;
	bh=J453WKSlqtPpf0Hq9cQ0qzPT7Ewtia+cpN/DrK1P0PA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emrVOS7C+0AXZlLlFs0AWdzo3uhCnOn+C6ArU9fLdqOxFEUyV7gU8Z9nuiY4ixYSDpoteX/uQnDsg6EAjKqyuOHDdRU+yTM4uFmkLUGSKgTav8TgYzGwhOqBBvs2EcC4ujSUqJXUVdmHuGVH7Loo0uVTb1yi3EZQX4jS5f3jtAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MSW7nBaI; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MSW7nBaI"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DFBl0h020987
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 08:35:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=+gyerWlCZzrYWnrBZKmzALwcarJOeB+Qemyc5hQMAHs=; b=MSW7nBaIGbx9
	+SGBr6FFP1xcdkKACqxX28X1a24n3fKuo9u8VHh6j4os9vBibSH9/kNZNHsjB1hk
	copdwdEpQejccWIK/UQGsgX4mWB5W32tPA1LNbuuQ3TBc4MtaPgTUBU0eqecmur6
	XqhEna/Gwmg6EXeMkPMlywE7Xvp4pqETfuDBC6rNxg7/vp4V2GbP9jrNAv9C7Mu1
	ZA3ooWxMltXo220THUK2tw8g9x6GB6YSqMlcmfavDpiwNw8Yt475fK16Wf2jmxG8
	ZsdF1FrUQz4y++wznqcoqSrUyigRSsyQ65QQvTo+zcE2NR/4qwN79ve+PUolwdw9
	PjardywWuQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48gt29hq71-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 08:35:10 -0700 (PDT)
Received: from twshared51809.40.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 13 Aug 2025 15:35:07 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 93E0F97CD8A; Wed, 13 Aug 2025 08:32:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv7 8/9] nvme-pci: create common sgl unmapping helper
Date: Wed, 13 Aug 2025 08:31:52 -0700
Message-ID: <20250813153153.3260897-9-kbusch@meta.com>
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
X-Proofpoint-GUID: FW2xGv6cp197CAV4UKxhZRzIMk0RU_UW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0NiBTYWx0ZWRfX98B0A0AM4dK4 uwBpYvBlCJJ53y7xhf2PqDWFVAR/D4ZyaTKevjYYRNd5CnklkT/YPGbptDP1iNUiOkUcOYQYiAn i8jB/qnPnXGrY/D7sDPVrFJn0jUWW57D7An4VMVhUTccTCWLdgaZJFLQ9f4B3nJFnKhi86pVa2E
 b+Ql0C7m8SkH6OvoJ6aYs4KDYUOpoxRyg0hmwE7Azssb+87P2GOqx6GfIwIFcSaV/jzmnTLe6oQ K9Pxg9EehtL1iZrlysvHJXaZnC6Cq/gpGFuTBCzpiJ5pglT0+3p/CQRjejpDV3c/wg5ce2ybiiw Zxk5SLoEdK+h4wQFUfocsxUq6i2gewFDORbShJ1iEVLABJYhwwUg70RmHnstNyDlgo02eKlzh+k
 wVT+1OsWNNkyGh8wP5aoOnkW4WKRArqRGA55/7ytUcMETtx3XXXhWvh5byfVZt4ZFzg7XUr3
X-Proofpoint-ORIG-GUID: FW2xGv6cp197CAV4UKxhZRzIMk0RU_UW
X-Authority-Analysis: v=2.4 cv=Oe+YDgTY c=1 sm=1 tr=0 ts=689cb0ae cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=n24e_ilN-p_VDh2xB_kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

This can be reused by metadata sgls once that starts using the blk-mq
dma api.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 111b6bc6c93eb..e12d47fecc584 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -693,25 +693,23 @@ static void nvme_free_prps(struct request *req)
 	mempool_free(iod->dma_vecs, nvmeq->dev->dmavec_mempool);
 }
=20
-static void nvme_free_sgls(struct request *req)
+static void nvme_free_sgls(struct request *req, struct nvme_sgl_desc *sg=
e,
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
 }
=20
 static void nvme_unmap_data(struct request *req)
@@ -731,7 +729,8 @@ static void nvme_unmap_data(struct request *req)
 	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len,
 				iod->flags & IOD_P2P_BUS_ADDR)) {
 		if (nvme_pci_cmd_use_sgl(&iod->cmd))
-			nvme_free_sgls(req);
+			nvme_free_sgls(req, iod->descriptors[0],
+				       &iod->cmd.common.dptr.sgl);
 		else
 			nvme_free_prps(req);
 	}
--=20
2.47.3

