Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D600B1C6FF7
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508183; cv=none; b=iINqfXKBwfpCfx4nAKB3aBOJDIwUbPv/KhtlKNWbirQ3kRIjqAeP1LK9+kb037JFNp62C7sOAYldoIsam1I2eTkuY74mLzNYU1NCKTK7KWETjqD+B+HOdQKA1qd637ksnEzA637GD8J/e//bXAzASxOyTcb67A7hmhdp5YNDR2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508183; c=relaxed/simple;
	bh=1hGH9oRZCN2j/qbjtdnvi2aSAui5xIu50W9gI+t4BZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZ3gWQ6gpmRoP2Otix1eaRJQMX3SC8UeAuthDVgnmv4KeJAqzeOMt5Ts03uuZKWk/B40KXkNHRFT7eu+rM5ZkuaL65NTuqqeUfprijwAhSmewesekRv/STyQTMZgkxS+fFo9HBG/y0nULlIws7tdgZEqTH+WYxSeHr5AL9ETrR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9p3UWpF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9p3UWpF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGJdeK0H078HumIUeju6hjuKG5yTrR1JeX8PtnYcOf4=;
	b=W9p3UWpFQMcwMV9Axkm8ltS0ICivKaOWFpwo6OEnhBXr1YMyjG7PggMfa5zqlwy16XFIRG
	eWyr47nr1z7pkZQYFNK9S3DXmS1lkXyVnM63B+ekpYYVlLQanMCedmcYQaMk4YxADYvQDo
	/e7eEhN1kESRVZdFRMYEMUlJAGQVsgg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-cIR-XOBwMTanpsGOar06IA-1; Thu,
 24 Apr 2025 11:22:56 -0400
X-MC-Unique: cIR-XOBwMTanpsGOar06IA-1
X-Mimecast-MFC-AGG-ID: cIR-XOBwMTanpsGOar06IA_1745508174
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C611319560AB;
	Thu, 24 Apr 2025 15:22:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA73C30001A2;
	Thu, 24 Apr 2025 15:22:53 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 15/20] block: fail to show/store elevator sysfs attribute if elevator is dying
Date: Thu, 24 Apr 2025 23:21:38 +0800
Message-ID: <20250424152148.1066220-16-ming.lei@redhat.com>
In-Reply-To: <20250424152148.1066220-1-ming.lei@redhat.com>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
index dde8732b7a26..48f2f202af98 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -426,7 +426,10 @@ elv_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 
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
@@ -444,7 +447,10 @@ elv_attr_store(struct kobject *kobj, struct attribute *attr,
 
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

