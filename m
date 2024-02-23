Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18D1405C7
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703973; cv=none; b=fcSv4QxHBmJ5YJ/3F43x/hcNjDC8s7VACtOnw4J+VS8ahE9O/HDaBUJN3RIV6xkmAEYZ+qcLyKUbQEJj2cxpUe9noDKtQP6v2SaYNlsRNjLshFG3hgwtTbCE9MWjTNKqSZWMZ30vT5APYTOawoBHFwGcCaRsHleWVmmvg0sFK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703973; c=relaxed/simple;
	bh=qjkfnx3lXgo+eKjLYIdsMj7wig4Syy+Jn8U+Yl45WWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkqyh9dt7gu4s55njcsnIw/8G/nJZES2NxncmTKpIFeQi5QnNBTiV+Y5nLJQ1QzlEdvSexSJf9qwo24r4Mfk/M1EH6uhzpe7mLvZN0bFka/gnUPvbjFn6dxa9Uf/Sz+BUPSN3dbAtjpNQJui0eMINB4I0P749ohJpqPM0TV/kg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NcuUrRqS; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NcuUrRqS"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NEi8Rm022671
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 07:59:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=UvajsDIOtKJqeFO4f5D1zhd0cD5+h19KssvbIm8LbRU=;
 b=NcuUrRqSSQ4DtgXJ8CqwcKly4vVFLSqC8JEl2Ml2ctigiMZ7Q1hIA1YUhsvZIvuRRM40
 ek8lEqcOEgm4X1r0MmsVvKGSvMYQg9oBqTEzELFMc31UVBOujxEk6b2p5p61yat+5GDk
 SnUjufRy1ymWQ7gx3mKI1Ys3vzYnLbsLvgDiNPPgT5i6KE1LgvuYINQTRXZAxYgQDMtL
 eTte3T/76xyxbWwIkeaUI1pssCp3D+GySpLLjPA/K8ntHHRbM7J3o4+VzpN0TkPOgfPP
 7SH4Twk6yQspdhVhpY9+psU3SPrd6hpMT+KdtHjmrEEKekMdByxSIV1+nKBQDlyCB0Jo fA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3webyke4e9-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 07:59:31 -0800
Received: from twshared34526.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 07:59:26 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id E94CB2574FA44; Fri, 23 Feb 2024 07:59:12 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.org>, <ming.lei@redhat.com>, <nilay@linux.ibm.com>,
        <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 2/4] block: cleanup __blkdev_issue_write_zeroes
Date: Fri, 23 Feb 2024 07:59:08 -0800
Message-ID: <20240223155910.3622666-3-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223155910.3622666-1-kbusch@meta.com>
References: <20240223155910.3622666-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GMDdntjW-9yHp09rvDcgx1CoHsesfu_3
X-Proofpoint-GUID: GMDdntjW-9yHp09rvDcgx1CoHsesfu_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_02,2024-02-23_01,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

Use min to calculate the next number of sectors like everyone else.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-lib.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 91770da2239f2..a6954eafb8c8a 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -120,31 +120,28 @@ static int __blkdev_issue_write_zeroes(struct block=
_device *bdev,
 		struct bio **biop, unsigned flags)
 {
 	struct bio *bio =3D *biop;
-	unsigned int max_write_zeroes_sectors;
+	unsigned int max_sectors;
=20
 	if (bdev_read_only(bdev))
 		return -EPERM;
=20
-	/* Ensure that max_write_zeroes_sectors doesn't overflow bi_size */
-	max_write_zeroes_sectors =3D bdev_write_zeroes_sectors(bdev);
+	/* Ensure that max_sectors doesn't overflow bi_size */
+	max_sectors =3D bdev_write_zeroes_sectors(bdev);
=20
-	if (max_write_zeroes_sectors =3D=3D 0)
+	if (max_sectors =3D=3D 0)
 		return -EOPNOTSUPP;
=20
 	while (nr_sects) {
+		unsigned int len =3D min_t(sector_t, nr_sects, max_sectors);
+
 		bio =3D blk_next_bio(bio, bdev, 0, REQ_OP_WRITE_ZEROES, gfp_mask);
 		bio->bi_iter.bi_sector =3D sector;
 		if (flags & BLKDEV_ZERO_NOUNMAP)
 			bio->bi_opf |=3D REQ_NOUNMAP;
=20
-		if (nr_sects > max_write_zeroes_sectors) {
-			bio->bi_iter.bi_size =3D max_write_zeroes_sectors << 9;
-			nr_sects -=3D max_write_zeroes_sectors;
-			sector +=3D max_write_zeroes_sectors;
-		} else {
-			bio->bi_iter.bi_size =3D nr_sects << 9;
-			nr_sects =3D 0;
-		}
+		bio->bi_iter.bi_size =3D len << SECTOR_SHIFT;
+		nr_sects -=3D len;
+		sector +=3D len;
 		cond_resched();
 	}
=20
--=20
2.34.1

