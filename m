Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF65825332C;
	Wed, 11 Dec 2024 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943232; cv=none; b=KTiKF6vzAR3sRHrBfhhxA3ib20cANl8fZHUqmFW/XAEcDO2+ZiPst5uTqi6VO2F5Xfwq/wWd+7LccBiERTJ2YooFFz4OqDOF6kZKP/PgHu9HE23iEZpD5gAHGx7Vow210B6ykaUuI/2wcrKKHvmbW4T5PsYXnT60Hml1GaFPKxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943232; c=relaxed/simple;
	bh=OrkWIbXM0KdIPk8HRXIAI3tRb8LvmxPMYzRl1CeF+lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8hVeYR9KJCUqQsw4mRfZzCeEWwbP0ajqweOjEkR+u1tW/o9poJ0xl/2LsAmBz1Ft9ysN6wIM46DXHYQgACLxb48fgIOSU7fPgo4TtfISoq2jHARQ+Z4b9B7NEz9mzxBwGWnP40TNhtJRNkGafR+0mZmHOS8adyZG+9obFU9fDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2dpDUTf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2dpDUTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40DFC4CEDD;
	Wed, 11 Dec 2024 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943230;
	bh=OrkWIbXM0KdIPk8HRXIAI3tRb8LvmxPMYzRl1CeF+lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X2dpDUTfm92rBgzFiiS/oasqsvuJnwOy3gBZV6xSP8aL+5n8O51FxqF4guMJbmOK3
	 WlGn/zS50mrgr/5Uy08/CA+Bb1PzBf1f7XJ6R6zextZZFU2lDjaEORUXwONIecxWUn
	 evWDAitR/Is+R9DclZPC0k7tWUQUNOiwLR2EGd3xz43Y2PXPGkLIyCliSRjKE/q+Ah
	 cbECsc+pVrOzfL1jy/BSWiEOmjEKh/+shAEJLJwP/5tJMyAqyXU5SgLGjpeb39stHy
	 D2vetDGhPpOKGPjESSiY3cNDpyLAOLtBYRfmqnqTNgsxsfvDdydB+mhMB5n2w1KoOq
	 R+oLTCWc0Qo7w==
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
Subject: [PATCH AUTOSEL 6.1 15/15] blk-mq: register cpuhp callback after hctx is added to xarray table
Date: Wed, 11 Dec 2024 13:53:07 -0500
Message-ID: <20241211185316.3842543-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185316.3842543-1-sashal@kernel.org>
References: <20241211185316.3842543-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 542b28a2e6b0f..fd289f2f83db1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3665,16 +3665,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
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
@@ -3683,6 +3678,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (xa_insert(&q->hctx_table, hctx_idx, hctx, GFP_KERNEL))
 		goto exit_flush_rq;
 
+	if (!(hctx->flags & BLK_MQ_F_STACKING))
+		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+				&hctx->cpuhp_online);
+	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
+
 	return 0;
 
  exit_flush_rq:
@@ -3691,8 +3691,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
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

