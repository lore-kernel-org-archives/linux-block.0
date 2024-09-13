Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC6136330
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252153; cv=none; b=IjKbhDEX8BmFrJ0Uxl8UM/i8GnnfeEYCsDN11c//ClZesHgBp0zZIJG4uyoe61cJglbpsIvpQipHRNarlTcrSc6/JcMgsXR6cQFCdjuDlNlD92DzuyKa4lZREkSi4bSQOTGeYPF5sQyzhSRbpDrMGDWadFNIoFvFkzc33SCR/+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252153; c=relaxed/simple;
	bh=iz1+AhRMB4Jo0p2TIHTuDSLNf7yS85rfXZrYU2zdXmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyIzn+t8qxCTS0QaEGt3tqAeExq5T+mG1fSWmCppWM5GlLY04aHj+TBPO9/0wubG/QoLuNH0ZYfeWJ+zLPVOHOMce+7W6mBH9YvXrV0unN3mdbcLT1cBgX21SLlzK6Gk+nilf5woMgCbaNJtkgLOJrwaGLtajzCwqMnlNBNwmfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eB+fO9Eo; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eB+fO9Eo"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DI2DVW032589
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 11:29:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=HcqXvo6kQUXv7b2KuuGjEPVoCjrXFP5rn6rmKQIjDMs=; b=
	eB+fO9EoWcqkHrsr+jKYMXy/ig+HbIx3QOvTL1B+tx8GyTuuSo8qmYi1ONuEzmhZ
	eoPg/TzVge+jXh9B+sW/7OIc8cSGNRyRrKLbmx/R0h12FZpIe10YMg0Ih0fDN8S6
	luEwKb/bjmpJipH4j7/SXRF7iUJ4K80wfFY1jac+K7sDLGPZGIt0R283ZFU8bYNk
	sy0gg1uvl7gzA4VS9kGYVrf5Wf0kD+orzpD67Bq43xdoRxJfJDFR3zyDwddCXpaj
	rjkv/8Yi9WBCdkc+i8b1vVrnUGtszd9119zdb2MOyJfZB5TkIcph9ug2z4u9UF0G
	efQj97VZpCIwBdiAzw06/A==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41mqb2sp7a-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 11:29:11 -0700 (PDT)
Received: from twshared13976.17.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 13 Sep 2024 18:29:06 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 97EB512F91051; Fri, 13 Sep 2024 11:29:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 8/9] block: unexport blk_rq_count_integrity_sg
Date: Fri, 13 Sep 2024 11:28:53 -0700
Message-ID: <20240913182854.2445457-9-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240913182854.2445457-1-kbusch@meta.com>
References: <20240913182854.2445457-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: gIPg2NDKfxygI19ZmjOb0k2k_TXwMX_V
X-Proofpoint-ORIG-GUID: gIPg2NDKfxygI19ZmjOb0k2k_TXwMX_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01

From: Keith Busch <kbusch@kernel.org>

There are no external users of this.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index ddc742d58330b..1d82b18e06f8e 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -53,7 +53,6 @@ int blk_rq_count_integrity_sg(struct request_queue *q, =
struct bio *bio)
=20
 	return segments;
 }
-EXPORT_SYMBOL(blk_rq_count_integrity_sg);
=20
 /**
  * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
--=20
2.43.5

