Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2BE31B813
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526491; cv=none; b=GKVp67AZU1j/of/+k6tWlsuH5jK4QN1aKsf2C446UbgiKO4pjcXmaLCdN1zxZvme4/ML9hWFLPNHOP9CqgHtrDze8MnXgqc8bWTNvm1EROph2mJQJAWLe6W3L6NtTvZn4AfAiewnJzzk0mPmGUSouJhDxBMiB7MVx2Fty0rTwZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526491; c=relaxed/simple;
	bh=8qzIG3sv11g37/LQX6+H6uVQtQo4Iw9cMMJmFP3k2yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8yREZNw7Gj+ccmjkI4dbRlECSVieuKfyTl76nxNz3STzf85DkRPM9XqPsYCIwRd+k0uiyncBDYDow9Ojn17ecmTDylv2YaL/R9ffPdJh35J0WR0//Zu4Cbslsx1zpth0pwjd2anMxFrIhh29bRwszur294YuCGEQtuU+mjkKJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNnt3oVf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNnt3oVf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760526488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSnBvyrWlqPf2Yo3cHoAPmv4UXTjVvpXyU8BW77zoTk=;
	b=gNnt3oVfP9ir5QnlV0mXkDNoe/1px+Pae0vN2lmPjqY6NWHIu2P9v8QGVqrnLD+79HT+tJ
	GYPoyvmyIF13whDvsd51ERf9aTt2+n7cOyTSGZ0lyPclBQco1o1rjO7d64vOvNQkHRiYLH
	g0qegeoZl0bVawVmgsBEHvovjeFldds=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-lK2c4MPTNrukOhTMFlj74g-1; Wed,
 15 Oct 2025 07:08:05 -0400
X-MC-Unique: lK2c4MPTNrukOhTMFlj74g-1
X-Mimecast-MFC-AGG-ID: lK2c4MPTNrukOhTMFlj74g_1760526484
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71E3F19560A3;
	Wed, 15 Oct 2025 11:08:04 +0000 (UTC)
Received: from localhost (unknown [10.72.120.29])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AE7A1800446;
	Wed, 15 Oct 2025 11:08:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 4/6] loop: move command blkcg/memcg initialization into loop_queue_work
Date: Wed, 15 Oct 2025 19:07:29 +0800
Message-ID: <20251015110735.1361261-5-ming.lei@redhat.com>
In-Reply-To: <20251015110735.1361261-1-ming.lei@redhat.com>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

