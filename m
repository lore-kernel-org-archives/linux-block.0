Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711CF2264AC
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753037052; cv=none; b=JxcUVdGFXrHsgecRwlEdUPt+6RrZ4puZeTU+Bdd44N4JIfw/dnj7t5Tljf28YZQ4lzfVNX7/5U4G3qifH72mCYCMsCD0Y6Wmmq03kPYBuVfTYcHGrHmAPs4YbeahN6M/XXly8W3hlVEk6pIuEtGyYmydsq0/m+pON8sb7eGmo4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753037052; c=relaxed/simple;
	bh=7nm7V4fyydyBD+1I9H0zZVOSl7x5JCH1mr2Y5QwzjtY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RYp0yIb8oyHKAEGgZSyADOF9tQUx8kHVY2Wxw4MnUtM8VE0jWDLlK81XHHdv0qi9Ip262UIDYkJ/1VFT8Ud6/4E21OPtXcCh2e2X46PjV9I10C8uQ9UUTuELR56y/CJoDFz3vgA2U8gIiY/SWnJOxsNfc7SmcKKjPgktAEpklUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GRHQAaZ6; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GRHQAaZ6"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 56K90DG9022250
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 11:44:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=HyjXf3/nSEeB3THFU/
	B+KtgJn+xJwQJUZZbDs1Ls+ag=; b=GRHQAaZ61A/NH2kpmX6X+KrEHqeFa3oAYM
	D34zPQvpvbt3yFoS6yCSKZuVs85YxInXZIveNjM16uUCF5wPMEZlVCXXs4/H68Qt
	EDD0zrqWJkZqNHB5xPYcUP9siigO4S5qNxfytAzekxywSBTlBAuWTce5qq2UBGVZ
	6fY71BpLxPcUQC9j06s7jM9Y7Ci0k1v54ms9W2yZCBez6/HgUq4wekdbxtJY6SBe
	kThBUn9klEUGZGDIeVx9XHEk4Z/U+RGKFLd/FZltvGvBCe7Eq7iVI0t+UyLxzMZf
	Whg7EtnVM8qBPvXIJ7kBa8J89GP1upc4elDyGy5zLbx+lz7bMLWw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4806vk5u5m-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 11:44:09 -0700 (PDT)
Received: from twshared4564.15.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Sun, 20 Jul 2025 18:44:00 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 747AB178C789; Sun, 20 Jul 2025 11:40:49 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/7] blk dma iter for metadata
Date: Sun, 20 Jul 2025 11:40:33 -0700
Message-ID: <20250720184040.2402790-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=demA3WXe c=1 sm=1 tr=0 ts=687d38fa cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=uDLVS1ffcISpbTSFWSIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MCBTYWx0ZWRfXzFt3fP5UCZRI r33tl+hEk+8GYI0EHmOvgRaVm+m71j5bfEmve1RW6tSxO7kPWkxQNH0ZV5bZUIpLa6bN6YXZiy4 TbGeMm7hknHgbxN3UCwCBnFLJ+kFS9igsa9xsIE3NI86vrAWOtHqJs4gRM+GvP9TCZteTmTKH3P
 wQxmXpDDGPqIvjZfsEV3HKD/Tnj5EfVA83B4PHqVWFe3yaF/vMiMjG5EIg7HFCONORNHNj+5cVz X5Qj0MQ5Z6VjfZqF7rf1GS9YMuIRxwXMfUorHC1LS04/Qqr/Hnst6zb9dfFSQQVcyEbUu+a2+lv fBniETIdjH3DqdWj3Mz57uO/hWQb6JdUd8Irh3yIhv1fPR8rfYF5ilRKwIu4CZAy87Bto2DxUx7
 brlKzWe5dvBboTlk6o8DSaiXnC7OxCTUtQyqc1TPD2zgH/TDJUtk+9HDjCSd7JtCk8v1uHCT
X-Proofpoint-ORIG-GUID: Nk8TFO3l2VMsAHLD3qKYvT-Ef4wI9Qed
X-Proofpoint-GUID: Nk8TFO3l2VMsAHLD3qKYvT-Ef4wI9Qed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Here's a new take on the dma iteration for integrity requests.

The current code still has the integrity payloads subscribe to the
"virt_boundary" queue limit when considering merging and coalescing in
iova space. This is an unnecessary limit for nvme-pci metadata SGLs, and
it currently makes testing merges a bit difficult.

Changes since v1:

  Provided a bunch of prep patches to make the current dma iteration
  more generic to reduce code duplication with integrity metadata.

  An nvme optimization for single or coalesced segments

Keith Busch (7):
  blk-mq-dma: move the bio and bvec_iter to blk_dma_iter
  blk-mq-dma: set the bvec being iterated
  blk-mq-dma: require unmap caller provide p2p map type
  blk-mq: remove REQ_P2PDMA flag
  blk-mq-dma: move common dma start code to a helper
  blk-mq-dma: add support for mapping integrity metadata
  nvme: convert metadata mapping to dma iter

 block/bio.c                   |   2 +-
 block/blk-mq-dma.c            | 173 ++++++++++++++++++++++------------
 drivers/nvme/host/pci.c       | 135 +++++++++++++-------------
 include/linux/blk-integrity.h |  17 ++++
 include/linux/blk-mq-dma.h    |  10 +-
 include/linux/blk_types.h     |   1 -
 6 files changed, 207 insertions(+), 131 deletions(-)

--=20
2.47.1

