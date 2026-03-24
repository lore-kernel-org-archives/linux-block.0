Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BDA1C84CB
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774318983; cv=none; b=ISJAsTg3jkUv3sqLj2SnTuqHLuZKtEiKs3n7DjdqPPYvAXnwl+C8ESDzFyKUajOFKHkWlm2hlUKYrXr9ITn9tX2StKfy0RHtCimIyL+RA8gIdl0gjhDsKXaPzkhuCxyBalFmTChO757weqQeg46bVmUSkUR4IO+VC/YSK8QdIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774318983; c=relaxed/simple;
	bh=CUDin1c3uX+pGK2V1PKkyejQ5db7Cxs7H5j0Hf4bmC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CWbP8dVg4Qu2e1zdYR+QQiukJsfiB0YbpVFLRtLJSaRaxh+E58qJiCb1JXJfYxJ06jC6liYjvgJudghm8e8TfYJdYGj1sCQKGDqLzdiMcCev9/W3aJc5h0kE049s7CKbzoI8k3Ju4EfERNcJSAAdwPzHlcrC0S3Syj9xZtnoed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=teYCGbmj; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="teYCGbmj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774318979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tWkEaNCiuvEQnfJ4w1FKyXFMXNvJXDxjRZMdazAAOIY=;
	b=teYCGbmj2r2k0MgB5t3S2JgSaeBNjoiMgx608N2GqV9NLwXCWi6czG9X/TLikHeMGpoH+6
	EpJeIZDIUqPMFZYkKMsnaKgPJ9NfbgNLt1aMYB49266p3AEn+snz3Vz+PHgjN4SJ2Cx9Ss
	q4iG4Ed+8mtfB3PMviRJQfNS0+Cj/jg=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-block@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] blk-mq: fix slab-out-of-bounds in blk_mq_free_rqs on nr_hw_queues update
Date: Tue, 24 Mar 2026 10:22:51 +0800
Message-ID: <20260324022252.315050-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When __blk_mq_update_nr_hw_queues() increases nr_hw_queues, it first
pre-allocates scheduler resources via blk_mq_alloc_sched_res_batch()
with the new (larger) queue count, then removes the elevator via
blk_mq_elv_switch_none(), and finally expands set->tags via
blk_mq_prealloc_tag_set_tags().

If blk_mq_prealloc_tag_set_tags() fails, the code jumps to switch_back
which re-attaches the elevator using the pre-allocated resources
(ctx->res.et) whose nr_hw_queues is the new larger value. But
set->tags was never expanded, so when the elevator is later freed,
blk_mq_free_sched_tags() iterates et->nr_hw_queues entries and
blk_mq_free_rqs() accesses set->tags[hctx_idx] beyond its allocated
size, causing a slab-out-of-bounds.

Fix this by moving blk_mq_prealloc_tag_set_tags() before
blk_mq_elv_switch_none(). If the tags allocation fails, the elevator
has not been removed yet, so we simply free the pre-allocated scheduler
resources and exit cleanly without entering the switch_back path.

Note that blk_mq_elv_switch_none() practically cannot fail today (it
only fails via WARN_ON_ONCE on xa_load returning NULL), so
blk_mq_prealloc_tag_set_tags() is the only realistic failure point
that could reach switch_back. Moving it before the elevator removal
eliminates the problematic path entirely.

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 block/blk-mq.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3da2215b2912..2183142b4568 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5141,6 +5141,18 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	if (blk_mq_alloc_sched_res_batch(&elv_tbl, set, nr_hw_queues) < 0)
 		goto out_free_ctx;
 
+	/*
+	 * Pre-allocate the new tags array before removing the elevator,
+	 * so that if allocation fails we can exit cleanly without having
+	 * modified the elevator state.
+	 */
+	new_tags = blk_mq_prealloc_tag_set_tags(set, nr_hw_queues);
+	if (IS_ERR(new_tags)) {
+		new_tags = NULL;
+		blk_mq_free_sched_res_batch(&elv_tbl, set);
+		goto out_free_ctx;
+	}
+
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_debugfs_unregister_hctxs(q);
 		blk_mq_sysfs_unregister_hctxs(q);
@@ -5155,10 +5167,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		if (blk_mq_elv_switch_none(q, &elv_tbl))
 			goto switch_back;
 
-	new_tags = blk_mq_prealloc_tag_set_tags(set, nr_hw_queues);
-	if (IS_ERR(new_tags))
-		goto switch_back;
-
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue_nomemsave(q);
 	queues_frozen = true;
-- 
2.43.0

