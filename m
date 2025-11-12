Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759EA34029C
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965758; cv=none; b=VCmh0CCkC9p1y5vU/7k/LZVjedNix8e56rotUQt4oV4CMRcyYypnB6MmkqlPz7FGP559Qb1K63qLQyq4bYIxSE/ODWeG+MzDNDxMSy0xex1rGVyTGBa9IuWu+6Vl8D/rOcgSbRVEwu/kJvpe+/u5dNARv6HpjYo5i2sCYGN0cGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965758; c=relaxed/simple;
	bh=re44qUPqIi7xSrZchjfekVk4DXy0fC2mQkDFEtEkYNI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NdPwQ/Ywqu13AvUTZ3ncAHfIctq60Q5g2G2xwHFj+PmgAFFYSQV5dZ3ggiK1e7rP/1Z7NRhQXgzXM5T9Uj53fDi1Ir+in+u8mSCmthmuFeBa0TCIKr2b+2HqG5V66LTvanjcdf4CxKRuNKHUa3YydMP7C3OBiFsSADDHvlSTPgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DWRpj5EU; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DWRpj5EU"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5ACDtuGh1517738
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 08:42:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=LNj5rqmwORQI4oGup/
	vPZfG9BEM+VxBjKQv678r4JR8=; b=DWRpj5EUN1mFgm2U0N7p1KegEu79Isoq87
	eZ8hl1lEViIvdna5PGANVxpeqz20uQ7METcolOOh4f+QkAHi/EpzPIE/33u2bjhX
	dDcYDORTFogQfNFcCeBhojMh9X7CkFw6T69Ls1UTVUEK6j4BDXpYXRkTzGimST9p
	dq5GgS/ne1MHSLvXBX1Y30cNS9xISZnXJptjh65VDJSUEa9nOwczC40F11g1UkYn
	pq8z4ErG19fX/NrXdPWxLA/CtviT0YwVm254snVFT02Va+DdP3MrAPFconVI2nUY
	pDtmMziDIyJHaJEcX3Zi+6kNpNNhV9SZlrbNO8zpaXVucIKqq0UA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4acuj79ems-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 08:42:35 -0800 (PST)
Received: from twshared12874.03.snb2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 12 Nov 2025 16:42:33 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 93ABB3B2AD04; Wed, 12 Nov 2025 08:42:19 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <dlemoal@kernel.org>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <linux-block@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] null_blk: fix zone read length beyond write pointer
Date: Wed, 12 Nov 2025 08:42:18 -0800
Message-ID: <20251112164218.816774-1-kbusch@meta.com>
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
X-Proofpoint-GUID: BWbXFhoMa4zPZDW4xpU1APzaYynCzQK-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEzMyBTYWx0ZWRfX1A3kfd5y9w/Y
 3uqLMw6J9UZi9yULkcnzDMCgf+/aTXNAiKfxJSMjapkmn0s09d37WZglVU3FmnkA4TNpPIEGtkt
 WNiLeLN3E6mZuAZBa+Fji66EsOVhajTjrcOA4pu1S16jj2pjUJVBjlwuVo6DpIiIurmxELMZ6im
 zjKpMAXe0P2/l4oici3NflPBH9qrecvQDgqeHIXAxs48qG9s0QlO1psv4UqY4lL8jzW47KQ0H9Q
 me5k9DwCdbmd/kyS5P0UJWuYzE3O8i1SW53eKTm4S/gv5McMB1xRjn3at9GRhB6lbdRhgvLYjBO
 JmEtn37NOwO6j0YSkjjycDV26NX9JynqjZe+Y4tAA7DTrMvbaA7VqwpIcyT1kvwmGQIiJlXgmzT
 1430nUndm6eTUUVcWXOw1IagbAaUMw==
X-Authority-Analysis: v=2.4 cv=H8LWAuYi c=1 sm=1 tr=0 ts=6914b8fb cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=s0CbcqpA53pQYuaTvfkA:9
X-Proofpoint-ORIG-GUID: BWbXFhoMa4zPZDW4xpU1APzaYynCzQK-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Fix up the divisor calculating the number of zone sectors being read and
handle a read that straddles the zone write pointer. The length is
rounded up a sector boundary, so be sure to truncate any excess bytes
off to avoid copying past the data segment.

Fixes: 3451cf34f51bb70 ("null_blk: allow byte aligned memory offsets")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/block/null_blk/main.c  | 5 ++++-
 drivers/block/null_blk/zoned.c | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index f1e67962ecaeb..c7c0fb79a6bf6 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1240,9 +1240,12 @@ static blk_status_t null_transfer(struct nullb *nu=
llb, struct page *page,
=20
 	p =3D kmap_local_page(page) + off;
 	if (!is_write) {
-		if (dev->zoned)
+		if (dev->zoned) {
 			valid_len =3D null_zone_valid_read_len(nullb,
 				pos >> SECTOR_SHIFT, len);
+			if (valid_len && valid_len !=3D len)
+				valid_len -=3D pos & (SECTOR_SIZE - 1);
+		}
=20
 		if (valid_len) {
 			copy_from_nullb(nullb, p, pos, valid_len);
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zone=
d.c
index dbf292a8eae96..0ada35dc0989e 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -242,7 +242,7 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 {
 	struct nullb_device *dev =3D nullb->dev;
 	struct nullb_zone *zone =3D &dev->zones[null_zone_no(dev, sector)];
-	unsigned int nr_sectors =3D DIV_ROUND_UP(len, SECTOR_SHIFT);
+	unsigned int nr_sectors =3D DIV_ROUND_UP(len, SECTOR_SIZE);
=20
 	/* Read must be below the write pointer position */
 	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL ||
--=20
2.47.3

