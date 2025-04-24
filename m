Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6513C1DCB09
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508177; cv=none; b=V76BewZ9Ci5KYARoo1CZOD80pkmfE8x4EROg3vp7rzhhsgVZVAyeUqRQrWHpPJKjPoQ3v7KLZy1TQc1dXW5Bv+7kncxMnODuho7+EQl8AApdlQPyyBEj5JwYbFjlgVhKHhZRst0MmDshzZCqphDexw80R1J9gsNqBUcH+v5vwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508177; c=relaxed/simple;
	bh=TArro86byj9iQ2bI2XIDGirIQNKuv8+mv2ZZInB8mfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYftND9jXX5uEINRwZGqMYWkcZVPNyp6mbSO1zTf32aXmVsyYFuHmlYIyLkV7ASv9A2GhLqy+g4dN/+CHzAtjmJSvuLaaqaL5iDy7tNAX3pzHM/nawJb0rqkDbLNn4Gb0+IgZkmEZFf/iSq3jgRrDuS1p5AbcJS29PStK7cIIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcGF77RI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcGF77RI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAS+B5zZJQaiNubq6Z97WVkanGRyqB5MvIamzacwjLg=;
	b=QcGF77RIO9ZraY51cKPaySfZ9bSzQPw+UDw7iYts0NgBKCkxVs3M8ztwHZ8I1Wav0pwXP7
	tCmDM7/Rb5yrAYQRs88dB18q35nY8W5RSiqnzr0zS5qq3cSrmnC6gkifvzc+Mymf2ENxLb
	j0XV9Uvn8v26nmWpUJy13VZoYhaqgcE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-WTO-TYvBMLCdFYP6mCl6Rg-1; Thu,
 24 Apr 2025 11:22:52 -0400
X-MC-Unique: WTO-TYvBMLCdFYP6mCl6Rg-1
X-Mimecast-MFC-AGG-ID: WTO-TYvBMLCdFYP6mCl6Rg_1745508170
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3F631800877;
	Thu, 24 Apr 2025 15:22:50 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4F3C18001DA;
	Thu, 24 Apr 2025 15:22:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 14/20] block: pass elevator_queue to elv_register_queue & unregister_queue
Date: Thu, 24 Apr 2025 23:21:37 +0800
Message-ID: <20250424152148.1066220-15-ming.lei@redhat.com>
In-Reply-To: <20250424152148.1066220-1-ming.lei@redhat.com>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Pass elevator_queue reference to elv_register_queue() & elv_unregister_queue().

No functional change, and prepare for moving the two out of elevator
lock & freezing queue, when we need to store the old & new elevator
queue in `struct elv_change_ctx` instance, then both two can co-exist
for short while, so we have to pass the exact elevator_queue instance
to elv_register_queue & unregister_queue.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 5ec66fbd4f24..dde8732b7a26 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -459,9 +459,10 @@ static const struct kobj_type elv_ktype = {
 	.release	= elevator_release,
 };
 
-static int elv_register_queue(struct request_queue *q, bool uevent)
+static int elv_register_queue(struct request_queue *q,
+			      struct elevator_queue *e,
+			      bool uevent)
 {
-	struct elevator_queue *e = q->elevator;
 	int error;
 
 	lockdep_assert_held(&q->elevator_lock);
@@ -489,10 +490,9 @@ static int elv_register_queue(struct request_queue *q, bool uevent)
 	return error;
 }
 
-static void elv_unregister_queue(struct request_queue *q)
+static void elv_unregister_queue(struct request_queue *q,
+				 struct elevator_queue *e)
 {
-	struct elevator_queue *e = q->elevator;
-
 	lockdep_assert_held(&q->elevator_lock);
 
 	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
@@ -595,7 +595,7 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
-		elv_unregister_queue(q);
+		elv_unregister_queue(q, q->elevator);
 		elevator_exit(q);
 	}
 
@@ -603,7 +603,7 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
 	if (ret)
 		goto out_unfreeze;
 
-	ret = elv_register_queue(q, ctx->uevent);
+	ret = elv_register_queue(q, q->elevator, ctx->uevent);
 	if (ret) {
 		elevator_exit(q);
 		goto out_unfreeze;
@@ -628,7 +628,7 @@ static void elevator_disable(struct request_queue *q)
 
 	blk_mq_quiesce_queue(q);
 
-	elv_unregister_queue(q);
+	elv_unregister_queue(q, q->elevator);
 	elevator_exit(q);
 	blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
 	q->elevator = NULL;
-- 
2.47.0

