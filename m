Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842853168F7
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004169; cv=none; b=cYRY+6Nbob4cVihFDOETISP/KdS5nZeHXYCt62RdC98lsdRwCOyAIF56QVzQOtZX3xuIhtbqA5sWMm1r/g0mPx/uDKUEiMTyqaaHg5C0AbDMpa7kzQPtmoVs15x6lPJHS/a/ajE0bshgnvhLQaPaDue6OLdEaSO2UT4TDnlUM5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004169; c=relaxed/simple;
	bh=6J2h3bOqmj4OmaT+fcLLCYVPX2DRmbbmocASOp/WII4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RRUFB+S4DNrQ2CqPKRpVlXG4ttNdysg7nRJUDcPYvxcJoVUS/uqUdQ11LngYPohRdacQviOYX8cSc9zq25wu3vcy3nYzjp1DdVwWFIH+6Vs1/D32MRuBTAELUKF7BaJilm3dZmvpeOZ2OWMPqjE8T3ltTy3OLgupgl6UQTZiva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=qdXeJCrJ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="qdXeJCrJ"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOEZolB2694097
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 09:09:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=D596QU76Zwi3x5swVX
	nkDy7gYMxvg/feyxcKGDTW/qA=; b=qdXeJCrJzaVT1syz17UDQUiCPAP2Bu1Bug
	AUeE+PUNEQcsYlgeDL7H82knUC/OPDszBCKBP98sM6bMrRu1PRG4Ag+RhbSNB85o
	WQnbqMCZLo0julspITZlpG/l/gxnRTQM18j8iv7jSKZ1e0YCbR+6B2ytVuUUm/qy
	piCXniqEHUTQsgsoc+rJ+28VYfud72XmzzCsT+vT7z8NXeshre+8xnsTzMxtir3t
	f2UAYQsGnDhZ+iyBKY1g7jb1Fwvvy9Ryr9FrXINMRTwCwA1hc5dZI3eG1Bna+DG0
	quZlSYRhEn72e74NLNOO7DvorYvxA3SsYL3VLQME/j9h4rovehCw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ams9119jt-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 09:09:26 -0800 (PST)
Received: from twshared31947.34.frc3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Mon, 24 Nov 2025 17:09:16 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4932941D0F4C; Mon, 24 Nov 2025 09:09:08 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <dm-devel@lists.linux.dev>, <linux-block@vger.kernel.org>,
        <snitzer@kernel.org>, <hch@lst.de>, <axboe@kernel.dk>,
        <ebiggers@kernel.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/2] dm-crypt: support relaxed memory alignment
Date: Mon, 24 Nov 2025 09:09:00 -0800
Message-ID: <20251124170903.3931792-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 424rKCtC177xjxRCxzqIjrSTxGF_Nsie
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDE1MCBTYWx0ZWRfX+RNBBPSIbeaj
 Yp9Z1cHRu0RFdnALC7G6LRfaceLBaWQ+M0hNVLRXT80muY69rDXsDbb2190ZrptbNqhXQ2gVLxf
 q59+Sjt2JFKOSsf+7NYO1YKwIIRwk7BIBj8yT9RgwjfSqXl3H2RVTfGtNIGMUOvKklRSiR+v2uA
 9Qu7F7spkTSO22bPrC1FAEmBo0hP1FP6dP8GuJrysY20XEYsM5nK5JGQeV6B91YjO6YxdXl+3o0
 Ah7fqu1UfIep0pBqsL11V65ds08tXUIyF9C7OUiY2xBs8iZsJvgALMo6Nt8nWvelorKKM0YqZQn
 0U+kF+WJ1jmYzo868EECZ23reU30pXy6TSfA82hh3BvZsvm6+QmEx3wJH416HNNh6O83trvYdWf
 BRBXLQeqI+mSxUUylhNQoQJGP/X21w==
X-Authority-Analysis: v=2.4 cv=BL2+bVQG c=1 sm=1 tr=0 ts=69249146 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=Y_sEM6iBs9CKCa9LBqwA:9
X-Proofpoint-ORIG-GUID: 424rKCtC177xjxRCxzqIjrSTxGF_Nsie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Direct-io can support any memory alignment the hardware allows. Device
mappers don't need to impose any software constraints on memory
alignment, so this series removes one of those limitations.

Changes from the v1, which was an incomplete RFC:

 * A block layer prep patch to allow stacking drivers to define their
   own lower dma alignment limit.

 * Prevent reporting the relaxed alignment for any of the initialization
   vector types that use the scatterlist for other purposes beyond
   encrypt/decrypt.

 * Keep the error handling for data that unaligned data, but instead
   using the block device's queue limits.

 * Use the same scatterlist setup for both the in and out vectors.

 * Use multipage bvecs.

 * Check the alignment as the scatterlist is being built.

 * A follow up patch provides support for dynamic scatterlist allocation
   when the base bio has a lot fragmented segments.=20

Keith Busch (3):
  block: remove stacking default dma_alignment
  dm-crypt: allow unaligned bio_vecs for direct io
  dm-crypt: dynamic scatterlist for many segments

 block/blk-settings.c  |   1 -
 drivers/md/dm-crypt.c | 105 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 86 insertions(+), 20 deletions(-)

--=20
2.47.3

