Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A36E2D05D
	for <linux-block@vger.kernel.org>; Mon, 29 Apr 2024 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386196; cv=none; b=h3F2s7rdtCIeDultx6itBfxyyQQ0VOd7mkegOJM6qC9ERKAbE51ii31+BqaqIFuHhxV76J6hNI83yLSqRf1CxJkXoKB6LxZ3x0YT2VBo84pR7qgL54LynxVj4OcNK994EktgIFtLIdxdBTjpmlQpgk9LP03jHD8K76D4CYSG7sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386196; c=relaxed/simple;
	bh=NPxl741pISNh0AwHUWNeZldFV2a74Kj8QA7vinwmwj0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GsDVc5xp+uc0L/qC4zh7Yelfuxn0SlGBRWV1TonQGUkcyYfeKp4F46mR/ZYcEPHLmr4RuPpzGWd9w0j9slGarKXvSqsUywvfXMXJz/F3bSjT70jIhHOqWo7KhV9esUZ1LQSRVNZE872iWtN1mxYB08VQavmGGwzsuLgzmPyJnxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZOxcEGFg; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZOxcEGFg"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 43T1kRtE014426
	for <linux-block@vger.kernel.org>; Mon, 29 Apr 2024 03:23:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=MAgiSx+jpMavICXqxWgDhqGL6E++1Q5guNHh8ZHS4Ks=;
 b=ZOxcEGFgnR4h1thiVhI/2+N++6KxJwdZR4zHM2jM7AhZwitLkoaNNKGA74rgeRxpBODe
 eFMOUt5qyAsJiSdSOOWWNJUmkGOZ969aHijfz9PnI3W+B0vf8nV+e67Ev/zd/d+Sdylc
 bEUlb+2ytuYoCLfvIRZ39OYwa05WliLzP8gu9I9wHbrGFch/RNLulFvZdAN/xoHccff1
 vupt6sB8QIcYvwBJeNJUnWtivNZcRfbdsByyr2B7EmOqbqGecvhg/PXdxUCC0WAIYVx0
 dbacJdimDt21qYRu9uytK0FAdfWXLtMOy8pJ0iHktWgeWg/nHVSCdEDbIUVNpvSVXZu6 eg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3xrw1xy91e-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 29 Apr 2024 03:23:14 -0700
Received: from twshared19845.02.ash8.facebook.com (2620:10d:c0a8:1b::449c) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 10:23:11 +0000
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id 0A4801FF51F3; Mon, 29 Apr 2024 03:23:10 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] brd: implement discard support
Date: Mon, 29 Apr 2024 03:23:08 -0700
Message-ID: <20240429102308.147627-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Q_qK8q0AsUHzv_9VzOhrEhmAVri9RPZr
X-Proofpoint-ORIG-GUID: Q_qK8q0AsUHzv_9VzOhrEhmAVri9RPZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_08,2024-04-26_02,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

The ramdisk memory utilization can only go up when data is written to
new pages. Implement discard to provide the possibility to reduce memory
usage for pages no longer in use. Aligned discards will free the
associated pages, if any, and determinisitically return zeroed data
until written again.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/block/brd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index e322cef6596bf..e741b0c3a4f79 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -240,6 +240,23 @@ static int brd_do_bvec(struct brd_device *brd, struc=
t page *page,
 	return err;
 }
=20
+static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 =
size)
+{
+	sector_t aligned_sector =3D (sector + PAGE_SECTORS) & ~PAGE_SECTORS;
+	struct page *page;
+
+	size -=3D (aligned_sector - sector) * SECTOR_SIZE;
+	xa_lock(&brd->brd_pages);
+	while (size >=3D PAGE_SIZE && aligned_sector < rd_size * 2) {
+		page =3D __xa_erase(&brd->brd_pages, aligned_sector >> PAGE_SECTORS_SH=
IFT);
+		if (page)
+			__free_page(page);
+		aligned_sector +=3D PAGE_SECTORS;
+		size -=3D PAGE_SIZE;
+	}
+	xa_unlock(&brd->brd_pages);
+}
+
 static void brd_submit_bio(struct bio *bio)
 {
 	struct brd_device *brd =3D bio->bi_bdev->bd_disk->private_data;
@@ -247,6 +264,12 @@ static void brd_submit_bio(struct bio *bio)
 	struct bio_vec bvec;
 	struct bvec_iter iter;
=20
+	if (unlikely(op_is_discard(bio->bi_opf))) {
+		brd_do_discard(brd, sector, bio->bi_iter.bi_size);
+		bio_endio(bio);
+		return;
+	}
+
 	bio_for_each_segment(bvec, bio, iter) {
 		unsigned int len =3D bvec.bv_len;
 		int err;
@@ -327,6 +350,9 @@ static int brd_alloc(int i)
 		 *  is harmless)
 		 */
 		.physical_block_size	=3D PAGE_SIZE,
+		.max_hw_discard_sectors	=3D UINT_MAX,
+		.max_discard_segments	=3D 1,
+		.discard_granularity	=3D PAGE_SIZE,
 	};
=20
 	list_for_each_entry(brd, &brd_devices, brd_list)
--=20
2.43.0

