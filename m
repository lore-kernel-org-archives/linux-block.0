Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB4C30CDA5
	for <linux-block@vger.kernel.org>; Sat, 30 Aug 2025 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756520330; cv=none; b=AkXwtQEEYlCT5517YaJDw6e/0YCMuaaCsOShnjPN9BD/wMfvmXFvX5iJJ7w753emPLffb+CAHKMsMhsQUcqzEdswvFgxUl20K4uyE5FYI2PA766ABisIURwTCL06N7+tejKRYmlXJeqmgswPCn/KYN2AVgkPaPuZhR0oKCmHmWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756520330; c=relaxed/simple;
	bh=WlqXuVE5yAzN93Yfdd1Dm+uLsNYwqjJ2ofYHxLHHwGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ye8QBSqULJB5z9CdZPsWoehORQwFrMfLIu6cwFQvFHavCAokvw6XAqrEBFrVJXfVadnqZmmaObrb1D48F8d2JzXQu2BupnVzEZn0ObBTc2l2pB5x1APbPR5aeT4Sj3qRrWGxnLg9wO6vgZ2t7qwXZ1wtf5RdJ2jVBLCwQnVAU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UH026Vbo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UH026Vbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756520328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w48k28YJtaZ4GOhZqD1JXzRin7EcLJzhgP5d3/17v+g=;
	b=UH026Vbom4/h3AKwNzJWczw6qgcby/DteQaDNW1LFozlkpD2HizMhDJT0Ohvyx7rk5GKb5
	zJqglLj8R1fV4cb3DPc5VuH/s+Qxzy/ivASE4nKqFQ9Hsux8NlsLPq9MrdvVOtaIKILaUO
	MqJHkeIcnJzoh1pl6i8MvTaa0/ZOrXM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-uOFdDUA6ONC8TRPqHRWMsA-1; Fri,
 29 Aug 2025 22:18:44 -0400
X-MC-Unique: uOFdDUA6ONC8TRPqHRWMsA-1
X-Mimecast-MFC-AGG-ID: uOFdDUA6ONC8TRPqHRWMsA_1756520323
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB577180048E;
	Sat, 30 Aug 2025 02:18:42 +0000 (UTC)
Received: from localhost (unknown [10.72.116.21])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 55E161956048;
	Sat, 30 Aug 2025 02:18:40 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Yu Kuai <yukuai3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/5] blk-mq: Pass tag_set to blk_mq_free_rq_map/tags
Date: Sat, 30 Aug 2025 10:18:20 +0800
Message-ID: <20250830021825.2859325-3-ming.lei@redhat.com>
In-Reply-To: <20250830021825.2859325-1-ming.lei@redhat.com>
References: <20250830021825.2859325-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

To prepare for converting the tag->rqs freeing to be SRCU-based, the
tag_set is needed in the freeing helper functions.

This patch adds 'struct blk_mq_tag_set *' as the first parameter to
blk_mq_free_rq_map() and blk_mq_free_tags(), and updates all their call
sites.

This allows access to the tag_set's SRCU structure in the next step,
which will be used to free the tag maps after a grace period.

No functional change is intended in this patch.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c |  2 +-
 block/blk-mq.c     | 10 +++++-----
 block/blk-mq.h     |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d880c50629d6..6fce42851f03 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -576,7 +576,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	return NULL;
 }
 
-void blk_mq_free_tags(struct blk_mq_tags *tags)
+void blk_mq_free_tags(struct blk_mq_tag_set *set, struct blk_mq_tags *tags)
 {
 	sbitmap_queue_free(&tags->bitmap_tags);
 	sbitmap_queue_free(&tags->breserved_tags);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cfd4bbc161ac..b8f13e321516 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3491,14 +3491,14 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	}
 }
 
-void blk_mq_free_rq_map(struct blk_mq_tags *tags)
+void blk_mq_free_rq_map(struct blk_mq_tag_set *set, struct blk_mq_tags *tags)
 {
 	kfree(tags->rqs);
 	tags->rqs = NULL;
 	kfree(tags->static_rqs);
 	tags->static_rqs = NULL;
 
-	blk_mq_free_tags(tags);
+	blk_mq_free_tags(set, tags);
 }
 
 static enum hctx_type hctx_idx_to_type(struct blk_mq_tag_set *set,
@@ -3560,7 +3560,7 @@ static struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 err_free_rqs:
 	kfree(tags->rqs);
 err_free_tags:
-	blk_mq_free_tags(tags);
+	blk_mq_free_tags(set, tags);
 	return NULL;
 }
 
@@ -4107,7 +4107,7 @@ struct blk_mq_tags *blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
 
 	ret = blk_mq_alloc_rqs(set, tags, hctx_idx, depth);
 	if (ret) {
-		blk_mq_free_rq_map(tags);
+		blk_mq_free_rq_map(set, tags);
 		return NULL;
 	}
 
@@ -4135,7 +4135,7 @@ void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 {
 	if (tags) {
 		blk_mq_free_rqs(set, tags, hctx_idx);
-		blk_mq_free_rq_map(tags);
+		blk_mq_free_rq_map(set, tags);
 	}
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index affb2e14b56e..b96a753809ab 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -59,7 +59,7 @@ void blk_mq_put_rq_ref(struct request *rq);
  */
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx);
-void blk_mq_free_rq_map(struct blk_mq_tags *tags);
+void blk_mq_free_rq_map(struct blk_mq_tag_set *set, struct blk_mq_tags *tags);
 struct blk_mq_tags *blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
 				unsigned int hctx_idx, unsigned int depth);
 void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
@@ -162,7 +162,7 @@ struct blk_mq_alloc_data {
 
 struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
 		unsigned int reserved_tags, unsigned int flags, int node);
-void blk_mq_free_tags(struct blk_mq_tags *tags);
+void blk_mq_free_tags(struct blk_mq_tag_set *set, struct blk_mq_tags *tags);
 
 unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
 unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
-- 
2.47.0

