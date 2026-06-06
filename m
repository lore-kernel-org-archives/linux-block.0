Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FAC15C14F;
	Sat,  6 Jun 2026 02:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780713977; cv=none; b=dQwae4EBkVbUKtBG3R8pSGeFKP+uoWYUbNNL65SmMvNp3wjWYwbWIhj5fulFm+a4kyxRd/3NMfgCCko/OO5QPzLOY78NQSVhQ3rtyyK5QtIbMbfb+VRN+y0Pok05Xi5YuoGtmdwsmDSNPL1QB6xNzr6VvOhFzsbV9YXlECMHi4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780713977; c=relaxed/simple;
	bh=U0JYpfqAEwuksO3STUah9ub50XyHjyaVeu7A3M18LDo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=N58U+WLMoA0hT0fUMt7id8uqssDXvUJj8ZxRQ7pxpYLY5/aIaSYnCPg1sY/4pay5GwhPstNTiMT7W8/g+HSiE2OZWTasj2d7A1UMGxF72db1FGPUiqVuu8jaDHZLjG9TBtRyvuxOYJj1a11TLkB6wns/8puTKOv6HxE25HwFVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joint-cloud.com; spf=none smtp.mailfrom=joint-cloud.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AstwgwuC; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joint-cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=joint-cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AstwgwuC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780713969; bh=fGKPtnuiTen/wS4O5FHxU5H4ht+RLPFuVj+cN/gw8lw=;
	h=From:To:Cc:Subject:Date;
	b=AstwgwuCdSa2pNK7pOYrhIJdi2wgnqLNLmT6oMkxJCjaxXeSGqkUFZQ+NDFKOvBBD
	 Dk79FRGhm7KYT4FQwNMAxRhS6rSj1n/88F5wf7mNlNksFDXuIKyrifIYXCBwKysdvg
	 +EPjpbut3Gr5ooFh8TeZeW8TUg5sSpvi3aHu68ZA=
Received: from ASUS.localdomain ([116.21.163.77])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id A9532086; Sat, 06 Jun 2026 10:42:21 +0800
X-QQ-mid: xmsmtpt1780713741tulvolh6l
Message-ID: <tencent_79B652BD0CC23E093F27914380F161E7E505@qq.com>
X-QQ-XMAILINFO: M2SvzgchpLqfy6xZrI+fHbUOlGpaL3o8wdsOgcjp5soVoqE+FC0mar15FNcB4G
	 pHahlvegU7BpQ6vHFV/6enLrZ81fv9FdnrTGYZpHoR24O8mi9yrVbmLdBlIgAlx7Z4Hlc3Z/gp3T
	 d/39GttiDGLCzsP0K6QtEzAXymOzlspkcKsMD9h1mTfhH6PcBVNOmHOnYppVw6cqZsklpS+ZR8MR
	 C2Vm/JBG2Ls0okr96hQigg5VqWxF5xDUc7PRjHLO+VsCwkvLZnCQUgoQfNklXY/g17L9sryNL+IG
	 hpysJp2Nv4KnpS2EiRU2N2oU/sqCku8LKIGxvmhQt9sOjmTlrN+XwvCmRiQM9z0zKKUHdxmKnq55
	 Wiv5tHfD2ZTbpy9NKOdknX0ZItGAPi9IsGTTqdOcWlsk4c1w8ORMZhkdYCdO7dC8ui6eooaR+csi
	 +jADw+4wB6RU5MNzYg5FLOhms1pG25c+XuDGAWppPbhDpajncULmaJnH16Tr4QiLeUtAkEjd6efr
	 3Bi6H6PA5yu5ruA16VJ1T5/G8hBiY6sje6pbKV8EJmmM4X4Ojv0ebIbAd9yymPvQL1sqPn5fwf2S
	 nPMX1ecCeMi7mH4MsrfYfywYW0rDCBJsWh1O3shpWYvr5mVbbbevtmI3CWW0ALOQHu1Wtr+OVKAK
	 +LTpSvY3jQS/DKV5HyinTejhEK3xP/U9E3bzQbOS2wOYXS2dDRbaCWnhykekHiwz24P16uG9dBSF
	 4wEK3Npj9ng/NS4n3Dx6QLGCZlWp5fZoaGiF7p0IgIB3KFOuVudLWpCtVRS/fgZ+u2roruxmTMBq
	 WfEeagiJrqGEKcEbYY7arcX4Y62IiXLgjYiVnymrDuEvl7CVNAbPR8oRf/+CjpZdd3rrlt2mcBUj
	 R/M3ZQUXD6KZTWoYmPfhfG8t0cg6HY6gEUsJFMps26gTk36sQHLhT+6LgTDDlu0LmWYuwR63psDA
	 3HMwU+d26RFQJY1/I4Q9077axf4BIkMlNH+20JI/488WA6CExsN16RjCAYx4FMCfN8A+mWUPO1xY
	 7gYNUpHaNAY+DYY6SHdGLHYjQQMkK2nBrlH4PkzMtHvc53xN66
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Steven Feng <steven@joint-cloud.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Feng <steven@joint-cloud.com>
Subject: [PATCH] block: optimize I/O merge hot path with unlikely() hints
Date: Sat,  6 Jun 2026 10:42:18 +0800
X-OQ-MSGID: <20260606024218.15871-1-steven@joint-cloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove redundant '== false' comparisons and add unlikely() branch
prediction hints in block I/O merge path functions.

These functions (ll_new_hw_segment, ll_merge_requests_fn, and
blk_rq_merge_ok) are executed on every I/O request merge attempt,
making them critical hot paths. Data integrity check failures are
rare events, so marking these conditions as unlikely() helps the
CPU optimize the common case by improving branch prediction.

Changes:
- Replace 'func() == false' with 'unlikely(!func())' for better
  code style and branch prediction

This micro-optimization reduces branch misprediction penalties in
high-frequency I/O merge paths.

Signed-off-by: Steven Feng <steven@joint-cloud.com>
---
 block/blk-merge.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index fcf09325b22e..65347d1646a1 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -547,7 +547,7 @@ static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
 	if (!blk_cgroup_mergeable(req, bio))
 		goto no_merge;
 
-	if (blk_integrity_merge_bio(req->q, req, bio) == false)
+	if (unlikely(!blk_integrity_merge_bio(req->q, req, bio)))
 		goto no_merge;
 
 	/* discard request merge won't add new segment */
@@ -649,7 +649,7 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	if (!blk_cgroup_mergeable(req, next->bio))
 		return 0;
 
-	if (blk_integrity_merge_rq(q, req, next) == false)
+	if (unlikely(!blk_integrity_merge_rq(q, req, next)))
 		return 0;
 
 	if (!bio_crypt_ctx_merge_rq(req, next))
@@ -905,7 +905,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 
 	if (!blk_cgroup_mergeable(rq, bio))
 		return false;
-	if (blk_integrity_merge_bio(rq->q, rq, bio) == false)
+	if (unlikely(!blk_integrity_merge_bio(rq->q, rq, bio)))
 		return false;
 	if (!bio_crypt_rq_ctx_compatible(rq, bio))
 		return false;
@@ -915,7 +915,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 		return false;
 	if (rq->bio->bi_ioprio != bio->bi_ioprio)
 		return false;
-	if (blk_atomic_write_mergeable_rq_bio(rq, bio) == false)
+	if (unlikely(!blk_atomic_write_mergeable_rq_bio(rq, bio)))
 		return false;
 
 	return true;
-- 
2.43.0

