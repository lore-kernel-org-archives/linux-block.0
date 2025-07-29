Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB4A1B0F0A
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799697; cv=none; b=WxwARcEGI/4Qxo+o3aIA1cjUpCnBYi/uAq5DwpGN4IDlLrhjgP0LXJ+pNxCd8ugGMVQnkqG01pbSN7tcFouoeJ0dnidX7Xh5Gq38dp4J4L7eU3SfVExPm66dCth+AKqivZEud8P2sTtYYZPDgNiv68oZuIzin61Vklb2X0t30wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799697; c=relaxed/simple;
	bh=IuudHw9W3upy3yoci0XFW9QMiyQjlvCOAKldbmD1sUY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k9tSR7fvIwcK4QH34VEj//PXKtdqSas9PLbA6KoAEqMIItqaaV4c4cKMlE/suSNMbbSg6VYu84973Ismb19vU8pqicLdW3OR2w7n5+UMY9qZ1wQ92AL3RLvt2btXUp4+GCh2AjOP5yeOtJcpDVkMbpY5M6v5e8C1SVI7D9WuqGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=wFL37IQc; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="wFL37IQc"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 56T7QnS7019432
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 07:34:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=h16HvIigt2XSFX4l7h
	VzZW8JA4EzMQgFO0SgFpo9SY0=; b=wFL37IQcxRWftNqPGSqyUlUtkpXsrVHtAW
	u91lHDpMYGoOBHZp7HQVe0j5gLMJ3OqDDZx2dNMrv1BVlXIZ/+oG2ElroocFAsG7
	Y/ptsH8OdS8ZbFWBE18jtNKLR7S35igxumMx3znFGmRLp0wiACC3DzDHFt+HSW17
	EWHIDMlvVJ+k2W3jwTXIqBSArBjXesCUUjRXVhh5dmmsRULaEd8HpIoS6g938TGd
	wQ4qmX68QVCBcG4nvu1eiLM9X/C8O6CeDZg5Pot8ZCuhyrvm01akAzKmvE9FER5b
	lcszCyhnf2HrADE7NqS9xvWU1NJSdh4Y1Kfo8oDJgRhd8krhI5kw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 486swgt96w-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 07:34:54 -0700 (PDT)
Received: from twshared63906.02.prn5.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 29 Jul 2025 14:34:52 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 715931CC41FB; Tue, 29 Jul 2025 07:34:45 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/7] blk dma iter for integrity metadata
Date: Tue, 29 Jul 2025 07:34:35 -0700
Message-ID: <20250729143442.2586575-1-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExMiBTYWx0ZWRfX/z3iABtrIcr/ EFoCbnC/pxU0hLFgmgDfuhU3sBts1kAXur+fIhDKMyS49oVlbl2pMgAFzUnyGN4pTK8es8I7Ovw buR4ZfSEQoXNZL7iHv+iofLxltP0D72P6QRtnPFOw9yDd2+K4WlFXOhjIt6H1CkVfkiJQOpKNaY
 Y4huT1CKe5WV0s/0gVEJ9n/GGhdda2cxV2wkOb3bwuhXm8UlY3d1hvrx4MHuT5Llt8aB3ApNkkn ikz+lRoneVW10oGW0je54iSn5fYJYYkGqHShhZ3zEf7LaUbtpxeLH20A/uj3n4NT3KSHu5IRPol P2aw9TFWOsBu9XigbRt+tk87JMdTN1wte6BDsI9khWDFfiCYkNGywzvcH5d+cAm2Sv5Bwfcm6NH
 HeRplbcw++X0mSx5j7KdklntYDgWosUhQQZrPb6t/eIxesmucWVLblRjsm53taDWhoQHSERS
X-Proofpoint-ORIG-GUID: dnyeAUNunGUtMPlFdUGRNx8j6UxTcOIu
X-Authority-Analysis: v=2.4 cv=WdkMa1hX c=1 sm=1 tr=0 ts=6888dc0e cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=-7KjEqLkBevZipjnv6YA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: dnyeAUNunGUtMPlFdUGRNx8j6UxTcOIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Previous version:

  https://lore.kernel.org/linux-nvme/20250720184040.2402790-1-kbusch@meta=
.com/

Changes from v2:

  - introduce the "blk_map_iter" type for the lower level's physical
    address mapping.

 - fixed missing "static inline" for stub functions

 - appened "is_" prefixes to bool types

 - nvme uses the MPTR method when it's a single entry, execpt for user
   commands, which will always use SGL when possible. This nicely
   unifies the setup and teardown for each, too.

Keith Busch (7):
  blk-mq: introduce blk_map_iter
  blk-mq-dma: provide the bio_vec list being iterated
  blk-mq-dma: require unmap caller provide p2p map type
  blk-mq: remove REQ_P2PDMA flag
  blk-mq-dma: move common dma start code to a helper
  blk-mq-dma: add support for mapping integrity metadata
  nvme: convert metadata mapping to dma iter

 block/bio.c                   |   2 +-
 block/blk-mq-dma.c            | 226 ++++++++++++++++++++--------------
 drivers/nvme/host/pci.c       | 181 +++++++++++++--------------
 include/linux/blk-integrity.h |  17 +++
 include/linux/blk-mq-dma.h    |  16 ++-
 include/linux/blk_types.h     |   1 -
 6 files changed, 253 insertions(+), 190 deletions(-)

--=20
2.47.3

