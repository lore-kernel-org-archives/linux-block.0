Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930531D7984
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099131; cv=none; b=YJZzlcFMDIRubh4OnHHMDGfInAgsyKejqKn8aUw97+TlCrh/TlQAwO4AQBEt9JFqW3gpGQPky4SKVC+zu1Cau+TY2N5cWV+d8UyO86uIBLCTqQ82RQvFQOTsXKxP6Q5I0FH8CcUI022equ3wVebhkfKPtpVMgZmhidjcGjj5FqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099131; c=relaxed/simple;
	bh=RaXYuFyrqmYQFymD49wdXslwgxQ/7SyxU7GxeN10Ccc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQJNBvTbOGudrBD3u+N+SNPpRJt35kH0cgQujXszAb/RiWZjn/ypNDt4dmMNbvlJRtkDu6BbY4gUjF/4mh2S+WLu7l+n/pN1NPojpOunhsKR3TXI2P+7NRcwUcNANolxQpiXLWAL85+2f8/LTwCXgx9FAiuFwjwLXpEIjebjzHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=PvdfjM1t; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="PvdfjM1t"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DFBki8020949
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 08:32:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ATd9aLqfAuUonWisv9tjrA1ckMNkUrs5UgNGR4dDPHE=; b=PvdfjM1tU54p
	daETPXtCet+Ui3AXYMYKOhzFdBLeM5nCxf0Nx4iPtnJ25gPCW7Y5SarzGQi6u74c
	xLhUObT/V69alk0YLVk0MvXmGE0Yanm16+AYVK4yeMZdGyL5LJQJeDfSlsuRnDkY
	GHBXunjc92zNcA4rR+YjH7GFl2/2heqKEDn4gxzlLhtzhWjNifY74Z8O2xlYzchb
	HeaZesBZ7eEsHl4d9EN81iyuf3Zm2QG6fRklAQcynwE6hTTzgsLhxAlCRvrIiV/R
	hT5Anqy/t1eeGlw2U21Wm+6QniUc8tG6Pz6bu19pqY29wjPga654fqIzAuiPGvL/
	1DK96tdt+w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48gt29hp7j-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 08:32:08 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 13 Aug 2025 15:32:04 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 7283897CD81; Wed, 13 Aug 2025 08:32:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv7 3/9] blk-mq-dma: require unmap caller provide p2p map type
Date: Wed, 13 Aug 2025 08:31:47 -0700
Message-ID: <20250813153153.3260897-4-kbusch@meta.com>
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
X-Proofpoint-GUID: jO2Vn794YB6F8UQaleV9DBJaSiZK4yCk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0NiBTYWx0ZWRfX7eY5aQbFHUnM gLZtMa9YSJxZIVvERjmg1NN0K3149zvmHi02c0zVAoo38s2ruPa4oRpZXMegQqWYFdJuH+SjO/W Tr8Hl6GPR9EMh9RBTpvsIxmV7eDzmhUOMPFf/IDgFfyVsMGb9NxVRhnVKu0xBMmTT23ZPWcsCQ+
 Ka7s+YyxL4bi1TO3Nmx3zn5xb3f2cC8iFnCrsZAlLQmeQFfRHMMWW8B0NK1WCLd4NDZUj/8xXVw ojv6jEqnrbYDFgvVBzo/k4QSRsAPMb2/SxAEurDnIiO408XYJ36CY2Jg04YSzTymIJmy0PTH41U b4fjzeiNBDPqxLPb8A1KD1EY48K/C3LRje1DA0+73XoSMjsMT6BQUfS1akgv621lbViZ4RrLavC
 84DbSMGj2hTawb+3WC9BVqhE7KsVQVM0TL/l1bE3rp5RcVoIm6OhAOFhWmsxPoyFpjQNVAxt
X-Proofpoint-ORIG-GUID: jO2Vn794YB6F8UQaleV9DBJaSiZK4yCk
X-Authority-Analysis: v=2.4 cv=Oe+YDgTY c=1 sm=1 tr=0 ts=689caff8 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=lg-0pX42I_tHtCv8E8UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01

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
index e5cb5e46fc928..881880095e0da 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -47,14 +47,15 @@ static inline bool blk_rq_dma_map_coalesce(struct dma=
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

