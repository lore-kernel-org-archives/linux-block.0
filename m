Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451281C8FB5
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987804; cv=none; b=jyrXUg6LYp7+TB1oAPPuX4aiuQE4jNi5msS6qznjiAPL64wNCXGgjXT6Xyegk0hx0aup3tHU93ypu9DSnixOYn1RY3MXuFe+5485BhEattmTHyQJsLXFoDn6SNACoS9CaBBuCCyzqWpq0UFZ+/VL1fgzqezFbTcnHow1DFpxPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987804; c=relaxed/simple;
	bh=6BxOFyWdxFHSQy7/8R0FrgPvvhjCRlgLemBAj1TfyFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzY7SYZG8TXrs/aii3QcgUvkIBpuKlbbB30YSpHUFm3t6CXkMOeK0NsSGCjNxNZuD6MzKtvgOOJvDErucZeYwULph5dxdv+yPokEnaPaNpAEy9ZPeyxstKvViOmZAm+nJYtxAJWPnqDevagtrDdoh1aMer69v2j42PT4r51btks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HegRn1TG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HegRn1TG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IaY36bR5DkhD1bBYDSZD6payTFqw+jgSY9Vr4XzaS/w=;
	b=HegRn1TGvTUCl0SId7jK+gZ3bg4iRMAIuxG0PzHyIGseI4rQAX+i384xPkmQ7ob5LLQcOz
	FQc4v09JyKFbJmya9nLEwkfCOz3Qv+8tlufjXeWl4TdPgpsscI/+GFSiEul1G+njk2GD1w
	2dqgcET0G1RgL/aA9HQ5PTH8hWsUHzY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-VPwzLNgUMS2YTLpXBLyfuw-1; Wed,
 30 Apr 2025 00:36:38 -0400
X-MC-Unique: VPwzLNgUMS2YTLpXBLyfuw-1
X-Mimecast-MFC-AGG-ID: VPwzLNgUMS2YTLpXBLyfuw_1745987797
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FDCC180034E;
	Wed, 30 Apr 2025 04:36:37 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 78A1819560A3;
	Wed, 30 Apr 2025 04:36:36 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 16/24] block: pass elevator_queue to elv_register_queue & unregister_queue
Date: Wed, 30 Apr 2025 12:35:18 +0800
Message-ID: <20250430043529.1950194-17-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Pass elevator_queue reference to elv_register_queue() & elv_unregister_queue().

No functional change, and prepare for moving the two out of elevator
lock & freezing queue, when we need to store the old & new elevator
queue in `struct elv_change_ctx` instance, then both two can co-exist
for short while, so we have to pass the exact elevator_queue instance
to elv_register_queue & unregister_queue.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index aaec9584ed72..2b16394972c0 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -458,9 +458,10 @@ static const struct kobj_type elv_ktype = {
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
@@ -488,10 +489,9 @@ static int elv_register_queue(struct request_queue *q, bool uevent)
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
@@ -584,7 +584,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
-		elv_unregister_queue(q);
+		elv_unregister_queue(q, q->elevator);
 		elevator_exit(q);
 	}
 
@@ -592,7 +592,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 		ret = blk_mq_init_sched(q, new_e);
 		if (ret)
 			goto out_unfreeze;
-		ret = elv_register_queue(q, !ctx->no_uevent);
+		ret = elv_register_queue(q, q->elevator, !ctx->no_uevent);
 		if (ret) {
 			elevator_exit(q);
 			goto out_unfreeze;
-- 
2.47.0

