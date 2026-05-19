Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534FF27281E
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211445; cv=none; b=I09vGwCcDVznPFz/2FE4/24LVqd8m1l1SoAIud7kn8zIwLHkF0CNJOpO6Jg/D/ECQ4GjZaDTpotDsfsedbH5caaCgPbrRVREe95qdygbT8FgESZM3fTYbiBHoZFZa125LbtgdlLxHAUaeZ3mtWAFW9Dq6ROqe7Mqkdn+mb6CGj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211445; c=relaxed/simple;
	bh=yc3g2K4pxqFh76jItgHJWT6HJ50TQk7Mbux8U3LY8Fc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GookVmCNI+k8ISH5B/Wm7p3TMXz8oQxJKOSDvjw5FYdcxkOHvR7DCORd0n4CWVFF5QEsofy8dThFF9VDMm2Ki39aLlllsbk5foo9L6UUHlGPw+mIhQCIh5KPFVBXs918UpX4TfdNXlVZMdJwGahIo0+hQEtl8puupE+Pf6Bz6Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=oSHl2CiW; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="oSHl2CiW"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J4VXVO182059
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 10:24:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=53LR8ALSOVcr1chIg7i5h6RsLjS4b0KKwqAikvUBUeM=; b=oSHl2CiW0NvA
	ck+XR12XCjJF76m2ynQ1f1RtmmW8W440AnNoR7qYEQcD+niDx18op1zpg8q5KmMk
	EOagVJ7RdJGz5Gd/WtgEpvA1BhybrNBT7p8inKRmy8rZcXz25U83f3gTHPTgxgWN
	TSrjyAxKgr3ex4mWwA3Hf5/OqRg8DaLfVMdNn8nRlve6me+h/qziamtax05YNJAI
	VCauRvaiMtoXqjjq4zXpKEFhDRHq6UfUX6ikM3AS2sW7sTciR/46iVngv91D+Ykt
	2L4iB+dcUra8OioerPQR8wHAqyuZZ278Zh3FFFtXfbsEwMRxi7JWWD5xzSjdVAu3
	R6c3sVwnbg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e6p3bskgw-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 10:24:02 -0700 (PDT)
Received: from twshared11179.02.snb2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 17:23:48 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id EA7081A75979B; Tue, 19 May 2026 10:23:34 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <tom.leiming@gmail.com>,
        <coshi036@gmail.com>, <Igor.Achkinazi@dell.com>, <dlemoal@kernel.org>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCH RFC 3/5] block: validate bio bounds in the queue entered context
Date: Tue, 19 May 2026 10:23:24 -0700
Message-ID: <20260519172326.3462354-4-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3NCBTYWx0ZWRfX1oae00QL524Y
 kNifmODbTMqfw6/W7xyGUmb4ByV+rKQQfgTT5AqiTC9VJ7NBsf9CxA7pT/E4qahJ5DysVFZ10k8
 CeV0WuJJ2LIbN+oILjZ2kOh37+bXtfdoA3S/nL8adULdLcjsmYguBYkxfNCcw+JYZ+u1h9cRccJ
 CC0a/3kRE+LFbbK1404xTjz79eCt4ht+j4Pz1myW5Ms+YTZP54N6KMo166PMeNSdM2Zx8xyfT6h
 EstA6nYI8z50iEJaXRSvY88SX3wDQzGCPs91tQ1qSryFq/vE9sEyVrWfCqAeTXH4ymF6u/z9Lsi
 b6qY8je3gtrk1YTvsQUxRGwBr78JkKCe56Y1nqvOkCQksK2cUyu7esLNvw7qdQpemCE1IAcuawR
 ApsNRYiVzq6IIoOj2olzwDYWc9t/WQQux1Hbisn657yULPnQY8fro2/xuPTwQBaaRMK7PyZzcEC
 v+fzNbav0hBYlpdnSMg==
X-Proofpoint-GUID: ecyHM04AgflXtmW05kV8H8DQLWQe7BFK
X-Authority-Analysis: v=2.4 cv=K6cS2SWI c=1 sm=1 tr=0 ts=6a0c9cb2 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=4C8x5qO1QXPBt7sUNhsA:9
X-Proofpoint-ORIG-GUID: ecyHM04AgflXtmW05kV8H8DQLWQe7BFK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

bio_check_eod() in submit_bio_noacct() validates that a bio does not
extend beyond the partition's available sectors. This check runs before
bio_queue_enter(), so it is not serialized against queue limit updates.
A driver that freezes the queue, updates limits, changes the capacity,
and unfreezes can race with a bio that passed the early check under the
old capacity.

Remove bio_check_eod() and replace it with a bounds check in
__bio_split_to_limits(), which runs after the queue usage reference has
been acquired. The check uses partition-aware arithmetic to validate
both partition bounds and disk capacity in a single comparison that
works correctly on the post-remap sector values.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-core.c | 26 --------------------------
 block/blk.h      | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 92a802dc8042c..c200d0fc44fe7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -547,30 +547,6 @@ int should_fail_bio(struct bio *bio)
 }
 ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
=20
-/*
- * Check whether this bio extends beyond the end of the device or partit=
ion.
- * This may well happen - the kernel calls bread() without checking the =
size of
- * the device, e.g., when mounting a file system.
- */
-static inline int bio_check_eod(struct bio *bio)
-{
-	sector_t maxsector =3D bdev_nr_sectors(bio->bi_bdev);
-	unsigned int nr_sectors =3D bio_sectors(bio);
-
-	if (nr_sectors &&
-	    (nr_sectors > maxsector ||
-	     bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
-		if (!maxsector)
-			return -EIO;
-		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
-				    "%pg: rw=3D%d, sector=3D%llu, nr_sectors =3D %u limit=3D%llu\n",
-				    current->comm, bio->bi_bdev, bio->bi_opf,
-				    bio->bi_iter.bi_sector, nr_sectors, maxsector);
-		return -EIO;
-	}
-	return 0;
-}
-
 /*
  * Remap block n of partition p to block n+start(p) of the disk.
  */
@@ -802,8 +778,6 @@ void submit_bio_noacct(struct bio *bio)
 		goto end_io;
 	bio_check_ro(bio);
 	if (!bio_flagged(bio, BIO_REMAPPED)) {
-		if (unlikely(bio_check_eod(bio)))
-			goto end_io;
 		if (bdev_is_partition(bdev) &&
 		    unlikely(blk_partition_remap(bio)))
 			goto end_io;
diff --git a/block/blk.h b/block/blk.h
index bf1a80493ff1c..e70acb2d358e3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -423,6 +423,17 @@ static inline bool bio_may_need_split(struct bio *bi=
o,
 static inline struct bio *__bio_split_to_limits(struct bio *bio,
 		const struct queue_limits *lim, unsigned int *nr_segs)
 {
+	if (unlikely(bio_end_sector(bio) > bdev_nr_sectors(bio->bi_bdev) +
+					   bio->bi_bdev->bd_start_sect)) {
+		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
+				    "%pg: rw=3D%d, sector=3D%llu, nr_sectors =3D %u limit=3D%llu\n",
+				    current->comm, bio->bi_bdev, bio->bi_opf,
+				    bio->bi_iter.bi_sector, bio_sectors(bio),
+				    bdev_nr_sectors(bio->bi_bdev) +
+					bio->bi_bdev->bd_start_sect);
+		goto ioerr;
+	}
+
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
 	case REQ_OP_WRITE:
@@ -442,6 +453,9 @@ static inline struct bio *__bio_split_to_limits(struc=
t bio *bio,
 		*nr_segs =3D 0;
 		return bio;
 	}
+ioerr:
+	bio_io_error(bio);
+	return NULL;
 }
=20
 /**
--=20
2.53.0-Meta

