Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600C036EAAB
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809759; cv=none; b=KmpPzi1Qgni5Ie9Jex7IBdThsNuQ35cB65Gm56yBd6fqT5KucycOBzZWndEBAG0+8SMD5QPw/58ByYo1osJcH8SpyF9cUy07JZmWSGw4W/35B4ZSdjjUjv1tRnNmELENryeLrq9z+53pcbdQtfB88qyMd4sV1m0qPMe+oTUuZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809759; c=relaxed/simple;
	bh=o6W5WfzbDTEvjVLEUyBfEwwMjRDYUWLLGWTHt/nhRpA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lnLmryy6IHno/2f0sL1bCaE7yyAgTkBUBdi4MTfEtCW/8hz8/rtb5jy9TDCdkMM9o0q4f1xs6K+jbs0jO3mM5Zc1akH5se+/j6vbZJZdNUeg402wmNVYLcFv0bleLjCDpNoYPio5Xy2ywF8zpX3fO3MGERL7KiMHGy9nBSoQZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BJ1NX0wr; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BJ1NX0wr"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QFW1wt1039899
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 08:35:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=j8Ecogw3YBGRuoyqJ6
	aShqn8/KMBYM5J9SolyBPFzw8=; b=BJ1NX0wralxDKBqU5rbtlIO6DZrnWCg3h8
	sTotQzegZXz+uma3XxteKO8DuyPrq2T3owfUJ4ZYsBXl/tlrIrC3FW507+wwEQ3e
	vPHbHC8OQwFc9RYwhFJmbGzJw5Hn+NZ54G8wdus/oUYpgUjctIt4P95fqF1th9sv
	qYKA2uQnM1jr3Jw+creFzyw3RRHM+TQaFLo+Yzqoq44XU23Dv7yLX1nYziFk2wFd
	YArTTl3gqC9fc8pKpxOxOX5opJV9NlraA+CM2QoPuljZULgC87RzzCyJsMhyXY4A
	X1r+EAjZdZioEexxkYM8Cv5ctqnzXB7LweOCWyoiWmUW+par0ddw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ec0uhtrkn-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 08:35:53 -0700 (PDT)
Received: from twshared23436.02.snb2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 26 May 2026 15:35:51 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 8193F1CA8C213; Tue, 26 May 2026 08:35:43 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2] blk-mq: reinsert cached request to the list
Date: Tue, 26 May 2026 08:35:31 -0700
Message-ID: <20260526153531.2365935-1-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=We88rUhX c=1 sm=1 tr=0 ts=6a15bdd9 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=HvWbp9H3uqfuRpaB1fwA:9
X-Proofpoint-ORIG-GUID: gw591YagmfIC9gRuJZ2FJ5uu3CJgl1pR
X-Proofpoint-GUID: gw591YagmfIC9gRuJZ2FJ5uu3CJgl1pR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzMyBTYWx0ZWRfX5BgtDKeGUiV/
 SmHrtEswvFbwFpSLppONBlLaPi9mXs6bsUKoGGWuWc7AayhIC4LO1iEQEx/dP6zQwdUksB5zjMJ
 52HwQ9vioA+eQ6p0TjUL5rS0APXLRdcdFMSjBMzRJujT5xq98liVqC5czDS70hshvBeXsD5AQ8w
 sDSEe+xYBeDjz1ud7f3yD+N/BZOv2V6jnrHVqj0qjKNaVfU4L/T++VnR1AMwnfEmfTyN7vsUFfp
 Dq7FBwNeYoZ0j1LZiTbc/osJqNlOn7yE5HEXdlae+ekaX0D0PIpzcO8carzpTzDN7/jcwFCW3tQ
 4rKerC+p5PYgMtS3FuXq010RBv4D8DSfsOew+ygas6Em6b3pfiSf31HfdNlzlPdwJhDYUAaHV0h
 aoX0AM/ocYWWlxN4g1gbCR7R4QI89MyKqWlm6zWRctb/VG0O0asaV2kvOvKlOq2hUrQn4IZhdJQ
 7mhtWoBIkUiP4w2HkDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

A previous commit removed an optimization out of caution for a scenario
that turns out not to be real: all the "queue_exit" goto's are safe to
reinsert the request into the cached_rq's plug list as they are either
from a non-blocking path, or a successful merge that already holds the
queue reference. This optimization is most needed for small sequential
workloads that successfully merge into larger requests.

Fixes: dc278e9bf2b9 ("blk-mq: pop cached request if it is usable")
Suggested-by: Ming Lei <tom.leiming@gmail.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Actually use the correct rq_list function to return the rq to the
  list.

 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 28c2d931e75ea..a24175441380e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3246,7 +3246,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!rq)
 		blk_queue_exit(q);
 	else
-		blk_mq_free_request(rq);
+		rq_list_add_head(&plug->cached_rqs, rq);
 }
=20
 #ifdef CONFIG_BLK_MQ_STACKING
--=20
2.53.0-Meta

