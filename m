Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B0C1D90C8
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987784; cv=none; b=tx2wtsw+C4f2TKiIZCTKiiURqeYzDZ7kJBQFNiKWyGcLpwEABrPPsJw2+T88iBQc5HyWwnjiYLUSEsAZSJ5I2uSGstroNEZ40IMVBlrfJQi7cDzQjv3XLLO5RtffTQAv2+TZsSTHvwzJ7QP+kSZib1ONibHF1J26DRC/14+iCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987784; c=relaxed/simple;
	bh=kyofJi/8/WgqObTiHzJs/1IVSm2Gw5QxO40DOE2CTJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJzSsTyG5KiVihkBom9k/BiRgn0SSiaWBMlEkE4g2KdPSGP2lBe37q9mrLcMJmchkHY3+oSfhz1NqqYXau6dMvDL0PaBEHZX1FWhheH6DmoeCS3IUltQD6cwSFsfycdKVHeXhIpM191YDDiN1/JP0fWW+AAz+jBLR/efVlRwrs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpsKwUaX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpsKwUaX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0AhVQYWI924VCvBQdX1IkHjoZOiiPBLLggBJAXsFu8=;
	b=GpsKwUaXJbHVfWoK2wqdkpBPDs+dT/NA9aKsjU9xewxpebe3X1oNR9MrFqlrJ9GcrpMHfg
	tPpT2B3cTzfET0JSWkcehoQskhTgbnoyqMFNy+zcJfn6rJJzma7dPfKRugJvMo08NdAZSN
	Gi+SHHd+0yl4XcWia3MJYZqCtFb8cuw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-Hm8g0xlsO-WoN6v1zDy7bw-1; Wed,
 30 Apr 2025 00:36:13 -0400
X-MC-Unique: Hm8g0xlsO-WoN6v1zDy7bw-1
X-Mimecast-MFC-AGG-ID: Hm8g0xlsO-WoN6v1zDy7bw_1745987772
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E739195608A;
	Wed, 30 Apr 2025 04:36:12 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3905D30001A2;
	Wed, 30 Apr 2025 04:36:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 09/24] block: look up the elevator type in elevator_switch
Date: Wed, 30 Apr 2025 12:35:11 +0800
Message-ID: <20250430043529.1950194-10-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Christoph Hellwig <hch@lst.de>

That makes the function nicely self-contained and can be used
to avoid code duplication.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c   |  2 +-
 block/blk.h      |  2 +-
 block/elevator.c | 18 ++++++++----------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3706c0dde2fc..54f1d8b4e35c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5014,7 +5014,7 @@ static void blk_mq_elv_switch_back(struct list_head *head,
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
index 12296f77efbd..3ab4ed17de0f 100644
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

