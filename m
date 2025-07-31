Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07441D6193
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974330; cv=none; b=TLctnTliYt1REnaZS4AvPu00d6K5R253iQDVJ66NgrPeqi0QyGjEWV9ouYnlU0YQuV9T4oosZpf8N70Q4wsvkhfK5lGOrqh6HENgTcuvw3WbLD9HMKps4aMm69UCWJCfABU5TLULbK7ZAkrvvIBgrHD5pnMt37fwfwQjQgrPx2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974330; c=relaxed/simple;
	bh=n8SAv9CEDTj5Os+IYGHRPA9UJN15Ip/2lStdIIj2GOg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pVw+HaGZU97dlzqTBAJp/mqhpxpl/etDEae3r7JTGIWXbLmXLyDhoauiPuq/7vtx/xf/PfNK1qfjjywebFP/YCuaXhuLvRLRD/O+9KAnzEWaNdFbCudoq9mORdxD3+odbVSarAgDWOfFPyoKSPtt5JiDdBgr7kS0APBq89gmmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Lpic8GQO; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Lpic8GQO"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VE7REM012264
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=dHyeKnG3m5lYgQY6OD
	04dVFvOoVjGKnoxFkIYe4DwGU=; b=Lpic8GQOR4zVD6swRTSyk5gGUMFaRtWxvY
	Y4ZaEb2YWz0TrVb6RUAhn0OAnF0SCPvTtriiWoICOzN0bnfsfDd6svWSubd6XGP6
	qBiGmdwQ41f6gwy6xCgXpItNKfs3Ri/tkobAa5FKRuGvEBPWz8hm4plB28TsUXFe
	2o7QgSuQLfzzI7T0arN9bYIGtJsAFzePA02MHKUcjpCTyl0LErBOAWbGCqurD3OY
	AZYHRjyk/G13lDaAJKH54rMepl7QlcJ9xuOShprmSLKCbCUrUTsUS3HF0L68Dmc6
	OzRZsT6Pc3JzXVwYtOxTUpHtcAFohwVZ7tzwJTISTCw8Du7dgUUg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4883mj2k83-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:26 -0700 (PDT)
Received: from twshared0973.10.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 31 Jul 2025 15:05:24 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id E4D0B231DA6; Thu, 31 Jul 2025 08:05:13 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 0/8] blk-mq: introduce blk_map_iter
Date: Thu, 31 Jul 2025 08:05:05 -0700
Message-ID: <20250731150513.220395-1-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=K/giHzWI c=1 sm=1 tr=0 ts=688b8636 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=0iyWCkrW18D_fWTiA50A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: ZZoBqQM7Am5YaFjH1tRfUtD_msSX_WkK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMiBTYWx0ZWRfX4v99dp+iZ8/f KrE7vy25XAwYac4nLUGtvtCJFmOLQe7cIJFozi5wIAL/7Lj6Jmo2JJgcv9A7DwoIIQw3wo5AzVq eVNxGN9oAQ4VwOpXeFgKyC2OS1Qwt8YbbfonMmwhQWLGUnp8dWqOTKFJmMUL65FPsntVSTl9vwp
 2/A5FBmFjHCUtcAz66NNNy5L6rz42gJUKi6pgye7q/5udR8IPvu7tURus5JF+7/7Lh50wGh9Nnh aFgzk3bSvp1FSF0W9mRR3tvM7rBOqhhLK6/Fg+BZjOH9mQLW8EX6F8QP5iCxxz2bOaP50Uh3rHW rhbc+hk04/qDvEp6y869m7OLKdg4yz3MRKTwPqnieVKBurXlfo9f7uTRbV9Z4U1DIXLCGERH+/o
 VIvn6uzpT2XTjDFkChkfw5Xih4M4eUMJ7Cb/BJQG6ATz2aZxDVGIhPH8mmAftVQWd3mA7r6Y
X-Proofpoint-GUID: ZZoBqQM7Am5YaFjH1tRfUtD_msSX_WkK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Previous version:

  https://lore.kernel.org/linux-nvme/20250729143442.2586575-1-kbusch@meta=
.com/

Changes since v3:

 - Fixed special vec handling

 - Fixed address check for dma_mapping_error

 - Fixed nvme leaks on dma iteration errror

 - Added an nvme prep patch to reduce code duplication when unmaping
   sgl's

 - On the last patch, I retained the previous MPTR setup for when a
   single integrity segment exists for non-user requests. A code comment
   in the data path claims that is more efficient than the DMA iterator.

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
 block/blk-mq-dma.c            | 237 ++++++++++++++++++++--------------
 drivers/nvme/host/pci.c       | 190 +++++++++++++++------------
 include/linux/blk-integrity.h |  17 +++
 include/linux/blk-mq-dma.h    |  16 ++-
 include/linux/blk_types.h     |   1 -
 6 files changed, 279 insertions(+), 184 deletions(-)

--=20
2.47.3

