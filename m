Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0386528689C
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668729; cv=none; b=oDfqwc0XSJbz23DdB6Vh+hJvNMRzScWUyLiVcADwffcwNpWMlIbsZ47bzVGBWte9IQsfdXS+juQ76I7bhUsPvv5JD45HWSR11gHDiQesItErd8iEnUq4Mpy9qX1U/jgclBS/077X37V4GQEzcqL3dIMAdAV0Tai3T3tbBaofgZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668729; c=relaxed/simple;
	bh=sIgBT7Vu1/n/e5EBmWiSawKpVS8eCmKmh8QU8V3hv0g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JtSdzc9uHEsBbWP/2kF6Y7lBlJkafiqPPkc0hXpLzLKMLh2liHV4QKwtE9tttNTcUv6yj4PsOXAioMozBHBPfXVPXb+l8eONsNMCIkSfmcHkouxg371JjC69VA1eLVsn8/qTg9KfX1g/gtBJMF4dd33wGZHXPF9tQk0sTlo8j7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=R1m+Mrbx; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="R1m+Mrbx"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 578FIqju012510
	for <linux-block@vger.kernel.org>; Fri, 8 Aug 2025 08:58:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=jFORdkuYpnBcFvG1gO
	x/i+B5cKvoQ9+xtADPU12ZRbM=; b=R1m+MrbxW/Iv0KVBdZiLhIFe4dX7FglyQp
	mrsoKDwYyGtuzyJ4xUrgDcmoMeAfoGWOsQoMPaInleEshwsgZ1mGxu2himhhOHf5
	8XE+h67PNej2L4wl79C6UNhqfyezFUxSS4V+axYZlYAd/rbpgGfXnOvoFjVoleXC
	WdhLsqr5VOyVNpj6yBRCS2VNrFkUdUs+5/1uVxLhhny9M1YKtmNDXOx8HKYL6mwU
	prASPf+HAxJhtdPOQyqx/wX9Ki8101xhmGveBFjoXxic2hy6yB2cAOdBeoes/yXY
	aiPpU0jyuqmaGIYjtA048YHegB6Zwefzr0C05FLzIwV0iCLQDtWQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 48d1x5xjtu-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 08 Aug 2025 08:58:46 -0700 (PDT)
Received: from twshared21625.15.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 8 Aug 2025 15:58:39 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 19B556C76BB; Fri,  8 Aug 2025 08:58:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 0/8] blk dma iter for integrity metadata
Date: Fri, 8 Aug 2025 08:58:18 -0700
Message-ID: <20250808155826.1864803-1-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyOSBTYWx0ZWRfXxK96nNYIwStF a5HBv15gUaaTt6glzhAt06pG9mRndpkaeMhh5gl3e4mOV+4YU2r8FKu2of41PYxkzTUvJrAB0dt kWBTswzFFqspCbkGgJX8lpRQOF4aiCvHHgbGSOWzaiW1sDQJ6qc26bnYTjbrUh3yQJ2O+ygKpk6
 S4phD9/msdyuzX01zQICkWqzriqQxAF2ApCVny6UxFL9TYiQnrpkIct6TZK7TudIWVx18GnGZlj YSgP9yNG8yI11BWuPnhiM4W2cSOm/VgCtHBGQWFcwieYzciNGRQEZBaSV4hX2XHK0dL5EcRQSsc GLW6Y3TvwT+bcp9kzANDgA42wvHlEW0WcURQC7N7OM6dxsQfSoOTN3YU0HPYcH5OfBHHWIvB63a
 Qz1W8vwphSonmdbOw6hujcYqz4X9dBK5TJk9ingluUWvCRu/Ea28eb0XwRz6KQnWlJuDva0S
X-Proofpoint-GUID: 4IoQhj4YycsUCXAX-cm0EwtB23cIZ19o
X-Proofpoint-ORIG-GUID: 4IoQhj4YycsUCXAX-cm0EwtB23cIZ19o
X-Authority-Analysis: v=2.4 cv=R4sDGcRX c=1 sm=1 tr=0 ts=68961eb6 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=QyXUC8HyAAAA:8 a=agJ6Vr9HkWBsIA0g1xEA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Previous version:

  https://lore.kernel.org/linux-block/20250731150513.220395-1-kbusch@meta=
.com/

Changes since v4:

 - Fixed nvme initialization for metadata total length (Kanchan)

 - Removed the now unused __REQ_FLAG_P2PDMA (Kanchan)

 - Fixed checks with CONFIG_BLK_DEV_INTEGRITY is not set (lkp@intel.com)

Keith Busch (8):
  blk-mq-dma: introduce blk_map_iter
  blk-mq-dma: provide the bio_vec list being iterated
  blk-mq-dma: require unmap caller provide p2p map type
  blk-mq: remove REQ_P2PDMA flag
  blk-mq-dma: move common dma start code to a helper
  blk-mq-dma: add support for mapping integrity metadata
  nvme-pci: create common sgl unmapping helper
  nvme-pci: convert metadata mapping to dma iter

 block/bio.c                   |   2 +-
 block/blk-mq-dma.c            | 239 +++++++++++++++++++++-------------
 drivers/nvme/host/pci.c       | 197 +++++++++++++++-------------
 include/linux/blk-integrity.h |  17 +++
 include/linux/blk-mq-dma.h    |  18 ++-
 include/linux/blk_types.h     |   2 -
 6 files changed, 287 insertions(+), 188 deletions(-)

--=20
2.47.3

