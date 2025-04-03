Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6942E3385
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743677656; cv=none; b=XJu+Q9cIsRrgE7oNTPJa0zNNOkJf3YyBSmzsa317lBDMNpPufeLBn9fKYHjuy5wRFoS6CRmupMlGZ3zDc3AaBdjTGKdesvqN6a0jV9r7p+OdqngQxQgYl4o5Y9f8iymbHRaK60gKVJ3fgwgTK6uaEkpACF1yJ4By+cFoFweeJeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743677656; c=relaxed/simple;
	bh=JGby5fFrvviiBLKvToSBxf1OCou+1Kuta/nU2jTMz64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ulz3ftcX6UwxaWVO8LTMzTcVN3FYVRemwvmW5ZbmrUM4ze43Y4n/c4YDm+ivMkl6ij1P5mydF5KnNq5xAObNaGMfzczToeM2OSe0uKR2C+wmx6Ons88SZ/oANkWh5xXk8sDS5NKOBvs0orVRURkjaYkBTLMAdB4vre1rDfShDho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cyktNK2f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cyktNK2f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743677653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ojrk567b/97DhLRE9z+8UN5wQBQYIth0alOTH41JbiU=;
	b=cyktNK2fj9ML2QiCMeUqzAefgHHwNTmkPm8lqS3tQjSmUYjF/gckUv02pe5EUmFwKwvsXT
	rMbJO2ydoOwNzsnZv0GghZjdEb2o0yr68CX9GBfqkygxdFKKUeD7k3fj92/UNWzlAu3C4L
	MikgzKr5wcA1fLoM/0acGlNVQ7v3oEY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-1ClGQj8cPbe8cW9gHXH56g-1; Thu,
 03 Apr 2025 06:54:10 -0400
X-MC-Unique: 1ClGQj8cPbe8cW9gHXH56g-1
X-Mimecast-MFC-AGG-ID: 1ClGQj8cPbe8cW9gHXH56g_1743677649
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95A671800349;
	Thu,  3 Apr 2025 10:54:08 +0000 (UTC)
Received: from localhost (unknown [10.72.120.26])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA3CB1809B63;
	Thu,  3 Apr 2025 10:54:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
Subject: [PATCH] block: don't grab elevator lock during queue initialization
Date: Thu,  3 Apr 2025 18:54:02 +0800
Message-ID: <20250403105402.1334206-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

->elevator_lock depends on queue freeze lock, see block/blk-sysfs.c.

queue freeze lock depends on fs_reclaim.

So don't grab elevator lock during queue initialization which needs to
call kmalloc(GFP_KERNEL), and we can cut the dependency between
->elevator_lock and fs_reclaim, then the lockdep warning can be killed.

This way is safe because elevator setting isn't ready to run during
queue initialization.

There isn't such issue in __blk_mq_update_nr_hw_queues() because
memalloc_noio_save() is called before acquiring elevator lock.

Fixes the following lockdep warning:

https://lore.kernel.org/linux-block/67e6b425.050a0220.2f068f.007b.GAE@google.com/

Reported-by: syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
Cc: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae8494d88897..d7a103dc258b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4465,14 +4465,12 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 	return NULL;
 }
 
-static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
-						struct request_queue *q)
+static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
+				     struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i, j;
 
-	/* protect against switching io scheduler  */
-	mutex_lock(&q->elevator_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		int old_node;
 		int node = blk_mq_get_hctx_node(set, i);
@@ -4505,7 +4503,19 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 	xa_for_each_start(&q->hctx_table, j, hctx, j)
 		blk_mq_exit_hctx(q, set, hctx, j);
-	mutex_unlock(&q->elevator_lock);
+}
+
+static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
+				   struct request_queue *q, bool lock)
+{
+	if (lock) {
+		/* protect against switching io scheduler  */
+		mutex_lock(&q->elevator_lock);
+		__blk_mq_realloc_hw_ctxs(set, q);
+		mutex_unlock(&q->elevator_lock);
+	} else {
+		__blk_mq_realloc_hw_ctxs(set, q);
+	}
 
 	/* unregister cpuhp callbacks for exited hctxs */
 	blk_mq_remove_hw_queues_cpuhp(q);
@@ -4537,7 +4547,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	xa_init(&q->hctx_table);
 
-	blk_mq_realloc_hw_ctxs(set, q);
+	blk_mq_realloc_hw_ctxs(set, q, false);
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
 
@@ -5033,7 +5043,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_realloc_hw_ctxs(set, q);
+		blk_mq_realloc_hw_ctxs(set, q, true);
 
 		if (q->nr_hw_queues != set->nr_hw_queues) {
 			int i = prev_nr_hw_queues;
-- 
2.47.0

