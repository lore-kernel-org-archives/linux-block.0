Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5ACDDC5
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 01:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779930074; cv=none; b=ocg+523C5LSQ91hDCL86xuJC3myBzpPpDFEqogMzSAsZ7OnQcIJWgCAt7koooRed4kiL7EdRwvqMTb669aVC4ut29bzP5AhF5XlbmRKAoHucQjLC/mQkkx3wdPHNlCkahS8WEn5kmqAXW5G646q9Lf35MM1v8IQ7D3ZMkbpQRjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779930074; c=relaxed/simple;
	bh=5FT2GFfVX2I1i5a488wDgLyfzLPJSqyFeNgMBgEVcns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvCiZ+K0USFAXfAhAlvpJGUz4IzoDfBvuO8AkAIj65+FSJx+x09vQuZkU0pFOrG3OWVQiauYWFenlmr3diHglFIvBfu+8TBn5JItQtKIwdFSK2/QPll045jW6+md3B5Tzhu784FnM/Jqo45oDCpZAGmLR8KsRbXFIl/ER5XS/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ocZksARZ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ocZksARZ"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKjHom4094134
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 18:01:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=WOofK0Nj07KI3RlrPU1SpwwDKUz1V/zDmsROl/EeEms=; b=ocZksARZwkZr
	ZdS9rFdL5aAOdBeD4dUgVPH5kYdTxNCyU2qtXdq4xPCBFVcAisT/MWaqR4MndGVR
	jsQgTj2Jj3AlZUh0SrOFMIw6DPlptX/a0lYYxZPCMidZ4jX9RWyavgUZuFsVD0BZ
	2k++dIL0PhL2sExi5gXxEfIjXeGVvAmv6WeoA48DWLeSJwG35JE+plT4JNbtq12t
	XSrUKYAHvQyz8/8a9sOMndE3+HI2qTmMop81wyHJ7SE6UE7YN2hLXUweRFpj32Lw
	2M2yMkDiR82QOZ2rOezWbFkrhSdqG+UEW2A4IWnBcK8wzA9OLpbIjShQH9jy27sU
	BAcZ1mZf5g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x6986q-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 18:01:11 -0700 (PDT)
Received: from twshared114832.14.frc2.facebook.com (2620:10d:c085:108::150d)
 by mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 28 May 2026 01:01:09 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 1D14F1D39B577; Wed, 27 May 2026 18:00:58 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Nilay
 Shroff <nilay@linux.ibm.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCHv3 2/2] nvme: add support multipath passthrough iostats
Date: Wed, 27 May 2026 18:00:41 -0700
Message-ID: <20260528010041.1533124-3-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528010041.1533124-1-kbusch@meta.com>
References: <20260528010041.1533124-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NstHg5bziCvR4DelyNJ5VfJcckwraPiT
X-Authority-Analysis: v=2.4 cv=TdymcxQh c=1 sm=1 tr=0 ts=6a1793d7 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=hD80L64hAAAA:8
 a=xT7lm6qD1slQ1dElJxQA:9
X-Proofpoint-GUID: NstHg5bziCvR4DelyNJ5VfJcckwraPiT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDAwNyBTYWx0ZWRfX8SjfCqe6d/yO
 sqd7QKF2OiqC4AlPFBJWlHdH/UKJfNoorKUTe447RL6PG8h0nsu4ASlG9k4o9PWbK2RxaFBV7Sg
 afdpkSlS0jv6H4uvhwTNWHfLDsJUEDozQr++hpNZly9DIIk47UaOdKNPsIb4zM63p+NWfiu6EUk
 Zcx3erB6JDhwwUKmkF5yJA7P/n1b2s6w3gjDJNS33zsb1eDTVtAnSz8n9+s28qnFn2kMoFt2avl
 RVBHaoFx8K/8Ug+QNKedbnkwoGkInoswNzfdOi3qo4ixh5byKtJwcQxK+Cay1S806u6uecykVUv
 rGLeo8b+ZXTRv7EPZI5RfYt8bsmvDoFC32rwXQARzkc8JTeF3r9R23Q3L/j2wbfAbOiYbQbsS2C
 3DwYQ4UJchqz/EywUAqSK3dfMkaj7ne5929cHrN1Qf5yLXjKuG7S/pbVZZn+YtC/5tjKFkDnHoT
 kiMClZaFXe/QTL3vwJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Don't skip the io accounting for passthrough commands if the user
enabled tracking these.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c     | 9 +++++++++
 drivers/nvme/host/multipath.c | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 08889b20e5d8c..664216eece4a6 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -102,8 +102,17 @@ static struct request *nvme_alloc_user_request(struc=
t request_queue *q,
 		struct nvme_command *cmd, blk_opf_t rq_flags,
 		blk_mq_req_flags_t blk_flags)
 {
+	struct nvme_ns *ns =3D q->queuedata;
 	struct request *req;
=20
+	/*
+	 * The NVME_MPATH flag is set only for IO commands sent to a namespace
+	 * with a multipath enabled head. The request is not eligible for
+	 * failover as passthrough requests also append REQ_FAILFAST_DRIVER.
+	 */
+	if (ns && nvme_ns_head_multipath(ns->head))
+		rq_flags |=3D REQ_NVME_MPATH;
+
 	req =3D blk_mq_alloc_request(q, nvme_req_op(cmd) | rq_flags, blk_flags)=
;
 	if (IS_ERR(req))
 		return req;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index ff442bbf2937a..bca8e7c975190 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -175,9 +175,12 @@ void nvme_mpath_start_request(struct request *rq)
 		nvme_req(rq)->flags |=3D NVME_MPATH_CNT_ACTIVE;
 	}
=20
-	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
+	if (!blk_queue_io_stat(disk->queue) ||
 	    (nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
+	if (blk_rq_is_passthrough(rq) &&
+	    !blk_rq_passthrough_stats(rq, disk->queue))
+		return;
=20
 	nvme_req(rq)->flags |=3D NVME_MPATH_IO_STATS;
 	nvme_req(rq)->start_time =3D bdev_start_io_acct(disk->part0, req_op(rq)=
,
--=20
2.53.0-Meta

