Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D917E1DDC1E
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508190; cv=none; b=V6T/vS9GVZ3NYj3Q8na69OdzO3YtxIT/AD9yuf7dYv2knJ3WMwJ0X4GaKgVWte5aQAcRXRyoDU4ArwiR9hP44jHHZrpB/4edWLBwLybHv2Oat0ujnxuAIDhLN0faWKdCtQWNkUghiwtXS0HiCLcd4DfAdgJ9oE2XusRfTp3pJ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508190; c=relaxed/simple;
	bh=NWReOZSd+Z9EWqLcuHH+zEbCwDr0hUrL/NnyxE9pdPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CplwBXb0z2FRzqf5VOYHAXJoUqRjUVxp08CaabfL6BBzuIw9bB8v/lDiAV8E4M03teBopwzsNgUz13tXVwuCpa3DYMA5lMiaJB0+Fe7MGv9Wt6H7tk34ijTCkgOYAFm329rXEuBR/eRIn7ddhzs97PgXtsACNGpAcdMdS6/nsRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPj6BvWM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPj6BvWM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7tcXAB58jQLUsR2wF8OT5Pt9dgPV9DB1jZey0AnfxI=;
	b=EPj6BvWMAiJ7KWGomUYNXMarLY4fHWx62cwoeneDeq/5FBgl1zxiJ8iKi5TpaT+uObTahQ
	y1I1Es5sjljohL1iMEfiFbx79+Yjtkm14M5LrOXWnDjJRtZ4HOnlrVu20xvPjHkL9nel0Z
	/n10u/cdS1qjq+OI7dq/WQYCpuVvXEY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-aUHq7SflP_WKdMJfh2wqNA-1; Thu,
 24 Apr 2025 11:23:04 -0400
X-MC-Unique: aUHq7SflP_WKdMJfh2wqNA-1
X-Mimecast-MFC-AGG-ID: aUHq7SflP_WKdMJfh2wqNA_1745508183
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E26EC19560A1;
	Thu, 24 Apr 2025 15:23:02 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C7584195608D;
	Thu, 24 Apr 2025 15:23:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 17/20] block: move debugfs/sysfs register out of freezing queue
Date: Thu, 24 Apr 2025 23:21:40 +0800
Message-ID: <20250424152148.1066220-18-ming.lei@redhat.com>
In-Reply-To: <20250424152148.1066220-1-ming.lei@redhat.com>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Move debugfs/sysfs register out of freezing queue in
__blk_mq_update_nr_hw_queues(), so that the following lockdep dependency
can be killed:

	#2 (&q->q_usage_counter(io)#16){++++}-{0:0}:
	#1 (fs_reclaim){+.+.}-{0:0}:
	#0 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}: //debugfs

And registering/un-registering debugfs/sysfs does not require queue to be
frozen.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ecbf73773ea..420150eb5a45 100644
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

