Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3851DC994
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987821; cv=none; b=equ3M/EQDVRO3RzrKr3W+GipOZi6EAsF1N3A4/5Y8OfA5Miq65Mow8rY5iEa/eOHqhBe7bAyB9SKFSZT6P8sGIIGmg+djYN+vJhYYvq4PVRN9ZLM/3/FFgAxlXKzxMYFvY8qj5zHeljtiOCLMPboOx4uOOtT9bhZ4/4sE8rPHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987821; c=relaxed/simple;
	bh=fADfJ58SKKOe4I4T7vCscygY8mI/hsdSnh5GFd5cyR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCAhYHc01CScqbBr8HrHhe6Hk82dQ+j0y+KQv3HB6qUIXCXK9MEPZQZvZ1quSofv078Vd8CB0pNTkEdIW5xzZ83hUkERgR6w7ZUsLNqmn16keYKLdCIkppfTrCGWBrjPlFBJ0l8BK04Ldle69+U3RecQcVKNCBXUVBLkf8FXHcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVlWlZk2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVlWlZk2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srd591/YPbnDU2xDt6HEaTn8Qde2FWe00GRnbdXtvA0=;
	b=iVlWlZk2pP1YQgdGbh1X/VMuznwmScEbKMq7OVuIc71vPDgoQc0ild5hgbJYCYTSgp/1SI
	pBJurPmj8XgHT+nSgPbBUxJ1I+8AlD618odRkNWawJzWihNNQSsbHMJpvWPg6WJDNHdpn3
	V2I2vzZ+zSuSBOFWIRTObNQp+MPGVAY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-y2EknbmgOTaWVgZim9lbvA-1; Wed,
 30 Apr 2025 00:36:57 -0400
X-MC-Unique: y2EknbmgOTaWVgZim9lbvA-1
X-Mimecast-MFC-AGG-ID: y2EknbmgOTaWVgZim9lbvA_1745987815
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96E1B19560BB;
	Wed, 30 Apr 2025 04:36:55 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C62611956094;
	Wed, 30 Apr 2025 04:36:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 21/24] block: move hctx debugfs/sysfs registering out of freezing queue
Date: Wed, 30 Apr 2025 12:35:23 +0800
Message-ID: <20250430043529.1950194-22-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
index a4bcfce4c4b9..33bffacc33db 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4961,14 +4961,14 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
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
 
@@ -4991,16 +4991,15 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
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

