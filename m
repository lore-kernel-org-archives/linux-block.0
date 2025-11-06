Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B38D823DD
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 01:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394109; cv=none; b=BW7kDCDILMVuF77cbisR7NINnq5sdrj2Fue/dfRLsL/v40pXSAZG7L/EInTOanfgoIZmT0Bn7GHvGbHOGaGgCUMvlAA/PNJiSZjVNp1NXGmNpLyFGGWqQd2nPB04/CCvW/GfuDa+DbKF1jyet4lzVTNwk767F7HBBhe9UucXm2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394109; c=relaxed/simple;
	bh=EX9e+2yyfy/7GpR8yujCL4coqQe6cY462MQCtJk/zHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOERX484C1ADzumi9cRzvQz0Q3ikHQhhhfUIjM9W9IDVBkzowiBIRDif0XebaR6SlW2INhCQgeOQ3Lji1BpCa0GtK16EiyZeLZkDbZ6FGQkdmt1Zb6dST3qes6X4Z6qTwMIwYBwYhvLROpSQXss6LvyTbgM7nKpT0vRuEAHUQDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=otexohjb; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="otexohjb"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A61TGgs4131744
	for <linux-block@vger.kernel.org>; Wed, 5 Nov 2025 17:55:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=dAdEHPpAgksVxw22DEzvKIBGSmqmI7dZQwmYJKRgIt0=; b=otexohjbwwEG
	accXkfxj86XpJbO/Aekmyx/K+vTFKCEsN0WaGm8tJvuYMmQHuHPxZqdZOgvjJbf+
	dQlQavWrfmmywBG+ojeyLrVFmnCO1fFYjU3eEt/aQfGxEUS0iSzwKldCPFZq9xzx
	n7ozNZeqUls0lWzf4x26bmQDUwCcKz5DeM4CgmARoHiThbdgXbK7bmDlvaoWsOi8
	e5yRiDbqi1Fbr5wTAuiw5BNQY+Z8ChGFhQ0iTjhjbU/P4m+GgMoaQoOTieHu+qcG
	OmeOhbl8QREqUQchBlKXkBr3p4deCbYXkRkuUtT9Ha0RLB9d6bbs9zOjr6d9jKB6
	D38Zg9hD4Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a8bjq3fcv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 17:55:06 -0800 (PST)
Received: from twshared13080.31.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 6 Nov 2025 01:55:05 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A9EFB3789B21; Wed,  5 Nov 2025 17:54:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <hch@lst.de>, <axboe@kernel.dk>,
        <dlemoal@kernel.org>, <hans.holmberg@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 3/4] null_blk: single kmap per bio segment
Date: Wed, 5 Nov 2025 17:54:46 -0800
Message-ID: <20251106015447.1372926-4-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=E7bAZKdl c=1 sm=1 tr=0 ts=690bfffa cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=RSXmTHoquemIaMvHk_8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAxNCBTYWx0ZWRfX7Xx2ug9OmXhl
 TWP06k1pacO51wPSOEYeyXo4QWLKmf8Sm/FC2gSmH2xBuD1JpZdylh9Xcc2/EfeCTbQSMEoeO0j
 2EK7/d9mPvF0OZjSvamziDNXfUF4VpleP1B97reu5Mqj2EoFOH+fUPQMmfaVtrZQvplpZTtidkw
 6jSo/rHvtYeOPut4GipZT4L2hQaXPYifWUERPskbFY4ZtLZ/050UAX/GGVYLifSsm/OWnUI8OT5
 roGxq/gxMEbs2kfIWwBWDJoSGaCxIK+65sXP2zcJNiJXYwfoFDDJvEoDCwAEFpfiCNbYt73PbGh
 0ayD418rjqN3LN7rc9iD1LLz+227XN//wMYfSl/nGuGjyZ0aFVttkWLITK+F7CF+lzxOeB8TNmU
 MjRKHomLp3CPX36WOe9unP8Wo0hzyw==
X-Proofpoint-GUID: YhbxOhcKFbQJkoyecirihydx5_Yyd3Or
X-Proofpoint-ORIG-GUID: YhbxOhcKFbQJkoyecirihydx5_Yyd3Or
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Rather than kmap the the request bio segment for each sector, do
the mapping just once.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/block/null_blk/main.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index ff53c8bd5d832..34346590d4eee 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1129,8 +1129,8 @@ static int null_make_cache_space(struct nullb *null=
b, unsigned long n)
 	return 0;
 }
=20
-static blk_status_t copy_to_nullb(struct nullb *nullb, struct page *sour=
ce,
-	unsigned int off, sector_t sector, size_t n, bool is_fua)
+static blk_status_t copy_to_nullb(struct nullb *nullb, void *source,
+				  sector_t sector, size_t n, bool is_fua)
 {
 	size_t temp, count =3D 0;
 	unsigned int offset;
@@ -1148,7 +1148,7 @@ static blk_status_t copy_to_nullb(struct nullb *nul=
lb, struct page *source,
 		if (!t_page)
 			return BLK_STS_NOSPC;
=20
-		memcpy_page(t_page->page, offset, source, off + count, temp);
+		memcpy_to_page(t_page->page, offset, source + count, temp);
=20
 		__set_bit(sector & SECTOR_MASK, t_page->bitmap);
=20
@@ -1161,8 +1161,8 @@ static blk_status_t copy_to_nullb(struct nullb *nul=
lb, struct page *source,
 	return BLK_STS_OK;
 }
=20
-static void copy_from_nullb(struct nullb *nullb, struct page *dest,
-	unsigned int off, sector_t sector, size_t n)
+static void copy_from_nullb(struct nullb *nullb, void *dest, sector_t se=
ctor,
+			    size_t n)
 {
 	size_t temp, count =3D 0;
 	unsigned int offset;
@@ -1176,22 +1176,16 @@ static void copy_from_nullb(struct nullb *nullb, =
struct page *dest,
 			!null_cache_active(nullb));
=20
 		if (t_page)
-			memcpy_page(dest, off + count, t_page->page, offset,
-				    temp);
+			memcpy_from_page(dest + count, t_page->page, offset,
+					 temp);
 		else
-			memzero_page(dest, off + count, temp);
+			memset(dest + count, 0, temp);
=20
 		count +=3D temp;
 		sector +=3D temp >> SECTOR_SHIFT;
 	}
 }
=20
-static void nullb_fill_pattern(struct nullb *nullb, struct page *page,
-			       unsigned int len, unsigned int off)
-{
-	memset_page(page, off, 0xff, len);
-}
-
 blk_status_t null_handle_discard(struct nullb_device *dev,
 				 sector_t sector, sector_t nr_sectors)
 {
@@ -1240,27 +1234,29 @@ static blk_status_t null_transfer(struct nullb *n=
ullb, struct page *page,
 	struct nullb_device *dev =3D nullb->dev;
 	blk_status_t err =3D BLK_STS_OK;
 	unsigned int valid_len =3D len;
+	void *p;
=20
+	p =3D kmap_local_page(page) + off;
 	if (!is_write) {
 		if (dev->zoned)
 			valid_len =3D null_zone_valid_read_len(nullb,
 				sector, len);
=20
 		if (valid_len) {
-			copy_from_nullb(nullb, page, off, sector,
-					valid_len);
+			copy_from_nullb(nullb, p, sector, valid_len);
 			off +=3D valid_len;
 			len -=3D valid_len;
 		}
=20
 		if (len)
-			nullb_fill_pattern(nullb, page, len, off);
+			memset(p + valid_len, 0xff, len);
 		flush_dcache_page(page);
 	} else {
 		flush_dcache_page(page);
-		err =3D copy_to_nullb(nullb, page, off, sector, len, is_fua);
+		err =3D copy_to_nullb(nullb, p, sector, len, is_fua);
 	}
=20
+	kunmap_local(p);
 	return err;
 }
=20
--=20
2.47.3

