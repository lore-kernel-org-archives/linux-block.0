Received: from out30-83.freemail.mail.aliyun.com (out30-83.freemail.mail.aliyun.com [115.124.30.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CD4346A0D;
	Fri, 16 Jan 2026 06:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768544385; cv=none; b=OcbVp4hWmcicvvgifavnWO8Acvt2XJAv569Bz7x8u/+61AcDl7goofkTmDbrSerK4AqAzBmSsojgmspZ6jg8VGdudN6O4BZb8HzzZ4KzQ5pP8M6RBF/wNtH80p5lmGWyf0y9DfK8+7h39jLZ6t9d5vmWLEyHRyLijaGcubKPgXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768544385; c=relaxed/simple;
	bh=reFwSkq+FDoH3syQF5xld8lHi+rmXKnJzNHnn67jcm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1wkAwyWeZvSjECde7+4NuC2mAjyRYpotcUMoLZ8iMnJ+Tlame6vWJOQuWIQpBUFpMNhQeo2V8akM3xwwyFvSuO98GHXCWLyw9ISi7A6Z1UbvRGbPdSqTzn/K31x4N0qOxvvRoW1VFtl8/studbM9A6a0A6DLnHFr1aqwFnWA7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=CmjkrZtV; arc=none smtp.client-ip=115.124.30.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="CmjkrZtV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1768544381; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=znwefcwTZDxtm3I9x03g3269v5Z9oujCTTVHhbeTcuc=;
	b=CmjkrZtVkf+I/ORkuJvOP2NUCvGce6CdLHqTxphR1RL7GBetcYQZSWgdAUecCUboGtqRwZwpDNJrN6KbCGMs00/Hp5qyPcvUB+av72Gl3D/VCgkZzqJVayzmDaGhjDLnbrdVF55UMwv4wgaGItIt6sfPVSrsNDt9brdSkyg0AZI=
Received: from localhost.localdomain(mailfrom:wdhh6@aliyun.com fp:SMTPD_---0Wx993BG_1768544369 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 16 Jan 2026 14:19:41 +0800
From: Chaohai Chen <wdhh6@aliyun.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chaohai Chen <wdhh6@aliyun.com>
Subject: [PATCH] blk-mq-sched: Remove redundant code in blk_mq_sched_mark_restart_hctx().
Date: Fri, 16 Jan 2026 14:19:27 +0800
Message-ID: <20260116061927.1004411-1-wdhh6@aliyun.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current purpose of the blk_mq_sched_mark_restart_hctx() function
is to set the BLK_MQ_S_SCHED_RESTART flag in hctx->state. Just remove
the redundant judgement.

Signed-off-by: Chaohai Chen <wdhh6@aliyun.com>
---
 block/blk-mq-sched.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index e26898128a7e..2f6c353cb6d0 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -21,9 +21,6 @@
  */
 void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
 {
-	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
-		return;
-
 	set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_mark_restart_hctx);
-- 
2.43.7

