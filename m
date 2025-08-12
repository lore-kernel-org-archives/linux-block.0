Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5B82877D9
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006826; cv=none; b=pHEctufnoK8BZWGCYpr2mzECQmAKCH1xqHW5RmHQ7gtdQn6MAJPetBdSmAPEqKQI/Nk4Q0evDj99qmtxAmHRGo6J77JmEleYv59r4FdIJsRx92QaOyJrX8Ewr7ibmATkFqp9K5o5a0Y74mRb4FysIvm5M69OTckm6HaKeQ42mak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006826; c=relaxed/simple;
	bh=N4bqL/36diiGwEIqdXbec/ImZhP5uZx7nMRb/2AUIkI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7F4eg5/++mIvr6F/h3I1PcSlRT7yyxlaMtbodSFUWu37hfC6Ps+s643JsGD5zVuX1QxfAUEYFEC/5PSRN67hXgObTZdvaT01QLVobXZ72VLYe/nH2IW3Bed3Ix/147nbMi+byLn2qrJgT3otoYjtSWU2PRxCpj6wTBpXSgWZxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=YxDRUNBs; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YxDRUNBs"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDnqqf012173
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 06:53:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Kcoo5840AGoxNXqmlM7GRSvPqwN2LEc1uL+j011rAsk=; b=YxDRUNBs+8Kt
	9n2DSxN8s1S7D3CaC1nN3fFvvS0HQZS6iJ/SQtCnhKKPC5m+7KVXXnEJhNeIrTbc
	JqSLOasBNizCWWMkC2flpTprzRLuapJXxZYFzS6IqcK8pEKQSTMxOTwqsTDdlp3+
	7DlEpKUlrNzIjbeLMV9u7tyKN1schfrrhNiDr3yx21R1dSEY8nbXbDHLtob6VonN
	0+MwQweR3JwNLljDc7yxN4IUUHVko4K6Iggpz7kWQ1d6ZyJokQ82xkhTC1nIbxpB
	0FXStiZwfzEjj33hqqPOTUVO2YW/oJdMbiHT1Y7KpeM5sGkmzHCBQlmgDUrL6EDC
	xY/SvxT2tQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48g5s6rrwh-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 06:53:43 -0700 (PDT)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 12 Aug 2025 13:52:23 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9D2388D407A; Tue, 12 Aug 2025 06:52:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv6 3/8] blk-mq-dma: require unmap caller provide p2p map type
Date: Tue, 12 Aug 2025 06:52:05 -0700
Message-ID: <20250812135210.4172178-4-kbusch@meta.com>
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
X-Proofpoint-GUID: o_427hhIWX0iioHrFHUT2x80cMPi0m7K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzNCBTYWx0ZWRfX1IGCKwKI+shD VVEQ5DdPSsjwmEAq+z+1FoOiyvrTaQ5pO9NdB6JxHlGLXi39GE/jiu/G9tt8nZ/LM6iKnOO+41U LQ5XF1LyyWGyHBbjm7atMoq1o/HLDaCN9nKN3IiCQOGjmKhcMx/uTqWKLa9qajHLm2XqsFAUNJK
 IHGl2omcl5vm55XhcIXfAPFe4pNOvu7hJyT7WoR4UPrcAvhHgZJ5eg34xlqaApSko4s0XgyvuTt lR47y9ekTD7cAoAp1+6u8xNMquTLuU4NFKl884e/iMTJQD1fvrBGB3KIlTGfLhZ17jAlFEz/yr+ whf3BV8hBXLlUPTZb052big/k9zmnZq+OchKDFABjjNtfrylOjMJhg5NssiX9CgdsWZ8qKmYehq
 rC3h7ESujiYDllRl8RHxmatjTIU8YdbK7WsT8EFFUfCbgojTX10uY8r2dI3Lhk3AC7QWyU1q
X-Proofpoint-ORIG-GUID: o_427hhIWX0iioHrFHUT2x80cMPi0m7K
X-Authority-Analysis: v=2.4 cv=H4vbw/Yi c=1 sm=1 tr=0 ts=689b4767 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=lg-0pX42I_tHtCv8E8UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

In preparing for integrity dma mappings, we can't rely on the request
flag because data and metadata may have different mapping types.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

