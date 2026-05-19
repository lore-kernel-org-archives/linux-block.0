Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E923DB339
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211442; cv=none; b=b10VXdU8F2WafhhYwCwsCPgVqbOqUG/ahg6yYjtbs7K5E7nPnVsmVz8y/sAJkNTYMKof5pnLVSHWJKTU7Aox9NdaVGcyP5Vg1mCHfPIOcupPQi2enXP9zLRehrdSY5iR+atdQ/uu/Rba5i0UOQjP6pm8HgvUsV/6Y+hNupG43sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211442; c=relaxed/simple;
	bh=RL4hyiBNUnJhrBsAuywsGZ0/dsS6gzuHe6Vb5UY0S8E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyVLOJJlW2OhK4etwozKdDrHcsUeLnsPetl9j8Q/1j3Ice8+bk4ZVYFOrj0ixZ+T23obJOezatgtckkJGzc0s7CAikODEtUiDJZ9BV9c9U26FIxoI9l6XcpobiJsf7EC3UmXM0P4Bq94SvoENdjedkosZnd0Ed1wmBUCt7I/SeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Re5BAIjH; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Re5BAIjH"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JE8sUx2574853
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 10:23:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GvU1xBEA3AMnCAty9ku+e17nT0gNRKHLvZIkc3M8dYo=; b=Re5BAIjHHhgJ
	5JlLcMh35QHev7Cpl9S3/4GpFFTjcbmB5rH5aJhmop9ZAuBYRX5vTgRJRyQFxmv6
	W8fSwydvIqkxwrTSfYpokUxRRiRUmkxfR2SakvwZFD4NmVE7WfsENHEiziSR3tOt
	ad4TzBdiKeNTniDy2TkXp4OxpblCEsrpXYYU6bLJY2rl6MwpmikNTOIsKxq9M2F0
	5UbNP4jKRcjmOckwi2DSNyUC2fJQEuC62f+lGUGEvxG5XK6pVyPIT/KMoNbK1nYF
	lSuUkAZuY+VmPcl/EVtB/ueQSNoerZ9UY51i5Ol6sDbCwOZmox2z/fF99Uaj7eRT
	CShceFVaUA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e8sc51bm2-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 10:23:59 -0700 (PDT)
Received: from twshared34426.16.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 17:23:51 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 6254D1A75977C; Tue, 19 May 2026 10:23:32 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <tom.leiming@gmail.com>,
        <coshi036@gmail.com>, <Igor.Achkinazi@dell.com>, <dlemoal@kernel.org>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCH RFC 1/5] blk-mq: fix status for unaligned bio
Date: Tue, 19 May 2026 10:23:22 -0700
Message-ID: <20260519172326.3462354-2-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519172326.3462354-1-kbusch@meta.com>
References: <20260519172326.3462354-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=TaimcxQh c=1 sm=1 tr=0 ts=6a0c9caf cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8 a=g6QZ0kzQZARFZKXYqHoA:9
X-Proofpoint-ORIG-GUID: rqZHlLxyO46e5HD5ETynxo7J1m5t1dGp
X-Proofpoint-GUID: rqZHlLxyO46e5HD5ETynxo7J1m5t1dGp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3MyBTYWx0ZWRfX9zVbzK7Wye+x
 ZBad5P/JEXRRy8TC1ySDTEsqwSNRKkawNHW8a71gQLvVBOUC4xRhqbI0ERaIW6QNjMTTrcafuIo
 DBWi0vYZb/Rcddq9p8Vi8GEGUFMJ+OQ9gaURGNe62DtSNC7OSgBToS8LNGZiIXexB5VMm+sj/Fr
 v/AYRgtNWbVbdOLBsciHp7qwyyGBjy++SBXKds8d6t0viYHp/C2Xmg2fPm3ccnuhj+6esqDXCdk
 4GqMIoUov4erN4+EpgLRSow24BWP1cdojNsGn8tOPE3N4oThDI13SgBZyjL1NK2BBTJg4oJDiM0
 OUjUsnm5DjYC4ABy4Ix32Z6OUQ2Yi4F1lVChWlwnh2SJiRZdHcFq1OBLuspH7TG3gG9EObhJV5b
 MbrdEqjgdfagCzfrpSO46rQfdzU58lT6W8O/ModLTtusH6F7KeXxoNv7yFr5WuB8lsq39VQZFCE
 6hklwMck2G8ZigNoMiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

A bio requesting sectors unaligned to the logical format is invalid
rather than an IO error. Fix up the return code because there are some
device mappers that care about distinguishing these kinds of errors.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d0c37daf568f2..881183345a85c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3182,7 +3182,8 @@ void blk_mq_submit_bio(struct bio *bio)
 	 * have to be done with queue usage counter held.
 	 */
 	if (unlikely(bio_unaligned(bio, q))) {
-		bio_io_error(bio);
+		bio->bi_status =3D BLK_STS_INVAL;
+		bio_endio(bio);
 		goto queue_exit;
 	}
=20
--=20
2.53.0-Meta

