Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164EE35963
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517002; cv=none; b=hPqDtcIlYG017sIurmbtlMV20IOQzwUup9Nb3lW7T/lf06R1QeKl05j4F+JqTEvk5KqlLRoDMFOw9LOnedaoq4lazsWxQ9DlzbZS/kx6NUnJnRjuKFbDKYIIlIiWIt8i64xk54Ld55OHGF8YklKy/Uzun7ET3nCzR1dr+gTK4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517002; c=relaxed/simple;
	bh=DhEQTH6i+r7Y0Fd6cYeeUjjesLgApibUPiA5D3o/9DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqzEhOHutyf4HZUmRy9GFZmUubmiP18tCbbcQzgj2gp5NcAV7Qqr5zxKmB/oyNguocJSd0qUHO+Vx2BtNMQL98vna6LwdeCfRfLxPN7tWZ/KgBEJPN74ZmmnhnAm1fLU+K/OT0RgjNmuu/l6+oaP+22nMo1V9i7FsHa1dDr0ArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3GU2nB4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3GU2nB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734517000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iu4OatZ2f6i6XwzsZEtUgA+WOBW31S2z2FxrUChqiRw=;
	b=R3GU2nB4F4dj72GTzB6GtDwsEZezNc8GT+XSiu9DjcVQq9GmIu5FSnjHOKm5IZIBN8Fw3b
	QkRgNaudIB5Thyny6mbCbKnEjrV3fbdEeqjWhN4+V1EwEH7t83piA2iZEFHNuDCCD35rBP
	qqdsfcFrpoZuXaLgvx/Jgr2m8gD/YPE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-ABRm7q5WOOq70bUj5qLzGQ-1; Wed,
 18 Dec 2024 05:16:34 -0500
X-MC-Unique: ABRm7q5WOOq70bUj5qLzGQ-1
X-Mimecast-MFC-AGG-ID: ABRm7q5WOOq70bUj5qLzGQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A527B1956086;
	Wed, 18 Dec 2024 10:16:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.10])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D898195605F;
	Wed, 18 Dec 2024 10:16:32 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 2/2] block: avoid to reuse `hctx` not removed from cpuhp callback list
Date: Wed, 18 Dec 2024 18:16:15 +0800
Message-ID: <20241218101617.3275704-3-ming.lei@redhat.com>
In-Reply-To: <20241218101617.3275704-1-ming.lei@redhat.com>
References: <20241218101617.3275704-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

If the 'hctx' isn't removed from cpuhp callback list, we can't reuse it,
otherwise use-after-free may be triggered.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202412172217.b906db7c-lkp@intel.com
Tested-by: kernel test robot <oliver.sang@intel.com>
Fixes: 22465bbac53c ("blk-mq: move cpuhp callback registering out of q->sysfs_lock")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 92e8ddf34575..8ac19d4ae3c0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4412,6 +4412,15 @@ struct gendisk *blk_mq_alloc_disk_for_queue(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_mq_alloc_disk_for_queue);
 
+/*
+ * Only hctx removed from cpuhp list can be reused
+ */
+static bool blk_mq_hctx_is_reusable(struct blk_mq_hw_ctx *hctx)
+{
+	return hlist_unhashed(&hctx->cpuhp_online) &&
+		hlist_unhashed(&hctx->cpuhp_dead);
+}
+
 static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 		struct blk_mq_tag_set *set, struct request_queue *q,
 		int hctx_idx, int node)
@@ -4421,7 +4430,7 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 	/* reuse dead hctx first */
 	spin_lock(&q->unused_hctx_lock);
 	list_for_each_entry(tmp, &q->unused_hctx_list, hctx_list) {
-		if (tmp->numa_node == node) {
+		if (tmp->numa_node == node && blk_mq_hctx_is_reusable(tmp)) {
 			hctx = tmp;
 			break;
 		}
-- 
2.47.0

