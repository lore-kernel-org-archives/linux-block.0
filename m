Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1252D2248AC
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753037044; cv=none; b=s7HqJsNJcCqjVNOPOmt6f+6sOXMkPgrdwI17FWCeoQu9iU+uO9lVaZhVj+kbPzgIXsn7WXw3odjpkI42lryAtKak++47T8+ofnkxiVTsKjUDVU51Q769KidoGsAzcc/HqihadXZxofbeVYlgwgjQi6fvBqZ6hqYGZ+d+mDoUSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753037044; c=relaxed/simple;
	bh=7VB2uwLS1BBoty4LcYhx/rxEhGPzFqNT1eNmj6O5KwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlnCNNcsqj+Sws6udVPupIGho4jH+JSGvqe53QqhEjX7dv3c7RlE3PKLoVbLpGF6fUnHK5FvyV1I1bSPzA2F8fHeVXmQJJH3Mun5hZLbnHTjPXm3reHgA1oszAShVnhcIIW8yhSTBYwzpTI2OFWVgJPc53YjpxM4JwnlkF8G7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=uwbzKkaq; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="uwbzKkaq"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 56K90DFt022250
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 11:44:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=XrEUUXG/DV7XdFOpiNyMcNXqkL3TMsWCbPvu6QUhyIc=; b=uwbzKkaqeSKu
	97mSAOHJvJ8XBZf5E4LVaVzAqgthg8YCLtxikQNECrfoEuIMa9T+NKX5pWJyIOoO
	YRI3rUF1jny+Jwlqmt7JhUOAujwCHeXzi1TKVCGZEMebrCTC2lYmlKGEfrfLHhsE
	6W5RY6gIlJEPdwLpK2eccH73v0hGgINdvnby8vIo/ChoZFepMVIT4ScQyrn2+ZDw
	J+I8NXxuf8wtSo+NQbX71tTLjnWCgaivpRKmy6YYRIhj0Z28Hii6xOdRTswYl223
	yFNfYuTTT1YLeMCqzwJUPyRyJe43l+PzznD28BxpAPkjAT8tUzTuKuhrssYWc0Vg
	UOlNCXLEaA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4806vk5u5m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 11:44:01 -0700 (PDT)
Received: from twshared4564.15.prn3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Sun, 20 Jul 2025 18:43:59 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 485B0178C794; Sun, 20 Jul 2025 11:40:50 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 4/7] blk-mq: remove REQ_P2PDMA flag
Date: Sun, 20 Jul 2025 11:40:37 -0700
Message-ID: <20250720184040.2402790-5-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250720184040.2402790-1-kbusch@meta.com>
References: <20250720184040.2402790-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=demA3WXe c=1 sm=1 tr=0 ts=687d38f1 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=gTB_xsApw5YEP2-mlJsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MCBTYWx0ZWRfX/6ZVCDfWPNZ6 eHpPlDBdHkqYzwcfEPWhfoe6TuocwaisJSFoDiGrnOLwsyuvw2uJ7w8slF0mb1tebSLr2F40/5H pVFs1WVToMGMubXQlfoVyP9Iu430zWRxOLm4peMAqjXyEY7voB0rh5Cd98zhuLRj9xlRrAIvvLo
 4e0WY6AVKQbNrynrwEAozciedaqVG8n8p9GJ8D9mEQ2/tglSF7FFR0Ouz6AjEpNugsr8tm3CPpC 5ZbkTyVkqWMYFdK7pfVSknC4KvMwd9FdWA8n93zkXJSUTDQo3qqWoLdNOooEfb0UUUqP9tkB740 rJYssqZV+g6ZuELTe5FwZ5kvHuegERPVuxvisdW7R9a8PzVOO0FMfoa7iebWhp7V5hYM9z0Tvl2
 TWcfjm43xnSrrgWrVdq6sJcFX6zWapmoYUWpmNrZ6Je9Uybfqro1hjEEDIThHaH72QJYFH3N
X-Proofpoint-ORIG-GUID: gT1Mc2LnNS-s3ZUQdKodxk6a0Yd1vx7g
X-Proofpoint-GUID: gT1Mc2LnNS-s3ZUQdKodxk6a0Yd1vx7g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

It's not serving any particular purpose anymore. pci_p2pdma_state()
already has all the appropriate checks, so the flag isn't guarding
anything.

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
index 7f3ad162b8ff2..56158ed504747 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -165,22 +165,20 @@ bool blk_rq_dma_map_iter_start(struct request *req,=
 struct device *dma_dev,
 	if (!blk_map_iter_next(req, iter, &vec))
 		return false;
=20
-	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && (req->cmd_flags & REQ_P2PDMA)) {
-		switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
-					 phys_to_page(vec.paddr))) {
-		case PCI_P2PDMA_MAP_BUS_ADDR:
-			return blk_dma_map_bus(iter, &vec);
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
+				 phys_to_page(vec.paddr))) {
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		return blk_dma_map_bus(iter, &vec);
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
2.47.1

