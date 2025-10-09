Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC32D0622;
	Thu,  9 Oct 2025 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996399; cv=none; b=JhbKsrIcfmEzdzJB7ZWqNr598FiaUKKM50QKURu47VoS+HUx5Oe6iBisOXkpt2Qq55hhFHIEI2Eytg7BPZ+UuTET7zlOIaV8jnBPPJuENT6ay0Joyouh6fD8pSv0HpXUyxOPbDli2b590vmgPmwHU21Ftn+UFqRjWIM5EcmS6G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996399; c=relaxed/simple;
	bh=+8Bb4r0vXbWygYr4lRD1U07jQnTJxwykTh36et+XRMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G5UytlZJwW2UGG2BYwalI2nx/JXHBbzB5x31WtYuf6DSspZoptBJM4nNVr9F62T3n7AKdcG6KKEaIJQJOgWeGmy4AbxwRY75pRoJkCoqAcuZ8YDBGPO75Z3+pJNme71DXhzGW/w4XwP3tVa28AgcD9ftEai8Yu/8TJKj5lLKJIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cj2Cz3KzdzKHMgq;
	Thu,  9 Oct 2025 15:52:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 033751A12F1;
	Thu,  9 Oct 2025 15:53:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.159.234])
	by APP4 (Coremail) with SMTP id gCh0CgA3+mHqaedo7Fo7CQ--.38248S6;
	Thu, 09 Oct 2025 15:53:15 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com,
	jmoyer@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [patch v2 2/7] blk-mq-sched: unify elevators checking for async requests
Date: Thu,  9 Oct 2025 15:46:29 +0800
Message-Id: <20251009074634.527661-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251009074634.527661-1-yukuai1@huaweicloud.com>
References: <20251009074634.527661-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3+mHqaedo7Fo7CQ--.38248S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4kKry8Aw48Jw45ZryrWFg_yoW5Xw15pr
	ZxXFW5GryjgFs7uFWrZ3W7Xw18J3ZxWry7Cr45Jw1rtF9F9FsF9F4rtr48XFWSvrWfArW7
	ur1qq343XFnY9rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

bfq and mq-deadline consider sync writes as async requests and only
resver tags for sync reads by async_depth, however, kyber doesn't
consider sync writes as async requests for now.

Consider the case there are lots of dirty pages, and user use fsync to
flush dirty pages. In this case sched_tags can be exhausted by sync writes
and sync reads can stuck waiting for tag. Hence let kyber follow what
mq-deadline and bfq did, and unify async requests checking for all
elevators.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c   | 2 +-
 block/blk-mq-sched.h  | 5 +++++
 block/kyber-iosched.c | 2 +-
 block/mq-deadline.c   | 2 +-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4a8d3d96bfe4..63452e791f98 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -697,7 +697,7 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	unsigned int limit, act_idx;
 
 	/* Sync reads have full depth available */
-	if (op_is_sync(opf) && !op_is_write(opf))
+	if (blk_mq_sched_sync_request(opf))
 		limit = data->q->nr_requests;
 	else
 		limit = bfqd->async_depths[!!bfqd->wr_busy_queues][op_is_sync(opf)];
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 8e21a6b1415d..ae747f9053c7 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -103,4 +103,9 @@ static inline void blk_mq_set_min_shallow_depth(struct request_queue *q,
 						depth);
 }
 
+static inline bool blk_mq_sched_sync_request(blk_opf_t opf)
+{
+	return op_is_sync(opf) && !op_is_write(opf);
+}
+
 #endif
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 18efd6ef2a2b..cf243a457175 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -544,7 +544,7 @@ static void kyber_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	 * We use the scheduler tags as per-hardware queue queueing tokens.
 	 * Async requests can be limited at this stage.
 	 */
-	if (!op_is_sync(opf)) {
+	if (!blk_mq_sched_sync_request(opf)) {
 		struct kyber_queue_data *kqd = data->q->elevator->elevator_data;
 
 		data->shallow_depth = kqd->async_depth;
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3e741d33142d..592dd853f6e5 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -492,7 +492,7 @@ static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	struct deadline_data *dd = data->q->elevator->elevator_data;
 
 	/* Do not throttle synchronous reads. */
-	if (op_is_sync(opf) && !op_is_write(opf))
+	if (blk_mq_sched_sync_request(opf))
 		return;
 
 	/*
-- 
2.39.2

