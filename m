Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E653E548EB
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629657; cv=none; b=sdOmDccwHtFvbjnWUQSbM3nAdJ61JlwwKJv/cKgx9cfBbjcqCj8jsg3S76Cn1/HAsqB6Qu64/ll4kCumlmgC034guFV9xdUy4NxSZev7k36p30zrOmow4bRSumuwhBRVeeY3DfLKwwhUNw1JE0hsc1P+h/xNk/VtyQzGTfB/udE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629657; c=relaxed/simple;
	bh=Vj+L3/70ajCUy8KeYpw+fGjzkFe8WDybhJ+VaEq7fGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4zqN8NkNVkDeYFNKEht+RstPT17yGauFn9Ez9aSphAd0yOUTiro9rzXahR8O1blbj7KeTjCEBvz8U+rZI9mUYXr4VwbiNZ68aifd/ezpK4P/51HvWEC9GUipQzCjvmcUVNrntkF07q9kYaAvxz7F6zzhX2y65OaYaXwcsBN6jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EI9UisMd; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EI9UisMd"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MIcf4x017785
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 11:20:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=4uYN0swH0MhsHnhs0GxmEssjHKom0NEX7OpTrV6hhm0=;
 b=EI9UisMdU9t4Iy3/wffbMT1HZG60juMXa77sjiSgtntFQib/JqAfS2rZEKTjs9Hw/O+Q
 zN/fNiZ4QR8k3ud+KZ1xShNNjT7XXmiMzH9MJBpb7FVfam5pXaatSoPC7ZO3c8LeCYrb
 D3EYm18MUPk7iCeknB0v8LPbcqSxJprjXIXlJ1/4zZGwub2iwyvX6UQpmr4uhIIlenka
 mz2XYXd+umkffhw0lb3i/kV9kgY6EcYGnTk3Y4ar6kCTIvXE4E6gIyzZHP7QLajjbdWZ
 SqoUFwCcEpkRzYuquzsMv3DIQyPiPJ1ncXTjKlV+0Csa3QZLVkqfpEXfFqg8Lxsd1+8W jQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3we86y27jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 11:20:54 -0800
Received: from twshared6594.02.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 11:20:54 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id BAA5E256D9817; Thu, 22 Feb 2024 11:20:40 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.org>, <ming.lei@redhat.com>, <nilay@linux.ibm.com>,
        <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/4] block: blkdev_issue_secure_erase loop style
Date: Thu, 22 Feb 2024 11:19:19 -0800
Message-ID: <20240222191922.2130580-2-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: OQKgYzbpuRnncnYA4j2_d8vBlgeLoU8b
X-Proofpoint-GUID: OQKgYzbpuRnncnYA4j2_d8vBlgeLoU8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

Use consistent coding style in this file. All the other loops for the
same purpose use "while (nr_sects)", so they win.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-lib.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e59c3069e8351..91770da2239f2 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -322,7 +322,7 @@ int blkdev_issue_secure_erase(struct block_device *bd=
ev, sector_t sector,
 		return -EPERM;
=20
 	blk_start_plug(&plug);
-	for (;;) {
+	while (nr_sects) {
 		unsigned int len =3D min_t(sector_t, nr_sects, max_sectors);
=20
 		bio =3D blk_next_bio(bio, bdev, 0, REQ_OP_SECURE_ERASE, gfp);
@@ -331,13 +331,12 @@ int blkdev_issue_secure_erase(struct block_device *=
bdev, sector_t sector,
=20
 		sector +=3D len;
 		nr_sects -=3D len;
-		if (!nr_sects) {
-			ret =3D submit_bio_wait(bio);
-			bio_put(bio);
-			break;
-		}
 		cond_resched();
 	}
+	if (bio) {
+		ret =3D submit_bio_wait(bio);
+		bio_put(bio);
+	}
 	blk_finish_plug(&plug);
=20
 	return ret;
--=20
2.34.1

