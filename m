Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA743446B0
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413240; cv=none; b=dN9nVm8qiEWbZ4LhKwFTjstD1LxnPPFVatgZF44IRq3zhJlGYawIUhEkWFey4hoYbMynTHszaEPk4DfBgFcCBVJllLZhyKmJn6vJ+CdUxFpcM1mJN/8a9kFygQuTd/xZU8gDNuGlnnz48YhVbjV84R+QEm5Czij31BIfucmBIE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413240; c=relaxed/simple;
	bh=EZl1Zpu311+UaLdcH1TjXcbNSDI4FgArW73LcYkGEas=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGCCvZUQwtkV6jh4NjJTUM+bIAx7fWttqbvy78PTpzvt2Tt07rdTxbq8/euCd4Dus0TAk+jQY8j51IBdkAywFRnKxkNlhYnLBNoMAgedkc9abJrcjTIMKRORM3IeC0fhps0Y2Zt20QI7Ckezl1guKKCFI6ZbZCdRepWocn19nNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=byXcXnep; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="byXcXnep"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DDtWp32954810
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 07:47:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=UP2hK2eX/saeHSZLDr3Hpsk2KdjI33GdK7J7L8FP7UI=; b=byXcXnepk6g6
	dG/cLKPu6Wzt12T3Sa3juB9BKBD45BnfFzBBo/4/WlhuZDwcjSmPzaMt1YG0kjxG
	UtJYs2cs2VWK9p/XkGPFuYXLI2ydA+Nx8x2vzEPJbDtf126JxGNOn9VVeKeitto1
	6kfcV7BIoLKh6XWrd8ggAeI1sGl7IzyrJOQxbdMFm4Rh5rSS64rtqC4gXHX2b0xo
	0vq+qArjT3rpit7wLCdP+fd9/LSpUkeWR67yZME67SB6fN6oB7GBzeT4MSj0A1M+
	lLa4bw6EGhgbZrJoBE6tEkzg5wmDBJ2jclgaYSFyy6wXcjVGF+0jtyaKOwYzg2Fe
	L1Bu6MTHjQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cvkw48n0b-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 07:47:18 -0700 (PDT)
Received: from twshared17475.04.snb3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 13 Mar 2026 14:47:16 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 0BB0DB3BB9E5; Fri, 13 Mar 2026 07:47:02 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists-infradead.org>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
CC: <hch@lst.de>, <martin.petersen@oracle.com>, <csander@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv8 2/2] ublk: report BLK_SPLIT_INTERVAL_CAPABLE
Date: Fri, 13 Mar 2026 07:47:01 -0700
Message-ID: <20260313144701.1221652-3-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313144701.1221652-1-kbusch@meta.com>
References: <20260313144701.1221652-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Y0KbE0dlhAlacLvVBwIaqt-d1bkGckb2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExNyBTYWx0ZWRfX1dAk2PQM7x8A
 DE8Auiq1zRfD6RaZRCkHggHMFxZ/luD+p5EGGKlCa51eTtgt1Ki8XXPslZ/V7tte+xF3n+7kwOD
 Cvts/FD3tHoiQ3nItK331nitLfXWr9onTOI0RjW6EY6K9Nc92UltjE+9K9mf7Hu+esREqeDx8GJ
 V2uZgYyAgOLZ0jFmnI2TZqh9cadfL3b6ZA069il0/JF88BHuKurL1h1pWfDSXTcTI4aIS0RF65B
 nNDE4v7u9RG2JEzNXqtZwV21MSfwCcUWvjbN6WXVKZuc7B3igsGpeZsULTPUJBDo4j8xTxvKUJa
 DdT971ZbYxdEFRDwbCbIaFp4cTiIJU/FmYQVSUptdYQ0T9KNh3GaWofkh9HPiehKA2Eo1cU9OY0
 20sIlgIDfRa6EBJDOuVHek0Qc7G06legCz/CEDijOiv11BsROr5nIe8RRotYDviaueLW8uhSm8u
 2CCmdCKecIBR2NjP99A==
X-Proofpoint-GUID: Y0KbE0dlhAlacLvVBwIaqt-d1bkGckb2
X-Authority-Analysis: v=2.4 cv=XvL3+FF9 c=1 sm=1 tr=0 ts=69b42376 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=WTJdmG3rAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=O2R9A2DNrl80SOu8WGEA:9 a=q3NGepEMMmKWaCv8Sx90:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01

From: Caleb Sander Mateos <csander@purestorage.com>

The ublk driver doesn't access request integrity buffers directly, it
only copies them to/from the ublk server in ublk_copy_user_integrity().
ublk_copy_user_integrity() uses bio_for_each_integrity_vec() to walk all
the integrity segments. ublk devices are therefore capable of handling
requests with integrity intervals split across segments. Set
BLK_SPLIT_INTERVAL_CAPABLE in the struct blk_integrity flags for ublk
devices to opt out of the integrity-interval dma_alignment limit.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 004f367243b69..34ed4f6a02ef2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -808,7 +808,7 @@ static void ublk_dev_param_basic_apply(struct ublk_de=
vice *ub)
=20
 static int ublk_integrity_flags(u32 flags)
 {
-	int ret_flags =3D 0;
+	int ret_flags =3D BLK_SPLIT_INTERVAL_CAPABLE;
=20
 	if (flags & LBMD_PI_CAP_INTEGRITY) {
 		flags &=3D ~LBMD_PI_CAP_INTEGRITY;
--=20
2.52.0

