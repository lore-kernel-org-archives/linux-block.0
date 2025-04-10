Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F748633A
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291887; cv=none; b=Bf5X3DGzLHTFqUTb8FzOyJ6DCgqcQlioeMDiAT3TTZILFp4BFzru+/L5qs5GTI5qRDrdiKUP84BVXChDWsPcBobx7aFG6eMJG8pbVp2rT3og+NVmkch5//DBreRXh2qTMtR3R6CX/RTCGqdwcUTt2OhbQMI6cjoo956eVpsNs6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291887; c=relaxed/simple;
	bh=yKoRJYYXrgSR4iQBbtWnOQyarXYrui4zmdZENlBIUMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wt9bUSoJBRuZQYPBNfwwykhsARYiWn/m69ZRF2Qk746j5p1LFk9X32vGxGctBL6abWKYVq981I1jeUg8DUo8vdqNXs+Q+C/IRgvt6lRCMy7r6N6UlztW6XOgMbakD2PAXNMhCiGu6LDgrJVNdHledBvOaJzIaVPLjg5qrRmNB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9knUBX/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9knUBX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744291884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6yhpuePknjGj4Q76z4Q/TzgSmmjJhZfiXg0Eft7+eg=;
	b=K9knUBX/etkaYelj5x9DUzkG8Q7mwL8SXI2t+9S5TmUVDrSjtleRk2qh4ft/cYcgJwVupW
	jhtGC2fvHpL4aEJLfjqA8OYo61hDZzg4ju0NG4fWz0OINDAkrAU6lBA4uJXVb3s3aAhmqO
	7sKqdNhiVudj+xBNfJyJQjWFPzEbp+s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-HE-8IBffN3CvoIJISHJonA-1; Thu,
 10 Apr 2025 09:31:21 -0400
X-MC-Unique: HE-8IBffN3CvoIJISHJonA-1
X-Mimecast-MFC-AGG-ID: HE-8IBffN3CvoIJISHJonA_1744291878
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51674180025C;
	Thu, 10 Apr 2025 13:31:18 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EDBD180B486;
	Thu, 10 Apr 2025 13:31:16 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 06/15] block: add helper of elevator_change()
Date: Thu, 10 Apr 2025 21:30:18 +0800
Message-ID: <20250410133029.2487054-7-ming.lei@redhat.com>
In-Reply-To: <20250410133029.2487054-1-ming.lei@redhat.com>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add elevator_change() to simplify elv_iosched_store() a bit, and the new
helper will be used for unifying all scheduler change.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 52 +++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 612fa2bdd40d..e028d2ff9624 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -53,6 +53,8 @@ static LIST_HEAD(elv_list);
  */
 #define rq_hash_key(rq)		(blk_rq_pos(rq) + blk_rq_sectors(rq))
 
+static int elevator_change(struct request_queue *q, const char *name);
+
 /*
  * Query io scheduler to see if the current process issuing bio may be
  * merged with rq.
@@ -681,10 +683,6 @@ int __elevator_change(struct request_queue *q, const char *elevator_name,
 	struct elevator_type *e;
 	int ret;
 
-	/* Make sure queue is not in the middle of being removed */
-	if (!blk_queue_registered(q))
-		return -ENOENT;
-
 	if (!strncmp(elevator_name, "none", 4)) {
 		if (q->elevator)
 			elevator_disable(q);
@@ -703,6 +701,29 @@ int __elevator_change(struct request_queue *q, const char *elevator_name,
 	return ret;
 }
 
+static int elevator_change(struct request_queue *q, const char *name)
+{
+	int ret, idx;
+	unsigned int memflags;
+	struct blk_mq_tag_set *set = q->tag_set;
+
+	idx = srcu_read_lock(&set->update_nr_hwq_srcu);
+
+	if (set->flags & BLK_MQ_F_UPDATE_HW_QUEUES) {
+		ret = -EBUSY;
+		goto exit;
+	}
+
+	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->elevator_lock);
+	ret = __elevator_change(q, name, false);
+	mutex_unlock(&q->elevator_lock);
+	blk_mq_unfreeze_queue(q, memflags);
+exit:
+	srcu_read_unlock(&set->update_nr_hwq_srcu, idx);
+	return ret;
+}
+
 static void elv_iosched_load_module(char *elevator_name)
 {
 	struct elevator_type *found;
@@ -718,12 +739,10 @@ static void elv_iosched_load_module(char *elevator_name)
 ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 			  size_t count)
 {
+	struct request_queue *q = disk->queue;
 	char elevator_name[ELV_NAME_MAX];
 	char *name;
-	int ret, idx;
-	unsigned int memflags;
-	struct request_queue *q = disk->queue;
-	struct blk_mq_tag_set *set = q->tag_set;
+	int ret;
 
 	/*
 	 * If the attribute needs to load a module, do it before freezing the
@@ -735,22 +754,13 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 
 	elv_iosched_load_module(name);
 
-	idx = srcu_read_lock(&set->update_nr_hwq_srcu);
-
-	if (set->flags & BLK_MQ_F_UPDATE_HW_QUEUES) {
-		ret = -EBUSY;
-		goto exit;
-	}
+	/* Make sure queue is not in the middle of being removed */
+	if (!blk_queue_registered(q))
+		return -ENOENT;
 
-	memflags = blk_mq_freeze_queue(q);
-	mutex_lock(&q->elevator_lock);
-	ret = __elevator_change(q, name, false);
+	ret = elevator_change(q, name);
 	if (!ret)
 		ret = count;
-	mutex_unlock(&q->elevator_lock);
-	blk_mq_unfreeze_queue(q, memflags);
-exit:
-	srcu_read_unlock(&set->update_nr_hwq_srcu, idx);
 	return ret;
 }
 
-- 
2.47.0

