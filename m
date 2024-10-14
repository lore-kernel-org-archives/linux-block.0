Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4063FD4
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728867091; cv=none; b=c6gTq/VLC7G+ABfk3jv828Tvl1Ue5vWrRaFk0EtivCCRi8mJ/b+hSN4UdGhFttYYzzz4SwKhr1dcLr6bp2uUH/DtI347F1HAPnFwr6gOF4aEElpeMVrghqMdZVctXMnAqWLGoio4IL/nkYuU8em+1FPGbfVEudjr/UvpVcmItcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728867091; c=relaxed/simple;
	bh=znTkRxnVJ87EJfVio0oOxdIwO8anRsmWpzsz5X1CfMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1L5ewUVRfXdTGdCVcWbrV015NFrkpFWTuYZ6E+Vid60T/ErrAww3vTR2VFAr+k6frr3pe474iyZgWkfTdP1g+87xh4vtT6QmpIehlLK+eYQ3zJfQQWZa48TgluIX84GDlKRwMd7N429ppJyUi44SSHF9CHP3UzwncSBpQE8+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGhxqCFB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGhxqCFB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728867088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mmuABJx7wIX9RlsNTIPRSsssFMiymfsh2OYsIQmAkx8=;
	b=IGhxqCFB9sb1TaD5cLQlLseV8E61/LGUDfCjbEsBOglA99DmCYP+pL9bCqnf1WNCMoWuFX
	51IJ7Qyt1QeBTeskG7GVDR43Pt8G5Djiuv5gqV1BdKN1HPEiz6tDJ0LigavfmVuYD2ISe0
	2TQk5FH9x4bqqg46izyqOzExBpjjOzU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-CYgOV6PZPDSN9dyczo0H8w-1; Sun,
 13 Oct 2024 20:51:24 -0400
X-MC-Unique: CYgOV6PZPDSN9dyczo0H8w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71F9319560A2;
	Mon, 14 Oct 2024 00:51:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.46])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44BE73000198;
	Mon, 14 Oct 2024 00:51:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Rick Koch <mr.rickkoch@gmail.com>
Subject: [PATCH] blk-mq: setup queue ->tag_set before initializing hctx
Date: Mon, 14 Oct 2024 08:51:15 +0800
Message-ID: <20241014005115.2699642-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Commit 7b815817aa58 ("blk-mq: add helper for checking if one CPU is mapped to specified hctx")
needs to check queue mapping via tag set in hctx's cpuhp handler.

However, q->tag_set may not be setup yet when the cpuhp handler is
enabled, then kernel oops is triggered.

Fix the issue by setup queue tag_set before initializing hctx.

Reported-and-tested-by: Rick Koch <mr.rickkoch@gmail.com>
Closes: https://lore.kernel.org/linux-block/CANa58eeNDozLaBHKPLxSAhEy__FPfJT_F71W=sEQw49UCrC9PQ@mail.gmail.com
Fixes: 7b815817aa58 ("blk-mq: add helper for checking if one CPU is mapped to specified hctx")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b2c8e940f59..cf626e061dd7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4310,6 +4310,12 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;
 
+	/*
+	 * ->tag_set has to be setup before initialize hctx, which cpuphp
+	 * handler needs it for checking queue mapping
+	 */
+	q->tag_set = set;
+
 	if (blk_mq_alloc_ctxs(q))
 		goto err_exit;
 
@@ -4328,8 +4334,6 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
-	q->tag_set = set;
-
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
 
 	INIT_DELAYED_WORK(&q->requeue_work, blk_mq_requeue_work);
-- 
2.46.0

