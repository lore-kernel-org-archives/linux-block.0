Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58DB188006
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291927; cv=none; b=uazxnxMz+AWf8VSmT38vPIjt1unJ41BJwqHIawwxmchKA0JjcrB69Kxum5dRDaJ7e0Sl8dQ0W4F5ZitZscMQFjOc4FBr5+BpvcEbJfOtyFBAT5etnJBenl59/ZWpmZ8uDIGdv5k2Q1VMzpUpBVT1e/Mryj/bskWb2wmt0+EqS3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291927; c=relaxed/simple;
	bh=k4XS5BBXWJoOZ9an0OYny3cUGfP2t9D0aCKxih9/Evw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISA7L4umjB6CNOK6rtxUVcNOMpw0Pp65Do7L4rA8YmZHIaBlTdb9dkSGP8Pd2FqTuPqV/RqaYBcYOkNBhpCYjTtsle+hqe0Q5T/2gCm3KKbEBHhseVqRB1v3Cy0YBWTV7hhRKD9YjHrB5YZDDjaYLg9Mub6goYL69ndxL8bcVZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpPpYvf+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpPpYvf+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744291925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKHd7cs1y9A1ReQXiJleGLMIXRcUpiEW5ZZKSVQRBkk=;
	b=fpPpYvf+2mJmk6T0PI/xm9L/NQonbSv3Pu5RsLSiIyjoU2wGtoDF+fSfSd3Ot3igFvf96d
	UZzGqPOX6+28+hLbduk/vZfMvf12/xzjuVoZqPRlZGLQX+Cv5YMnN0FRemKJyBa+U477br
	vUmt8xK5trrrgMEZIeGgX/3gS3tjlwE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-nMfwbdOrMvmt2UDFz5IrMA-1; Thu,
 10 Apr 2025 09:32:01 -0400
X-MC-Unique: nMfwbdOrMvmt2UDFz5IrMA-1
X-Mimecast-MFC-AGG-ID: nMfwbdOrMvmt2UDFz5IrMA_1744291920
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 049D319560A2;
	Thu, 10 Apr 2025 13:32:00 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 104A53001D0E;
	Thu, 10 Apr 2025 13:31:58 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 15/15] block: move wbt_enable_default() out of queue freezing from scheduler's ->exit()
Date: Thu, 10 Apr 2025 21:30:27 +0800
Message-ID: <20250410133029.2487054-16-ming.lei@redhat.com>
In-Reply-To: <20250410133029.2487054-1-ming.lei@redhat.com>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

scheduler's ->exit() is called with queue frozen and elevator lock is held, and
wbt_enable_default() can't be called with queue frozen, otherwise the
following lockdep warning is triggered:

	#6 (&q->rq_qos_mutex){+.+.}-{4:4}:
	#5 (&eq->sysfs_lock){+.+.}-{4:4}:
	#4 (&q->elevator_lock){+.+.}-{4:4}:
	#3 (&q->q_usage_counter(io)#3){++++}-{0:0}:
	#2 (fs_reclaim){+.+.}-{0:0}:
	#1 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}:
	#0 (&q->debugfs_mutex){+.+.}-{4:4}:

Fix the issue by moving wbt_enable_default() out of bfq's exit(), and
call it from elevator_change_done().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bfq-iosched.c | 2 +-
 block/elevator.c    | 5 +++++
 block/elevator.h    | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index abd80dc13562..18018c8cf84d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7211,7 +7211,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 
 	blk_stat_disable_accounting(bfqd->queue);
 	clear_bit(ELEVATOR_FLAG_DISABLE_WBT, &e->flags);
-	wbt_enable_default(bfqd->queue->disk);
+	set_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT, &e->flags);
 
 	kfree(bfqd);
 }
diff --git a/block/elevator.c b/block/elevator.c
index 1cc640a9db3e..9cf78db4d6a4 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -676,8 +676,13 @@ int elevator_change_done(struct request_queue *q, struct elev_change_ctx *ctx)
 	int ret = 0;
 
 	if (ctx->old) {
+		bool enable_wbt = test_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT,
+				&ctx->old->flags);
+
 		elv_unregister_queue(q, ctx->old);
 		kobject_put(&ctx->old->kobj);
+		if (enable_wbt)
+			wbt_enable_default(q->disk);
 	}
 	if (ctx->new) {
 		ret = elv_register_queue(q, ctx->new, ctx->uevent);
diff --git a/block/elevator.h b/block/elevator.h
index 87848fdc8a52..7b66be5b8295 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -122,6 +122,7 @@ struct elevator_queue
 
 #define ELEVATOR_FLAG_REGISTERED	0
 #define ELEVATOR_FLAG_DISABLE_WBT	1
+#define ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT	2
 
 /* Holding data for changing elevator */
 struct elev_change_ctx {
-- 
2.47.0

