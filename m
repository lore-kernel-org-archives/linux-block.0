Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04EB1F30A4
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454797; cv=none; b=W4Q6m7FbUNhdPv47E8nG7BiQe/xT8OKjYobgyMwNwDZEuN00NecNyYN4rQ+GoK61X5Os7/FoESALl5llQPvZORYJQKGpB+tZqpBS/MR8qzVc88dT321V+vt5QiaTLJlSfaRF6UMWP+zU2Dvum+7wc5ng5y+FU4sX1SObj+qdIio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454797; c=relaxed/simple;
	bh=dcnYdD7cdnmyJ8fhEjzn3O6a/CmIO8NEs/Zqc/wOtG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mx6h5odxIgthryermn8Bi1Zpuilg79WhmrID5bzuF9MjS+/c0wwwwVIUl+LYr1PDmrsygIdvlvyn/FyInTRddTG3p03I6ou8wbiMbPJosjqyZ4xuRI9xNjPZo8Fuq7OVHzPuN0YUHcGDWOEU4YGUwDah7tSCDnH16NxwkZTMp2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ex9K3mTq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ex9K3mTq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlzXhPuBKdnom5GbIQztIPXgpkr+CYcvnfotiZjqZFA=;
	b=ex9K3mTqmy3U9r1c03MpMdXQqhjw4iPWvbqGtwTxGCwY+Rs1oJFxWI3wgWd8nmYbkUbXvh
	s8qAa7/7taPtZaz4O/QTcZIyOYP5n7aTgSBMcTpnSJCu51z4hSjz4hxHyLr9Hm/qyyOaqr
	EesMoPV+6r9NPq43QqQ04Bf9UIDDCao=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-mv3olhrcNA-B-LfGxmnNVQ-1; Mon,
 05 May 2025 10:19:51 -0400
X-MC-Unique: mv3olhrcNA-B-LfGxmnNVQ-1
X-Mimecast-MFC-AGG-ID: mv3olhrcNA-B-LfGxmnNVQ_1746454790
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE31119560BC;
	Mon,  5 May 2025 14:19:49 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D1999180036E;
	Mon,  5 May 2025 14:19:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 22/25] block: move hctx debugfs/sysfs registering out of freezing queue
Date: Mon,  5 May 2025 22:18:00 +0800
Message-ID: <20250505141805.2751237-23-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Move hctx debugfs/sysfs register out of freezing queue in
__blk_mq_update_nr_hw_queues(), so that the following lockdep dependency
can be killed:

	#2 (&q->q_usage_counter(io)#16){++++}-{0:0}:
	#1 (fs_reclaim){+.+.}-{0:0}:
	#0 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}: //debugfs

And registering/un-registering hctx debugfs/sysfs does not require queue to
be frozen:

- hctx sysfs attributes show() are drained when removing kobject, and
  there isn't store() implementation for hctx sysfs attributes

- debugfs entry read() is drained too when removing debugfs directory,
  and there isn't write() implementation for hctx debugfs too

- so it is safe to register/unregister hctx sysfs/debugfs without
  freezing queue because the cod paths changes nothing, and we just
  need to keep hctx live

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d1b5b75840eb..32526d120bf4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5007,14 +5007,14 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		return;
 
 	memflags = memalloc_noio_save();
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_freeze_queue_nomemsave(q);
-
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_debugfs_unregister_hctxs(q);
 		blk_mq_sysfs_unregister_hctxs(q);
 	}
 
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_freeze_queue_nomemsave(q);
+
 	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
 		goto reregister;
 
@@ -5037,16 +5037,15 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_map_swqueue(q);
 	}
 
+	/* elv_update_nr_hw_queues() unfreeze queue for us */
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		elv_update_nr_hw_queues(q);
+
 reregister:
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_sysfs_register_hctxs(q);
 		blk_mq_debugfs_register_hctxs(q);
 	}
-
-	/* elv_update_nr_hw_queues() unfreeze queue for us */
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		elv_update_nr_hw_queues(q);
-
 	memalloc_noio_restore(memflags);
 
 	/* Free the excess tags when nr_hw_queues shrink. */
-- 
2.47.0

