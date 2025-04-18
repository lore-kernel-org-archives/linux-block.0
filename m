Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27E7462
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994312; cv=none; b=ltyxeX+tFgdGoZdm0aWH4/mWIvvKxI1bgqbmOUiBfPDTZKKNhbWWU6ErFfgfSt59Uk0WUSuToQiKV9CUFDZPhtss7n5gwHg9LLwevW3RmQuIEnpfe04TKjzeHHL4oBx3FToxlqbZAxZMQ49TfmC1mpXv4ybFjBB63NThVOHiXHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994312; c=relaxed/simple;
	bh=q2jCv4fj42tMGcSPxWIaka9P/+dS4gyig+acpdMrlSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkOEsXhbX+6fcYoeaZh98Kn4eGht9vWPVF+5oiNH/L3rz0jlmGojUVTOZXICZMwrFexMrKgOLrpGOtdb5IIwITgAmGeThboihH9/08FhojEHEHmjLfmQFPW5hagQH1r5oARrZghCwQQNVUXd+XEzkpwz+r1qaFLPg5DIWsRgz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UA82JnEk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UA82JnEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wkWQXgWjr4tyJneJ8rrzbQKv/kR8kzwxaaf7vr4i4g=;
	b=UA82JnEk3/KE92aZGMkjibpEJTBIUh1KHEMvZ05uIZgDtPBC5hd1XZQNVgKcMeVXwQv0Dp
	wXlBzYEELue0AOh3km6YcnNDXZVudpptJxM5ynNYKsJZ2aEkfPGq4u1n9iIh2vG998387d
	JPvd4RPyWD2o6tIQqvamk3T1fCLNqxk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-Src3OM0DOsG-FLZxIrKiPg-1; Fri,
 18 Apr 2025 12:38:24 -0400
X-MC-Unique: Src3OM0DOsG-FLZxIrKiPg-1
X-Mimecast-MFC-AGG-ID: Src3OM0DOsG-FLZxIrKiPg_1744994303
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11D891956086;
	Fri, 18 Apr 2025 16:38:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05D8119560A3;
	Fri, 18 Apr 2025 16:38:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 15/20] block: fail to show/store elevator sysfs attribute if elevator is dying
Date: Sat, 19 Apr 2025 00:36:56 +0800
Message-ID: <20250418163708.442085-16-ming.lei@redhat.com>
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

Prepare for moving elv_register[unregister]_queue out of elevator_lock
& queue freezing, so we may have to call elv_unregister_queue() after
elevator ->exit() is called, then there is small window for user to
run into ->show()/store(), and user-after-free can be caused.

Fail to show/store elevator sysfs attribute if elevator is dying by
adding one new flag of ELEVATOR_FLAG_DYNG, which is protected by
elevator ->sysfs_lock.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c |  1 +
 block/elevator.c     | 10 ++++++++--
 block/elevator.h     |  1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 336a15ffecfa..55a0fd105147 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -551,5 +551,6 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 	if (e->type->ops.exit_sched)
 		e->type->ops.exit_sched(e);
 	blk_mq_sched_tags_teardown(q, flags);
+	set_bit(ELEVATOR_FLAG_DYING, &q->elevator->flags);
 	q->elevator = NULL;
 }
diff --git a/block/elevator.c b/block/elevator.c
index 568457e01d28..16171ea92f80 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -422,7 +422,10 @@ elv_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 
 	e = container_of(kobj, struct elevator_queue, kobj);
 	mutex_lock(&e->sysfs_lock);
-	error = e->type ? entry->show(e, page) : -ENOENT;
+	if (test_bit(ELEVATOR_FLAG_DYING, &e->flags))
+		error = -ENODEV;
+	else
+		error = e->type ? entry->show(e, page) : -ENOENT;
 	mutex_unlock(&e->sysfs_lock);
 	return error;
 }
@@ -440,7 +443,10 @@ elv_attr_store(struct kobject *kobj, struct attribute *attr,
 
 	e = container_of(kobj, struct elevator_queue, kobj);
 	mutex_lock(&e->sysfs_lock);
-	error = e->type ? entry->store(e, page, length) : -ENOENT;
+	if (test_bit(ELEVATOR_FLAG_DYING, &e->flags))
+		error = -ENODEV;
+	else
+		error = e->type ? entry->store(e, page, length) : -ENOENT;
 	mutex_unlock(&e->sysfs_lock);
 	return error;
 }
diff --git a/block/elevator.h b/block/elevator.h
index e74e27dd6586..16d8888fa2b2 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -121,6 +121,7 @@ struct elevator_queue
 };
 
 #define ELEVATOR_FLAG_REGISTERED	0
+#define ELEVATOR_FLAG_DYING		1
 
 /* Holding context data for changing elevator */
 struct elv_change_ctx {
-- 
2.47.0

