Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A0B37474A
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809978; cv=none; b=li0Kf602F6766mZMkB1dsJjb+U+UziL+7LmDRC3u3flqWOXjONayuE5KhtSIv0zwVSyEBOvRa2qZK+gYE/3isTJp1qfeKC2a3OOnUXcIQ6+eEOuY9wFsvvWGiSKljBVdQqyoT11lOPVYVl4vd7yfd/PNzWJvfO7QFjf0yUP+Cok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809978; c=relaxed/simple;
	bh=iZ4MgVFPjOrwaHfRW4oWMsTjk3j2oW4aHYkxU9ZkvnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OA8oqYDsPX8kuWLcNFRvBt5ApZ/MYSFFprxvJrDu6Tp0sWeVShQo+LguB5ho+WG2eCeiYImSttQnc0WLmJnaWuPXDsdXAgnTNeNT5EZFYvdKme9nZD6wJZbEF6ZGgOso70neYACd8bPNHyXvtBj3CEqhpyghkQB+6NWIuGbm2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dY7DvuzR; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dY7DvuzR"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PKuCHp1978827
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 08:39:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=g+gNnuCEu0CCTScieZP2q/o0Hc0wagg2kuzY3RUVL2k=; b=dY7DvuzRE5Ci
	McDxPH0acpwnWq4lkkWpk8gsiO13+1Ka0OKoUH6uPd2zuY0XB9/n3gf6XfSAowvT
	ROEMJA1OFMgFubpjOLL/ZKkJZNbOuyq7xO4YRP7lzIalIxG4Vj00ooP7sIgwG24C
	jFOupEFKrXYhv0L4QtmwUDdnbgWG0u+YbiN26/E5GPsdSTgTgpaAZYP6ExPhKezb
	ux4xSmB0Ri5s1KCWw4BnQ9kLFKxKO0GRVe0JF8M4GKKSNGJGz+Ifp94081zo1akg
	LAvk2kKqDOdgrdpnYH+oRVlQ2+7wVSLDFoBOFsgHp87+FjFrYwN6trGWjihstz+a
	1ZJmtrzhzg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ec08tjvy1-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 08:39:35 -0700 (PDT)
Received: from twshared10183.03.snb3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 26 May 2026 15:39:33 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4BB121CA8D4B7; Tue, 26 May 2026 08:39:22 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <nilay@linux.ibm.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 1/2] block: export passthrough stats enabled
Date: Tue, 26 May 2026 08:39:20 -0700
Message-ID: <20260526153921.2402015-2-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260526153921.2402015-1-kbusch@meta.com>
References: <20260526153921.2402015-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzNSBTYWx0ZWRfX8Sijb/KB7JI+
 o3FDtnKRxQL1JxJBgKV7pyTZC0MJ8m1GdvBZ2oWQtDBPUc/buNdm5xJdrUF45NvHTm2wG+kmHoT
 Tc8x/vVIvOTB6Pmq4Ul03yQnOraKrdO+PNQYuTNcsU+6GCIcL/1PYalWK28cvDTS3PJGnYsr1dn
 Tu6S/rguRsmQizEfcjSbkMbNq6AlC8afDeyNbcSyXkVukRpQsEYdH/hHB871TclYD4Yzf1txrR8
 /KFee2eWZo7TJruCkQperf+eRaZRY/AEPlFcLr+mIR5SLrBVQY2sGgxIKAc+l4L7P/96SULCeRZ
 VFbxPkucBn1gjvw6+DLe87JUeq8rAnCHVjoovJh9/WZqbvNfwoySwbeHl+HqAu8MkAnGXxmUJr8
 tYq0b6VPVZGppocO1K5Qk8BkI1oi0MZhbXcoHQyQZr0ZpDNQ9WpphCw9Xo5yrjopXUQQLwq1iF1
 3BNPJkgJx0tFJTQPvsA==
X-Proofpoint-GUID: q252N-H9NajGQdj7oTNyn8MfF4F_F050
X-Proofpoint-ORIG-GUID: q252N-H9NajGQdj7oTNyn8MfF4F_F050
X-Authority-Analysis: v=2.4 cv=LvKiDHdc c=1 sm=1 tr=0 ts=6a15beb7 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8 a=EHD5-2HmoPCg4FQ8pjcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

A user can enable io accounting for passthrough requests, so export the
helper that checks if the request should be tracked. This will enable
stacking drivers to to report iostats for passthrough workloads.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c         | 32 +-------------------------------
 include/linux/blk-mq.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 28c2d931e75ea..48115e1d9d6a8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1088,43 +1088,13 @@ static inline void blk_account_io_done(struct req=
uest *req, u64 now)
 	}
 }
=20
-static inline bool blk_rq_passthrough_stats(struct request *req)
-{
-	struct bio *bio =3D req->bio;
-
-	if (!blk_queue_passthrough_stat(req->q))
-		return false;
-
-	/* Requests without a bio do not transfer data. */
-	if (!bio)
-		return false;
-
-	/*
-	 * Stats are accumulated in the bdev, so must have one attached to a
-	 * bio to track stats. Most drivers do not set the bdev for passthrough
-	 * requests, but nvme is one that will set it.
-	 */
-	if (!bio->bi_bdev)
-		return false;
-
-	/*
-	 * We don't know what a passthrough command does, but we know the
-	 * payload size and data direction. Ensuring the size is aligned to the
-	 * block size filters out most commands with payloads that don't
-	 * represent sector access.
-	 */
-	if (blk_rq_bytes(req) & (bdev_logical_block_size(bio->bi_bdev) - 1))
-		return false;
-	return true;
-}
-
 static inline void blk_account_io_start(struct request *req)
 {
 	trace_block_io_start(req);
=20
 	if (!blk_queue_io_stat(req->q))
 		return;
-	if (blk_rq_is_passthrough(req) && !blk_rq_passthrough_stats(req))
+	if (blk_rq_is_passthrough(req) && !blk_rq_passthrough_stats(req, req->q=
))
 		return;
=20
 	req->rq_flags |=3D RQF_IO_STAT;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581d..25931a8076d2a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1243,4 +1243,34 @@ static inline int blk_rq_map_sg(struct request *rq=
, struct scatterlist *sglist)
 }
 void blk_dump_rq_flags(struct request *, char *);
=20
+static inline bool blk_rq_passthrough_stats(struct request *req,
+					    struct request_queue *q)
+{
+	struct bio *bio =3D req->bio;
+
+	if (!blk_queue_passthrough_stat(q))
+		return false;
+
+	/* Requests without a bio do not transfer data. */
+	if (!bio)
+		return false;
+
+	/*
+	 * Stats are accumulated in the bdev, so must have one attached to a
+	 * bio to track stats. Most drivers do not set the bdev for passthrough
+	 * requests, but nvme is one that will set it.
+	 */
+	if (!bio->bi_bdev)
+		return false;
+
+	/*
+	 * We don't know what a passthrough command does, but we know the
+	 * payload size and data direction. Ensuring the size is aligned to the
+	 * block size filters out most commands with payloads that don't
+	 * represent sector access.
+	 */
+	if (blk_rq_bytes(req) & (bdev_logical_block_size(bio->bi_bdev) - 1))
+		return false;
+	return true;
+}
 #endif /* BLK_MQ_H */
--=20
2.53.0-Meta

