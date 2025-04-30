Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC5679FE
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987820; cv=none; b=kFVdXhNAmae6FEuZzUA0SzKI9LMJGRzUMMpmYNpWhFHqGhZ444A3+Pfbx02oiXCCbHndILBkoMmFOfrP+DcX59WXjLqb09CZj9pjjEAkRbo3lOv2tuloDbvrcGBJpEH/u3v8+Jv+QeBPAA44MbPsRUHdiovfDIBUz7cuJtjjbuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987820; c=relaxed/simple;
	bh=xlkSSMa37tQlJREq2N/F2S5hoEJYm+62FDA+UV8eAnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ho6roS+k+/as29vpMXc+dXhcUGIhcfnXTk8UcCOIIex/i51BHquA/gjcYOXeOojZawXaazhab+ANNDhSOuS8I5VyJkZlINnW4wqkerzU9kqC8pD7BJPNwYDkPBCf88HYqNHEBivQajQr5F/ZGQpyqqGQ9mnlB3jl54M3OIuV/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YF3e6NW3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YF3e6NW3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PP2rbkmmgVz0z0wAfW4yxpOlTdwkr9x/e4k5k3sT0Mk=;
	b=YF3e6NW3nkqb5Op8+TaBeJ3pFBGb+KNlOxdO9cXclouD/LdxZA+syipnwstRw4n+zCV5NS
	Y8TYRo5JSwMsoDfX96cCYdGzKXjVJh9pn/rvdXOXQl56j7B07WmbFuVjiVoLHn4FuRV7mZ
	6+71vq8EDtoVezHwCd7HSsXSou40LRc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-AuEj_MmeNGq1stMgSeh0Ng-1; Wed,
 30 Apr 2025 00:36:47 -0400
X-MC-Unique: AuEj_MmeNGq1stMgSeh0Ng-1
X-Mimecast-MFC-AGG-ID: AuEj_MmeNGq1stMgSeh0Ng_1745987805
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD1A91800873;
	Wed, 30 Apr 2025 04:36:44 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 18018180045C;
	Wed, 30 Apr 2025 04:36:43 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 18/24] block: fail to show/store elevator sysfs attribute if elevator is dying
Date: Wed, 30 Apr 2025 12:35:20 +0800
Message-ID: <20250430043529.1950194-19-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Prepare for moving elv_register[unregister]_queue out of elevator_lock
& queue freezing, so we may have to call elv_unregister_queue() after
elevator ->exit() is called, then there is small window for user to
call into ->show()/store(), and user-after-free can be caused.

Fail to show/store elevator sysfs attribute if elevator is dying by
adding one new flag of ELEVATOR_FLAG_DYNG, which is protected by
elevator ->sysfs_lock.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c |  1 +
 block/elevator.c     | 10 ++++++----
 block/elevator.h     |  1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

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
index 86e448bc12ae..fd0bcf22aaee 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -418,14 +418,15 @@ elv_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 {
 	const struct elv_fs_entry *entry = to_elv(attr);
 	struct elevator_queue *e;
-	ssize_t error;
+	ssize_t error = -ENODEV;
 
 	if (!entry->show)
 		return -EIO;
 
 	e = container_of(kobj, struct elevator_queue, kobj);
 	mutex_lock(&e->sysfs_lock);
-	error = entry->show(e, page);
+	if (!test_bit(ELEVATOR_FLAG_DYING, &e->flags))
+		error = entry->show(e, page);
 	mutex_unlock(&e->sysfs_lock);
 	return error;
 }
@@ -436,14 +437,15 @@ elv_attr_store(struct kobject *kobj, struct attribute *attr,
 {
 	const struct elv_fs_entry *entry = to_elv(attr);
 	struct elevator_queue *e;
-	ssize_t error;
+	ssize_t error = -ENODEV;
 
 	if (!entry->store)
 		return -EIO;
 
 	e = container_of(kobj, struct elevator_queue, kobj);
 	mutex_lock(&e->sysfs_lock);
-	error = entry->store(e, page, length);
+	if (!test_bit(ELEVATOR_FLAG_DYING, &e->flags))
+		error = entry->store(e, page, length);
 	mutex_unlock(&e->sysfs_lock);
 	return error;
 }
diff --git a/block/elevator.h b/block/elevator.h
index 9198676644a9..76a90a1b7ed6 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -121,6 +121,7 @@ struct elevator_queue
 };
 
 #define ELEVATOR_FLAG_REGISTERED	0
+#define ELEVATOR_FLAG_DYING		1
 
 /*
  * block elevator interface
-- 
2.47.0

