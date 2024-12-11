Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D196024B25C;
	Wed, 11 Dec 2024 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943184; cv=none; b=ZBZjRJ0Qfwy+MYd729L0wRg9Np6AmwFIvUDRFtJ++kbitmFU74iFU8s9wJUBKlCs2kiT2rKSu8WKMj0/N48fM1AkVekJdD15r/r7mAGOXlO39wI8ofmn8CxmftPeZjGWwQ/JyA/lSCy72VUEhs2wGOceYZFVbVPe7txE64eGDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943184; c=relaxed/simple;
	bh=D3IAyIjHoOs3RteOsC/ABTBQ8y3aBRgE5lF4KaYC4vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7vytl4is4t2dapnIeJzdnAYC46zzSX0OgrZqKi93kctfyZZlMf6hEYTePCLOHitbl6sMjelFb70194zyJRSbQos4gn05muSm7DRm9/fqMd5nUdQ3feUjR8I8/oj9q5xJ32Np9Ipt1IszbFdb+2Svrc0bJqqoRppl0icEanW9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zvrvq11l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zvrvq11l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BDDC4CED2;
	Wed, 11 Dec 2024 18:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943184;
	bh=D3IAyIjHoOs3RteOsC/ABTBQ8y3aBRgE5lF4KaYC4vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zvrvq11l9+pVm3GBgbBBjcw+X+IyJKaohW/+Emh1Z4IwWvo6hnLmTjdjealP+zF2U
	 qHJMfbbm/IvgMqXD2G22oZVFHFNHyricLy1XLEowYWLskjI54ohpR5i+OuZpp3e3C+
	 pEc81si8a3B0r2R57dzRH2yeR1PUWjPawVIbLBQ314Go+nB3TW7GUxP0PtfdR6kTjc
	 BiIT2TQULS/kpqHrgURBiNjeOzCH+g3zuC7wFnM1h+fM/wGOwOqo92aVQrUi4Gh05p
	 fpMj/58mtDFHeOHjyEIlsg57yVtcRCKdlxw4wC1HVtaS/uxFFeFZpMeCa3eU2RKRcb
	 GJxHih9B0xB4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>,
	Babu Moger <babu.moger@amd.com>,
	Luck Tony <tony.luck@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 22/23] blk-mq: register cpuhp callback after hctx is added to xarray table
Date: Wed, 11 Dec 2024 13:51:59 -0500
Message-ID: <20241211185214.3841978-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185214.3841978-1-sashal@kernel.org>
References: <20241211185214.3841978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.65
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 4bf485a7db5d82ddd0f3ad2b299893199090375e ]

We need to retrieve 'hctx' from xarray table in the cpuhp callback, so the
callback should be registered after this 'hctx' is added to xarray table.

Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Peter Newman <peternewman@google.com>
Cc: Babu Moger <babu.moger@amd.com>
Cc: Luck Tony <tony.luck@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20241206111611.978870-2-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6c71add013bfc..f4a9eed1b9774 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3708,16 +3708,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
 {
 	hctx->queue_num = hctx_idx;
 
-	if (!(hctx->flags & BLK_MQ_F_STACKING))
-		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
-				&hctx->cpuhp_online);
-	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
-
 	hctx->tags = set->tags[hctx_idx];
 
 	if (set->ops->init_hctx &&
 	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
-		goto unregister_cpu_notifier;
+		goto fail;
 
 	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx,
 				hctx->numa_node))
@@ -3726,6 +3721,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (xa_insert(&q->hctx_table, hctx_idx, hctx, GFP_KERNEL))
 		goto exit_flush_rq;
 
+	if (!(hctx->flags & BLK_MQ_F_STACKING))
+		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+				&hctx->cpuhp_online);
+	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
+
 	return 0;
 
  exit_flush_rq:
@@ -3734,8 +3734,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
  exit_hctx:
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
- unregister_cpu_notifier:
-	blk_mq_remove_cpuhp(hctx);
+ fail:
 	return -1;
 }
 
-- 
2.43.0

