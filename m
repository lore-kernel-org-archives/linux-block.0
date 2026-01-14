Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A9B39E6EF
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405285; cv=none; b=KPKMpq3HirNiu/EAdWj/2m2FsdwNdERqYQs8cCgdhBjin7RTS4Q4CP1WX7JlaAkpq7FVch1pp1e9agkNHj2uF0RCXH/K+2tk0EwNAKW6qQr9A5tkBQKn40TZy3FmlH5/7fF/JHN1Bqy61600bk/rYx9WgELoOnoWSvCYXVcxhaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405285; c=relaxed/simple;
	bh=uoYeTVO/oNx7JVivr+YReXOWFEc0wL2JJKTh1X9OQXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEIKkVJMtplK7iKPNcNShwhhK1fUtYG9TB7o9cx2cG/M3oG37lUgozpu7czMGPH4fHt8IniftN6l4oa2a+LXUh6xltQF208ts++hrtD9MrgIlQazcN59zpYOkjBBbSUrU0qEy90a18eeZvTDhCliffBerB8sBhM6U1x8zM/hqK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Msk8AYLl; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Msk8AYLl"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EETKbY4028387
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 07:41:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=t++cTXL1wgV9wEspodYuYmUnkMprtJ4AbLORX5XRU70=; b=Msk8AYLlS9ks
	3s4Hj6Q2bZAhVsqVPYaQhFD1L+M6DzSLyB7+dmhrgjD7pdDbwQler9jfSSeY919w
	XtsvdEIsJITlgTb1DLDWbb37VeSF9ZvuPd6J2WxGUTB76QZyUALkqFsCrH7RRhbm
	qvZ5++Q5/2o5EHoXscpm0ZtE9wBFr4+xm5ZZM3xzJlveIMkU4Jf5KPhqHnxhalyL
	XEZU9KuDUq40y5Tje2rofJoT4w8s/GZT3wgzhyBEfRYD5vvP3zSZwJuFVcNUqHpa
	1OyXBPZdvOO2VxxiUtP0xA1RtJEcNJAlGwDvg/rNAlfo79lYR8NeAVVaTaINDvPz
	b2iV1RooGQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bp6pwug6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 07:41:21 -0800 (PST)
Received: from twshared18080.32.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 14 Jan 2026 15:41:21 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 02BB563A8FF9; Wed, 14 Jan 2026 07:41:13 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <dm-devel@lists.linux.dev>, <linux-block@vger.kernel.org>,
        <snitzer@kernel.org>, <hch@lst.de>, <axboe@kernel.dk>,
        <ebiggers@kernel.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/3] block: remove stacking default dma_alignment
Date: Wed, 14 Jan 2026 07:41:11 -0800
Message-ID: <20260114154113.3207790-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114154113.3207790-1-kbusch@meta.com>
References: <20260114154113.3207790-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=GYIaXAXL c=1 sm=1 tr=0 ts=6967b921 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=wfdUoG3Gv6Dt7mlkbiwA:9
X-Proofpoint-GUID: gQpOJNvym_Jrb4wTuOL4EW-noVhDY9Y1
X-Proofpoint-ORIG-GUID: gQpOJNvym_Jrb4wTuOL4EW-noVhDY9Y1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEzMSBTYWx0ZWRfXz3ATdcjbsgfX
 hhDN0r7hAKMsJmYbUjV183soWDue67ag2xv7M1cw4931uTjuX1AEJncAg74lMqCr/Y73qTsMw2W
 oO3wO5hs8R0q5vRQWMGsLPkTrfE0/myuRLO70DAZPOfzGAYs5aZ5EzF/pJG0WqAookrSXj+A+Jk
 NdsDIPa0dGqbTQ9BOP/xifTD5IN6i7OsRJXBbTnOUtzQcQmbogHSDU06eOYcDE/1YCt0U9KfFUp
 g7RDTfkdgR5ctanIVcCh1ttHfySCrtqHZU0AYd/gaO+lVMuASn5LIG+dO1VDoxrk+dx0H12CcTV
 2SVOykCS23PUt0uvabFkBguVUurrcFZdHNkjDLbuS133DN+bFT7wHYwNqq8b37VwDF/F+HPrufA
 tsYsoFas6Eix8uxzMd3Me8uNY0HaAb3JV8p4vj7Qyn8CdIRxINm47dB1ohnc+DNGPnd2n9Go85Q
 2FdJvmblVI7pIpDHeOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01

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

