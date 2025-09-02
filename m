Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5826D4E2
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843304; cv=none; b=Avoo/yqzcZlZY2RqnXTWeyRCIjUI7Bghe8U8YYQsy09ORYnoTj+EAm50ezgVIOqnONihBeg9UNlj8J5yxGhW1pbKTceNQMBCK3G3Yh3wP8sA5ndS+/cnk3bgU1bb0BIcU7ilVMcmhXxeE4mpZMHSrgZ1wOg0x6TOKL+iRcr2VnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843304; c=relaxed/simple;
	bh=CKb0qa2EwVbAZlDXyciR9KwmzofMhiVf3/s7y3mEtnQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RD+kDp72bmUQcu3Qz7sWUkfw2WKhbt+1JgbPF0P2TrAd3vjyCKDPDPSg8FjamyVg+1WAxpkPYUKPirslJMu80XQtW72ekS63z9cc8GoxTUJYfkrZByvd1vrnGOTtgL13GBCv1eBNnwXuze9E+bi9ZvoM8RZwprGaw0PhGCyvN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fFx7tsOI; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fFx7tsOI"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 582IJahl4048692
	for <linux-block@vger.kernel.org>; Tue, 2 Sep 2025 13:01:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=9ORkJ89cvsyKX82bbv
	xxMnq3y50ntuJ0q7elgqyduRc=; b=fFx7tsOI3VbZjmuPYy/AZYAp/FT2SkEvQ6
	1vJQ64wdltI4YWHKv9vGHQUnoi5F03r4T17z4RGDk6lF375NfLlhWkLcTWLbqY9d
	etmeWCEqaldYp3mNEKApAyaw2iKaQZFen/cwCny9SVhbodm9s+oPWI6jCAYgR5z/
	qzyOSvUNAVYeoQRaMFVAQECuV7Ex3PEnnDmeal/B40BTQH0qCnEN4sH9Foq9PmMn
	u7tjs2Qk/Qpa6SxdL7x2aWGraGNHXh3L5UbGs94mLqjAdX4FDztwTEByeqTpPP4X
	gYl96WUw7v3Jp6IeobRQ5ZFmBgnPurxd4ZpqUHEtGVfbov5b7ZVQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48x5rtgsn1-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 02 Sep 2025 13:01:41 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 2 Sep 2025 20:01:38 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9A9B6142C455; Tue,  2 Sep 2025 13:01:22 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <martin.petersen@oracle.com>,
        <jgg@nvidia.com>, <leon@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/2] blk-mq-dma: p2p cleanups and integrity fixup
Date: Tue, 2 Sep 2025 13:01:19 -0700
Message-ID: <20250902200121.3665600-1-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: zPn1w0uNNsq0XK0dhMgWOYLvYvoDQ-GE
X-Proofpoint-GUID: zPn1w0uNNsq0XK0dhMgWOYLvYvoDQ-GE
X-Authority-Analysis: v=2.4 cv=duXbC0g4 c=1 sm=1 tr=0 ts=68b74d25 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=f_Omk_ncVSdtrnns-hoA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDE5OCBTYWx0ZWRfX2a7LXJfbrLw0
 09nyAMUmRwIkWFew4SZgiiF3ZvT6GRu8zpbCDq4e4Nlptm5cl1s2zpTUk418SdksR05LA+aiD55
 SZkWlvVHlndTPrVj48y9l9NlnQGJf7x43mzTDQ43MzZbx+QfZODybRPFp225PFGvdLh4RGsszJt
 EWUwUpsjyB9cczbDVBM3CObE2nzqHbAeyQdgNWoXTeQR6SFYuYodHooxf3hbmYzAaqFfbgt9J3s
 BRgZ83NuxBnNnvDZU4iwzJ0BhTr4VUPUmtiHquD8NV0wu3Vi2PrkCGT5L0pLvTwXYYVkKKmojnm
 p3uYe1A4RLue/C2hp6rAQYFxn25Qa5m5fDWwDRiTE4d2+iOHMM9EL0R50pi6EU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

This series moves the p2p dma tracking from the caller to the block
layer, and makes it possible to actually use p2p for metadata payloads.

v1:

  https://lore.kernel.org/linux-nvme/20250829142307.3769873-1-kbusch@meta=
.com/

Changes:

  Folded in a fixed to patch 1 that was inadvertently included in patch 2=
.

  Added review.

Keith Busch (2):
  blk-integrity: enable p2p source and destination
  blk-mq-dma: bring back p2p request flags

 block/bio-integrity.c         | 21 +++++++++++++++++----
 block/blk-mq-dma.c            |  4 ++++
 drivers/nvme/host/pci.c       | 21 ++++-----------------
 include/linux/bio-integrity.h |  1 +
 include/linux/blk-integrity.h | 14 ++++++++++++++
 include/linux/blk-mq-dma.h    | 11 +++++++++--
 include/linux/blk_types.h     |  2 ++
 7 files changed, 51 insertions(+), 23 deletions(-)

--=20
2.47.3

