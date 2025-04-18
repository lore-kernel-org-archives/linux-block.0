Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C4F2222D3
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994327; cv=none; b=iuL4+zfS9pO85iZLqrW7uBWEamwAFkmvsz2+mTNpYXf9Z5Vjzbax2T+JU1eHU5NHIbQyNUuyF4j8QLaw+GLG4m2qqN6Z0d2Plyvoj9gNujkJLthieofMmzd2Y0qlRuCpJT02ycdceKK7bKCrTzfFEa8hZE/cIGjGX7gyQSzHhIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994327; c=relaxed/simple;
	bh=GFn+0JsJbd41Gknq+7uBEOwcXxoe58QdIzoMjzwPg4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxU6b1pJm2wiX034cAaFJ2WQEq3MHSTVSEMGMrXMyBu9zhrd8TjAorjGWhLehhNvygxWQEpMeIhHgQ96fzIxWp0noLV6thwKXVeYD6LsqJOoT+lnRslgJti1Vl7nrgQzlYevFbsMY2Na/HscuXvx0ciUbBIPO2Mfq+EpVDdLPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uz397ogN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uz397ogN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRDvh1Lew3SoNPiwpubUaTWEXt/qfAL3pl3cp3qv+3M=;
	b=Uz397ogNketqqXEe0wy2KKf7JtnCjE3D0LCeCDexEWXSBcDbIBlyKUVipSxHr8KVUUrm7l
	Q2X/As2c9xQOYAk5ab/W5hkD67qO3PAAW4irc609XGE1TaQZ2f6q2PtuAtoHBuHlxBDUjs
	AGNHcaaB/fDCiV6Joo66LG6yhGgOSsg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-cB-dr81wO4uEpnrWBAiyRw-1; Fri,
 18 Apr 2025 12:38:43 -0400
X-MC-Unique: cB-dr81wO4uEpnrWBAiyRw-1
X-Mimecast-MFC-AGG-ID: cB-dr81wO4uEpnrWBAiyRw_1744994322
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4ADFB195608E;
	Fri, 18 Apr 2025 16:38:42 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07A4A19560A3;
	Fri, 18 Apr 2025 16:38:40 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 20/20] block: move wbt_enable_default() out of queue freezing from sched ->exit()
Date: Sat, 19 Apr 2025 00:37:01 +0800
Message-ID: <20250418163708.442085-21-ming.lei@redhat.com>
In-Reply-To: <20250418163708.442085-1-ming.lei@redhat.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
index 40e4106a71e7..310ce1d8c41e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7211,7 +7211,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 
 	blk_stat_disable_accounting(bfqd->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_DISABLE_WBT, bfqd->queue);
-	wbt_enable_default(bfqd->queue->disk);
+	set_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT, &e->flags);
 
 	kfree(bfqd);
 }
diff --git a/block/elevator.c b/block/elevator.c
index 8652fe45a2db..378553fce5d8 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -687,8 +687,13 @@ int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx)
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
index 486be0690499..b14c611c74b6 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -122,6 +122,7 @@ struct elevator_queue
 
 #define ELEVATOR_FLAG_REGISTERED	0
 #define ELEVATOR_FLAG_DYING		1
+#define ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT	2
 
 /* Holding context data for changing elevator */
 struct elv_change_ctx {
-- 
2.47.0

