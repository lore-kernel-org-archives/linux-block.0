Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5D782D7D
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703997; cv=none; b=bRCMgDT7EuFuuEhUmaJR36uTHciLT1eADLAzWSBAmTGQ62bJs4xic1EfLZEis4aTSCG/+MA65mDfqKkJHrtc609SIOSuugvH5aSOcCgFfePDx/3EWSE3i8WjqVXtEhAZDeQvfIkkk3QFc/HNDGHukPhLqKUPj6mLjmYEZvYTH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703997; c=relaxed/simple;
	bh=QhJk5WCim3ppStJXdISlPyPXyOJjRwsz4DNi8IZIEJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LsTp7qJaXZwOa1njRW6LijvsjCe04+D3MVfLwstpgxXXQChbiKiIToPWrrsQ32wE2Om+LbAZ0xqhaQmC+eSasvP9GmvBlj9Y43esG0+XcSJ8vewi1O/ayDkel75t3tII9QwkXg3EeDtEUEhfQJQvDnFBeOhJfokdv+dLtyipe6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RPQ/6m3a; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RPQ/6m3a"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 41N36YH9008854
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 07:59:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=1NfP6xsV93KEOWBV/kWyr+viXR/FDP+NGbmg2sv08/I=;
 b=RPQ/6m3a+t3t5dviozTmEmY4mQDtjq/mn7hMzH+OuGMMS5qi1ndrRugB+ijSFaGPuVSj
 3DOeJ5SLtbfmvITmHCWtRY3ZrktDCEdJwz1oXHGD0C/hZ0rzYostapdfdJsZuxaoyo+d
 tL1afHOcMiOozlJelD++eFRTOTGfj01aTp1sqpQEtvjUgi6MHTuAYf/GKY8w4OPGsI+h
 gfAlSrDJ08sL9IJM1ohd+OfTp2lSXmIY2iWn/B8/BRURGdsJbvtW7fXVtoLpg41WZ1SQ
 C9Yx1uYK+s7DAsjR2VJajUGUzPDZI5SJRX5vmaAiJleJnRcALK88GYMTcFBnlx2G4rAw WQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3wek5m3a08-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 07:59:55 -0800
Received: from twshared53729.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 07:59:25 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 9FFE42574FA41; Fri, 23 Feb 2024 07:59:12 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.org>, <ming.lei@redhat.com>, <nilay@linux.ibm.com>,
        <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig
	<hch@lst.de>
Subject: [PATCHv4 1/4] block: blkdev_issue_secure_erase loop style
Date: Fri, 23 Feb 2024 07:59:07 -0800
Message-ID: <20240223155910.3622666-2-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: pkhawA1H3ttzLhS9_9rE4WZe98jMem4v
X-Proofpoint-GUID: pkhawA1H3ttzLhS9_9rE4WZe98jMem4v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_02,2024-02-23_01,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

Use consistent coding style in this file. All the other loops for the
same purpose use "while (nr_sects)", so they win.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

