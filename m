Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1825CC63
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454747; cv=none; b=eZoWECsZagJBPN2WkXKjHaSYvBAxgDkHsGp3od/511nqrC1v1Y1j30mUvL3oU8PZGGK7oBLSmnE8dWijCZbxxaUrKcfgcNZQDynjK7fsMqZQn05tx84i3XuGr/zmoMaAArByWTCXFJgiYxqVkqgApr0TPqOQsIgNHFEYLH6MHhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454747; c=relaxed/simple;
	bh=e+hRv9qcMB833sE9TaXL1RyRtFdzPQy/HyxrHROSlZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hN4XhVHskdshpF9cyuMqHXepWyqvDoh1bIck4Ze7LJ+hG7hGdWr3XM1dEvzKkJpEggszpunwZXbBxjylw7KUtyz10ONPh7WY9ui8/+XtYcgmOvwHPah7a77acwpz0rOsjk18cLJGieO+1huJIzT0NInog8EmznE0dNHuKuu2Gts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOgZdqS+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOgZdqS+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CODBM/n0ijiHmJn0t2m0NVIPkGBPkw0afhhKRobXnkI=;
	b=KOgZdqS+sTLylj1v+Cjwp5V57mHElhYP4Vjxs4jgIXOfmuciYSpsYfoljg6auZJESeYgIX
	D2NuicmZfgX+x/J0PzgCXrwlBqwOjCan42oqQcsACwlKzmGieixReZ6msruYR+T0U+04ms
	MDhQTGbI5uEV+uojzJCkOn26q3Ct7KM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-zFYgRaFiOleSqsTQINM9GQ-1; Mon,
 05 May 2025 10:19:01 -0400
X-MC-Unique: zFYgRaFiOleSqsTQINM9GQ-1
X-Mimecast-MFC-AGG-ID: zFYgRaFiOleSqsTQINM9GQ_1746454740
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42CB319560A6;
	Mon,  5 May 2025 14:19:00 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2829819560AB;
	Mon,  5 May 2025 14:18:58 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 10/25] block: look up the elevator type in elevator_switch
Date: Mon,  5 May 2025 22:17:48 +0800
Message-ID: <20250505141805.2751237-11-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Christoph Hellwig <hch@lst.de>

That makes the function nicely self-contained and can be used
to avoid code duplication.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c   |  2 +-
 block/blk.h      |  2 +-
 block/elevator.c | 18 ++++++++----------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 240afa4c6ab3..20bf2d797bdf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5060,7 +5060,7 @@ static void blk_mq_elv_switch_back(struct list_head *head,
 	kfree(qe);
 
 	mutex_lock(&q->elevator_lock);
-	elevator_switch(q, t);
+	elevator_switch(q, t->elevator_name);
 	/* drop the reference acquired in blk_mq_elv_switch_none */
 	elevator_put(t);
 	mutex_unlock(&q->elevator_lock);
diff --git a/block/blk.h b/block/blk.h
index 328075787814..ac90a8c5a8cf 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -322,7 +322,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-int elevator_switch(struct request_queue *q, struct elevator_type *new_e);
+int elevator_switch(struct request_queue *q, const char *name);
 void elevator_disable(struct request_queue *q);
 void elevator_exit(struct request_queue *q);
 int elv_register_queue(struct request_queue *q, bool uevent);
diff --git a/block/elevator.c b/block/elevator.c
index 2e18513dcd73..286d240a3aef 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -621,13 +621,18 @@ void elevator_init_mq(struct request_queue *q)
  * If switching fails, we are most likely running out of memory and not able
  * to restore the old io scheduler, so leaving the io scheduler being none.
  */
-int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
+int elevator_switch(struct request_queue *q, const char *name)
 {
+	struct elevator_type *new_e;
 	int ret;
 
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
 
+	new_e = elevator_find_get(name);
+	if (!new_e)
+		return -EINVAL;
+
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
@@ -654,6 +659,7 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 			new_e->elevator_name);
 	}
 
+	elevator_put(new_e);
 	return ret;
 }
 
@@ -679,9 +685,6 @@ void elevator_disable(struct request_queue *q)
  */
 static int elevator_change(struct request_queue *q, const char *elevator_name)
 {
-	struct elevator_type *e;
-	int ret;
-
 	/* Make sure queue is not in the middle of being removed */
 	if (!blk_queue_registered(q))
 		return -ENOENT;
@@ -695,12 +698,7 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 	if (q->elevator && elevator_match(q->elevator->type, elevator_name))
 		return 0;
 
-	e = elevator_find_get(elevator_name);
-	if (!e)
-		return -EINVAL;
-	ret = elevator_switch(q, e);
-	elevator_put(e);
-	return ret;
+	return elevator_switch(q, elevator_name);
 }
 
 static void elv_iosched_load_module(char *elevator_name)
-- 
2.47.0

