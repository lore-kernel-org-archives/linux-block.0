Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B561DE2B4
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987786; cv=none; b=DBy2GZ9eBkuMdvAh6x5UJf+oYvDR5ulXfWDJ9rqceN9K7B1ldlc+JyhCtGfJq3yFf4Mp+LVXhPPgsbzWInqve8A4umUiGRz4urJSLetBLXB/RQUnVCmsEOXYrHnEdUUFTzDEF11IVuj2UKRf9D/NPh2iFkTNi85FPQvqGMC9BYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987786; c=relaxed/simple;
	bh=WXT5dwIJeO40dxfTltFZPcSY7qSQ2h3aO+Ad5ILZb/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoRdc9MfZFpV41usWhRkPgjQCBv6zmJ8ppH71bPPXZZxQN0SG1ssR/WbTmXfmi2TUI1LTXPFhk7EUCGM3sbAevTjgkTHcyvWXWeLY5KhKGBn8ZtgPe1+qVfKM1GgjClSIGsFUWaQSAOsUYmDwcxFAsae9kcb6BSyaDHZPKZkqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTPURi/g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTPURi/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s1DI+bBmO8Ix6Ftz2TOn5MXtteAMOBekWCrPueQ3lPQ=;
	b=hTPURi/g6JqSXgAA8VznuYlhNgS1ZKlH2i4wr6GQd43qyoXUsENB/r2uSlvbMpnwl8A+wK
	C0BRj+RIpbDlfyJyE4E1BNOXyiefGSO5ZWBg0Zg/kS3qLEYTm/XZY7xBKNVDqYnJ0Y5Vdu
	ihUPlaY+Ru+PLkZuCcbjTJMn8ulge3Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-_-A273vzP7qWTNoIg5nE5A-1; Wed,
 30 Apr 2025 00:36:20 -0400
X-MC-Unique: _-A273vzP7qWTNoIg5nE5A-1
X-Mimecast-MFC-AGG-ID: _-A273vzP7qWTNoIg5nE5A_1745987779
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5547C1800360;
	Wed, 30 Apr 2025 04:36:19 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8555A180045C;
	Wed, 30 Apr 2025 04:36:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 11/24] block: move blk_queue_registered() check into elv_iosched_store()
Date: Wed, 30 Apr 2025 12:35:13 +0800
Message-ID: <20250430043529.1950194-12-ming.lei@redhat.com>
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

Move blk_queue_registered() check into elv_iosched_store() and prepare
for using elevator_change() for covering any kind of elevator change in
adding/deleting disk and updating nr_hw_queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index df3e59107a2a..ac72c4f5a542 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -676,10 +676,6 @@ int elevator_switch(struct request_queue *q, const char *name)
  */
 static int elevator_change(struct request_queue *q, const char *elevator_name)
 {
-	/* Make sure queue is not in the middle of being removed */
-	if (!blk_queue_registered(q))
-		return -ENOENT;
-
 	if (q->elevator && elevator_match(q->elevator->type, elevator_name))
 		return 0;
 
@@ -708,6 +704,10 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	struct request_queue *q = disk->queue;
 	struct blk_mq_tag_set *set = q->tag_set;
 
+	/* Make sure queue is not in the middle of being removed */
+	if (!blk_queue_registered(q))
+		return -ENOENT;
+
 	/*
 	 * If the attribute needs to load a module, do it before freezing the
 	 * queue to ensure that the module file can be read when the request
-- 
2.47.0

