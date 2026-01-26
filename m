Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED6733BBBF
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444859; cv=none; b=gBfcTuRAOkLXXF0uQLzYqJ4d2VLQE5dRvb3rXQ7cMTkLcUHVwUC9bKWs+SDkImKYDNaTqhkj6fLWXNz1yB65dMFlLcmaSIdhXQ5hydxW14ZLdwE3tIA/ITHb0TWlIA/q6HSVL8ZenxI3WYKpyonkMBjrZ9Ifu5LPhLke7R/AcG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444859; c=relaxed/simple;
	bh=ZGfjECRXSu+gnzNjS9m351g0BIpokfDygnm7jjNTFe8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DoV/qC4waePmcQq395Y2y6H9KkS7jNoFIm1s6K+VpN2dNl4Os3JiPh+Ka3J95NWcf67rXwsHBq7ke5DMZ1efohrCKIE8x5NOecaH1AZj/Bb078/I41cTiwgpglzoqdRkjg93hFW2OPOPj/YrZbCmXhLqrKXcRQgrsxx9XI3UeCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VavjwfHL; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VavjwfHL"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QFd2nW2052827
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 08:27:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=oA3/xdC0n/q6uovqhC
	X2hnYk9NIsQT61ZIxK+RshItc=; b=VavjwfHLAGj1zfm6fumAtTQMC/mh2Zymc+
	eu6ryXmFi1klQZcDJ4h9crroHq8orlyv7fqnrFkQSo96b0xtSigyT0dmMAY6ODfD
	hih+n3fJhnp/n6ZxcCSNm0BbrmZdMCbgIQp3PSHNeCj9RjgRZIQBd1XFW4nnWkJl
	PRFCTDIZg2e599IY/0qVMaQ3ciqlV39jezQxp+Co9np5FxfnJJIE47iunZ54arMU
	rgQ23QdtgX5xRkj4IUUS7dmN/q4WhewW3ddrcB6yOJUA6lFBBRGvFsY4z6A47OA+
	gC/lD8FqhyQai3NMHA/sUpgrokeyF1iPJJO7+FbAd7dz1QkhCRlA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bx0vx3ykr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 08:27:36 -0800 (PST)
Received: from twshared18017.01.snb2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Mon, 26 Jan 2026 16:27:36 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 542056B9FA8A; Mon, 26 Jan 2026 08:27:25 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block: remove bio_last_bvec_all
Date: Mon, 26 Jan 2026 08:27:24 -0800
Message-ID: <20260126162724.1864652-1-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: 0GWAG63RgjrX9npNTUuGex5iZ59TZbNk
X-Proofpoint-GUID: 0GWAG63RgjrX9npNTUuGex5iZ59TZbNk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEzNiBTYWx0ZWRfX/MtRGFIoQ5i9
 bVmvJD3pzSnZeo8kqA0XfplNlSEkw4gnreD/Ko18CiX4YpGnj3vEabSFMcvoh+Xda5Z5fdVPFBF
 7FQhKi5mtQAZlPXV/AWPVH8U7BG5Untxfiz0y2ZT77ORHZeG7NSukK4KVesePVT9jEdO2ZXrXEp
 sDCXkoKZPYo9lbZrcKn6bC0itkEBjDco77iT1BygEijDklJ9WiBcein5eOO6uhi5Jtf8Td0rSnO
 tMGDr/JxVZlR5zDkd8ycC6l6o+QXFufj5jA0zbCub9SuLZwfaRy+QwByAfIXho4dHjBNTYVk9lz
 6WhT38rMoMD+00DcoRDOWX9lgNlnZ8an5y12nFaKNEwub9Nbse77yDZQs22zISQakD07nL021de
 L0IHBXw7pETUehPaBwU9BIOlYvh/MBds6z9VXVDvPpNJNN8KXOZFrF1xgpA7dTHvV9wXo8PhLIV
 svM+fxgZuyBzBcklJxw==
X-Authority-Analysis: v=2.4 cv=P743RyAu c=1 sm=1 tr=0 ts=697795f8 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=tJ1nug0kx5D7Olr3xrgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

There are no more callers of this function after commit f6b2d8b134b2413
("btrfs: track the next file offset in struct btrfs_bio_ctrl"), so
remove the function.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 Documentation/block/biovecs.rst | 1 -
 include/linux/bio.h             | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/Documentation/block/biovecs.rst b/Documentation/block/biovec=
s.rst
index b9dc0c9dbee44..11126ed6f40f7 100644
--- a/Documentation/block/biovecs.rst
+++ b/Documentation/block/biovecs.rst
@@ -135,7 +135,6 @@ Usage of helpers:
 	bio_first_bvec_all()
 	bio_first_page_all()
 	bio_first_folio_all()
-	bio_last_bvec_all()
=20
 * The following helpers iterate over single-page segment. The passed 'st=
ruct
   bio_vec' will contain a single-page IO vector during the iteration::
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 95cfc79b88b89..69d56b1d1bd21 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -256,12 +256,6 @@ static inline struct folio *bio_first_folio_all(stru=
ct bio *bio)
 	return page_folio(bio_first_page_all(bio));
 }
=20
-static inline struct bio_vec *bio_last_bvec_all(struct bio *bio)
-{
-	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
-	return &bio->bi_io_vec[bio->bi_vcnt - 1];
-}
-
 /**
  * struct folio_iter - State for iterating all folios in a bio.
  * @folio: The current folio we're iterating.  NULL after the last folio=
.
--=20
2.47.3

