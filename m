Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C6C212F89
	for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 02:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764470655; cv=none; b=F+nlSJjdtz2Juq0BBjOtXTitUwF6F3M1cjxJpxsdm9E1S26tehuTPNf9bnHykq1okzF5mIWj74Gi1lr9uwUan7XYgQnuXIPu5/NUXCaaaNrXPKNAbTjJE+2y4ZsoqeGKK7PcBkA8tmpRAAEkxonMj8av48T+wRT/WYUbJt34GuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764470655; c=relaxed/simple;
	bh=8bEebxUT5T0KT86XHVPir30hLHc/5eLWBieQba87z+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNk++9xZcEBKhirkW9LARd8yPkNwQarnsPkSV7VYU4BxbkKF2Dx8DoRrfc8liVb2hpjUOb41NH2+qZquguITZBSe0BC3GLTBynfW3meDOu2qHi8MXHcS9ZeXkBP460eQavS9PpD4o5bJqyRQj4e9JzzSYOpwxvkVlXvoc68A3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9BAC4CEF7;
	Sun, 30 Nov 2025 02:44:11 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v3 09/10] blk-throttle: remove useless queue frozen
Date: Sun, 30 Nov 2025 10:43:48 +0800
Message-ID: <20251130024349.2302128-10-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251130024349.2302128-1-yukuai@fnnas.com>
References: <20251130024349.2302128-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk-throttle is still holding rq_qos_mutex before freezing queue from
blk_throtl_init().

However blk_throtl_bio() can be called before grabbing q_usage_counter
hence freeze queue really doesn't stop new IO issuing to blk-throtl.

Also use READ_ONCE and WRITE_ONCE for q->td because blk_throtl_init()
can concurrent with issuing IO.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-throttle.c | 11 ++---------
 block/blk-throttle.h |  3 ++-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 97188a795848..6c63b9714afa 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1310,7 +1310,6 @@ static int blk_throtl_init(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct throtl_data *td;
-	unsigned int memflags;
 	int ret;
 
 	td = kzalloc_node(sizeof(*td), GFP_KERNEL, q->node);
@@ -1320,22 +1319,16 @@ static int blk_throtl_init(struct gendisk *disk)
 	INIT_WORK(&td->dispatch_work, blk_throtl_dispatch_work_fn);
 	throtl_service_queue_init(&td->service_queue);
 
-	memflags = blk_mq_freeze_queue(disk->queue);
-	blk_mq_quiesce_queue(disk->queue);
-
-	q->td = td;
+	WRITE_ONCE(q->td, td);
 	td->queue = q;
 
 	/* activate policy, blk_throtl_activated() will return true */
 	ret = blkcg_activate_policy(disk, &blkcg_policy_throtl);
 	if (ret) {
-		q->td = NULL;
+		WRITE_ONCE(q->td, NULL);
 		kfree(td);
 	}
 
-	blk_mq_unquiesce_queue(disk->queue);
-	blk_mq_unfreeze_queue(disk->queue, memflags);
-
 	return ret;
 }
 
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 9d7a42c039a1..3d177b20f9e1 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -162,7 +162,8 @@ static inline bool blk_throtl_activated(struct request_queue *q)
 	 * blkcg_policy_enabled() guarantees that the policy is activated
 	 * in the request_queue.
 	 */
-	return q->td != NULL && blkcg_policy_enabled(q, &blkcg_policy_throtl);
+	return READ_ONCE(q->td) &&
+	       blkcg_policy_enabled(q, &blkcg_policy_throtl);
 }
 
 static inline bool blk_should_throtl(struct bio *bio)
-- 
2.51.0

