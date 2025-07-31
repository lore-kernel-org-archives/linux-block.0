Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FAF1ACED9
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974326; cv=none; b=ik1TuZJy25q3WIbpaXIQ4d8dgGHNLSqHJ9uyPoN8DwxQvkBM+jQuwLV105H2Cp7/xR+ga0h+Zdd4bPaAEpI0OBBEZnUbJKYEVB9YeMWqu9wh4L95bha5uqzCxiZKQ7TlDAqp3oEJw9ZiyJt+R+1AG3GWJpsBg1NpikBD++dWCh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974326; c=relaxed/simple;
	bh=HEj6BwAq4nlRgokN+6MJWX/wwGN5e9uZO1s9jQ9xVTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFG6H27BFUk39BWZX5cR4NmnYfyBLG5by/W6fBgYxCSJyfsPdmkGFPjPszcXuQxDtVtXXD7C4jKAF+uyi9yVx6wH5km7FW8m9Z7fYVfhFpMkLtjB2waytM8Hz3VAXD/TccoQkFZYFwv/vmLD0l031QD0opki5aUsAfxVaJgkoY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GzTEliWZ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GzTEliWZ"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VE7REH012264
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=xb4+qZoBZTJSN3n5c0wo7/+q+Nd7lvZO56RURKkf+ww=; b=GzTEliWZjpy3
	h5Mhxis4MQFPw+iQVO+iO+DKwBQzofl2PVIl8zrQOCFbgTmvvDwuL/dbp5WPRqZ6
	ieXQytYHB/oJ3jOPK7areLjcGRWA1/r6R9tJvy8M4j68EnJBDO98HUF3P4g53GPd
	A3WXYcJOXogLrUmcxgkZa9DYyeKAZRScU+TqNDJpx9zeHObG7iejEHazq//riTFy
	cmvJ3DQSdtHdVOPNbQrN2eBKp2Z7ge84GvRTLkd+US9NCNv/nltPU49nfyjLxo6l
	b2/ujdBRv4U6L4e+TEiy5+ZUkdpDlzT/0Thj8X8vVa2r92cvUTW1Ou3kGIDuXLrq
	baeOK4RItQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4883mj2k83-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:23 -0700 (PDT)
Received: from twshared52133.15.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 31 Jul 2025 15:05:22 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 09E67231DAE; Thu, 31 Jul 2025 08:05:13 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 4/8] blk-mq: remove REQ_P2PDMA flag
Date: Thu, 31 Jul 2025 08:05:09 -0700
Message-ID: <20250731150513.220395-5-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=K/giHzWI c=1 sm=1 tr=0 ts=688b8633 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=gTB_xsApw5YEP2-mlJsA:9
X-Proofpoint-ORIG-GUID: MAgr1PVCpTzxM4Xv1hrVSAJQwbC0PaPj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMiBTYWx0ZWRfX1xGw/AawVnNx 3lrbS0ApLIbrDmd7/pklQa0msINfNXAp+TCcOhtvkorfRWAK1dIm/9MUEXT+4RMOono0FSYBd3a 8MVhc479jQmecJjnAgZPMuSYMjI2Wbd2HL2vi3XCdEuUhLK+/9sfcI7tvKHh5SliZgMVN4vzIwc
 H4xEMTQ+JRrLMSXb2w0GcTny0rHb4AfqdEAgoRDCw9BerLmiK6apEkclxT78EIdf+v9a5NcUTj7 xuWDtBY67luGHeESb9KRK24kbpCnAXX2x9GccpeRPV57FFKbScwdmdq8mG8/bvBgGeX9qMAALFG BmVryYL5Z4tcCCQW6CdZYELb7dvBxqQYD5ovzsg19wYTVlkewldPed8Kdblg6iPmU2U+6T3uFhs
 FNqDF/lqdUHOwGdqp+B5m1uzKymfqmjkIXYTNqOlZDMqVFMsqnv/vo0LM67T72cEYzl6UXrs
X-Proofpoint-GUID: MAgr1PVCpTzxM4Xv1hrVSAJQwbC0PaPj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

It's not serving any particular purpose. pci_p2pdma_state() already has
all the appropriate checks, so the config and flag checks are not
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

