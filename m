Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DD11FCFC0
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715528; cv=none; b=g8DZQ1G30Zv7XN72YOCu4TEOTwj+tGpJwe6++kszojjtbxZ0tTdEzOiHuL+WYZrUWEAbcFSGa1MSBtrn6VjdlaUOSyxre68rgQ4JcYMmZbun3lR95ksv6a3+y3W3ffJkwE8jVvp8T+Vc5zLYokVSryBCrZ5eP73WXxurbPiLGKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715528; c=relaxed/simple;
	bh=9ArIwhHODV/jdC53PdFwmqHSECOvgwzB5rFpKdxapeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5kQTfnk77q+PwHQ6Y+B1wbQEGpUjLq3CybMhCk272cOq94SbixykXPDZb7l6Dvqmula2GfrFDwBd0mpLkpMaA1N318lWRZ2J4QQuF5A8yESbU8G7zmsFn19HCbv2zvEpyFzGj5pW5JQ6zzmfi3gCrKHO7GnaiUBaotmB11qSAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Imohi5wd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Imohi5wd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732715525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmHrlc/yx9KjGvODOZ502l3k1IQtP7TuU7Z0oX0063Y=;
	b=Imohi5wdkbLAD2Pb3JXWjROs9BvrLmBxr/58vbXbINj4wWVolxxS9LNbJtilmxpyw6PZ9V
	dpjrkWQN23qDwHuLd9rdHjaZdkdHssAEsvCi3SUG57/dSiTgyb+KXxweFd+rpQCltLpzTA
	nK4zErBhA/X6Y2GQeYEvi7ZLjoa9MGM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-_s7DQCyVN_ys4-55UVYPEw-1; Wed,
 27 Nov 2024 08:52:04 -0500
X-MC-Unique: _s7DQCyVN_ys4-55UVYPEw-1
X-Mimecast-MFC-AGG-ID: _s7DQCyVN_ys4-55UVYPEw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2F6A1953941;
	Wed, 27 Nov 2024 13:52:02 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36F001955F57;
	Wed, 27 Nov 2024 13:52:00 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/4] block: don't verify queue freeze manually in elevator_init_mq()
Date: Wed, 27 Nov 2024 21:51:29 +0800
Message-ID: <20241127135133.3952153-4-ming.lei@redhat.com>
In-Reply-To: <20241127135133.3952153-1-ming.lei@redhat.com>
References: <20241127135133.3952153-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Now blk_freeze_queue_start() can track disk state automatically, and
it isn't necessary to verify queue freeze manually in elevator_init_mq()
any more.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index ca0a74369f1c..a26b96662620 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -601,16 +601,13 @@ void elevator_init_mq(struct request_queue *q)
 	 *
 	 * Disk isn't added yet, so verifying queue lock only manually.
 	 */
-	blk_freeze_queue_start_non_owner(q);
-	blk_freeze_acquire_lock(q, false);
-	blk_mq_freeze_queue_wait(q);
+	blk_mq_freeze_queue(q);
 
 	blk_mq_cancel_work_sync(q);
 
 	err = blk_mq_init_sched(q, e);
 
-	blk_unfreeze_release_lock(q, false);
-	blk_mq_unfreeze_queue_non_owner(q);
+	blk_mq_unfreeze_queue(q);
 
 	if (err) {
 		pr_warn("\"%s\" elevator initialization failed, "
-- 
2.47.0

