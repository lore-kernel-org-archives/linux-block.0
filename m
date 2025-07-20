Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461C72264AC
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753037050; cv=none; b=uQ6FBuAumHEiH+hmkZKc+giwOtcJLEG12YA4oe2cASBk/kIyWxw/l8e7Wi+06ZUIbiSDvcANqCqByqcEugtcR/MtwGn/kyr9z92M/bwxKEihgsgIFmLDs4YJAO8ck2GHFQswam6KxwZ3TpNzKfFVlPtBeUruBW+DhXtGFK8I6uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753037050; c=relaxed/simple;
	bh=bPvMEq/Qs23UU7naKQiLk/RFPIKSe/w74mWSXkWWnZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUNc3+tKQg1mFTGbPh1aZl8QjhoN064GPjn3hafd9huxwoUiCG0ypLK6TggRXLyAKa6Dt/O/JBZy+Tl0uupcKFazQF2D9h95iPTjUqFhlTLNjk/nWZ/RkGokqZnNHui10MOZ8469Mvl7Uh34/4v5QVRKmUpCfYWzV8x1OxjKwms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=qC5qJpbu; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="qC5qJpbu"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 56K90DG4022250
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 11:44:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=7SFWLtbHkyelQ1an+E2J+fwswR7CMW0LEEdp/6uxTwQ=; b=qC5qJpbuz8xR
	FGS5IBRKpS3iy+ynznKauKzR0o/v/ZmD0LuQbd7PgBimdCfW04nv08GHBmPS2xWh
	kqvA8NfCjrCimW8W3xdxozTZG2/TLYQUtjruxsgDbUtljgZz2LGKU9l/WLE0fNU6
	uAuL/4JnGAorAxW/QcDF8h2psHfjAW+2GiI1ykCox+qz/LP+aUfxm1znYA1gDHuz
	FIN4zkBdUT8FqFoUQhWMxWbCpBWuIkPVQu71oLthRDiTFhOjJKlhk/gXPejfN1I9
	Riulhun5rFvywZyyTpqdWHU5lfoLnwYslmB7TSTo0/Cu3r/U1u2droptfUEEfD2h
	QKaTrsn2Dw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4806vk5u5m-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 11:44:06 -0700 (PDT)
Received: from twshared4564.15.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Sun, 20 Jul 2025 18:43:59 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 44588178C793; Sun, 20 Jul 2025 11:40:49 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 3/7] blk-mq-dma: require unmap caller provide p2p map type
Date: Sun, 20 Jul 2025 11:40:36 -0700
Message-ID: <20250720184040.2402790-4-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=demA3WXe c=1 sm=1 tr=0 ts=687d38f6 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=lg-0pX42I_tHtCv8E8UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MCBTYWx0ZWRfX0UHvcFdFXEM2 T9NB2T+FB1Ceqm1kmT42AlrTx7LXx51cSofQroPcnVHGy35eAUIxJ6x2M40+9+xODM9u/xCWTwA iDPfRk/9CCtfKso28V0hJqleLi4ibPB9OT8K2v5BK/lM5iTOlW2x57SmyT+hAp/E4PMSvAv2keX
 L64rrmhw/yZIj1JHjs6WkwXncVeZw12GzDjFicyWVmqCwQ8J8EFBn+ldTrDDzFw4mIrGtBKRd4e uy3Me/Wlw22wGC+Na8ZOUG5yT8QYurx/c++fNOSnmUSxwYRs6/LnSP0MzTZhu6ReXp0CL3TuG90 I5w3EGadIxKPAqXP12EzN67Dvp82RBrNdFD+3LfKr8MnAAMJZcYp9WtHtKWe2lcgqvbbz4WnARQ
 8WEK5GBOdNhe6SHSdxk7ycSIGCZrTCipIvj+33Cexw1aPrAECtYooaI+ujEBqBnp4J67tUa6
X-Proofpoint-ORIG-GUID: 0DubXeuHnT2Z3ZN7IG9m_kwrIf8L0zkr
X-Proofpoint-GUID: 0DubXeuHnT2Z3ZN7IG9m_kwrIf8L0zkr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

In preparing for integrity dma mappings, we can't rely on the request
flag because data and metadata may have different mapping types.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c    | 9 ++++++++-
 include/linux/blk-mq-dma.h | 5 +++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 071efec25346f..6cefa8344f670 100644
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
index c2cf74be6a3d6..cdbaacc3db065 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -43,14 +43,15 @@ static inline bool blk_rq_dma_map_coalesce(struct dma=
_iova_state *state)
  * @dma_dev:	device to unmap from
  * @state:	DMA IOVA state
  * @mapped_len: number of bytes to unmap
+ * @p2p:	true if mapped with PCI_P2PDMA_MAP_BUS_ADDR
  *
  * Returns %false if the callers need to manually unmap every DMA segmen=
t
  * mapped using @iter or %true if no work is left to be done.
  */
 static inline bool blk_rq_dma_unmap(struct request *req, struct device *=
dma_dev,
-		struct dma_iova_state *state, size_t mapped_len)
+		struct dma_iova_state *state, size_t mapped_len, bool p2p)
 {
-	if (req->cmd_flags & REQ_P2PDMA)
+	if (p2p)
 		return true;
=20
 	if (dma_use_iova(state)) {
--=20
2.47.1

