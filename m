Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237462153ED
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994317; cv=none; b=gcRALL6X69RfbIUqYNxL5yKAfuMvSHqlFvEfvQVNuBD/nwzEPfjj1vl73f+jmsCkbFienMUZowtq84LyK8PPf30S8oZgImqs5qlQVNPLb8XZZDAAR3zBfdcPjVgcZ4GxMlbdeXRvyQ8Ju9aPmKRCwzpP0QHq3LWNXj3IUDduhrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994317; c=relaxed/simple;
	bh=veltcLZO+kYibCq4cuTVU8/d5uglnZrkyYQ2QeLEU20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOMzlfeKLyoh2PDQ3VsHszs6ZVP4RNVJm9+Ril1pZEGD8oOWqwQ/pxmPx7BpRGFFGdeVwZeC3DWpT5Entrh0vStXiszx5PI1DLLf1G0tcwFI+4Dmx3BSWks8FOkVYmKBsc3x/Vc/Pafqoc2ZOy9PlHKXFTnvl+I0VTbe/3QSLUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DARrR4yq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DARrR4yq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5umzoEAyWPE4xSTnNJBk8dtRp7sY6P5MKOuIVnJhpBg=;
	b=DARrR4yqhwX4HqPr6t4oQv1JP49kWdFu4zFyEC8TntULr+Saqf5cioQPX/w9uSCieb0foQ
	nl90pO5EReMEdtqfHlYxpdFlNhtVUfRa0rkQBqH7/KzP8FcqGEYhi199ZHy+TO0vDyK9wq
	Kqbr+rzCtklzS8MMYlqO2ctPc5zHr+4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-2aaYd9ulMpqvhkhyGTUJnA-1; Fri,
 18 Apr 2025 12:38:31 -0400
X-MC-Unique: 2aaYd9ulMpqvhkhyGTUJnA-1
X-Mimecast-MFC-AGG-ID: 2aaYd9ulMpqvhkhyGTUJnA_1744994310
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 974371955DCC;
	Fri, 18 Apr 2025 16:38:30 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B39D91800362;
	Fri, 18 Apr 2025 16:38:29 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 17/20] block: move debugfs/sysfs register out of freezing queue
Date: Sat, 19 Apr 2025 00:36:58 +0800
Message-ID: <20250418163708.442085-18-ming.lei@redhat.com>
In-Reply-To: <20250418163708.442085-1-ming.lei@redhat.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
index 9a361a173a8e..8d08127e40be 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4946,15 +4946,15 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
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
 
@@ -4977,12 +4977,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_map_swqueue(q);
 	}
 
-reregister:
-	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_sysfs_register_hctxs(q);
-		blk_mq_debugfs_register_hctxs(q);
-	}
-
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		/*
 		 * nr_hw_queues is changed and elevator data depends on
@@ -5006,6 +5000,12 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
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

