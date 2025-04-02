Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DB920AF8B
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 04:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743568799; cv=none; b=iyepTAjEEgKGME1fA+9NujT4IcffjMIYfxcZzF2hpuCO0Q/SnH1aF+C2uwID7/JD/cNEFkYCTc8uJyb4ILeOg8ebMhRx2km4PrEHJ0Y4KaialYThuMAkS9McXBZZFkDb4g2fOGKQWXy5bNC9e3+xUSTeRh8jGsB1AIQAs96K0nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743568799; c=relaxed/simple;
	bh=+1+zdgKGYW7xz7LawbksygupRRK8wv8dg7Ex7bYR5gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGhQdqSd+whus7/1gPG80XUO/I7bbswNgETiecNjToV+6TV5/BjmwLoS8XVN4kiRj18R8WpGUsIfr82Dd1ty1TxeKKPggq+J8mX3fSQ7bg/vxzOn3Ca7zWxcnM/O4CrJvfNrnU6+JshWKMLDnHTeZomb3JA10FHpahQg7xmPylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/kWxE5O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/kWxE5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743568796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3rG9+zq7p4OqKB+uNAMp87wtJfJfzV+yAGOnfGCJYo=;
	b=f/kWxE5OoILcWr4MG4Q5wFRYxmID0VRjC9pLaEWiPd7DjsFvRUu9syeNFtSszTLbZktSYr
	H8KXpFlurs9yc2cVga0o79VbY8e9OAoJSiYH5MMPPYIlXQN33Pl7gF8dWJLKz2I7OE7DLq
	9NI7JRTudLHbrxcZQGG9sTXX/ScCH8Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-HBnVHgQQPpyJp9G9xOem6g-1; Wed,
 02 Apr 2025 00:39:51 -0400
X-MC-Unique: HBnVHgQQPpyJp9G9xOem6g-1
X-Mimecast-MFC-AGG-ID: HBnVHgQQPpyJp9G9xOem6g_1743568790
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC7AF19560B3;
	Wed,  2 Apr 2025 04:39:49 +0000 (UTC)
Received: from localhost (unknown [10.72.120.17])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E56C1800BE2;
	Wed,  2 Apr 2025 04:39:47 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
Subject: [PATCH 3/3] block: use blk_mq_no_io() for avoiding lock dependency
Date: Wed,  2 Apr 2025 12:38:49 +0800
Message-ID: <20250402043851.946498-4-ming.lei@redhat.com>
In-Reply-To: <20250402043851.946498-1-ming.lei@redhat.com>
References: <20250402043851.946498-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Use blk_mq_no_io() to prevent IO from entering queue for avoiding lock
dependency between freeze lock and elevator lock, and we have got many
such reports:

Reported-by: syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-block/67e6b425.050a0220.2f068f.007b.GAE@google.com/
Reported-by: Valdis Klētnieks <valdis.kletnieks@vt.edu>
Closes: https://lore.kernel.org/linux-block/7755.1743228130@turing-police/#t
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c    | 7 ++-----
 block/blk-sysfs.c | 8 ++++----
 block/elevator.c  | 4 ++--
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 075ee51066b3..022d8139910d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4882,9 +4882,6 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	int ret;
 	unsigned long i;
 
-	if (WARN_ON_ONCE(!q->mq_freeze_depth))
-		return -EINVAL;
-
 	if (!set)
 		return -EINVAL;
 
@@ -5025,7 +5022,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	memflags = memalloc_noio_save();
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_freeze_queue_nomemsave(q);
+		blk_mq_enter_no_io(q);
 
 	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
@@ -5074,7 +5071,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_elv_switch_back(&head, q);
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_unfreeze_queue_nomemrestore(q);
+		blk_mq_exit_no_io(q);
 	memalloc_noio_restore(memflags);
 
 	/* Free the excess tags when nr_hw_queues shrink. */
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index a2882751f0d2..e866875c17be 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -76,7 +76,7 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 	if (ret < 0)
 		return ret;
 
-	memflags = blk_mq_freeze_queue(q);
+	memflags = blk_mq_enter_no_io_memsave(q);
 	mutex_lock(&q->elevator_lock);
 	if (nr < BLKDEV_MIN_RQ)
 		nr = BLKDEV_MIN_RQ;
@@ -85,7 +85,7 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 	if (err)
 		ret = err;
 	mutex_unlock(&q->elevator_lock);
-	blk_mq_unfreeze_queue(q, memflags);
+	blk_mq_exit_no_io_memrestore(q, memflags);
 	return ret;
 }
 
@@ -592,7 +592,7 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 	if (val < -1)
 		return -EINVAL;
 
-	memflags = blk_mq_freeze_queue(q);
+	memflags = blk_mq_enter_no_io_memsave(q);
 	mutex_lock(&q->elevator_lock);
 
 	rqos = wbt_rq_qos(q);
@@ -623,7 +623,7 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 	blk_mq_unquiesce_queue(q);
 out:
 	mutex_unlock(&q->elevator_lock);
-	blk_mq_unfreeze_queue(q, memflags);
+	blk_mq_exit_no_io_memrestore(q, memflags);
 
 	return ret;
 }
diff --git a/block/elevator.c b/block/elevator.c
index 4d3a8f996c91..c9cb8386bf5e 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -724,13 +724,13 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 
 	elv_iosched_load_module(name);
 
-	memflags = blk_mq_freeze_queue(q);
+	memflags = blk_mq_enter_no_io_memsave(q);
 	mutex_lock(&q->elevator_lock);
 	ret = elevator_change(q, name);
 	if (!ret)
 		ret = count;
 	mutex_unlock(&q->elevator_lock);
-	blk_mq_unfreeze_queue(q, memflags);
+	blk_mq_exit_no_io_memrestore(q, memflags);
 	return ret;
 }
 
-- 
2.47.0

