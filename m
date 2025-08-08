Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3028286422
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668726; cv=none; b=DJyTsuJXlTzR1/E62Cmumnxug8NvLOE504lmOs7KSOPxuAqR6tF84hiCCo4S3BA4B00zt2gyogm9HCPjtV++dcwu2h8EUmIK5sh+SKRt5Fd6UrEQqihGBD6MkYZtqI+nARdOCKhW/JDjBovIBMVk5pxEMkKrvytlcrKF/N4jc6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668726; c=relaxed/simple;
	bh=nbFUNCLDIX77GQoVzB4uqxgHzKim+TlydsY1Xka5ps0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSE/3vgKvH0MJkR8irojqb56+sHjN//aLllGr8vdbgofA5EHBukHbBnj5FfehQxJnsNYVilPCM3a2WrOiHS0mwjy9K1UZE5mlpMfkEQ200ePNtW6R/kIHvbQrh2ttcJZ7LkFCr+qExBtLZzGPQg4nPN5RZazz9GwVzcwzAr/dts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LvCP1wKq; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LvCP1wKq"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578FJ2Vm027029
	for <linux-block@vger.kernel.org>; Fri, 8 Aug 2025 08:58:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=OnVEN0Qg5E3J9URYGA3KFwVlmgiUbfXOh2icZeBfBt4=; b=LvCP1wKq0z1G
	AXnWtDALY6omIsU12Vd1mfg3b/fJRNTwnm5i8C+ItGw2DpdhSbfA0Lg6+T8T0UDh
	ugHrtXlXNn3afwPNnvNa4nRqzGKEiuXVo6TbIkkc2G2R9wOe0POWjQ27FmMi9+hC
	3XkccIx8Ve+gruLy/l+NCUnp/ylyYc+NSnwOKF/ZXqjGC90hwSueEV+oMCLgm9ki
	0GNNURsEP0VqaaiPMA1MQpTSIJ/AEg76zHyQlKmvzUF4H4HaKduVLOidGhDijSpE
	WkT4hAelCUXp0oglkEbFaOBWFLR0TBguSD5HU4DMJxL1PkxPUNEBYlJv2Ux9zJjU
	MNL4Civn0Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48d8mybvnm-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 08 Aug 2025 08:58:44 -0700 (PDT)
Received: from twshared7571.34.frc3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 8 Aug 2025 15:58:34 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C22056C76C4; Fri,  8 Aug 2025 08:58:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 4/8] blk-mq: remove REQ_P2PDMA flag
Date: Fri, 8 Aug 2025 08:58:22 -0700
Message-ID: <20250808155826.1864803-5-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=I5BlRMgg c=1 sm=1 tr=0 ts=68961eb4 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=gKVTuvNHKxM_LcN8e1sA:9
X-Proofpoint-ORIG-GUID: vgRqn5hbsxSz2IW5JkDXreP7u_RNN-dQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyOSBTYWx0ZWRfX1BgVO/fvBr8O mgJaJ5hSHo4zfsGUUNY70fAQSri2Lk5wC2zy/a9LLQfx/APcJHtUjIrE4K+5ePwPccpacEMRjhu +Eo86DlPnGSgMc7WP2S9so/PsSvSGEGXmnO415rCWhgpXq2Pni6UiDzGuhkM5JZzLvFxn3TCM4I
 d6JFzVuypCoIRVjsYouhwhrBJAlIrQHWQL8sIiJ3cgmyTwSxMIXePMBybmDkmeW+2SXYQiqRAUd F+VCsz3FP08QwLgHWUEzu3Y0qiEJ5wI090KadEsrL2lFAuQQSkGnq0s4nTIgHixwP1Z/6+f2h/L 0G3DJ3TytmcB0cZFSe3ze+JUXmAP1Yh/+I18IAbqxUTBwCZgsRQHp9YKi9UEfwpVZ4+9MvnVDul
 BsVVysSyIZEep4UF7lM9luqrJAqAxwDzriDbZC/DY6uowRWhK4SSPZIs+P3324zXMBQIIPca
X-Proofpoint-GUID: vgRqn5hbsxSz2IW5JkDXreP7u_RNN-dQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

It's not serving any particular purpose. pci_p2pdma_state() already has
all the appropriate checks, so the config and flag checks are not
guarding anything.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c               |  2 +-
 block/blk-mq-dma.c        | 30 ++++++++++++++----------------
 include/linux/blk_types.h |  2 --
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 92c512e876c8d..f56d285e6958e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -981,7 +981,7 @@ void __bio_add_page(struct bio *bio, struct page *pag=
e,
 	WARN_ON_ONCE(bio_full(bio, len));
=20
 	if (is_pci_p2pdma_page(page))
-		bio->bi_opf |=3D REQ_P2PDMA | REQ_NOMERGE;
+		bio->bi_opf |=3D REQ_NOMERGE;
=20
 	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, off);
 	bio->bi_iter.bi_size +=3D len;
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 4a013703bcba5..988c27667df67 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -173,22 +173,20 @@ bool blk_rq_dma_map_iter_start(struct request *req,=
 struct device *dma_dev,
 	if (!blk_map_iter_next(req, &iter->iter))
 		return false;
=20
-	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && (req->cmd_flags & REQ_P2PDMA)) {
-		switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
-					 phys_to_page(iter->iter.paddr))) {
-		case PCI_P2PDMA_MAP_BUS_ADDR:
-			return blk_dma_map_bus(iter);
-		case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
-			/*
-			 * P2P transfers through the host bridge are treated the
-			 * same as non-P2P transfers below and during unmap.
-			 */
-			req->cmd_flags &=3D ~REQ_P2PDMA;
-			break;
-		default:
-			iter->status =3D BLK_STS_INVAL;
-			return false;
-		}
+	switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
+				 phys_to_page(iter->iter.paddr))) {
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		return blk_dma_map_bus(iter);
+	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+		/*
+		 * P2P transfers through the host bridge are treated the
+		 * same as non-P2P transfers below and during unmap.
+		 */
+	case PCI_P2PDMA_MAP_NONE:
+		break;
+	default:
+		iter->status =3D BLK_STS_INVAL;
+		return false;
 	}
=20
 	if (blk_can_dma_map_iova(req, dma_dev) &&
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 09b99d52fd365..930daff207df2 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -386,7 +386,6 @@ enum req_flag_bits {
 	__REQ_DRV,		/* for driver use */
 	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 	__REQ_ATOMIC,		/* for atomic write operations */
-	__REQ_P2PDMA,		/* contains P2P DMA pages */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -419,7 +418,6 @@ enum req_flag_bits {
 #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
-#define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
=20
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
=20
--=20
2.47.3

