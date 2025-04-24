Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E737C178372
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508195; cv=none; b=bX4tYpBIHMSCtI1tGy72GReOcYNm2idEhIgjXcIZb6T6fM5SQ9HgBQvZ7j0ZKIuZOHyRaBd8e1fr5vF55zfFzluCnSdWx9Wo8BiH5tz3ZaqtloRLPZMWzAceaKROAoXYYLl+0pGP1EJpxm/RuAvM48Mzpn45qIK8L4a6S/N8JEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508195; c=relaxed/simple;
	bh=Xumw/D7uNQqm9Weg2KbvhKgjkbZThJ6Lz8mwGc8IBJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biX8H+P/5KLHMlvDCVbaR2sXymi+r8sFzoBj1XqFFsh6dyi3NXRvbBg4VZeMrtznvfNv6eoeVWBP6jt9YYKb+Ztv2/6knB3g7wl2Ssy4rKeYYM+Y4O3qjVCSprP0Ee3QnoX9a5NGjLdCkjYihvhdZHxGBHGV5Olxc5UHS3i8mnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhCzvpLy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhCzvpLy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yih09EU53TCtIOtUG7cIxEhRIIm9eokGB27RzNJUvhI=;
	b=LhCzvpLyxuuPd1R89UY85fUBlVKyxyh/XRBYkC/evjSmNHTXuzaazDzSsLMcoltHhmwWfQ
	fs2TrHxFyiJql2eRM40/n4wbg5OEeLNmdRYJ97SnMMVxOLB+6o1+zi6fAQXuwwH1zGW5vp
	bwAN85CBiis60ElTLMmvVBMS5kj1hF0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-OyNDHx8UNAmlBTwbxtNMNA-1; Thu,
 24 Apr 2025 11:23:11 -0400
X-MC-Unique: OyNDHx8UNAmlBTwbxtNMNA-1
X-Mimecast-MFC-AGG-ID: OyNDHx8UNAmlBTwbxtNMNA_1745508190
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E54C1955DC5;
	Thu, 24 Apr 2025 15:23:10 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E507195608D;
	Thu, 24 Apr 2025 15:23:09 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 19/20] block: move hctx cpuhp add/del out of queue freezing
Date: Thu, 24 Apr 2025 23:21:42 +0800
Message-ID: <20250424152148.1066220-20-ming.lei@redhat.com>
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

Move hctx cpuhp add/del out of queue freezing for not connecting freeze
lock with cpuhp locks, then lockdep warning can be avoided.

This way is safe because both needn't queue to be frozen and scheduler
switch isn't allowed.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e08eda094ae7..add653f84797 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4964,7 +4964,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_realloc_hw_ctxs(set, q);
+		__blk_mq_realloc_hw_ctxs(set, q);
 
 		if (q->nr_hw_queues != set->nr_hw_queues) {
 			int i = prev_nr_hw_queues;
@@ -4988,6 +4988,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_sysfs_register_hctxs(q);
 		blk_mq_debugfs_register_hctxs(q);
+
+		blk_mq_remove_hw_queues_cpuhp(q);
+		blk_mq_add_hw_queues_cpuhp(q);
 	}
 	memalloc_noio_restore(memflags);
 
-- 
2.47.0

