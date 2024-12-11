Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8D246B16;
	Wed, 11 Dec 2024 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943117; cv=none; b=A4H5otV5QniULrVl3OBZaS05Ev5TzF0OOcnTwTPtIazoWpunRrCpktZIfflbs1dmd+GNHJAX4oZNLuUdjKwSclgj4VAkFfYO8hf2ZWcknEgWbyWjM7KhFOT3xraqcaGhAUePdH2a53ABd+QaJp1ze7zVub6S8q+3AjUk6OOp04M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943117; c=relaxed/simple;
	bh=NjxKBf/EuqTHkgb6dy5bQgUiQRcG4xAVXlpY5Sdvc4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQtvwgphtCeC8dxAeH290KmShQe/t/k2vMZWhDntXVlBwMdcZVTfKZknrKjCxb3gLpsQ0bcDaRTO5Ju7dSYhxbd0Q2XlZwAgnyBjX/lWtlvicFAjZLuKGunm26gyr0mFTJcQtBbkEJ+0nllXrBH+rDKyZSeBqxzafxnRknJ5h4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hluyqw1D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hluyqw1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5624AC4CED2;
	Wed, 11 Dec 2024 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943117;
	bh=NjxKBf/EuqTHkgb6dy5bQgUiQRcG4xAVXlpY5Sdvc4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hluyqw1DT5RKa+9tzJwB80Zsv/ijIJ2TV89nr/AqDHdqt0AWAPP5awu2Mj9gqfMNi
	 7VOdfjqy+spQVM09wZBqt0v2gIqhEU4f71EDeGbxd791ILKnUbdHjXhYG0ZfWCIWgC
	 L2KiBXPSLQbCT1XwY1VmUG0doBxM7FRPmndMMPxMAIZ4530qHrNCNCpS9/lbINTiJs
	 CT5KFlg5qQU6+VW+eAGKrfGZLxJ1yJv6x0QNaIOOsvc9+5DqE9CW+f+DZT1wBlBYiI
	 IpauYLjR6eNZC1dFOXUFnXneAbqnHCENoGGJ7E6ey+yjCwOT8xHPZAHOhQXPUW9TPo
	 PyV0Jt28fPE4A==
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
Subject: [PATCH AUTOSEL 6.12 35/36] blk-mq: register cpuhp callback after hctx is added to xarray table
Date: Wed, 11 Dec 2024 13:49:51 -0500
Message-ID: <20241211185028.3841047-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
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
index b4fba7b398e5b..c4012cb3adbf1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3825,16 +3825,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
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
@@ -3843,6 +3838,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (xa_insert(&q->hctx_table, hctx_idx, hctx, GFP_KERNEL))
 		goto exit_flush_rq;
 
+	if (!(hctx->flags & BLK_MQ_F_STACKING))
+		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+				&hctx->cpuhp_online);
+	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
+
 	return 0;
 
  exit_flush_rq:
@@ -3851,8 +3851,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
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

