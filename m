Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610F13D6B
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473351; cv=none; b=cH6AFUyfFTD4F1XkPEFfhA93QXk/FbAO+VMpbwMjhxQPshiUh62n4HNp5iJfp2PNxA9DBUBMrdl4lLlmlyVvpUTMNI6x4WMTy5IiCr5WKG5OC19wYppX4Zov+FvYSvZn4Gcg/uy3nb5WePykZ6/tUYJTdZg7Oxtzg+md6KO0Fkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473351; c=relaxed/simple;
	bh=vQn9QURLIfaXvVlYqtTq/ePaYCO52eCO2bZFXtLs5yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQvcSUIfB2wfk6cDXZZvniN9yCwozFLnxxYrld0RfzCy+OVlWk+YpVhwhCb+55rBymVYcBhnVGU4522bJhqwEDH8nahcBMD0LuTddPYubn7XUdWAlo2bvUSFmWgvNbgSA/wjOKA8UqNnsjb38WD2QKrq8V5g+2btAsS3QVLsQyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUDHgjqe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUDHgjqe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733473347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1/kbOswB/3piSP5aqjdGg4OQdqydNy0z8n0U7Ou+ZI=;
	b=LUDHgjqecUPoVe/qLhZc4YyV0ic1gf5hV+AAFdrw6Buyo8CPL5MMZxP1qNwMaZfCMohnc/
	wMH8pbgAU9yFug4aImsXK0piHFQY10gfCwE1ZLJKqkEm33ssp9Yg3fqIkfDWjlQ3wCf8Fi
	MGHtHiK6/EqjYnz9fIeEput88FZxO1Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-Q76RtDyaMXus7_pvRxgd6Q-1; Fri,
 06 Dec 2024 03:22:26 -0500
X-MC-Unique: Q76RtDyaMXus7_pvRxgd6Q-1
X-Mimecast-MFC-AGG-ID: Q76RtDyaMXus7_pvRxgd6Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25708195609D;
	Fri,  6 Dec 2024 08:22:24 +0000 (UTC)
Received: from localhost (unknown [10.72.112.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB43419560A2;
	Fri,  6 Dec 2024 08:22:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>,
	Babu Moger <babu.moger@amd.com>,
	Luck Tony <tony.luck@intel.com>
Subject: [PATCH 1/2] blk-mq: register cpuhp callback after hctx is added to xarray table
Date: Fri,  6 Dec 2024 16:21:55 +0800
Message-ID: <20241206082202.949142-2-ming.lei@redhat.com>
In-Reply-To: <20241206082202.949142-1-ming.lei@redhat.com>
References: <20241206082202.949142-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

We need to retrieve 'hctx' from xarray table in the cpuhp callback, so the
callback should be registered after this 'hctx' is added to xarray table.

Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Peter Newman <peternewman@google.com>
Cc: Babu Moger <babu.moger@amd.com>
Cc: Luck Tony <tony.luck@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 424239c075e2..a404465036de 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3824,16 +3824,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
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
@@ -3842,6 +3837,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (xa_insert(&q->hctx_table, hctx_idx, hctx, GFP_KERNEL))
 		goto exit_flush_rq;
 
+	if (!(hctx->flags & BLK_MQ_F_STACKING))
+		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+				&hctx->cpuhp_online);
+	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
+
 	return 0;
 
  exit_flush_rq:
@@ -3850,8 +3850,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
  exit_hctx:
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
- unregister_cpu_notifier:
-	blk_mq_remove_cpuhp(hctx);
+ fail:
 	return -1;
 }
 
-- 
2.47.0

