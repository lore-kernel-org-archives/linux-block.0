Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1773161A4
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190954; cv=none; b=l3QRZeC86YJtzKQOKCrQDwNgYYJ3P9Fls9ROJIcdadXwjBIDMHOsopWgi5U6vjMuthVxBlUYchg2oQ2av3rBusWcKdIhlvA8LRY2VS6M0K2orC0q2JVm5dqPhA7qv7kpyv7+/HHn3jDZNWYnuDSgAie3fpNWxcsuQhIm+MVF8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190954; c=relaxed/simple;
	bh=ePBXjJ3p4LWx58JHQYTN1xfjRRsyFhJCM+qsfYP+RKU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sRiVgWUFsmNxEm5bbrxgBn12RA2STF6TVMcYUzdWX2XlpEuubi912bjk/JPQ7HYhIxJtlET4avEtjCxJrtG7nEnSH4Z0fstXdqYkFsXzpTqqWBuCXRfheRy0G34C5x4ydFPicTlAsC1MDEsaS6oYbJjdpm5UpsniIbNUldpW2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LfUh1c24; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LfUh1c24"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3HSDHp2130813
	for <linux-block@vger.kernel.org>; Mon, 3 Nov 2025 09:29:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=p+zCD1fSr6h7J6yYF2
	5dB7GDBglEX81oWmLDHFWTBlM=; b=LfUh1c24+yyD/2nV8RSRsDiPx8yEGnJtlz
	UdmyFry4IBSnYAA5O7dTkfWKPpzdIXsVK9/mCq31JNC+JdJiG9tsSHryNdOm7PgZ
	VlVOROMZGt/xesjbHa14dxKQ5zePmMXMeqL/wH/IhPNyKDFNpaU9MO8+yjNaHVxm
	1mDd7CfZaKiJoRQC42njwzHTbaqxjvZzPBSRFxvMpJLOaRvAee6VHNIzyIB9Zb2K
	704l1lvHfrZVj/+QEQAuc863hFTrXBHPhXesillSDMl1fpalq848On1TpqfBoLLG
	WRg7l4duTHm4wmL0t/2+k/tCX3ilImhKNaGuyI4c3zz4Xbktg5fA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a6w5gt6b4-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 09:29:12 -0800 (PST)
Received: from twshared31947.34.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 3 Nov 2025 17:29:10 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 2C01336322AA; Mon,  3 Nov 2025 09:28:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <hch@lst.de>, <axboe@kernel.dk>,
        <dlemoal@kernel.org>, <hans.holmberg@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] null_blk: allow byte aligned memory offsets
Date: Mon, 3 Nov 2025 09:28:54 -0800
Message-ID: <20251103172854.746263-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=forRpV4f c=1 sm=1 tr=0 ts=6908e668 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=8wkJC9dwGeHAYpYqR5gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE1NyBTYWx0ZWRfX+j+34l2OHGwZ
 OCOKvxkxRA4NMa8rlqcYGdrjTuKZThlcENj1xzsQUTchnWh4MjViPEymg8XonZ0lRdx19R5PK15
 aVuPH/FfHwfqUiXsXGX8f1zWFPCYJIj8oXHtTHSUX3tyP9ix1pbc+nHtN8AqKFP1TWcsIhIa5ib
 StFG81relE1sbyL32h7pf1/Td4vxcLqy6OkkuiZpTEOErzdLhpKHsM6AzzaEdvY/rN9+tLmad4j
 pDrPaROmJdtZ6JowbvgBKXY9tJvQUyoE5ESrQtPlvMYRXE+HLQbybcPNUy+vx3scwuflXW15oVS
 ZN5hNuCMhqsP3KoCdPMsmWj5Ap++z55oO67kVoLEold8botVTc355Y809xNNwgpdtnhGDyaTjg1
 5fJT/G3RojcvzxxoSXruqDAgHJpQeQ==
X-Proofpoint-ORIG-GUID: F1abmyU8S1PjBI8T5XaTd6AVJg1l3N6S
X-Proofpoint-GUID: F1abmyU8S1PjBI8T5XaTd6AVJg1l3N6S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_03,2025-11-03_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Allowing byte aligned memory provides a nice testing ground for
direct-io. This has an added benefit of a single kmap/kumap per bio
segment rather than multiple times for each multi-page segment.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/block/null_blk/main.c  | 84 +++++++++++++++++-----------------
 drivers/block/null_blk/zoned.c |  2 +-
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index 0ee55f889cfdd..2227f6db5d3d5 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1129,40 +1129,42 @@ static int null_make_cache_space(struct nullb *nu=
llb, unsigned long n)
 	return 0;
 }
=20
-static int copy_to_nullb(struct nullb *nullb, struct page *source,
-	unsigned int off, sector_t sector, size_t n, bool is_fua)
+static int copy_to_nullb(struct nullb *nullb, void *source, loff_t pos,
+			 size_t n, bool is_fua)
 {
 	size_t temp, count =3D 0;
 	unsigned int offset;
 	struct nullb_page *t_page;
+	sector_t sector;
=20
 	while (count < n) {
+		sector =3D pos >> SECTOR_SHIFT;
 		temp =3D min_t(size_t, nullb->dev->blocksize, n - count);
=20
 		if (null_cache_active(nullb) && !is_fua)
 			null_make_cache_space(nullb, PAGE_SIZE);
=20
-		offset =3D (sector & SECTOR_MASK) << SECTOR_SHIFT;
+		offset =3D pos & (PAGE_SIZE - 1);
 		t_page =3D null_insert_page(nullb, sector,
 			!null_cache_active(nullb) || is_fua);
 		if (!t_page)
 			return -ENOSPC;
=20
-		memcpy_page(t_page->page, offset, source, off + count, temp);
+		memcpy_to_page(t_page->page, offset, source, temp);
=20
 		__set_bit(sector & SECTOR_MASK, t_page->bitmap);
=20
 		if (is_fua)
 			null_free_sector(nullb, sector, true);
=20
+		source +=3D temp;
 		count +=3D temp;
-		sector +=3D temp >> SECTOR_SHIFT;
+		pos +=3D temp;
 	}
 	return 0;
 }
=20
-static int copy_from_nullb(struct nullb *nullb, struct page *dest,
-	unsigned int off, sector_t sector, size_t n)
+static int copy_from_nullb(struct nullb *nullb, void *dest, loff_t pos, =
size_t n)
 {
 	size_t temp, count =3D 0;
 	unsigned int offset;
@@ -1171,28 +1173,22 @@ static int copy_from_nullb(struct nullb *nullb, s=
truct page *dest,
 	while (count < n) {
 		temp =3D min_t(size_t, nullb->dev->blocksize, n - count);
=20
-		offset =3D (sector & SECTOR_MASK) << SECTOR_SHIFT;
-		t_page =3D null_lookup_page(nullb, sector, false,
+		offset =3D pos & (PAGE_SIZE - 1);
+		t_page =3D null_lookup_page(nullb, pos >> SECTOR_SHIFT, false,
 			!null_cache_active(nullb));
=20
 		if (t_page)
-			memcpy_page(dest, off + count, t_page->page, offset,
-				    temp);
+			memcpy_from_page(dest, t_page->page, offset, temp);
 		else
-			memzero_page(dest, off + count, temp);
+			memset(dest, 0, temp);
=20
+		dest +=3D temp;
 		count +=3D temp;
-		sector +=3D temp >> SECTOR_SHIFT;
+		pos +=3D temp;
 	}
 	return 0;
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
@@ -1234,8 +1230,8 @@ static blk_status_t null_handle_flush(struct nullb =
*nullb)
 	return errno_to_blk_status(err);
 }
=20
-static int null_transfer(struct nullb *nullb, struct page *page,
-	unsigned int len, unsigned int off, bool is_write, sector_t sector,
+static int null_transfer(struct nullb *nullb, void *p,
+	unsigned int len, bool is_write, loff_t pos,
 	bool is_fua)
 {
 	struct nullb_device *dev =3D nullb->dev;
@@ -1243,23 +1239,26 @@ static int null_transfer(struct nullb *nullb, str=
uct page *page,
 	int err =3D 0;
=20
 	if (!is_write) {
-		if (dev->zoned)
+		if (dev->zoned) {
 			valid_len =3D null_zone_valid_read_len(nullb,
-				sector, len);
+				pos >> SECTOR_SHIFT, len);
+
+			if (valid_len && valid_len !=3D len)
+				valid_len -=3D (pos & (SECTOR_SIZE - 1));
+		}
=20
 		if (valid_len) {
-			err =3D copy_from_nullb(nullb, page, off,
-				sector, valid_len);
-			off +=3D valid_len;
+			err =3D copy_from_nullb(nullb, p, pos, valid_len);
+			p +=3D valid_len;
 			len -=3D valid_len;
 		}
=20
 		if (len)
-			nullb_fill_pattern(nullb, page, len, off);
-		flush_dcache_page(page);
+			memset(p, 0xff, len);
+		flush_dcache_page(virt_to_page(p));
 	} else {
-		flush_dcache_page(page);
-		err =3D copy_to_nullb(nullb, page, off, sector, len, is_fua);
+		flush_dcache_page(virt_to_page(p));
+		err =3D copy_to_nullb(nullb, p, pos, len, is_fua);
 	}
=20
 	return err;
@@ -1276,25 +1275,26 @@ static blk_status_t null_handle_data_transfer(str=
uct nullb_cmd *cmd,
 	struct nullb *nullb =3D cmd->nq->dev->nullb;
 	int err =3D 0;
 	unsigned int len;
-	sector_t sector =3D blk_rq_pos(rq);
-	unsigned int max_bytes =3D nr_sectors << SECTOR_SHIFT;
-	unsigned int transferred_bytes =3D 0;
+	loff_t pos =3D blk_rq_pos(rq) << SECTOR_SHIFT;
+	unsigned int nr_bytes =3D nr_sectors << SECTOR_SHIFT;
 	struct req_iterator iter;
 	struct bio_vec bvec;
=20
 	spin_lock_irq(&nullb->lock);
 	rq_for_each_segment(bvec, rq, iter) {
+		void *p =3D bvec_kmap_local(&bvec);;
+
 		len =3D bvec.bv_len;
-		if (transferred_bytes + len > max_bytes)
-			len =3D max_bytes - transferred_bytes;
-		err =3D null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
-				     op_is_write(req_op(rq)), sector,
-				     rq->cmd_flags & REQ_FUA);
+		if (len > nr_bytes)
+			len =3D nr_bytes;
+		err =3D null_transfer(nullb, p, nr_bytes, op_is_write(req_op(rq)),
+				    pos, rq->cmd_flags & REQ_FUA);
+		kunmap_local(p);
 		if (err)
 			break;
-		sector +=3D len >> SECTOR_SHIFT;
-		transferred_bytes +=3D len;
-		if (transferred_bytes >=3D max_bytes)
+		pos +=3D len;
+		nr_bytes -=3D len;
+		if (!nr_bytes)
 			break;
 	}
 	spin_unlock_irq(&nullb->lock);
@@ -1949,7 +1949,7 @@ static int null_add_dev(struct nullb_device *dev)
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
index 4e5728f459899..8e9648f87f7c8 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -242,7 +242,7 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 {
 	struct nullb_device *dev =3D nullb->dev;
 	struct nullb_zone *zone =3D &dev->zones[null_zone_no(dev, sector)];
-	unsigned int nr_sectors =3D len >> SECTOR_SHIFT;
+	unsigned int nr_sectors =3D DIV_ROUND_UP(len, SECTOR_SIZE);
=20
 	/* Read must be below the write pointer position */
 	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL ||
--=20
2.47.3

