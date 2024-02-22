Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2269C14B824
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629647; cv=none; b=t0+hLxhlelRBDFoJcO1yVhA+UyWIUAEtAhJo/7CvN7BEFpbRK/vs5JzTTnfif2rb1GFhuHFe27QqfyTyiwvxj/OJdz2oGbjh1gbod1r+ArQfF/BIhNk6AJUGo3/rhNOHO0dh0CjM3AB/l0T5lrFLey++y2s4Cdy1xbeh2o5Yyec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629647; c=relaxed/simple;
	bh=zQD6oPiqsC7ES4uENVtVntjfOaQK0Mmoqg5f8SzwZSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ru4PTzGth6u15O9tQPX4YBnymkfm+WxcH6G2hzXwVbXi2SzcAC9xQ5SmHEWKG64dCuOQhBsBgmvGbnbxfC4n5pE2My5Eo7q3bKywnm3Vsv96n79aFjJsuoM1yNZEgj/Ih+tZZfpAugJjkxk1ESBvLOutKNHOCHQIWPw8Bt5YUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=XFLD5ZAB; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XFLD5ZAB"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MIvDoO012046
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 11:20:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=YtSiX6VZwe9+8caIFcZzz6t0+Mz/DJznXBZMA2Q+5tE=;
 b=XFLD5ZABNMEAZodgjd7Wy/rie81dpFTqsFFxKM0hfdvCIpNF//ZhI7Xmy/fFywkYX0Ye
 1hdxcbIlV++ijj2Ug6ThULTd0nwkDKkqEdDRnIoG96gCCThXuAdKNsOjkcy3r+jwBfCC
 KjWt+m5dlyVwGS0ESYLrMXq6HQ6JsIHN0f0fdw20m7pSyN10loj6HmoNZkH0wiHPseyD
 xJv16hJ4qjsfubzCeeM00DaaCBLdX455+DxQxHiivTJYm92jF5B6g2iP8PgpYM3reuNV
 kpfmCcsapV4pqIKVIj+eGB3OXICvKVGo867KWHi7eIyrtVNSBaJBVApKEa1WuU5GeoqG fw== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3wec0cr64e-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 11:20:45 -0800
Received: from twshared53729.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 11:20:44 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id C6D7F256D9819; Thu, 22 Feb 2024 11:20:40 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.org>, <ming.lei@redhat.com>, <nilay@linux.ibm.com>,
        <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 2/4] block: __blkdev_issue_write_zeroes cleanup 
Date: Thu, 22 Feb 2024 11:19:20 -0800
Message-ID: <20240222191922.2130580-3-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222191922.2130580-1-kbusch@meta.com>
References: <20240222191922.2130580-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: lntaIhGNhKEhZ3J2ljgTjPnIBA0chtWi
X-Proofpoint-ORIG-GUID: lntaIhGNhKEhZ3J2ljgTjPnIBA0chtWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

Use min to calculate the next number of sectors like everyone else.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-lib.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 91770da2239f2..d4c476cf3784a 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -132,19 +132,16 @@ static int __blkdev_issue_write_zeroes(struct block=
_device *bdev,
 		return -EOPNOTSUPP;
=20
 	while (nr_sects) {
+		unsigned int len =3D min_t(sector_t, nr_sects, max_write_zeroes_sector=
s);
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
+		bio->bi_iter.bi_size =3D len << 9;
+		nr_sects -=3D len;
+		sector +=3D len;
 		cond_resched();
 	}
=20
--=20
2.34.1

