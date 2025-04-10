Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401AD14658C
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291913; cv=none; b=t8l09jCgR1moznWxpSR46kohAtzJcq8qZHRoPPkVnGWRivYD7woLcnYrfTUGcBKBazn/OIqsxCINMQw18mdl4FRizDIkoAp6oM1BShSOEVvZIgEn3IJ3fWKkaCmCJUgc3wX+/0o+2gn3I06qtEb3niELrAzlck9op/jwWGlBMTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291913; c=relaxed/simple;
	bh=zvqKWt+3xoyEHl+hQxKvpTEV0brKUKAKJYo6GsnHYkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFQjM4P6hOkGUQK8I7lCIY3ZTAVo8waZVql/QTPppIjqBPYYZ7wMLWXJ1bjgwCIhMFBbBji9/r4SmEYHVZTJE2/KdqFNUGaHc8z2uAHm4sZbiFcNY9fhOLeuKlhWqcSrV+IvQiOvV6XBku+NXMyZpfhzftEF/x3wsJu/Si6qjAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AdnU1qQ0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdnU1qQ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744291911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tyDZz+LhXObHxXJHusskvh98XURw3zdwnCWMduKl+k=;
	b=AdnU1qQ0LIpAWxXfEDfSQu0BxH4POAs/Lgmq6yj1Q92HWpAb4z1KNEfDvzS7iWWEIv4Zqa
	DBJ7nvpv2b75DZBbqWK/+q0aj0xv6eW8ld/ro4+K/NeCXxDQvEyYlViMTkY/EGJ+rSRHOy
	5Fq3VLq9bKE/5eDBqbQ279uc8bsklmw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-mw6AmN2QP_O8QBfymRWR1Q-1; Thu,
 10 Apr 2025 09:31:47 -0400
X-MC-Unique: mw6AmN2QP_O8QBfymRWR1Q-1
X-Mimecast-MFC-AGG-ID: mw6AmN2QP_O8QBfymRWR1Q_1744291906
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36E3C180AF73;
	Thu, 10 Apr 2025 13:31:46 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B8903001D15;
	Thu, 10 Apr 2025 13:31:44 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 12/15] block: move debugfs/sysfs register out of freezing queue
Date: Thu, 10 Apr 2025 21:30:24 +0800
Message-ID: <20250410133029.2487054-13-ming.lei@redhat.com>
In-Reply-To: <20250410133029.2487054-1-ming.lei@redhat.com>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Move debugfs/sysfs register out of freezing queue in
__blk_mq_update_nr_hw_queues(), so that the following lockdep dependency
can be killed:

	#2 (&q->q_usage_counter(io)#16){++++}-{0:0}:
	#1 (fs_reclaim){+.+.}-{0:0}:
	#0 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}: //debugfs

And registering/un-registering debugfs/sysfs does not require queue to be
frozen.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7219b01764da..0fb72a698d77 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4947,15 +4947,15 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
 		return;
 
-	memflags = memalloc_noio_save();
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_freeze_queue_nomemsave(q);
-
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_debugfs_unregister_hctxs(q);
 		blk_mq_sysfs_unregister_hctxs(q);
 	}
 
+	memflags = memalloc_noio_save();
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_freeze_queue_nomemsave(q);
+
 	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
 		goto reregister;
 
@@ -4978,12 +4978,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_map_swqueue(q);
 	}
 
-reregister:
-	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_sysfs_register_hctxs(q);
-		blk_mq_debugfs_register_hctxs(q);
-	}
-
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		struct elev_change_ctx ctx = {
 			.name	= "none",
@@ -5003,6 +4997,12 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	}
 	memalloc_noio_restore(memflags);
 
+reregister:
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		blk_mq_sysfs_register_hctxs(q);
+		blk_mq_debugfs_register_hctxs(q);
+	}
+
 	/* Free the excess tags when nr_hw_queues shrink. */
 	for (i = set->nr_hw_queues; i < prev_nr_hw_queues; i++)
 		__blk_mq_free_map_and_rqs(set, i);
-- 
2.47.0

