Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD30B2F860
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252153; cv=none; b=CSwyp+/WNrkgM7terNzm7hDLkHTKUCTkbaz3h/3Qrlnb7Gij/6CFbFdFD0u3CDYWOHPUqnHZO2Xx1VyjZezqrzstOg6seyZsHJraLCy0r2h6HgwppyMCLKjbj/BphU97l6IET+96rwqAQ0j3OlGUnZYQ1HMYIq3Wexl59dQ0Ctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252153; c=relaxed/simple;
	bh=XoEpw5S2u1wXeN3nCPq1cfEK9odrIn7xITR9y1OrN04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFOiWCHvITeUo5r4jWO8ujl6YTQlU2myQ0Ouv2584aGbAXPepAmMr4fhMI70UjlbESxa+Jo/Z9A63C3Fb4WyxKOgE6r1dnm+t0zZ8E51hXzfk/ro8RloplJZsNgCvGDxrC/0XNK2EZZUeemookOFg3xaDexF1G+/sh/Xa1zVsDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FWfIdwSH; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FWfIdwSH"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DIANFJ018518
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 11:29:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=ol2Diwm840wEdv83fl13zLXO99ZYV29lYaH8A1zftr8=; b=
	FWfIdwSHCEfZy0/YTni/5H8bHV/misFA2GgOj/n3yB5SebLo5TLlhZfU6T0Tf3xF
	IzV8Qv/hEy2VO139ORDsrNn+Plvv7DpxeG5YK+xdCR3LejNSKLi3kqqRC7DTr4TJ
	nRbA5hDFBPaHM008rv+ZX7VYuOhmoKaIxWg7n8hqp0RDc/a6rzWCVcf7HrT2XzLQ
	ZUPJRfw0Nat6+U0UYLAfeS6d4F9rBdbxMzJcs3yIkA2dHUa4emeaR+eORxCU8oM7
	IZX0eUw8cUmvRoZBsrSN7Hiwebd6kau1TsxmASEgXceKWMoQoXpYbswgs55n1/U3
	CK/6wgTwmdC5YqvHrlfQuw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41mte705nd-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 11:29:10 -0700 (PDT)
Received: from twshared0911.02.ash9.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 13 Sep 2024 18:29:09 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 56D3E12F91043; Fri, 13 Sep 2024 11:29:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 1/9] blk-mq: unconditional nr_integrity_segments
Date: Fri, 13 Sep 2024 11:28:46 -0700
Message-ID: <20240913182854.2445457-2-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: jSMZ2ZE72jAPAeqxZtAw89gMCPXQrUnS
X-Proofpoint-GUID: jSMZ2ZE72jAPAeqxZtAw89gMCPXQrUnS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01

From: Keith Busch <kbusch@kernel.org>

Always defining the field will make using it easier and less error prone
in future patches.

There shouldn't be any downside to this: the field fits in what would
otherwise be a 2-byte hole, so we're not saving space by conditionally
leaving it out.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c         | 2 --
 include/linux/blk-mq.h | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3f1f7d0b3ff35..ef3a2ed499563 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -376,9 +376,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_=
mq_alloc_data *data,
 	rq->io_start_time_ns =3D 0;
 	rq->stats_sectors =3D 0;
 	rq->nr_phys_segments =3D 0;
-#if defined(CONFIG_BLK_DEV_INTEGRITY)
 	rq->nr_integrity_segments =3D 0;
-#endif
 	rq->end_io =3D NULL;
 	rq->end_io_data =3D NULL;
=20
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8d304b1d16b15..4fecf46ef681b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -149,10 +149,7 @@ struct request {
 	 * physical address coalescing is performed.
 	 */
 	unsigned short nr_phys_segments;
-
-#ifdef CONFIG_BLK_DEV_INTEGRITY
 	unsigned short nr_integrity_segments;
-#endif
=20
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct bio_crypt_ctx *crypt_ctx;
--=20
2.43.5

