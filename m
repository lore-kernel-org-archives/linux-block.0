Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C174381AEB
	for <linux-block@vger.kernel.org>; Thu, 21 May 2026 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390206; cv=none; b=sIMaviJg3peJPBZ3qqX5XWQkiIyRcuQyW998rtuYCCMyeLv991mvQJhzjSggwxGZLaYDPFHjjy9tuVJJFtV8PWiVbxZVNFrGQjNK+vTyfLjVB3lCe8KpXADldztWqOqrLHK1ToWLHJ21t8318mCr+6DJ8HHdLRKR/zzhyk96O2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390206; c=relaxed/simple;
	bh=PnVfwKwv/MGdRzz/FQltWdHGBFuU6uggaADJT3ft6AM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nLFLWZVJ5D+D6XQaf3ZCuTkLbj8NuMXd5VSRBBlxmUpkLAVgzGq+DjRz0Sm63Q3+R7mfzn4GbU5DZzCkqxYMrAPYdeVI0pmPDDcmsKp5K7vrQVeatPEMUx7yZAzWcv94h6b/jetbeRuv8iqQEMxh+D30oIggeI3d7PN2YQCy1sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=sIgHWitn; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="sIgHWitn"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LIHLUP1694316
	for <linux-block@vger.kernel.org>; Thu, 21 May 2026 12:03:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=CYQ6WRYb+QwWs/E9pe
	Ns/aMyVCpvaKQKTVzaiKSLHus=; b=sIgHWitniQ5SisFlPgiDArwwoz4F4TUCIK
	/qPl+CXZw2KUOOJWwxk90RCJv8hg0wCu5O2HWtJ3IRA9XzO614wOM5JHox4083ZT
	GoVwa+z4vwkim7FGKM3a7rWCJkA5E0GJ0oaGniToQbBsRsnTruL6XNQk5YoTCF/P
	t/cIAiIuMFyui38yPeDEwKGPAkdJ/AbxK+KTBeVd5ABQg8CyWqSfjiRWNZQyTUHu
	/DMISK7bKXaJLqiMRy4BU/+RuHcasmJWTdIwGd5Eqm4FwpveGN97ISbRPjigt9B+
	7NDDayKwt11/iKn5IvM4cXZKaQsn+zaLfyZJqo0ztQ3fcF8NKq6g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ea76pg9qx-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 21 May 2026 12:03:17 -0700 (PDT)
Received: from twshared13583.32.frc3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 21 May 2026 19:03:14 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 2EC151B2ABA8B; Thu, 21 May 2026 12:02:55 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>
CC: <tom.leiming@gmail.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3] blk-mq: pop cached request if it is usable
Date: Thu, 21 May 2026 12:02:53 -0700
Message-ID: <20260521190253.242065-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ROKD2Yi+ c=1 sm=1 tr=0 ts=6a0f56f6 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VwQbUJbxAAAA:8 a=o6C09Vw2lQhHS83W158A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE5MSBTYWx0ZWRfX9ubH/USAWPIP
 BSD1OavfiX5VwwFtcXUStqG6vMefGm8r8O9vB+smpjLK+rBs935SR2stzwHW3yW4YQMYjEe8Exg
 rDf45iKp0D/8U1wddzdlUalmwqBKrq42GZM8fZ0Dev24iSa0GEXPzrNt5Byva+XmZyT8G88spEt
 8MKSXQ8oQ3q9G9XRe+1/WoTrVpocTWaIUfhtXlX0nt4IG6fnUSrGyLeX2QqljqthCdXDGDHJanS
 my9j1DeCI4g8Qb65An8crAvmVUzK0xCsbHj/XC/yfFYbTFGBhNAZAuUcsSCvi8w4pHgyyYkFQ7z
 MSx7TvDWgjn/nu5VRkresDMCwmntHFTJqaIqOS1VmAhWXWH2Cb21VPYtWAtIZ26QaXvgKqlU9+4
 J1ffG0lFxDEIAF/LswavZVy6JLFqhhvLKFQkOtzF8bUMrngnVZuIbe2T9Ad5UjBHFRkALkCB1qG
 BnnH6dWt759nw23xR7w==
X-Proofpoint-GUID: jR0fbsXBk6N9_GNLKq_cs8_nKbK9dFpK
X-Proofpoint-ORIG-GUID: jR0fbsXBk6N9_GNLKq_cs8_nKbK9dFpK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_04,2026-05-18_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

When submitting a bio to blk-mq, if the task should sleep after peeking
a cached request, but before it pops it, the plug flushes and calls
blk_mq_free_plug_rqs, freeing the cached_rqs. This creates a
use-after-free bug. Fix this by popping the cached request before any
possible blocking calls if it is suitable for use.

Popping this request first holds a queue reference, so avoid any
serialization races with queue freezes and can safely proceed with
dispatching that request to the driver. This potentially increases a
timing window from when a driver wants to freeze its queue to when
requests stop being dispatched. That scenario is off the fast path
though, and drivers need to appropriately handle requests during a
freeze request anyway.

The downside is the popped element needs to be individually freed when
we performed a bio plug merge. The cached request would have had to be
freed later anyway, but this patch does it inline with building the plug
list instead of after flushing it.

Fixes: b0077e269f6c1 ("blk-mq: make sure active queue usage is held for b=
io_integrity_prep()")
Fixes: 7b4f36cd22a65 ("block: ensure we hold a queue reference when using=
 queue limits")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  This pops the cached requests first. It's simpler this way and I don't
  see any strong reason against it.

 block/blk-mq.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d0c37daf568f2..28c2d931e75ea 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3077,7 +3077,7 @@ static struct request *blk_mq_get_new_requests(stru=
ct request_queue *q,
 /*
  * Check if there is a suitable cached request and return it.
  */
-static struct request *blk_mq_peek_cached_request(struct blk_plug *plug,
+static struct request *blk_mq_get_cached_request(struct blk_plug *plug,
 		struct request_queue *q, blk_opf_t opf)
 {
 	enum hctx_type type =3D blk_mq_get_hctx_type(opf);
@@ -3093,27 +3093,10 @@ static struct request *blk_mq_peek_cached_request=
(struct blk_plug *plug,
 		return NULL;
 	if (op_is_flush(rq->cmd_flags) !=3D op_is_flush(opf))
 		return NULL;
+	rq_list_pop(&plug->cached_rqs);
 	return rq;
 }
=20
-static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *pl=
ug,
-		struct bio *bio)
-{
-	if (rq_list_pop(&plug->cached_rqs) !=3D rq)
-		WARN_ON_ONCE(1);
-
-	/*
-	 * If any qos ->throttle() end up blocking, we will have flushed the
-	 * plug and hence killed the cached_rq list as well. Pop this entry
-	 * before we throttle.
-	 */
-	rq_qos_throttle(rq->q, bio);
-
-	blk_mq_rq_time_init(rq, blk_time_get_ns());
-	rq->cmd_flags =3D bio->bi_opf;
-	INIT_LIST_HEAD(&rq->queuelist);
-}
-
 static bool bio_unaligned(const struct bio *bio, struct request_queue *q=
)
 {
 	unsigned int bs_mask =3D queue_logical_block_size(q) - 1;
@@ -3152,7 +3135,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	/*
 	 * If the plug has a cached request for this queue, try to use it.
 	 */
-	rq =3D blk_mq_peek_cached_request(plug, q, bio->bi_opf);
+	rq =3D blk_mq_get_cached_request(plug, q, bio->bi_opf);
=20
 	/*
 	 * A BIO that was released from a zone write plug has already been
@@ -3211,7 +3194,10 @@ void blk_mq_submit_bio(struct bio *bio)
=20
 new_request:
 	if (rq) {
-		blk_mq_use_cached_rq(rq, plug, bio);
+		rq_qos_throttle(rq->q, bio);
+		blk_mq_rq_time_init(rq, blk_time_get_ns());
+		rq->cmd_flags =3D bio->bi_opf;
+		INIT_LIST_HEAD(&rq->queuelist);
 	} else {
 		rq =3D blk_mq_get_new_requests(q, plug, bio);
 		if (unlikely(!rq)) {
@@ -3257,12 +3243,10 @@ void blk_mq_submit_bio(struct bio *bio)
 	return;
=20
 queue_exit:
-	/*
-	 * Don't drop the queue reference if we were trying to use a cached
-	 * request and thus didn't acquire one.
-	 */
 	if (!rq)
 		blk_queue_exit(q);
+	else
+		blk_mq_free_request(rq);
 }
=20
 #ifdef CONFIG_BLK_MQ_STACKING
--=20
2.53.0-Meta

