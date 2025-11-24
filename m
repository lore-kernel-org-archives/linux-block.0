Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18C3314B60
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004169; cv=none; b=glkAo701G9i4GK+1rnibQr3cbJ8ti48hgP6XsHZ8CBZKH0GuUlweaT4LYcdg7u2lRJoRJ2/rtgJ+LDAWEJDVc2HpAYdWZKuJtsBfWpSbkvcPOX7ybGivLDVgQKBWKzrW3HnpbKUFk0BSl46FuOvfxjSOLyeauwAkBI5RargPdgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004169; c=relaxed/simple;
	bh=uoYeTVO/oNx7JVivr+YReXOWFEc0wL2JJKTh1X9OQXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RW/qDPfNtRl3LOSMMnhWrgSGQ6hPBvJnQAYX6p74yJeL+JHqdP8YsjOTstveT2Qur2GxIfmf6rhBaJdi38LM72tahXczwdDeLM0RVdnBkZhkdp9MYQQRFrL8kGbn8SuX84BcLgNe2WlIJp2tL1vkhoE1mRGKJQd9QKmYeGJrLUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=rLC20jJd; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="rLC20jJd"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOEZolC2694097
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 09:09:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=t++cTXL1wgV9wEspodYuYmUnkMprtJ4AbLORX5XRU70=; b=rLC20jJdF6wx
	OqPr3Nc2KYJzeYeyuzvy+94qT/+0Y7UV4HANjIDpCuIG3dYTmP5IoM0TIsdGsAvI
	fmtzDoUfcBWLWu2NSF1yJxDKsvXsJGgUxSrjOooeTMDql2EQcdaGU2fr1BIKxlCG
	p+YRVq9dUhEe7TvrpiIGRFl3+TDkUds3giWO8OmHJ0Ez2ubPqqsNZFUxJ4tewdoQ
	toQgu8QOc+bcqqidLcHta2AXbpY/44l7k5sX9kluzSRv1wpUB4CUTehT3hoezI9M
	v34dUE9gONSJvsUZ8KL558x60T/+GzFGk/byr/FFb+tT+7wc66I5CZBte1fF859b
	cbtQ8o79Yg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ams9119jt-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 09:09:26 -0800 (PST)
Received: from twshared31947.34.frc3.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Mon, 24 Nov 2025 17:09:16 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4ACE241D0F4D; Mon, 24 Nov 2025 09:09:08 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <dm-devel@lists.linux.dev>, <linux-block@vger.kernel.org>,
        <snitzer@kernel.org>, <hch@lst.de>, <axboe@kernel.dk>,
        <ebiggers@kernel.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/3] block: remove stacking default dma_alignment
Date: Mon, 24 Nov 2025 09:09:01 -0800
Message-ID: <20251124170903.3931792-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251124170903.3931792-1-kbusch@meta.com>
References: <20251124170903.3931792-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nOndVnvgv-09sITKS3H-AKjts-YdkIWm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDE1MCBTYWx0ZWRfX0v1BbCG9OOV7
 HOtQOgTHFT1/QeyXnsbRtrrZ4cmcnZnZ4f7CF7yLgGhlhtHaYDZ1M6M5RPj5/MOub3Lj+J9Owsk
 7EtxZlRVd2rFEL8jLaLV/MKUHKmlzme1rcwtNs8XDK8/6u0a/oAdV05ykkBMoziKhsDMvM3x6UN
 QfHm4af5eflCiqs7/aq1JEh95Sc9teI54zjiWXEtRkINTvSB0DQ6jctUecsInPjgDyb1RNdwVT9
 EI2ml3c40djN/AYInsmxqv5VgrHvFG7A0nUoyokPzETnuFU0mdbMqezAwBhP4PLIs4I/gxtyoU7
 HjwkanD9als/JZ98E4IxrZ29N5Q/XGaZZ4e7mpLHLDxLDzouDPEAyJb+gPhJSvH9K2PIa67VWU/
 l8+5OIr6KL5CREbCZPG00Rc0QMGP+A==
X-Authority-Analysis: v=2.4 cv=BL2+bVQG c=1 sm=1 tr=0 ts=69249146 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=wfdUoG3Gv6Dt7mlkbiwA:9
X-Proofpoint-ORIG-GUID: nOndVnvgv-09sITKS3H-AKjts-YdkIWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

The dma_alignment becomes 511 anyway if the caller doesn't explicitly
set it. But setting this default prevents the stacked device from
requesting a lower value even if it can handle lower alignments.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-settings.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index b38e94c85402a..2a7cb46973440 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -41,7 +41,6 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->physical_block_size =3D SECTOR_SIZE;
 	lim->io_min =3D SECTOR_SIZE;
 	lim->discard_granularity =3D SECTOR_SIZE;
-	lim->dma_alignment =3D SECTOR_SIZE - 1;
 	lim->seg_boundary_mask =3D BLK_SEG_BOUNDARY_MASK;
=20
 	/* Inherit limits from component devices */
--=20
2.47.3

