Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D6B28A40B
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291902; cv=none; b=lgzcTEtpayjRrbBmeS+Bk9bN1rxkAlHy5r4yoseKfZ6svDqQby8D1SikYLg3ctgFGr3Mk/sz3XlHMMZ3ibTlXBqUh+SVQPwTZyF9s4F9XU1kYXtiuCNzanxtYBVUxFH5mW2jpLV7rQ99M/2Pxh4HQUz+FJVEp9ryIFUUCxuEc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291902; c=relaxed/simple;
	bh=720h5vI4UjCgHiu/oDG2Y1EmVTVJSMg2oU7RN5i3+SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSqG1iCFmeZdIrFtnolOp2bbf947HIo7oIl5Uno9pOgLOMeb3IzhSMDxZVlq9icsTWwnfJ0lILvKptnC3tRa8CE5gWjmMAB1TU4iZ0WNznL4Gu7PXlZFAY4audtkmMFI9GsEgSyVsjiGgzeqxm+QNihqfM5mKjiTQbFRjPGeXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PnUbRmga; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnUbRmga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744291899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHrLWHPyLHEITbCLh+w++Qah5C8kzi6YcdiT3KUsi/c=;
	b=PnUbRmgaQr28//abIkg3SWnOzs6lwkJvva5tdSyPZYo/abdqvtme1tT29V1nGCVvzIdWwS
	jtwbrw3DIrBcv+LNbXSsbxrw6mWf0K/ALOVIAGJvij2XAGJx/EVQs/WFJ3Y+ZnyWlG8jik
	X/jYL1BWZamolZ2UApLwnYGUVL3hNH4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-7O3gLIvOPxWsq2vvaUpZMA-1; Thu,
 10 Apr 2025 09:31:38 -0400
X-MC-Unique: 7O3gLIvOPxWsq2vvaUpZMA-1
X-Mimecast-MFC-AGG-ID: 7O3gLIvOPxWsq2vvaUpZMA_1744291897
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25257195609E;
	Thu, 10 Apr 2025 13:31:37 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AE2E1956094;
	Thu, 10 Apr 2025 13:31:35 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 10/15] block: pass elevator_queue to elv_register_queue & unregister_queue
Date: Thu, 10 Apr 2025 21:30:22 +0800
Message-ID: <20250410133029.2487054-11-ming.lei@redhat.com>
In-Reply-To: <20250410133029.2487054-1-ming.lei@redhat.com>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Pass elevator_queue reference to elv_register_queue() &
elv_unregister_queue().

No functional change, and prepare for moving the two out of elevator
lock.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 7d2a56ef0be6..238b8d47cc2b 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -455,9 +455,10 @@ static const struct kobj_type elv_ktype = {
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
@@ -484,10 +485,9 @@ static int elv_register_queue(struct request_queue *q, bool uevent)
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
@@ -629,7 +629,7 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
-		elv_unregister_queue(q);
+		elv_unregister_queue(q, q->elevator);
 		elevator_exit(q);
 	}
 
@@ -637,7 +637,7 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
 	if (ret)
 		goto out_unfreeze;
 
-	ret = elv_register_queue(q, ctx->uevent);
+	ret = elv_register_queue(q, q->elevator, ctx->uevent);
 	if (ret) {
 		elevator_exit(q);
 		goto out_unfreeze;
@@ -662,7 +662,7 @@ static void elevator_disable(struct request_queue *q)
 
 	blk_mq_quiesce_queue(q);
 
-	elv_unregister_queue(q);
+	elv_unregister_queue(q, q->elevator);
 	elevator_exit(q);
 	blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
 	q->elevator = NULL;
-- 
2.47.0

