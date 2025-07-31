Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF661A5B99
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974329; cv=none; b=O62tOf9NHW9PtrZr4r0sC0kicGpbiLYEYPvHKLIPPLyK8JoMDD2o2BWlSQSYb+tU0toJdl6yEuz71YYxnpA97laGARW3qk4VQAus91ZnGL8SXEuhTn3pfqxCyzWO8Cl8fSEIBcbcDn+CZhUgVBXpFEh2lTzi0OuA7lEMZGqXagc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974329; c=relaxed/simple;
	bh=50Bpk3z8FTM0rsQZJBadF/Vb1F4zTedXyHvRMzJvauA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIqZgxCZbQoCbF+Go1bqj1Co+h9ReLIMaFcL4FFT/8z9bifhqcStBBhX9qMWHBoEm0wjgn6L+sOfZ+0mCIqp3Z+grG+9vO3g/R2S6IKDhyBohPw75UOZfw3uA1dNOu03arVwd6FybxRwLXYuaHaf7EoS7nolmollo1rhdXSkmSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=wDdM6sZ2; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="wDdM6sZ2"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VE7VPt012595
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=dsr5x8qJZFXEH7GdyeAHRaxjQOPGX3vWdY3mJjxt6+4=; b=wDdM6sZ2bbGC
	mO+nffW8Ckonlb5pxwcNnslCec6twGwwEjZ2B64tHnDJj4HiKHTduFiG9ifVegM6
	8npXw+JKssE3Zf2juSy9+PguYG6CLB2t37VMFLYWon8LrG4sZndHsS6fPcRLNlbE
	9PsLRWcpC4I0juOwS/4yjhSiscrabrhk9xoS/SkmOEc5K/u8P07CxRugdbeBwsuQ
	I7FpS6xkrY3Ckt0gvW8aJHFmAOJrkwHQuFoHDYcJe+ddLDAxxEVQ1tXPMDto8+TD
	qEWeG6zHZ6F4TTnVptViww1zBdf8LRZRlh3g+Pze4DG6yp4SQsN9LFQ/Oj5AXt7U
	w70CbNaSpA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4883mj2k9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:25 -0700 (PDT)
Received: from twshared7571.34.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 31 Jul 2025 15:05:23 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id F2E62231DAB; Thu, 31 Jul 2025 08:05:13 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 3/8] blk-mq-dma: require unmap caller provide p2p map type
Date: Thu, 31 Jul 2025 08:05:08 -0700
Message-ID: <20250731150513.220395-4-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=K/giHzWI c=1 sm=1 tr=0 ts=688b8635 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=lg-0pX42I_tHtCv8E8UA:9
X-Proofpoint-ORIG-GUID: dkzQjo6toR41kzNZI3waJo5A18P2wIsZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMiBTYWx0ZWRfX/+rK0RL0tvRv 5cWbhOF/53yN7sqO/GGeDXjGYVmgFo3JMDOLFseKK+YsXDa/5+xg01mNr6nq0tq2mdS3Hn0nkT+ aq05d4SBGunQdQVo8Nant9lBzn6dUCKIdwjo9nCt9PMohjgadxUg6mKxy0wFK7WTSZDLe8qVYCt
 OdCPp3a4Z2HtrCMnVO9laRk7k0/a8rLfG7LsRsatgLFM5EacPqfSVY9W5hY5F08vHKbLNBBgGsB QYoq3VXBPQH4pItZXVNI3A6uJE+Y/78p6tcqVnErMMCr/VRYXG+Cjn9tsU4t84pEjU9a0iFjnT9 2F7OTpitcVvwv5Kbk9/h9MamwVxJSxRAR93Bgi81RiwISAZDa2+Jz2B/93uCxBqhiWfDDDUfONA
 nwaCHnZ3bWUDAHgHA7WsMiZ0P9q1NyU55Iuwngnre/e7OUSHFywJ0pY5wCsXf8r25f6icY7R
X-Proofpoint-GUID: dkzQjo6toR41kzNZI3waJo5A18P2wIsZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01

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

