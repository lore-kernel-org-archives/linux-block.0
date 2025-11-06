Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FDB2144CF
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394125; cv=none; b=n9esKazJ3PEYBk9awSmPKkY6Yz3hVXB/ykCIhArum8snrLkYFcGdKBsv7R9QQTeygAA1oESCUqhTMyoGam9uVZOI73Lk1W9NplGtY33qGbm004f5Twd03ryQ84v6e4rEhP0eRDofVhtn5lbQDCAWvlcXcHESeyw3prz6T2HrIEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394125; c=relaxed/simple;
	bh=tbJ8TSYzmtZ0JGsFjcGe/LToDu+H4Jni3HZVOR7722o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTvOx1o/qNdZ0AS8+mliC2ZSxb3bFKDWXdNQEBn5cXxg6vowY3sb5oz592A9wOAEJ6qnQ2j9y8qRIJQqCjwCM3DUOoHfdek7mAA/pwDZkLVoQek3hLo+F4LYdCWE6ZiVeUdDrhRemVbWvyOpyn3T0jtYkuzqWYr0eeB1Ey2Cp68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jhW4D8Pg; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jhW4D8Pg"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5MuCZX1771731
	for <linux-block@vger.kernel.org>; Wed, 5 Nov 2025 17:55:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=MgaVGB2mEPnICxfV7i/DP8IAcBCEfhqcmnMYRd/Etxo=; b=jhW4D8Pg25Lq
	kYEspFaeTKaefrFgYuF7N6yRDxXkkK6HXd4pD0Ls3ri+EkwJsvNpEGamIXFae4WE
	ZRljF8xZUZCK45fOwlwHz8RcL9Ap9X2u9KUYCUqXv8A/G+cyLGL+il8f8NpRuPOs
	3p13Jt6JJGBONmVtWCzwAeEuH/ENyEfK2Z/GQ2cxp+d6nXuXTQ5C98avIwbV3au8
	hMeNK7SoCsE84cw0pij6UvBWEl0Ss+1rzLpIgIyeRNsjjKhstNKqywZvT6gg9tPs
	/NcoVzmQ9T/gz0perZOUla1sSDvOr82FAKx0rkHuHuJuDyE8lgxuUuKnyE9+yMxY
	tku6bifILQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a8ftj13bh-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 17:55:23 -0800 (PST)
Received: from twshared82436.15.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 6 Nov 2025 01:55:09 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id AAF9E3789B22; Wed,  5 Nov 2025 17:54:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <hch@lst.de>, <axboe@kernel.dk>,
        <dlemoal@kernel.org>, <hans.holmberg@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 4/4] null_blk: allow byte aligned memory offsets
Date: Wed, 5 Nov 2025 17:54:47 -0800
Message-ID: <20251106015447.1372926-5-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAxNCBTYWx0ZWRfXwoEzdN93QsDU
 YNZPsLMBH/fxp35ZURRm6jeXilDqZGRSJ5avwA4DbRw7j2amZFyRxYgPFHV/fVQoy4EbwrRCt8W
 xBUw0n/EBaPDFOAoo+X8OQjXNO0lPB+5ECHdO9JyUedvShjG1RgWuHXI2dQxl9V/IhdyrlHzDjc
 ISjcmLMhgMge6epOXvgXgnvwQYEqhibHp0SylokNEyV3tAr+ziYVR7hLjw3myOFGIHPNGY35+uI
 k7jL6bZ0d9zIAllVMaT6YN5iuZ4WqqGrODF4np/unRudbNRsEl4zBn6Mj+zTiN1+AsiDu474Yjx
 fz9WJ9XiYU1EkjrHb2gfwhUQ8LrMxNY4vKJcHwHQm+xdyBHLuETOWofKlkFxsQYkNirPXrV1Juc
 Cp46P/SWLQX+3QN79tRBaSGA2EwS0Q==
X-Proofpoint-GUID: PKcMRUiQU1GcQywjPNw9DFx_HjVxL4aY
X-Proofpoint-ORIG-GUID: PKcMRUiQU1GcQywjPNw9DFx_HjVxL4aY
X-Authority-Analysis: v=2.4 cv=HIHO14tv c=1 sm=1 tr=0 ts=690c000b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=v9PiLxmtJ7OizVV4shsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Allowing byte aligned memory provides a nice testing ground for
direct-io.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/block/null_blk/main.c  | 46 ++++++++++++++++++----------------
 drivers/block/null_blk/zoned.c |  2 +-
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index 34346590d4eee..f1e67962ecaeb 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1130,25 +1130,27 @@ static int null_make_cache_space(struct nullb *nu=
llb, unsigned long n)
 }
=20
 static blk_status_t copy_to_nullb(struct nullb *nullb, void *source,
-				  sector_t sector, size_t n, bool is_fua)
+				  loff_t pos, size_t n, bool is_fua)
 {
 	size_t temp, count =3D 0;
-	unsigned int offset;
 	struct nullb_page *t_page;
+	sector_t sector;
=20
 	while (count < n) {
-		temp =3D min_t(size_t, nullb->dev->blocksize, n - count);
+		temp =3D min3(nullb->dev->blocksize, n - count,
+			    PAGE_SIZE - offset_in_page(pos));
+		sector =3D pos >> SECTOR_SHIFT;
=20
 		if (null_cache_active(nullb) && !is_fua)
 			null_make_cache_space(nullb, PAGE_SIZE);
=20
-		offset =3D (sector & SECTOR_MASK) << SECTOR_SHIFT;
 		t_page =3D null_insert_page(nullb, sector,
 			!null_cache_active(nullb) || is_fua);
 		if (!t_page)
 			return BLK_STS_NOSPC;
=20
-		memcpy_to_page(t_page->page, offset, source + count, temp);
+		memcpy_to_page(t_page->page, offset_in_page(pos),
+			       source + count, temp);
=20
 		__set_bit(sector & SECTOR_MASK, t_page->bitmap);
=20
@@ -1156,33 +1158,33 @@ static blk_status_t copy_to_nullb(struct nullb *n=
ullb, void *source,
 			null_free_sector(nullb, sector, true);
=20
 		count +=3D temp;
-		sector +=3D temp >> SECTOR_SHIFT;
+		pos +=3D temp;
 	}
 	return BLK_STS_OK;
 }
=20
-static void copy_from_nullb(struct nullb *nullb, void *dest, sector_t se=
ctor,
+static void copy_from_nullb(struct nullb *nullb, void *dest, loff_t pos,
 			    size_t n)
 {
 	size_t temp, count =3D 0;
-	unsigned int offset;
 	struct nullb_page *t_page;
+	sector_t sector;
=20
 	while (count < n) {
-		temp =3D min_t(size_t, nullb->dev->blocksize, n - count);
+		temp =3D min3(nullb->dev->blocksize, n - count,
+			    PAGE_SIZE - offset_in_page(pos));
+		sector =3D pos >> SECTOR_SHIFT;
=20
-		offset =3D (sector & SECTOR_MASK) << SECTOR_SHIFT;
 		t_page =3D null_lookup_page(nullb, sector, false,
 			!null_cache_active(nullb));
-
 		if (t_page)
-			memcpy_from_page(dest + count, t_page->page, offset,
-					 temp);
+			memcpy_from_page(dest + count, t_page->page,
+					 offset_in_page(pos), temp);
 		else
 			memset(dest + count, 0, temp);
=20
 		count +=3D temp;
-		sector +=3D temp >> SECTOR_SHIFT;
+		pos +=3D temp;
 	}
 }
=20
@@ -1228,7 +1230,7 @@ static blk_status_t null_handle_flush(struct nullb =
*nullb)
 }
=20
 static blk_status_t null_transfer(struct nullb *nullb, struct page *page=
,
-	unsigned int len, unsigned int off, bool is_write, sector_t sector,
+	unsigned int len, unsigned int off, bool is_write, loff_t pos,
 	bool is_fua)
 {
 	struct nullb_device *dev =3D nullb->dev;
@@ -1240,10 +1242,10 @@ static blk_status_t null_transfer(struct nullb *n=
ullb, struct page *page,
 	if (!is_write) {
 		if (dev->zoned)
 			valid_len =3D null_zone_valid_read_len(nullb,
-				sector, len);
+				pos >> SECTOR_SHIFT, len);
=20
 		if (valid_len) {
-			copy_from_nullb(nullb, p, sector, valid_len);
+			copy_from_nullb(nullb, p, pos, valid_len);
 			off +=3D valid_len;
 			len -=3D valid_len;
 		}
@@ -1253,7 +1255,7 @@ static blk_status_t null_transfer(struct nullb *nul=
lb, struct page *page,
 		flush_dcache_page(page);
 	} else {
 		flush_dcache_page(page);
-		err =3D copy_to_nullb(nullb, p, sector, len, is_fua);
+		err =3D copy_to_nullb(nullb, p, pos, len, is_fua);
 	}
=20
 	kunmap_local(p);
@@ -1271,7 +1273,7 @@ static blk_status_t null_handle_data_transfer(struc=
t nullb_cmd *cmd,
 	struct nullb *nullb =3D cmd->nq->dev->nullb;
 	blk_status_t err =3D BLK_STS_OK;
 	unsigned int len;
-	sector_t sector =3D blk_rq_pos(rq);
+	loff_t pos =3D blk_rq_pos(rq) << SECTOR_SHIFT;
 	unsigned int max_bytes =3D nr_sectors << SECTOR_SHIFT;
 	unsigned int transferred_bytes =3D 0;
 	struct req_iterator iter;
@@ -1283,11 +1285,11 @@ static blk_status_t null_handle_data_transfer(str=
uct nullb_cmd *cmd,
 		if (transferred_bytes + len > max_bytes)
 			len =3D max_bytes - transferred_bytes;
 		err =3D null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
-				     op_is_write(req_op(rq)), sector,
+				     op_is_write(req_op(rq)), pos,
 				     rq->cmd_flags & REQ_FUA);
 		if (err)
 			break;
-		sector +=3D len >> SECTOR_SHIFT;
+		pos +=3D len;
 		transferred_bytes +=3D len;
 		if (transferred_bytes >=3D max_bytes)
 			break;
@@ -1944,7 +1946,7 @@ static int null_add_dev(struct nullb_device *dev)
 		.logical_block_size	=3D dev->blocksize,
 		.physical_block_size	=3D dev->blocksize,
 		.max_hw_sectors		=3D dev->max_sectors,
-		.dma_alignment		=3D dev->blocksize - 1,
+		.dma_alignment		=3D 1,
 	};
=20
 	struct nullb *nullb;
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zone=
d.c
index 6a93b12a06ff7..dbf292a8eae96 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -242,7 +242,7 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 {
 	struct nullb_device *dev =3D nullb->dev;
 	struct nullb_zone *zone =3D &dev->zones[null_zone_no(dev, sector)];
-	unsigned int nr_sectors =3D len >> SECTOR_SHIFT;
+	unsigned int nr_sectors =3D DIV_ROUND_UP(len, SECTOR_SHIFT);
=20
 	/* Read must be below the write pointer position */
 	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL ||
--=20
2.47.3

