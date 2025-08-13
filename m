Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43A257422
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099141; cv=none; b=T1L+MXtickIFscUkJf4b1F3tgDjdNXG/Ky1Ii6dyBrVZECTAiarV71YLq9uSOGUIvGrF5L6q2rj34APkz04QZwlqqzzlCKtBhXigOOlk7Yn6Qw9PB/lEHrknuNAa/fqJ8Yl8X6qP4UjGgJVxBP/DD5a+I/MW6fHSSMKF7+vdKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099141; c=relaxed/simple;
	bh=vTK6ef2IAu6EzTB1gl0jY4X0idvbwPIa6/MFmQhHRGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvZSje7c8klRl+q877A64khJCTqpG2XNi4PtH+nRowAGOl9RoRHpH797f6XcVWKgfvDj0EH+RN4wXeZzr9pBoNDj2Hj0V0RspFjce38RVY/ZFnkT4XbvbdIwwHdVX/wyFSPvg1S2HaP0BkQsWNOF9mZsDgQDJXg5bqkohmou97k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dYipxKqI; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dYipxKqI"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DFB977031008
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 08:32:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=0lUwFCMGofO6tWukzpZ/9pJw4H5jiLYLGB09QF+xWrY=; b=dYipxKqIajug
	/xKWaR4YYlk7DJc+kbRCTJaoLO4GTZZWDDYerrkCtVZpklRuKeeIqvO3FdrcVBTW
	lpLRV82QdqaJDdwei/6o3jkDCx8XBvp/kB2w1K7Td/n/wT+Uk7JfxorKjoNMkWdI
	0TmaiiE73kEiIB5XTDGvOnOIIDMazJTopkaST+hkPPiLB2j0xZIhJag/QdF5a/yc
	8co/RsdQ+QFY8RoIuexVWA3r71RZN0JvFS5Ovn3uyqv/clZFYcV05IrzQqpj5cEk
	vHONVxvkobOjDOB24AgdxDiArQeMTZ3JY862UQSyxl9azoEM/wj0vumMVfxMudcd
	0Encr0z1GA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48gpru2kss-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 08:32:18 -0700 (PDT)
Received: from twshared42488.16.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 13 Aug 2025 15:32:09 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 3D55F97CD7D; Wed, 13 Aug 2025 08:32:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv7 1/9] blk-mq-dma: create blk_map_iter type
Date: Wed, 13 Aug 2025 08:31:45 -0700
Message-ID: <20250813153153.3260897-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813153153.3260897-1-kbusch@meta.com>
References: <20250813153153.3260897-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: l_650XQqsY3rD6u5G_qhIXkahctr61OF
X-Authority-Analysis: v=2.4 cv=JKM7s9Kb c=1 sm=1 tr=0 ts=689cb002 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yZlJt16GNrEBTkNGrycA:9
X-Proofpoint-GUID: l_650XQqsY3rD6u5G_qhIXkahctr61OF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0NiBTYWx0ZWRfX/uVqkgDtSljh LIGdw3/kmEoLs02c6vhs/if3Y1fyIepxAlJzGDIOsA2FK6mUgA4CsNA2W+oK6xfcw1icym4pbab MQrKK6ckkeWvb82NcLPBPKyy1/Fu83cEYWlTta1pQNIMoCy/UJt9sr0ag/ldQuXZlZzllRKUkKE
 0FB8N41d9uzmJMJdqmiN20fdeTxQBid+8uRmMZQnfZXyEvOP0gf1uvdVTysi03VlV7o97D4LW7M qFn6ZZi1YSsOhKuGAJDIvYQUqfd+HyMyU1BDbfsFNIytkWSp69/zIddltYVminzAx5Vf897fm7m GXwQtxg309VwImDI/rgqhsN3NkPQRte/SJ+ODd5EBVvO6jIhGpU0nPM1MaYVu18Q2y0hVutPmIo
 IHNyrQ+z5hpzkMnvF2YFclxzHiZw3hORmCKQq5kGfs6aecO6GAinLepwsobCAvNLuABfiS9C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The req_iterator happens to have a similar fields to what the dma
iterator needs, but we're not necessarily iterating a request's
bi_io_vec. Create a new type that can be amended for additional future
use.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-dma.c         | 4 ++--
 include/linux/blk-mq-dma.h | 7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index ad283017caef2..51e7a0ff045f9 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -10,7 +10,7 @@ struct phys_vec {
 	u32		len;
 };
=20
-static bool blk_map_iter_next(struct request *req, struct req_iterator *=
iter,
+static bool blk_map_iter_next(struct request *req, struct blk_map_iter *=
iter,
 			      struct phys_vec *vec)
 {
 	unsigned int max_size;
@@ -246,7 +246,7 @@ blk_next_sg(struct scatterlist **sg, struct scatterli=
st *sglist)
 int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
 		    struct scatterlist **last_sg)
 {
-	struct req_iterator iter =3D {
+	struct blk_map_iter iter =3D {
 		.bio	=3D rq->bio,
 	};
 	struct phys_vec vec;
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index c26a01aeae006..6a7e3828673d7 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -5,6 +5,11 @@
 #include <linux/blk-mq.h>
 #include <linux/pci-p2pdma.h>
=20
+struct blk_map_iter {
+	struct bvec_iter		iter;
+	struct bio			*bio;
+};
+
 struct blk_dma_iter {
 	/* Output address range for this iteration */
 	dma_addr_t			addr;
@@ -14,7 +19,7 @@ struct blk_dma_iter {
 	blk_status_t			status;
=20
 	/* Internal to blk_rq_dma_map_iter_* */
-	struct req_iterator		iter;
+	struct blk_map_iter		iter;
 	struct pci_p2pdma_map_state	p2pdma;
 };
=20
--=20
2.47.3

