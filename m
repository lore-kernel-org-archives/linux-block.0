Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4E22DEA86
	for <linux-block@vger.kernel.org>; Sun, 28 Sep 2025 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759066200; cv=none; b=fD+6B4WFQKJBoVWnvYnHIOhzibLZMU/Aw4R7vQ0/6uHuy5c+rwX+pE4cruoH79dr0U+az19H0X9WBdW2qVPa7MbBnM6rIE8h4vyvg5ZPU5LTyh9pL6SQ5UhllAT0hkk8C8bRPjX9OwZHlTy3BO3+icRIoYxe0NVWGAElrvWnZIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759066200; c=relaxed/simple;
	bh=8qzIG3sv11g37/LQX6+H6uVQtQo4Iw9cMMJmFP3k2yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+JEEd7S4b9S1AXlKsJMlNc5MOFI05NNoCn/0hK7fPRZYLVMDgybqaSp4JWb1oET/Vvr1raaa1jFMuLr0AfgXaGnjv9AQLXqTPJ89s+oug7s3OPkBKyrNy7sLYeKJWmFlF2dhKlHq39LANDFO903vtfMOmU5zaK21iousg/3nTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTHCMkS8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTHCMkS8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759066197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSnBvyrWlqPf2Yo3cHoAPmv4UXTjVvpXyU8BW77zoTk=;
	b=MTHCMkS8bYnix7k1CRaxe/hXVh8kxzJVvsxySc/xto+3bHxyZ92mlNaoNrhNKffxiQKTcB
	Fd2qzQpk6rvK9Kd4dzcb68nzivlnWRAzEQSKmmZ7VrnzzoRvPPlr5bS25PVYmljGiXlvNw
	WeUinK04sK7lriTPGi3hGiqcuVNQ2n0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-G-QOT18hP7-k5XK0yc47pA-1; Sun,
 28 Sep 2025 09:29:56 -0400
X-MC-Unique: G-QOT18hP7-k5XK0yc47pA-1
X-Mimecast-MFC-AGG-ID: G-QOT18hP7-k5XK0yc47pA_1759066195
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD8CF1800447;
	Sun, 28 Sep 2025 13:29:54 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 341411800115;
	Sun, 28 Sep 2025 13:29:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V4 4/6] loop: move command blkcg/memcg initialization into loop_queue_work
Date: Sun, 28 Sep 2025 21:29:23 +0800
Message-ID: <20250928132927.3672537-5-ming.lei@redhat.com>
In-Reply-To: <20250928132927.3672537-1-ming.lei@redhat.com>
References: <20250928132927.3672537-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move loop command blkcg/memcg initialization into loop_queue_work,
and prepare for supporting to handle loop io command by IOCB_NOWAIT.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3ab910572bd9..99eec0a25dbc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -829,11 +829,28 @@ static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
 
 static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 {
+	struct request __maybe_unused *rq = blk_mq_rq_from_pdu(cmd);
 	struct rb_node **node, *parent = NULL;
 	struct loop_worker *cur_worker, *worker = NULL;
 	struct work_struct *work;
 	struct list_head *cmd_list;
 
+	/* always use the first bio's css */
+	cmd->blkcg_css = NULL;
+	cmd->memcg_css = NULL;
+#ifdef CONFIG_BLK_CGROUP
+	if (rq->bio) {
+		cmd->blkcg_css = bio_blkcg_css(rq->bio);
+#ifdef CONFIG_MEMCG
+		if (cmd->blkcg_css) {
+			cmd->memcg_css =
+				cgroup_get_e_css(cmd->blkcg_css->cgroup,
+						&memory_cgrp_subsys);
+		}
+#endif
+	}
+#endif
+
 	spin_lock_irq(&lo->lo_work_lock);
 
 	if (queue_on_root_worker(cmd->blkcg_css))
@@ -1903,21 +1920,6 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		break;
 	}
 
-	/* always use the first bio's css */
-	cmd->blkcg_css = NULL;
-	cmd->memcg_css = NULL;
-#ifdef CONFIG_BLK_CGROUP
-	if (rq->bio) {
-		cmd->blkcg_css = bio_blkcg_css(rq->bio);
-#ifdef CONFIG_MEMCG
-		if (cmd->blkcg_css) {
-			cmd->memcg_css =
-				cgroup_get_e_css(cmd->blkcg_css->cgroup,
-						&memory_cgrp_subsys);
-		}
-#endif
-	}
-#endif
 	loop_queue_work(lo, cmd);
 
 	return BLK_STS_OK;
-- 
2.47.0

