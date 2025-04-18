Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFE8213E89
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994306; cv=none; b=qxKUeLPnfiK0dg/3V6fKO0vZLyCqMyaS/lQi9OPd5FGopHsEklO7GkIEvpsehgxxKMmz7ob53HuHWaEsIqt43MyxXdEIuUxFpexOYzXCC7s4D7guPkGHKwdTmmDU/DTfyuDMSwIqGEGb2wUWvjTbkUxDLsjuUpaIqwFpUuTt1nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994306; c=relaxed/simple;
	bh=tRsr3l9dcZhoFdeNn4LxqKqEONS/HFl0QW/N7boD7hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JG+MgpmEPX0S3Oh4wQGQ8Lo20SQ2xQLH1nk8AagUi/yN+M/0tZ0yaFm8fFFwl6+cOVLhHeeA06y1QT0YbkRKPMwOom5lvppLbJR66Ia33PulMdkuB5e+upj0mSxdgxfpMjFO4Yatp+OmxVp37LV3oOZLsqyGnQLZLqcmO/AFV3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UagYH5Uk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UagYH5Uk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+q9Sx7hfZ0zwaTfmmHHuVub0hFr8kTt3KPnLwaYFg+g=;
	b=UagYH5Uk6maXY5UkAJXugvspKDNoU4iseYcYwmWHZ7k2mxS3nP0L6Yp39CDdRsHDemm3vT
	jGS/fW+zYAwsLtZpH4fB3xM+CwmQ7ZC26Wsete4l3TRh1SOsaIe5DoYBNZ+VYzFqSEmmh5
	FNSPIdyRt+bXq06z70MIVWi0qdl0dfg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-iGt2HzBVMrKGillM1KKOug-1; Fri,
 18 Apr 2025 12:38:20 -0400
X-MC-Unique: iGt2HzBVMrKGillM1KKOug-1
X-Mimecast-MFC-AGG-ID: iGt2HzBVMrKGillM1KKOug_1744994299
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9A9019560A7;
	Fri, 18 Apr 2025 16:38:18 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1B11180045C;
	Fri, 18 Apr 2025 16:38:17 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 14/20] block: pass elevator_queue to elv_register_queue & unregister_queue
Date: Sat, 19 Apr 2025 00:36:55 +0800
Message-ID: <20250418163708.442085-15-ming.lei@redhat.com>
In-Reply-To: <20250418163708.442085-1-ming.lei@redhat.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Pass elevator_queue reference to elv_register_queue() & elv_unregister_queue().

No functional change, and prepare for moving the two out of elevator
lock & freezing queue, when we need to store the old & new elevator
queue in `struct elv_change_ctx` instance, then both two can co-exist
for short while, so we have to pass the specific elevator_queue instance
to elv_register_queue & unregister_queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 936d8ec9e9f0..568457e01d28 100644
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
@@ -485,10 +486,9 @@ static int elv_register_queue(struct request_queue *q, bool uevent)
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
@@ -634,7 +634,7 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
-		elv_unregister_queue(q);
+		elv_unregister_queue(q, q->elevator);
 		elevator_exit(q);
 	}
 
@@ -642,7 +642,7 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
 	if (ret)
 		goto out_unfreeze;
 
-	ret = elv_register_queue(q, ctx->uevent);
+	ret = elv_register_queue(q, q->elevator, ctx->uevent);
 	if (ret) {
 		elevator_exit(q);
 		goto out_unfreeze;
@@ -667,7 +667,7 @@ static void elevator_disable(struct request_queue *q)
 
 	blk_mq_quiesce_queue(q);
 
-	elv_unregister_queue(q);
+	elv_unregister_queue(q, q->elevator);
 	elevator_exit(q);
 	blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
 	q->elevator = NULL;
-- 
2.47.0

