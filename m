Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEE281720
	for <linux-block@vger.kernel.org>; Sat,  8 Mar 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741451042; cv=none; b=MfTtAupKe7u4fGnbsg2vSqwFbJplwDAA5fwIjeS/nobesr22e+Or5zZ8gydJBLryLIxcBXFDKKaZhfbq49VJfXsxB7hJuSAOua/vQdEtOcTwoA+iHEW/tGswiS4IL+ovBekCMS3X/YDw3XKa3rtY3rLsgfI8gmPRMqiMtZnGf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741451042; c=relaxed/simple;
	bh=AgJFbGTafhFf0iPcSfyG89cLeR4PwjpGsExlKjXUMxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+aZv6r1YRB0pbgzCOvwGDhUUnh9JFA5JJgC+Drj/ycTWIthVWUSf6brKIeN7LX8AnrH/GMP63pCI2c72mT/I3Q39Rj1X5AQmmSUogWo+6KjGgMYVVQ7WuUYcJazz9hZni6KGTAhpOyKmY2rLDWSLbi2fRTtHOL8s0I/JPlz/6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WfxDvn8/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfxDvn8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741451040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhGu5sg45RRsStdrJgrPGy8ehpmuWSgeWuA7ya3t1PY=;
	b=WfxDvn8/pvV0a637xcfLH5C8aJ8n2U+9xbWQNwTimTb9zIh7w0g+TOp6jwDePzuspAK8eU
	4tneMuQk2nzgxmDoU4rTninV+yywGUoujIJnGJrmXF8uPYwU8jcY/nWXqUTb4WhySYIg7f
	MxwTZF6Y1p9up4a1frCxI0EvJJZuAoM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-AT8JrPCeOi6uiKfoVieO9Q-1; Sat,
 08 Mar 2025 11:23:57 -0500
X-MC-Unique: AT8JrPCeOi6uiKfoVieO9Q-1
X-Mimecast-MFC-AGG-ID: AT8JrPCeOi6uiKfoVieO9Q_1741451036
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FE9F1955BC1;
	Sat,  8 Mar 2025 16:23:56 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 202AF18009AE;
	Sat,  8 Mar 2025 16:23:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [RESEND PATCH 3/5] loop: add helper loop_queue_work_prep
Date: Sun,  9 Mar 2025 00:23:07 +0800
Message-ID: <20250308162312.1640828-4-ming.lei@redhat.com>
In-Reply-To: <20250308162312.1640828-1-ming.lei@redhat.com>
References: <20250308162312.1640828-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add helper loop_queue_work_prep() for making loop_queue_rq() more
readable.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index eae38cd38b7b..9f8d32d2dc4d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -859,6 +859,27 @@ static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
 }
 #endif
 
+static void loop_queue_work_prep(struct loop_cmd *cmd)
+{
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+
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
+}
+
 static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 {
 	struct rb_node **node, *parent = NULL;
@@ -866,6 +887,8 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	struct work_struct *work;
 	struct list_head *cmd_list;
 
+	loop_queue_work_prep(cmd);
+
 	spin_lock_irq(&lo->lo_work_lock);
 
 	if (queue_on_root_worker(cmd->blkcg_css))
@@ -1903,21 +1926,6 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
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

