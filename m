Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23283283FD7
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006816; cv=none; b=ocT9mHUlWzy3vrDugV6qLbbpT5V7jRu47I9MXrUC66OksJeIXu8uDybgmz0z0zf8WksDMxmxKtlFHjtHrXJDGGGE6AGBuySLNcBaGb0qRot1MiCcy3GIG2njHBJsCWFiDMk1Xtge/MHQ3eMo8I4VaP3qETun+QzkVpt8wPrPoDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006816; c=relaxed/simple;
	bh=/7yFclhvz4UjH16jLbbT/rOR4vuS0bFAC++36p4AeHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1lHZ9Y3ZVsaXAtvuoZ45Gjczl+InrU52etrqudh2GhWTR5+WFWOM2OrGkorRuo+/tvrXvDLxxGLZhPRsbeTDSOB2FLOoDfp7u8/TB0/wrN0w/P4dc0VPehQyV46uYNEyDwJrEiHEJTjEokmTn52806EEezUWLk0Iu2elGwujQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=uvJlWBmv; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="uvJlWBmv"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDnqqU012173
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 06:53:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=aqd8GppnA9LGhePYAO8oJBoxHOWklKXHjgvg0kyOuK8=; b=uvJlWBmvSRUX
	kVCgZiXOOjFT/MTJQzz9chdxQpnvkfIvn2GisrAmaY598SOu3cu5Q0F03Zf2yyKZ
	M2NIWCcUpdOR8anXvOWbbhJ0rTWeZ0bFSQqKimr3e2znUCEiyZ+7nHy9lR2YaJY3
	r3BBpe1pxFFvb29TQ7nq99Y4e3BvR3XiDlYr5jEveznr7CFsqwHR/XJxTOKwjgcg
	FHtUGuSmIKrMKmL5nSwZM57IbCCO8A/I7b0PpXmQbUpISC0jWINFq1YvXWhsF5r+
	YBd1PKI2mzyRduxKSteHkyeIo+j3JuEIRe26+Tvomzqk7hukoFyI+KwhfqH5hIdX
	bCCYBdXSBQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48g5s6rrwh-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 06:53:33 -0700 (PDT)
Received: from twshared51809.40.frc1.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 12 Aug 2025 13:52:18 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 820078D4076; Tue, 12 Aug 2025 06:52:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv6 1/8] blk-mq-dma: create blk_map_iter type
Date: Tue, 12 Aug 2025 06:52:03 -0700
Message-ID: <20250812135210.4172178-2-kbusch@meta.com>
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
X-Proofpoint-GUID: i4Ppfel96YXDSlpVJwtxLYUP0ZHkCvZb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzNCBTYWx0ZWRfX5/FeQeX2NqdG 4DOlaI7ZFZCITDc1abCsfV9FHwcITqBW3ohwMb3oPZfpwT9mhEO4cLsE2PWgtBELj0UNeooBDE6 Qoi0d2JyrRQNh5NmZ3HJz8YPeBHZrCXIklhzfbTdKlKzILVnCFtr7RI1EZhL0AgGJjU6N17cLXK
 BZdcuL8DorVBUP6wKBL8OB34CvoYjOk4/wp7xF3HklMjUHmyFh2EUsQJksr9zIuDFZp0bZOPw6X f7dqUsmt3gyz6GKSoi/8GOPYynATk4uv+5nTIAx7oPd9MB2RS3Hn+hWA6X9CBirQte9Wl53sdEP Zxi4w/2WLlaUPaaV+uabO9AY7qzG/k70/iBMMFIiZevX7cg+EHizX7hpWGdOt8/n8H6tIJlkWpN
 Rcba7xuXSXsQNI59VMH9uqXgNZcUslIH2AmYGwigGukvNsgL7My1E0h9294omGXC79DBxgqi
X-Proofpoint-ORIG-GUID: i4Ppfel96YXDSlpVJwtxLYUP0ZHkCvZb
X-Authority-Analysis: v=2.4 cv=H4vbw/Yi c=1 sm=1 tr=0 ts=689b475d cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=1inAjTl7Go1hButXYeIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The req_iterator happens to have similar fields to what the dma iterator
needs, but we're not necessarily iterating a request's bi_io_vec. Create
a new type specific to the blk-dma api that can be amended for new
future uses.

Signed-off-by: Keith Busch <kbusch@kernel.org>
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

