Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAF878F4E
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291864; cv=none; b=AyORMQEaHm5iaDuQqb5bV0yuQwCGhbj9KWJ+a/MQWKzY9iFnCvYHJy371Yj5QcXugjiDfVGqqPIEXlQaXPaAfQ5xW86GITXP2urcUT30LIanL6idKSgjRqn2JDneCmXsxMQwfx+NpZQcOVgUivnUZFG9fOlwDdGsOnxso39OC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291864; c=relaxed/simple;
	bh=bavUu1Lt/jALufmHuyOkgx+9KGl02TYwcyjDVjt+QC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0w2FkYc5GQtOdTwjDPjvIgtHNBV0o1pV01tbVvc4zH0/1kr1jlmKnl134/E+hVmFlXj456KgR6gT08Z+Q+A0arR1OIgx5LoT/+d00llksJdFvknKWNqI6Xu5n9YHSPLgYHiOxpeSE1ody85n3amgZGnNa8ier/0XCniX5NPqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJPLCJMK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJPLCJMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744291862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HInUZ1JgSSKLSxNX9tbFbkA6LH4NVwRZynu5inN9PA=;
	b=XJPLCJMK2JsdLqk2t2Tl2ZKLL9D5QA1YAYtVF5MPI3dYNm+szGwkREOJv6fNL0jsehu2N1
	bMjmUwN4AVjvkurhNVTlZk1jVlzwvz0a2/RIpZLNGV7JgRhyEekX+rUraujqN30tbPn5dj
	Kiqf3zK5dY+hhPuDTJBnHnL2svd2Uv8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-A3rwYZo0OiaegcekcDJp_g-1; Thu,
 10 Apr 2025 09:30:57 -0400
X-MC-Unique: A3rwYZo0OiaegcekcDJp_g-1
X-Mimecast-MFC-AGG-ID: A3rwYZo0OiaegcekcDJp_g_1744291855
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C68E81955DCE;
	Thu, 10 Apr 2025 13:30:54 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 909361828A9E;
	Thu, 10 Apr 2025 13:30:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 01/15] block: don't call freeze queue in elevator_switch() and elevator_disable()
Date: Thu, 10 Apr 2025 21:30:13 +0800
Message-ID: <20250410133029.2487054-2-ming.lei@redhat.com>
In-Reply-To: <20250410133029.2487054-1-ming.lei@redhat.com>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Both elevator_switch() and elevator_disable() are called from sysfs
store and updating nr_hw_queue code paths only.

And in the two code paths, queue has been frozen already, so don't call
freeze queue in the two functions.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index b4d08026b02c..5051a98dc08c 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -615,12 +615,11 @@ void elevator_init_mq(struct request_queue *q)
  */
 int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 {
-	unsigned int memflags;
 	int ret;
 
+	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
 
-	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
@@ -641,7 +640,6 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 
 out_unfreeze:
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q, memflags);
 
 	if (ret) {
 		pr_warn("elv: switch to \"%s\" failed, falling back to \"none\"\n",
@@ -653,11 +651,9 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 
 void elevator_disable(struct request_queue *q)
 {
-	unsigned int memflags;
-
+	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
 
-	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	elv_unregister_queue(q);
@@ -668,7 +664,6 @@ void elevator_disable(struct request_queue *q)
 	blk_add_trace_msg(q, "elv switch: none");
 
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q, memflags);
 }
 
 /*
-- 
2.47.0

