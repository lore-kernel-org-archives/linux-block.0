Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC31DF25C
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172442; cv=none; b=GiMumKR36aFqO0TEH25PTFpeS2UHSFCaGqp5mcCWBHY1FtW9b9kcKMhthZvAmak2GP+EPiFoaQDDUGonafcdovEUUVghWXZnTRQkwFdaE3lTVg6Nn+7SF9UCFBAHihm0Coc/7KmN+xflTEXtdr0XXnqlUtZClde5Vbn86Yaxk/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172442; c=relaxed/simple;
	bh=QhV4gxQsozeZt4rJSw20XGTJ1UT1SgZp4TqFwqe39XI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=BZrIXpcEqNZjzQQV7wjzjHsgwrA0uBDs/kwKMqsF9xdviU/FoID0qPPJPuCvnQJ4tiUtsMomVvBL+SHgKCJjaOErZLrvYP6/GjJGT+4xASucoSU3w0+MEmkoIhcS94+A9qzEQJYdCLpxyCjdZa/CYKd9iWCxvQB66TAQZNGV3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=II7azpUW; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="II7azpUW"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250722082032epoutp0415a5e1e80ddbb38b8ecaaf165b70eba8~UhQnps1rU2275022750epoutp04b
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 08:20:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250722082032epoutp0415a5e1e80ddbb38b8ecaaf165b70eba8~UhQnps1rU2275022750epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753172432;
	bh=SIdi21AOkpyDnx2ZeL+pzOQAYPuPZaU/ZAeCKSe3EtI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=II7azpUWz7cgLIGxU5ldaMwQMndx7Tm0iTauUhDdQcaq/klwOcknmvLvoXCcIrhFO
	 XodHBZ+QuVmc0UyG/cWZRXAwF0eLkt5nU7ZTmQ5wi0Uu0cQCoqsnUsHJaJ1vOnJ+IE
	 L3WV09JTbADTAfcROxizG+KGf/1/Lejf1inxWvRs=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250722082032epcas5p137a6d8fc1c5d3db4130db6097a7d20c1~UhQnU-SUX1467414674epcas5p11;
	Tue, 22 Jul 2025 08:20:32 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.86]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bmVZR1tsvz6B9m7; Tue, 22 Jul
	2025 08:20:31 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250722081938epcas5p12a1ee45419754afa2f1c1c9040d519d6~UhP1q8gYD1959219592epcas5p12;
	Tue, 22 Jul 2025 08:19:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250722081937epsmtip2870bdae7aa8d409559f60c9f1cb5fd18~UhP0l9owm2336023360epsmtip2g;
	Tue, 22 Jul 2025 08:19:37 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, anuj1072538@gmail.com, axboe@kernel.dk,
	hch@infradead.org, martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH] block: fix lbmd_guard_tag_type assignment in
 FS_IOC_GETLBMD_CAP
Date: Tue, 22 Jul 2025 13:49:11 +0530
Message-Id: <20250722081911.78327-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250722081938epcas5p12a1ee45419754afa2f1c1c9040d519d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250722081938epcas5p12a1ee45419754afa2f1c1c9040d519d6
References: <CGME20250722081938epcas5p12a1ee45419754afa2f1c1c9040d519d6@epcas5p1.samsung.com>

The blk_get_meta_cap() implementation directly assigns bi->csum_type to
the UAPI field lbmd_guard_tag_type. This is not right as the kernel enum
blk_integrity_checksum values is not guaranteed to match the UAPI
defined values.

Fix this by explicitly mapping internal checksum types to UAPI-defined
constants to ensure compatibility and correctness, especially for the
devices using CRC64 PI.

Fixes: 9eb22f7fedfc (add ioctl to query metadata and protection info capabilities)
Reported-by: Vincent Fu <vincent.fu@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-integrity.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 61a79e19c78f..2b5829c58aa1 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -83,7 +83,23 @@ int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
 	if (meta_cap.lbmd_opaque_size && !bi->pi_offset)
 		meta_cap.lbmd_opaque_offset = bi->pi_tuple_size;
 
-	meta_cap.lbmd_guard_tag_type = bi->csum_type;
+	switch (bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_NONE:
+		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_NONE;
+		break;
+	case BLK_INTEGRITY_CSUM_IP:
+		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_IP;
+		break;
+	case BLK_INTEGRITY_CSUM_CRC:
+		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_CRC16_T10DIF;
+		break;
+	case BLK_INTEGRITY_CSUM_CRC64:
+		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_CRC64_NVME;
+		break;
+	default:
+		break;
+	}
+
 	if (bi->csum_type != BLK_INTEGRITY_CSUM_NONE)
 		meta_cap.lbmd_app_tag_size = 2;
 
-- 
2.25.1

