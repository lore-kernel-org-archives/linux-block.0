Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EBA39F162
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100937; cv=none; b=mfdca/G3wYqWRazaUBB3PIw35VSavI8MHVwcJfl3rMGEbBdAfUlKzJVoFS1wTNyVvSUNAeoZpReOGz3OcWnG7DpHBM08pXWH6SzVUyAV308Lb8BqAB26hCg5cWhl403gTl6eGNaVHbex8C1j7pou3O+6w7yrziFyAHsHOUQ/AG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100937; c=relaxed/simple;
	bh=1FWjYA3aCDGVx/v6BRiCbv2Xh12gTBqDHtlfIjMPZ2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sotipx1OmiKbILhwr3JTithXEArcZpjMhbBpLMzXPUcS31UZU5hXI1n1YHEFMynuefT2fFPaOEAIzlBEmUOhIQjZw/+rYBS2ZhIHh1QSTp2D7DlGudjM3FMusAi2zx/KHhqOmPuxm5DVKpVUhQHXHHO2XzjudS4ZjYShAKTAw68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u1o3n/a+; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u1o3n/a+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784100933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bRslnRVkNS+fv54hAOHsKH/tpgOpVb80fZL88zeT3xA=;
	b=u1o3n/a+eG+kydbUGaAjoIA1FrLGTJA9jGnnzjQFUKhxmlOSEAuLFtsk2AVd+4gZIa8b8K
	jfdwXGvZR64QDUrGarULbTy9W00PPo0WGF2P0gUyH5vRF56gWTysptjH4l4QNu8eIkFXCV
	LWJFtgPb/J4ZY7wR2V6v9KvL/fiJ2s8=
From: Jackie Liu <liu.yun@linux.dev>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: free copied pages when blk_rq_map_kern() fails
Date: Wed, 15 Jul 2026 15:35:18 +0800
Message-ID: <20260715073518.96042-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jackie Liu <liuyun01@kylinos.cn>

bio_copy_kern() allocates pages that are normally freed by the bio
completion callback. If blk_rq_append_bio() rejects the bio, however,
blk_rq_map_kern() only drops the bio reference. Since bio_put() does not
free pages referenced by the bio vectors, those pages leak.

This can happen when the bio exceeds the queue segment constraints or
when a later mapping cannot be merged into a request built by earlier
calls. Track whether the buffer was copied and free those pages before
dropping the rejected bio.

Fixes: 3a5a39276d2a ("block: allow blk_rq_map_kern to append to requests")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/blk-map.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 768549f19f97..d1d6bbe0ecf1 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -653,6 +653,7 @@ int blk_rq_map_kern(struct request *rq, void *kbuf, unsigned int len,
 		gfp_t gfp_mask)
 {
 	unsigned long addr = (unsigned long) kbuf;
+	bool do_copy;
 	struct bio *bio;
 	int ret;
 
@@ -661,7 +662,8 @@ int blk_rq_map_kern(struct request *rq, void *kbuf, unsigned int len,
 	if (!len || !kbuf)
 		return -EINVAL;
 
-	if (!blk_rq_aligned(rq->q, addr, len) || object_is_on_stack(kbuf))
+	do_copy = !blk_rq_aligned(rq->q, addr, len) || object_is_on_stack(kbuf);
+	if (do_copy)
 		bio = bio_copy_kern(rq, kbuf, len, gfp_mask);
 	else
 		bio = bio_map_kern(rq, kbuf, len, gfp_mask);
@@ -670,8 +672,11 @@ int blk_rq_map_kern(struct request *rq, void *kbuf, unsigned int len,
 		return PTR_ERR(bio);
 
 	ret = blk_rq_append_bio(rq, bio);
-	if (unlikely(ret))
+	if (unlikely(ret)) {
+		if (do_copy)
+			bio_free_pages(bio);
 		blk_mq_map_bio_put(bio);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(blk_rq_map_kern);
-- 
2.54.0

