Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023311D88D0
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491909; cv=none; b=VlkZ+R/Q4ySZ2ZG2Hg1zX0NqQ+7pwRyG/U+OPrMhJrhKmXxvzLQ0oGmsbWzuuaIifnEYBtadzK0chpxOEmrltSDWLagufU56a/xcHQQbK4s0lBNFtL/6FYNi4Mowzlzjw0IgDhLHASzGRc687A/l8Xvhv0NHK+ZVrcYrxKm1Ank=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491909; c=relaxed/simple;
	bh=PPzdRj4u1f14grobBcNT7IoX3CfNg7VjIILIXMpmcfo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UkuVVEHxMUjNArXRzkwTO6j5D5QjFaYPqIisv8nDiVyXmZXeO5WZie8WC3eL5fivjlC2huqxZ8N4tN8yPf5L/AMLrPohh8NrbEvU2JW95WRuXgecPKmRUxFBVHOTadSMNoT9X+brwnx71eNOkFBMeLaBEHOo57UVJ+sotDBpL3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=p/rbOyY8; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="p/rbOyY8"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576ETj7I019709
	for <linux-block@vger.kernel.org>; Wed, 6 Aug 2025 07:51:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=bwM44L2rmZ/Bx0r6Mu
	hs0y83imXKIEPNsSBmomJX38Y=; b=p/rbOyY8QnMl6Yzn7pNdSJy1BRcleSfD6M
	5XjCZlM5tevCB1RIAGE22X+/bk6uZk0xPaKp6oBh52fkPoCWtfzpFMNVji001BzC
	QzCnx9O1C0TCW7aP6S0j4pe4XMtWrA4w2IfMkQuOBEZbTRZhCitOeAPOPxhtIDL2
	yTCnhTn/gltdisn+NDpgPM1gqP4e3A7yhRwCozanFRX5Poxlzu0m/GmM06n1e2YK
	cSVr1jFnxmVdRlTMRIgEzG+k3KChWP3VYQkcDYl3gO5MJZe/UvaXJndfik2oG9bp
	DOKIjPcGR5A7hli2M0N/Lp0shjpl2cFd7T/RLZ90XzlfUzw+PjiA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48bpweywf4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 06 Aug 2025 07:51:47 -0700 (PDT)
Received: from twshared10560.01.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 6 Aug 2025 14:51:45 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id D6E9059F45B; Wed,  6 Aug 2025 07:51:37 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/2] block: replace reliance on virt boundary
Date: Wed, 6 Aug 2025 07:51:34 -0700
Message-ID: <20250806145136.3573196-1-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=BsqdwZX5 c=1 sm=1 tr=0 ts=68936c03 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=6zhmPM5ITRsy1UUQ_BkA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 3o4EHTioFz0JBK8EEsaoG1xWSrg0a--N
X-Proofpoint-ORIG-GUID: 3o4EHTioFz0JBK8EEsaoG1xWSrg0a--N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5MiBTYWx0ZWRfX2bmDf0xgrmtw /6QcyM/wAOXBvrkxUkTGDat8xJd5tQs7b/lFmtwZeVP3ihojTLmwUS4iZeQlw4qG8vDTYgdQfze x7jySgTlvX/kQUxWXtzJAIGCiJ2kZ6XOJxeWBFp9Gv/LzV+SsNX69NdfaO6feteZ8zEmtpa0TC0
 aFJYq8B9C1OtfW2HFROgz9blz5++g+oaFm8gKdlr+QIuyPxBxYr3EYejy57dByeGsQfke4RDwYh 6cE0ZfxquGLYz2WyXU5fYj80VWnalFlLG8EH4TbCeWCJcykk45b9yFzMXSrKtcqsozwZ0jaw7Dr B+A62OD2Jkg8nWNLoHOdCoJL4YCnWsefketvVc4D2HOofrZbUn5H7VEO2aZAlVdEhh1bw5xoP3Z
 B/WUVYEJ6XgvXJph3qwF9XggHT5zcwZJ4CPlsjnt5/WJZJyxNz7btMWGP4hmf31bMdi4LuuY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Changes from v1:

 - Replaced macro with inline function (Caleb)

 - Replaced unsafe tail bio vec access with safe access

 - For nvme, always set the max_segment_size limit rather than depend on
   it being set through the virt_boundary_mask usage.

Keith Busch (2):
  block: accumulate segment page gaps per bio
  nvme: remove virtual boundary for sgl capable devices

 block/bio.c               |  1 +
 block/blk-merge.c         | 32 +++++++++++++++++++++++++++++---
 block/blk-mq-dma.c        |  3 +--
 block/blk-mq.c            |  5 +++++
 drivers/nvme/host/core.c  | 15 ++++++++++-----
 drivers/nvme/host/pci.c   |  6 +++---
 include/linux/blk-mq.h    |  6 ++++++
 include/linux/blk_types.h |  2 ++
 8 files changed, 57 insertions(+), 13 deletions(-)

--=20
2.47.3

