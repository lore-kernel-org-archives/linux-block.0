Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E953327F16A
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755263881; cv=none; b=N4KQY2122P+a7ZowBbJvP0txXSPijvZeY8rboNPM7C8fjTvbO48lAIyOM19LrIP0L8lXHIiMj7KoMXUd99gf9pmf0Tao637Bq5/gMlZw18otfT+AkVV6v7Pn1wILDgpiNgO9XkcNZyAqXYB17dQXRO3dWsD5Ijb7i7HDRut5NUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755263881; c=relaxed/simple;
	bh=KboFJkMc/W0wwDRTV3H1n1aj25pXKG+FewTtiWOUuL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWYKa2R4P1tH4QwEg+YH4BPd9JS6L9sJkQqUU5tsONeY7exjXI7Nq3MbGTv9YmdMAwIFEnjWWrVuF9c4gCop+sJWYpMEQmdmTfdRoQbmeQCN7SekgRcjex/IXtJ3ybDFVJZkyEDyXHsbQXbP7MfB+Sl14EjqL7TOb3Ih8qOYDBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TsdJ3aZH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsdJ3aZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755263878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y4zz3a4BQKxKHbQz9pPAm4vH3Fg+6vq2c4tSs4JeY1g=;
	b=TsdJ3aZHCALr3xxfZ9OzAwbcCjnBlH7gEA/fV8g2cpvmHf7JwYA94Hfs8/H8pWf49lTBra
	P6MZAWtwlPBJWd3jlWXtQs5jZ85KzsHtxvf9nln6+V39+udY45j/WPJESroS2f74Oeucjz
	5eQeXPHM8QJHAbrz2A48cP26QgSHQ+4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294--URDyPLUONWqQ-aOwrt3DQ-1; Fri,
 15 Aug 2025 09:17:55 -0400
X-MC-Unique: -URDyPLUONWqQ-aOwrt3DQ-1
X-Mimecast-MFC-AGG-ID: -URDyPLUONWqQ-aOwrt3DQ_1755263874
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BCD6195608E;
	Fri, 15 Aug 2025 13:17:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21FB7180029A;
	Fri, 15 Aug 2025 13:17:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH V2] blk-mq: fix lockdep warning in __blk_mq_update_nr_hw_queues
Date: Fri, 15 Aug 2025 21:17:37 +0800
Message-ID: <20250815131737.331692-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Commit 5989bfe6ac6b ("block: restore two stage elevator switch while
running nr_hw_queue update") reintroduced a lockdep warning by calling
blk_mq_freeze_queue_nomemsave() before switching the I/O scheduler.

The function blk_mq_elv_switch_none() calls elevator_change_done().
Running this while the queue is frozen causes a lockdep warning.

Fix this by reordering the operations: first, switch the I/O scheduler
to 'none', and then freeze the queue. This ensures that elevator_change_done()
is not called on an already frozen queue. And this way is safe because
elevator_set_none() does freeze queue before switching to none.

Also we still have to rely on blk_mq_elv_switch_back() for switching
back, and it has to cover unfrozen queue case.

Cc: Nilay Shroff <nilay@linux.ibm.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Fixes: 5989bfe6ac6b ("block: restore two stage elevator switch while running nr_hw_queue update")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- fix the issue locally, so patch is simplified

 block/blk-mq.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b67d6c02eceb..ba3a4b77f578 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5033,6 +5033,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	unsigned int memflags;
 	int i;
 	struct xarray elv_tbl, et_tbl;
+	bool queues_frozen = false;
 
 	lockdep_assert_held(&set->tag_list_lock);
 
@@ -5056,9 +5057,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_sysfs_unregister_hctxs(q);
 	}
 
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_freeze_queue_nomemsave(q);
-
 	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
 	 * with the previous scheduler. We will switch back once we are done
@@ -5068,6 +5066,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		if (blk_mq_elv_switch_none(q, &elv_tbl))
 			goto switch_back;
 
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_freeze_queue_nomemsave(q);
+	queues_frozen = true;
 	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
 		goto switch_back;
 
@@ -5091,8 +5092,12 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	}
 switch_back:
 	/* The blk_mq_elv_switch_back unfreezes queue for us. */
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		/* switch_back expects queue to be frozen */
+		if (!queues_frozen)
+			blk_mq_freeze_queue_nomemsave(q);
 		blk_mq_elv_switch_back(q, &elv_tbl, &et_tbl);
+	}
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_sysfs_register_hctxs(q);
-- 
2.50.1

