Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4196F2264CF
	for <linux-block@vger.kernel.org>; Fri,  1 Aug 2025 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754048709; cv=none; b=HSSMwwsUdfepUxMhknOcKDMvj4QWiasb8k9Dhge65UuLhQvUNDZ0wAKTLXBS7CzeyBGyZayd/0OxRuFCaTAp3LEILxpm18EYqtu/TNQbebj/THXSxQvWsobvf/nzuvuWWG2hmDdpv4yGZp/Mepp4LqH+FVjmyfVrCsz6+rXG3cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754048709; c=relaxed/simple;
	bh=fhQMPyGmVnY2MLRlf82hoT6YmZw1MH+D3uN4s3UwbP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEUcBH6bA4jpyBgVXI0Y3KXes/dN/5kuiEG6X8SDkYuIKwFL+UoqCuryDt0NzQ9ftK8MV36mPDr6XjD8s3b+etxXIp4oU9KIYo3HWLOUngg8PovAUoKlboRUJGi21LnuJcczHE+W4OmKMOH82aYAcFWCNHt6BeGFD8jzDc6hAXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8gcYvEi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8gcYvEi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754048706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFQ5igrKIqQMkg6G8Lwocg3YS4VjCjArTCyTkVOlTGI=;
	b=A8gcYvEiaC660MOUr7wweZI1mA1vNY4zZ3eCS1Ilg4XxxsoIqRgWai7ag7yktipckNJlAj
	wet/hGSI+L2lEv1wXwgwjpMFIPq4A4HOPh//MPaCeMeaGaj5YfQMYM0WNYURoAE+mseEOX
	0qx00XnK4yB1o8uxzK4SVjtbFBzhiR8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-Vysngnp3PuW9B3VxGkq2Rg-1; Fri,
 01 Aug 2025 07:45:02 -0400
X-MC-Unique: Vysngnp3PuW9B3VxGkq2Rg-1
X-Mimecast-MFC-AGG-ID: Vysngnp3PuW9B3VxGkq2Rg_1754048701
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C2001800365;
	Fri,  1 Aug 2025 11:45:00 +0000 (UTC)
Received: from localhost (unknown [10.72.116.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E1E2E19776D4;
	Fri,  1 Aug 2025 11:44:58 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	John Garry <john.garry@huawei.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/5] blk-mq: Pass tag_set to blk_mq_free_rq_map/tags
Date: Fri,  1 Aug 2025 19:44:34 +0800
Message-ID: <20250801114440.722286-3-ming.lei@redhat.com>
In-Reply-To: <20250801114440.722286-1-ming.lei@redhat.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
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

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c |  4 ++--
 block/blk-mq-tag.c   |  2 +-
 block/blk-mq.c       | 10 +++++-----
 block/blk-mq.h       |  4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55a0fd105147..8b5ad3b3b071 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -393,7 +393,7 @@ static int blk_mq_sched_alloc_map_and_rqs(struct request_queue *q,
 
 static void blk_mq_exit_sched_shared_tags(struct request_queue *queue)
 {
-	blk_mq_free_rq_map(queue->sched_shared_tags);
+	blk_mq_free_rq_map(queue->tag_set, queue->sched_shared_tags);
 	queue->sched_shared_tags = NULL;
 }
 
@@ -406,7 +406,7 @@ static void blk_mq_sched_tags_teardown(struct request_queue *q, unsigned int fla
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->sched_tags) {
 			if (!blk_mq_is_shared_tags(flags))
-				blk_mq_free_rq_map(hctx->sched_tags);
+				blk_mq_free_rq_map(q->tag_set, hctx->sched_tags);
 			hctx->sched_tags = NULL;
 		}
 	}
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
index c6a1366dbe77..673cb534bc62 100644
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

