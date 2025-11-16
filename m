Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB32C19F12D;
	Sun, 16 Nov 2025 04:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763266234; cv=none; b=D+zBV8sSrDBuyuZPWsbbFEw79gaRurJOJTr8ToqhLKX9HUORM+IhXZvGKOg0AwPwz+36nGlTGqcEM1kYC10ayQl2ylQYZH58chWHFuSZmOJEOjhXPwz3IkeJ9rVL/u5B4gvW3RalQ07APU9AQ+vtKPubkx0Lh3982Pz03fPFABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763266234; c=relaxed/simple;
	bh=Z7O94oijY3strRk71JNZPL0gx2vdpAvUplzCS8521UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrpN6YPpJbWog7Jr0I+4n9H1ccDw8LH7tvXUP3Z0XteajLLDTgyJMd6ssmOXgaoBGCFqsIcOVD/FOOebEh4EGm2whDqsxyJYaXeoTdmi3OV5rvO7n1pVoG1Si/u+l4AGe0pIfwOtXUNuBLhIVLGc1njyLBDOXz1VfMtRYYMzq04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2A1C113D0;
	Sun, 16 Nov 2025 04:10:31 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH RESEND 2/5] blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue
Date: Sun, 16 Nov 2025 12:10:21 +0800
Message-ID: <20251116041024.120500-3-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251116041024.120500-1-yukuai@fnnas.com>
References: <20251116041024.120500-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

