Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071968;
	b=N98gPFVYo+5DzPaScy7vIRpsDI2T8CGgEtUXiSwRtAHqlHwUP/O1MGFl9Q23QD9BOh3Y
	 2TWBV7ScCJ3S2QYTz0ZPeksE9NzKn97QYTGAw0TiAxSCwDz3kza1CcnCq17Lom7uqWBHJ
	 a4I2QzOo53RtxX35GQY43Osi7/wlA3OLzVoX7CVYyV/PzHlxIewH1ACMqrUXpwAIalQyR
	 0P14YvmqZTCelcqt2AeK2LF8e2kTifsQMOfmBOnNRgzgMVG6RBJrI/bhDvDC87zvT7tVd
	 mtO8N+vPpFQTmgAkP+KXnEB0wZnVfqyktxp9/ba9cztd96iaguQenTRMeKzfGGvPlQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071968;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V+8xx5GM+ujOa1laZ12P0srdFBwzc8hmmfbg6tCKZp0=;
	b=fCWh6jRz0W67sBf11gpW+yT/mmx3sNlP06/3p+S50JvHFPWOYA8vV99koWkHkV64nBaY
	 cmbQeNlBUh70Er66t8Acs2ssWCN9XWMHU92FYRAc5dZKTIAdCL6d2mMT2NsvYQwlCvlw6
	 +Mj9c2InjAKTUQH5sw/e2h1T7coJKQE48F9o+mBZblNJQXcUO/6O42/z871mOsqXa4ohi
	 aDuFMwxt/GuJFYjL/GtJQ4azD+n0ERMVe3eC09mBfX0jBwjY25cepAaTH880/cvk6vYYq
	 IehpJ9a2XthtlXjGcf6KYerk1nE1bjBCsFjZ8qPKOV/R2NEjTzemJf/sQGL54UKg2rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cj7n5sAW;
	arc=none smtp.remote-ip=115.124.30.99
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562D2606A325
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 07:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 562D2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cj7n5sAW
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795071958; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=V+8xx5GM+ujOa1laZ12P0srdFBwzc8hmmfbg6tCKZp0=;
	b=cj7n5sAW0vQyzs9rSVWwerOZdOoeu0IInHoK7oTw9LuQnww8qBz1WBWi2A5ZttaVMGwFkEpxxhniQnzo3jzoAGip2L8bOn7VpqZ2t9uEkQad9d60+XLPeqjK7z2uhpNRtLwCWDtOGB4FgKYfE1YJ3VcGSJIHavhmRfNaliNIIsg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XF2mP.R_1795071956;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XF2mP.R_1795071956 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 15:05:56 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/7] blk-mq: free the rqs arrays of tags in the SRCU callback
Date: Thu, 19 Nov 2026 15:05:42 +0800
Message-ID: <20261119070548.3125491-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261119070548.3125491-1-kanie@linux.alibaba.com>
References: <20261119070548.3125491-1-kanie@linux.alibaba.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct blk_mq_tags and the requests are kept alive until the iterators
under tags_srcu are gone, and the bitmaps were recently moved into that
SRCU callback as well, but the tags->rqs[] and tags->static_rqs[] arrays
are still freed right away by blk_mq_free_rq_map(). An iterator holding
a tags pointer dereferences both arrays per set bit, e.g.
blk_mq_find_and_get_req(), so when the number of hardware queues shrinks
the arrays can be freed while blk_mq_tagset_busy_iter() is about to walk
them.

Free both arrays in the SRCU callback together with the bitmaps. With
that blk_mq_free_rq_map() is a trivial wrapper of blk_mq_free_tags(),
so drop it and call blk_mq_free_tags() directly.

Fixes: 995412e23bb2 ("blk-mq: Replace tags->lock with SRCU for tag iterators")
Fixes: ad0d05dbddc1 ("blk-mq: Defer freeing of tags page_list to SRCU callback")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 block/blk-mq-tag.c |  2 ++
 block/blk-mq.c     | 18 +++---------------
 block/blk-mq.h     |  1 -
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 3515031b3226..ee5413ebab01 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -611,6 +611,8 @@ static void blk_mq_free_tags_callback(struct rcu_head *head)
 		kmemleak_free(page_address(page));
 		__free_pages(page, page->private);
 	}
+	kfree(tags->rqs);
+	kfree(tags->static_rqs);
 	/* An iterator may walk the bitmaps for as long as it may see the tags */
 	sbitmap_queue_free(&tags->bitmap_tags);
 	sbitmap_queue_free(&tags->breserved_tags);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ae22d556540..ae12f2a52cc9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3532,16 +3532,6 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	 */
 }
 
-void blk_mq_free_rq_map(struct blk_mq_tags *tags)
-{
-	kfree(tags->rqs);
-	tags->rqs = NULL;
-	kfree(tags->static_rqs);
-	tags->static_rqs = NULL;
-
-	blk_mq_free_tags(tags);
-}
-
 static enum hctx_type hctx_idx_to_type(struct blk_mq_tag_set *set,
 		unsigned int hctx_idx)
 {
@@ -3594,12 +3584,10 @@ static struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 					GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
 					node);
 	if (!tags->static_rqs)
-		goto err_free_rqs;
+		goto err_free_tags;
 
 	return tags;
 
-err_free_rqs:
-	kfree(tags->rqs);
 err_free_tags:
 	blk_mq_free_tags(tags);
 	return NULL;
@@ -4155,7 +4143,7 @@ struct blk_mq_tags *blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
 
 	ret = blk_mq_alloc_rqs(set, tags, hctx_idx, depth);
 	if (ret) {
-		blk_mq_free_rq_map(tags);
+		blk_mq_free_tags(tags);
 		return NULL;
 	}
 
@@ -4183,7 +4171,7 @@ void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 {
 	if (tags) {
 		blk_mq_free_rqs(set, tags, hctx_idx);
-		blk_mq_free_rq_map(tags);
+		blk_mq_free_tags(tags);
 	}
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 1e64236d34d4..ba7bd917c361 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -62,7 +62,6 @@ void blk_mq_put_rq_ref(struct request *rq);
  */
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx);
-void blk_mq_free_rq_map(struct blk_mq_tags *tags);
 struct blk_mq_tags *blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
 				unsigned int hctx_idx, unsigned int depth);
 void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
-- 
2.43.7

