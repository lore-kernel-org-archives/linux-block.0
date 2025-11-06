Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF3D225390
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394114; cv=none; b=X6sCjW7RZigJNm0QRCRT4f4259AF88kScHz9KpoyQ54fi05GRT5dH0Sn2CKdYoElE0KRddhN3KgZcK0XGZwc2vaOv1hVVk5jtVDd2NTvSZ5kefPhdI0vRgPQema0xD1u+K8yJi2TVwldz+hFZCVSAdZ+6UhtjH4BXGi0g5Xyw58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394114; c=relaxed/simple;
	bh=tFVZwmioLF+YzlwLgGhS5pSHw9Qrc8sBMaWzy9QZA+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MidRcS24ligeyalnMtAnoYwlNOWzXLeIQTSyYsL2oZJFvPlMRAeLCMSBT67tjPTuuXehHMQJSwwMhit0YrdS8XyTK+CvX1r5l4CH9DjzDxuvWj6elDJnDR2HmekphSfDzD+dXbxism58n5Cn4IBQ1IkxfbB/gUTrImcmw5Jitk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Q2+PgwDJ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Q2+PgwDJ"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5NNab11709617
	for <linux-block@vger.kernel.org>; Wed, 5 Nov 2025 17:55:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=iQqwUe/nR62X6sUWyJQeXKfxPTChGKAtRwb6FIRlG6M=; b=Q2+PgwDJ2i+9
	wIqycLiUKtnXmr/U8/k5+strQwhxvwPpH384ZGAdhuiJ5pvSRgk4oTeK8cfxyX9v
	zhPtHu9/MEgdkmfpchM5/46yvVkkie/IvH/f0nj0KOYmTA/abm1TJcrVKqWkxXKg
	I0OOk+ydlfnu5ZLITpJgLf5FFEC71JnoNJ1vKo70CO07S8gp7p4E2JAx7hchLfvc
	jYFrpU1A/4vPmysVoQm0YhquJim7V09YXF3meMtQ20W5CqKILBl1B7ZM/xSAJfaZ
	iB3aYMZ+E6emstCPuqnrGVMaXme35GDBt4O9ka4gFQsvyVjfEcKRvWEB9ZzRel8v
	MufaaoNN0w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a8g7dgv3s-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 17:55:11 -0800 (PST)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 6 Nov 2025 01:55:06 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9E3EE3789B1E; Wed,  5 Nov 2025 17:54:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <hch@lst.de>, <axboe@kernel.dk>,
        <dlemoal@kernel.org>, <hans.holmberg@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/4] null_blk: simplify copy_from_nullb
Date: Wed, 5 Nov 2025 17:54:44 -0800
Message-ID: <20251106015447.1372926-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106015447.1372926-1-kbusch@meta.com>
References: <20251106015447.1372926-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1DpEdimvM1C0nR4QIvo4XfyTQvFozOjM
X-Authority-Analysis: v=2.4 cv=FeI6BZ+6 c=1 sm=1 tr=0 ts=690bffff cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=H1kaFOxHtia1-SAyDcEA:9
X-Proofpoint-GUID: 1DpEdimvM1C0nR4QIvo4XfyTQvFozOjM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAxNCBTYWx0ZWRfX8tDxzLIM0FEC
 0npwj1yZFMg65oGbvh86zCPacf782Jp0uMiVu2NJ7AtAllQm9q4aWChYQJ27MHPobbiExRmT4ha
 j1DMIKmCaLilIKWH/SXXEkzhg7BCKV94DZk+juBJZC9XyoFD1vOY+WZoCso0wyyNpwYCkM7d3gx
 k4Y366CelxqNhG8VXC/QasQ7BZd8uMEaL+9nUEukXfdAfe728MWb9p5eH7Bx1ut17XdSjgQODmU
 G1VoxamAsQDQcDxmwCBLQcaLN3X0raA/NoaXBA3e+t8MqBY/tuzunv+PV4QGfz/nuBHMUpcizOv
 OC7XyknIz9UNXhb3AAASwv5m2jSJmTZaH9ioPr332U8mfWbNwdXZyneT92stOiOMmeX6ZpNKJ2q
 75ZBJ/xgPiVEaRnu5Y3gVlH2YukhCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

It always returns success, so the code that saves the errors status, but
proceeds without checking it looks a bit odd. Clean this up.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/block/null_blk/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index 0ee55f889cfdd..a8bbbd132534a 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1161,7 +1161,7 @@ static int copy_to_nullb(struct nullb *nullb, struc=
t page *source,
 	return 0;
 }
=20
-static int copy_from_nullb(struct nullb *nullb, struct page *dest,
+static void copy_from_nullb(struct nullb *nullb, struct page *dest,
 	unsigned int off, sector_t sector, size_t n)
 {
 	size_t temp, count =3D 0;
@@ -1184,7 +1184,6 @@ static int copy_from_nullb(struct nullb *nullb, str=
uct page *dest,
 		count +=3D temp;
 		sector +=3D temp >> SECTOR_SHIFT;
 	}
-	return 0;
 }
=20
 static void nullb_fill_pattern(struct nullb *nullb, struct page *page,
@@ -1248,8 +1247,8 @@ static int null_transfer(struct nullb *nullb, struc=
t page *page,
 				sector, len);
=20
 		if (valid_len) {
-			err =3D copy_from_nullb(nullb, page, off,
-				sector, valid_len);
+			copy_from_nullb(nullb, page, off, sector,
+					valid_len);
 			off +=3D valid_len;
 			len -=3D valid_len;
 		}
--=20
2.47.3

