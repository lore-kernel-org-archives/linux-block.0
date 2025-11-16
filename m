Received: from sg-1-17.ptr.blmpb.com (sg-1-17.ptr.blmpb.com [118.26.132.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269F239E81
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 02:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763260926; cv=none; b=pHUSm9LhInBvwjXK9wPxonjvEj0Ezq2AL+E434ujnghAm1o3WtasNeUKVWAfHUNlA5Dkdms6vVssl5x4sFMpGfLGtkx8nMSzfxRqOHzvmgecax00Hggaw3V0a/fovsiBJZtyto7aCrwOoF8PEp3wtoGZQZwiC3uG9N+y5rB//EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763260926; c=relaxed/simple;
	bh=Z7O94oijY3strRk71JNZPL0gx2vdpAvUplzCS8521UU=;
	h=Mime-Version:Content-Type:From:Message-Id:Date:To:Subject:Cc; b=lBI1XGv4jh85MSgAwodqzE24+3BKj5pCWEBDIZPyO2TCtPeVUbVKBJmvebG0+lOYC7bJi4ddZ9Eg3ZjkC0ELXDl2NBRZR/a2fO2+AybBxDC4r22rkVM2SWkjEYpIbuhaJMm716aja52dBokbfSe4Xj/Ua2JM0MwzLP94jQCG3QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=fdan1kug; arc=none smtp.client-ip=118.26.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="fdan1kug"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763260913;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=eS9mut2o83UP0P4D/dZojWoRTZN8xQ/HzH88AZpecm8=;
 b=fdan1kug8M3oEWX4R27iBAnqviCE99WQUgangqVVRRjIuua1eVjKa8pMyMyTbkyq26/wRH
 zuFywzpCWJeF5te0T7INcG3Jc2TlyYGyepckU4eMwJBuFKHI3q/Ee6/O8wXPxxr73KqFpi
 JVFj1rRTVkHpj8ryUZFO9ClYMT/UV/lduaEIHMCiZF/zK6el+0LXxGZdObI+uawpXD2sws
 0FU/94seVnKgZxypYn+C9+9/8pxXPB+jOVyPFCngtSRpb3DnqkiiXQFmQFT6/ZnwPEjLqg
 jPHL6j5kpB9BgOVt8OPs+yOrdxYDWRX4c6qnx3+Pwl/yEdSdG2wcc7Urf0K2KA==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Received: from localhost.localdomain ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sun, 16 Nov 2025 10:41:51 +0800
Content-Type: text/plain; charset=UTF-8
From: "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <20251116024134.115685-3-yukuai@fnnas.com>
X-Lms-Return-Path: <lba+2691939ef+0d2bf5+vger.kernel.org+yukuai@fnnas.com>
Date: Sun, 16 Nov 2025 10:41:31 +0800
Content-Transfer-Encoding: 7bit
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <tj@kernel.org>, <nilay@linux.ibm.com>, 
	<ming.lei@redhat.com>
Subject: [PATCH 2/5] blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue
X-Mailer: git-send-email 2.51.0
Cc: <yukuai@fnnas.com>

wbt_init() can be called from sysfs attribute and wbt_enable_default(),
however the lock order are inversely.

- queue_wb_lat_store() freeze queue first, and then wbt_init() hold
  rq_qos_mutex. In this case queue will be freezed again inside
  rq_qos_add(), however, in this case freeze queue recursivly is
  inoperative;
- wbt_enable_default() from elevator switch will hold rq_qos_mutex
  first, and then rq_qos_add() will freeze queue;

Fix this problem by converting to use new helper rq_qos_add_freezed() in
wbt_init(), and for wbt_enable_default(), freeze queue before calling
wbt_init().

Fixes: a13bd91be223 ("block/rq_qos: protect rq_qos apis with a new lock")
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-wbt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index eb8037bae0bd..a784f6d338b4 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -724,8 +724,12 @@ void wbt_enable_default(struct gendisk *disk)
 	if (!blk_queue_registered(q))
 		return;
 
-	if (queue_is_mq(q) && enable)
+	if (queue_is_mq(q) && enable) {
+		unsigned int memflags = blk_mq_freeze_queue(q);
+
 		wbt_init(disk);
+		blk_mq_unfreeze_queue(q, memflags);
+	}
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
 
@@ -922,7 +926,7 @@ int wbt_init(struct gendisk *disk)
 	 * Assign rwb and add the stats callback.
 	 */
 	mutex_lock(&q->rq_qos_mutex);
-	ret = rq_qos_add(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
+	ret = rq_qos_add_freezed(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
 	mutex_unlock(&q->rq_qos_mutex);
 	if (ret)
 		goto err_free;
-- 
2.51.0
