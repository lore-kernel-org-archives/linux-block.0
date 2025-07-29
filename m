Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3051022
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799697; cv=none; b=R5kx+xUX/qcOXB3wdaX6Q4dh7VE8IlSuBoMkGpQpccPVxxySkmwEGxKnqD3HH//zPvQC6ejD7cOYKSmT3scPLPOfS9xeq1jHzGgr+Ccu/x1XOtjpkueaRm+lKO8/xcTyUJaCDXLtVhGhYaVMI3unHxGO2UW2UX7rblpt4J87r6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799697; c=relaxed/simple;
	bh=kzvtY4CIGHcrzNLH/HbisNce0DwFptBKJMtAoYFIgPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GP1M39Lrh+7ON+RB7njEEvyoMBpeOe1sNTIvpuWkKHUiXpRsXAhtkMr596V3yC70Pd0akZWgqBnO8Fz8iciDDvylVjoBygbxnSsH3ir6AttOUH2j3+6DPDYn9PHPRocfTg6+arjpScb6+2X3qp6fbv7mnW7bjsWbMECTx607evs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VzW2Jihe; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VzW2Jihe"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T6iXsL002683
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 07:34:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=mQwwX2iYCrJggUPTGK2S1iJAJ6OSGob73egHYy2twlU=; b=VzW2Jihem9/N
	9KzsUoyuCjdqm0gbkv+z0kulHWmWjC0HFo5hMJDCzFkizjN8zI2/sYpOuwnEC/Ke
	qIPYX5/MH85eicMnwc7Hza+UkhkWtYBzD4sDWe4mmR8pUtfpzUo7NULlTQf3EY9Y
	SU9lp6wCoa4DpGZDzrRF7+dv2Vurl+vKAhK6ihaxo/qa6LtmrHWJ1WNzea7JiKI4
	BWAE9qmmwZ+89grC5ACmrXa320nViW7b0M7KpY23XkE+rRPyjQi8n7+hE0Gi/YHG
	6/4QYIsjfCav0HSmdhrzNoV4Lr6ZaonDIXCCDVxbIM8IAf1879tLbtUujAD7EzFc
	B8UiLBVPdg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 486s9sjg9b-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 07:34:54 -0700 (PDT)
Received: from twshared38339.29.prn2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 29 Jul 2025 14:34:53 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 682FF1CC4206; Tue, 29 Jul 2025 07:34:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 4/7] blk-mq: remove REQ_P2PDMA flag
Date: Tue, 29 Jul 2025 07:34:39 -0700
Message-ID: <20250729143442.2586575-5-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExMiBTYWx0ZWRfX+vdDJwF8SBoB bH2SKzChZTqqXXx+/fzESTKhVgL7tsFQob9msSy5OknIZ+U37HfxnpkUZFP9Q2y2QRWYUfRvGUz DrqFcSnysqgXuyfXbT9Fg7Zh+WzO8FzDPpMnTXmuwdVbK+ZDNr/S7BPOVxgXadVgWUOab+4wgxF
 O5brD3ueP8dix7cE7HjN8lnwNYLZ4gpusbW3CcMdOSyQbnhdBJaz3XZA//jq//aDQ217up9J8eP +73Xt/eC4Ll/qhcd8hb0GG8dlhp6wVSjb3BnHs5swi7YlCxfkyJGwtrC7Plt687H4KX2vXZAsw1 xIHyY293GJHkhj+FxLGyu6Qc9TlMGD3PU5GeL7kEPkfhAcVzp4tXDrlxdPK8HZ5Z9u3enh2cg7J
 XxIU5VzX6l9DMcCbh13EFYuzRmfiLHnaQIR9Rh39TegVyp4R0tp7YFdekRl87uFoq6mZ6DHI
X-Proofpoint-ORIG-GUID: uGmkZMp2W6EIBd1AdJdgtv5L4dhA-QGI
X-Proofpoint-GUID: uGmkZMp2W6EIBd1AdJdgtv5L4dhA-QGI
X-Authority-Analysis: v=2.4 cv=TZiWtQQh c=1 sm=1 tr=0 ts=6888dc0e cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=gTB_xsApw5YEP2-mlJsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

It's not serving any particular purpose. pci_p2pdma_state() already has
all the appropriate checks, so the CONFIG and flag checks are not
guarding anything.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c               |  2 +-
 block/blk-mq-dma.c        | 30 ++++++++++++++----------------
 include/linux/blk_types.h |  1 -
 3 files changed, 15 insertions(+), 18 deletions(-)

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
index 08ce66175a7a3..87c9a7bfa090d 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -158,22 +158,20 @@ bool blk_rq_dma_map_iter_start(struct request *req,=
 struct device *dma_dev,
 	if (!blk_map_iter_next(req, map_iter))
 		return false;
=20
-	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && (req->cmd_flags & REQ_P2PDMA)) {
-		switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
-					 phys_to_page(map_iter->paddr))) {
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
+				 phys_to_page(map_iter->paddr))) {
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
index 09b99d52fd365..0a29b20939d17 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -419,7 +419,6 @@ enum req_flag_bits {
 #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
-#define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
=20
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
=20
--=20
2.47.3

