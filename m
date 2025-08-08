Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F209286422
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668729; cv=none; b=Iz0HpQlmfUpKicSq1RLANJ+JGDXccnAJgZib2ICVkTFZDkhpF4unmzQ1xPZLy7VJFEWL1jD9aTLfUB8sUfCSohn4Fo8tF3BlQD/WmnTjw6MUMBJv/mIbJlJ1uPI5I4B9iYcUbumGhU6Zn8zovpvjBsFmlqz16Yxxn5raX3JclpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668729; c=relaxed/simple;
	bh=50Bpk3z8FTM0rsQZJBadF/Vb1F4zTedXyHvRMzJvauA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFg3EVBip+E1qhouf72/NQrwl2RNtEbK7pVpCyV1MsgzHFliTLqOlv461VIw9G6HIpu2r3GYsTr5pqbE40oMz8htuBT6AmZs4YrMHBo7/roB5YWLgWPvVOKdNtQWWpKP71HCEt6nV/+zmfiOCdSXa5+9sNre9ba2DQHVXpyDSks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=rBY/Upjs; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="rBY/Upjs"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578FJ2Vq027029
	for <linux-block@vger.kernel.org>; Fri, 8 Aug 2025 08:58:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=dsr5x8qJZFXEH7GdyeAHRaxjQOPGX3vWdY3mJjxt6+4=; b=rBY/Upjs+n/g
	xkZkXI6svOsqLBAlBcXypDTuVuVK6l5HEByer53KWxq5+RTrqkXlq4QnMK9FPkft
	RgWHW+HFPSRhrurgUBYeKKMOgWvcQyufAdi207pLW+K9upeaOQBCjp1dR1nRasDx
	6h1ZYnVQvf5Il92D8cmhAatVHj8gN7m4mLz+eHoR/VEO1dKHmyTNS0t7hfHnXRUj
	7ox0BqCfhYfvufDu6s5BtmB7j70WHWmnmZVjq91knCNkaks85ka6NbCnWGd5rW8j
	PxXAygdMgpWM8EqjbikacRZA3ZV/9zxF8pH+N790JtNQhbCQDkJNP1sK1NlPv/xH
	bCbc03krLw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48d8mybvnm-20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 08 Aug 2025 08:58:46 -0700 (PDT)
Received: from twshared60001.02.ash8.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 8 Aug 2025 15:58:36 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4FC346C76C1; Fri,  8 Aug 2025 08:58:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 3/8] blk-mq-dma: require unmap caller provide p2p map type
Date: Fri, 8 Aug 2025 08:58:21 -0700
Message-ID: <20250808155826.1864803-4-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=I5BlRMgg c=1 sm=1 tr=0 ts=68961eb6 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=lg-0pX42I_tHtCv8E8UA:9
X-Proofpoint-ORIG-GUID: Y9XIJ8WtiAsGoxKcrviB_V3b5rhFzqy8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyOSBTYWx0ZWRfX85XVp7Pjwm5/ o5rWqxyVHCJWgnQjiRQMKCJhw3XE9zNYSNvO8W9DUnhHP4P1UScMk+Uulm97AKRHyNhthGE19VZ R8ayqkYmL0P/yR3PXTdHMS/qxvR2yI5GG0F3OD2u9dsgLv1hwnCS5Y4p3BO31DUOm6m+crSQjUi
 lZwZK4Hgyjez7+kzqoxcwOn6+unSfFR28yfx5hSr+oKO2CxEBaj1s9yO9TMVopDH5IxcbnEPPj8 2AaqMqe0HBo0Rak/fcYLSJANj5iSKtrznomQ+U/BxZHt8f8/MAMb+Rmfemun05kC5IXZanNv3Gn GakndYRgTusvl72KR8jqb0Eh0SwpE6nbaW77MihoBkBDamqDDqoZ97/DYFvLBtdNTKsYaerofXC
 jg0zeD8MRMmqjYKWPHUkV4HEgu4V1rktZkL8W/xq7HCjMkqvezS1t7JZjgjF7yXDiANZ62vO
X-Proofpoint-GUID: Y9XIJ8WtiAsGoxKcrviB_V3b5rhFzqy8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

In preparing for integrity dma mappings, we can't rely on the request
flag because data and metadata may have different mapping types.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c    | 9 ++++++++-
 include/linux/blk-mq-dma.h | 5 +++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2c6d9506b1725..111b6bc6c93eb 100644
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

