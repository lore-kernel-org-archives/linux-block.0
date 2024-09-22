Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E429A2
	for <linux-block@vger.kernel.org>; Sun, 22 Sep 2024 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727014697; cv=none; b=SL4sYx+7IgWbeRborTSLwPT0wnBZdFJk75byH2tUfwWTHbKayJ98XUNSCTHSbwmbtKy9CAnhZo44mhp+ZoZ6FD9k40YFKPFEl7n/UVtGn56dr9KlJO9sHnKcmmw976KY4wWqS/MC7QPF0CtvW5EYSXpxHTHFqvvepZGt5lSY5+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727014697; c=relaxed/simple;
	bh=1v3gI3D/nkcZrYshnVeYkBvWgias4MIf5icZKNFzlzg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mIy0+KmOGrkvJev9ASzKpc13++NjBlbQFQEQ/CLJdl3ev+alCskIGmlbiJOqBnLpCOSJPM2lIDz6tJ4whLuT4Sq/gUXHau8Xn+gqfsebJmzV6waQGjjDk7XdQqCDu9+BoRepZ+xfLkN9lLBbhUOD6pXFzYjw1iVAzVBRPtUGiqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Bj5pT+h8; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Bj5pT+h8"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MCrgQu032383
	for <linux-block@vger.kernel.org>; Sun, 22 Sep 2024 07:18:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=8O6
	k4c2jaJB7vRLGt5+zzaNNp5aDlFWuaR7DkhyaT2c=; b=Bj5pT+h8o71PlVmo5CR
	A5F12Znmhr0vZaT4TP09yZAyFNTN6Iw9qDkIsfLOGZGOuRQwqnD9Fk3PB80QVZfZ
	73KYtN8rFiOu6RsyfvUYWlF3uGJxJrIfeSUH1Lk32TU/yWdb+yvt8Gj5zMoS+WLX
	WXHZZ/8+bf/ICuijhn3kRw7vmD8bH18hCR8/UHXHISBLeJ/jaL0aTw2vHFSVaLQ2
	tYzfgVhzuY5+WpYrW2cwrRFcUCe/BFfQZ79tZDH7LRGrINt6ORZ++/SuN3p1S7yl
	Uw7jqbaYMqaAzOXQJdxbpVJKf2iAuUj+aG1nrJOpsgNUecUFq5EhyDYpMoW0Gzik
	mEw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41ssfeehm9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sun, 22 Sep 2024 07:18:14 -0700 (PDT)
Received: from twshared18321.17.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Sun, 22 Sep 2024 14:18:13 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 82DC81352B87D; Sun, 22 Sep 2024 07:18:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block: fix blk_rq_map_integrity_sg kernel-doc
Date: Sun, 22 Sep 2024 07:18:00 -0700
Message-ID: <20240922141800.3622319-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uvpkmQHf-PCNdiDwrKXr7Bhhco8ke6pl
X-Proofpoint-GUID: uvpkmQHf-PCNdiDwrKXr7Bhhco8ke6pl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-22_13,2024-09-19_01,2024-09-02_01

From: Keith Busch <kbusch@kernel.org>

Fix the documentation to match the new function signature.

Fixes: 76c313f658d2752 ("blk-integrity: improved sg segment mapping")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 0a2b1c5d0ebf1..83b696ba0cac3 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -56,8 +56,7 @@ int blk_rq_count_integrity_sg(struct request_queue *q, =
struct bio *bio)
=20
 /**
  * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
- * @q:		request queue
- * @bio:	bio with integrity metadata attached
+ * @rq:		request to map
  * @sglist:	target scatterlist
  *
  * Description: Map the integrity vectors in request into a
--=20
2.43.5

