Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC82A21CC40;
	Tue,  5 Aug 2025 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754379906; cv=none; b=QhzoDEdDYYga3dLNECGJlTMGOImQadU5nXV0+6GhoOU/VrHQV5S9Slbk+cc8jZFUBesFN2jjJbOHjEBROdy/N0PZ87e+PMiqAdlWTTMucwNi9HJY2d2uxtcNslt40MggIy8RcstGpyGW/gnbHEucofKg8Faw64t23dVdKm1KsxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754379906; c=relaxed/simple;
	bh=y3UHhWPmyPH+j1QInxmfQf7NM5ZpGpmr8sgcKkLZ1GY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aww0boeOvgOiMNpmTdF+j47lD0+yU8Isfy+IcdzQ0m249VGeQlUhsOT6BWXCxjPZjuR1yvkhyqFU/jP51C5PwtRASVNbrNJ2ahOjeCtGz4LH3kxsenRPgYxgG7HcB8Vbop2orypk3vl+taUFAIWALUGcuQ9u+p3dTPZKCTmwY+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bx5740qyhzYQv76;
	Tue,  5 Aug 2025 15:45:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BCA441A0359;
	Tue,  5 Aug 2025 15:45:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhN8tpFoEsmICg--.25448S5;
	Tue, 05 Aug 2025 15:45:02 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: yukuai3@huawei.com,
	axboe@kernel.dk,
	akpm@linux-foundation.org,
	ming.lei@redhat.com,
	dlemoal@kernel.org,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3 1/2] lib/sbitmap: convert shallow_depth from one word to the whole sbitmap
Date: Tue,  5 Aug 2025 15:37:47 +0800
Message-Id: <20250805073748.606294-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250805073748.606294-1-yukuai1@huaweicloud.com>
References: <20250805073748.606294-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhN8tpFoEsmICg--.25448S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Cr1UGr45AF1UJF18Ar4xZwb_yoWkCw4fpF
	47ta17KryrtF1j9r15t3yDZF1rtwn5urnxGF4Sqw1FkrWqqan7XFnYyFyrXFyxZFWkAFWU
	ArZ5Xr95Gw1qqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	vjDU0xZFpf9x0JU4OJ5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently elevators will record internal 'async_depth' to throttle
asynchronous requests, and they both calculate shallow_dpeth based on
sb->shift, with the respect that sb->shift is the available tags in one
word.

However, sb->shift is not the availbale tags in the last word, see
__map_depth:

if (index == sb->map_nr - 1)
  return sb->depth - (index << sb->shift);

For consequence, if the last word is used, more tags can be get than
expected, for example, assume nr_requests=256 and there are four words,
in the worst case if user set nr_requests=32, then the first word is
the last word, and still use bits per word, which is 64, to calculate
async_depth is wrong.

One the ohter hand, due to cgroup qos, bfq can allow only one request
to be allocated, and set shallow_dpeth=1 will still allow the number
of words request to be allocated.

Fix those problems by using shallow_depth to the whole sbitmap instead
of per word, also change kyber, mq-deadline and bfq to follow this,
a new helper __map_depth_with_shallow() is introduced to calculate
available bits in each word.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c     | 35 ++++++++++++--------------
 block/bfq-iosched.h     |  3 +--
 block/kyber-iosched.c   |  9 ++-----
 block/mq-deadline.c     | 16 +-----------
 include/linux/sbitmap.h |  6 ++---
 lib/sbitmap.c           | 55 +++++++++++++++++++++--------------------
 6 files changed, 51 insertions(+), 73 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0cb1e9873aab..d68da9e92e1e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -701,17 +701,13 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 {
 	struct bfq_data *bfqd = data->q->elevator->elevator_data;
 	struct bfq_io_cq *bic = bfq_bic_lookup(data->q);
-	int depth;
-	unsigned limit = data->q->nr_requests;
-	unsigned int act_idx;
+	unsigned int limit, act_idx;
 
 	/* Sync reads have full depth available */
-	if (op_is_sync(opf) && !op_is_write(opf)) {
-		depth = 0;
-	} else {
-		depth = bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(opf)];
-		limit = (limit * depth) >> bfqd->full_depth_shift;
-	}
+	if (op_is_sync(opf) && !op_is_write(opf))
+		limit = data->q->nr_requests;
+	else
+		limit = bfqd->async_depths[!!bfqd->wr_busy_queues][op_is_sync(opf)];
 
 	for (act_idx = 0; bic && act_idx < bfqd->num_actuators; act_idx++) {
 		/* Fast path to check if bfqq is already allocated. */
@@ -725,14 +721,16 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 		 * available requests and thus starve other entities.
 		 */
 		if (bfqq_request_over_limit(bfqd, bic, opf, act_idx, limit)) {
-			depth = 1;
+			limit = 1;
 			break;
 		}
 	}
+
 	bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
-		__func__, bfqd->wr_busy_queues, op_is_sync(opf), depth);
-	if (depth)
-		data->shallow_depth = depth;
+		__func__, bfqd->wr_busy_queues, op_is_sync(opf), limit);
+
+	if (limit < data->q->nr_requests)
+		data->shallow_depth = limit;
 }
 
 static struct bfq_queue *
@@ -7128,9 +7126,8 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
  */
 static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
 {
-	unsigned int depth = 1U << bt->sb.shift;
+	unsigned int nr_requests = bfqd->queue->nr_requests;
 
-	bfqd->full_depth_shift = bt->sb.shift;
 	/*
 	 * In-word depths if no bfq_queue is being weight-raised:
 	 * leaving 25% of tags only for sync reads.
@@ -7142,13 +7139,13 @@ static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
 	 * limit 'something'.
 	 */
 	/* no more than 50% of tags for async I/O */
-	bfqd->word_depths[0][0] = max(depth >> 1, 1U);
+	bfqd->async_depths[0][0] = max(nr_requests >> 1, 1U);
 	/*
 	 * no more than 75% of tags for sync writes (25% extra tags
 	 * w.r.t. async I/O, to prevent async I/O from starving sync
 	 * writes)
 	 */
-	bfqd->word_depths[0][1] = max((depth * 3) >> 2, 1U);
+	bfqd->async_depths[0][1] = max((nr_requests * 3) >> 2, 1U);
 
 	/*
 	 * In-word depths in case some bfq_queue is being weight-
@@ -7158,9 +7155,9 @@ static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
 	 * shortage.
 	 */
 	/* no more than ~18% of tags for async I/O */
-	bfqd->word_depths[1][0] = max((depth * 3) >> 4, 1U);
+	bfqd->async_depths[1][0] = max((nr_requests * 3) >> 4, 1U);
 	/* no more than ~37% of tags for sync writes (~20% extra tags) */
-	bfqd->word_depths[1][1] = max((depth * 6) >> 4, 1U);
+	bfqd->async_depths[1][1] = max((nr_requests * 6) >> 4, 1U);
 }
 
 static void bfq_depth_updated(struct blk_mq_hw_ctx *hctx)
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 687a3a7ba784..31217f196f4f 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -813,8 +813,7 @@ struct bfq_data {
 	 * Depth limits used in bfq_limit_depth (see comments on the
 	 * function)
 	 */
-	unsigned int word_depths[2][2];
-	unsigned int full_depth_shift;
+	unsigned int async_depths[2][2];
 
 	/*
 	 * Number of independent actuators. This is equal to 1 in
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 4dba8405bd01..bfd9a40bb33d 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -157,10 +157,7 @@ struct kyber_queue_data {
 	 */
 	struct sbitmap_queue domain_tokens[KYBER_NUM_DOMAINS];
 
-	/*
-	 * Async request percentage, converted to per-word depth for
-	 * sbitmap_get_shallow().
-	 */
+	/* Number of allowed async requests. */
 	unsigned int async_depth;
 
 	struct kyber_cpu_latency __percpu *cpu_latency;
@@ -454,10 +451,8 @@ static void kyber_depth_updated(struct blk_mq_hw_ctx *hctx)
 {
 	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
 	struct blk_mq_tags *tags = hctx->sched_tags;
-	unsigned int shift = tags->bitmap_tags.sb.shift;
-
-	kqd->async_depth = (1U << shift) * KYBER_ASYNC_PERCENT / 100U;
 
+	kqd->async_depth = hctx->queue->nr_requests * KYBER_ASYNC_PERCENT / 100U;
 	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, kqd->async_depth);
 }
 
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 2edf1cac06d5..9ab6c6256695 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -487,20 +487,6 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	return rq;
 }
 
-/*
- * 'depth' is a number in the range 1..INT_MAX representing a number of
- * requests. Scale it with a factor (1 << bt->sb.shift) / q->nr_requests since
- * 1..(1 << bt->sb.shift) is the range expected by sbitmap_get_shallow().
- * Values larger than q->nr_requests have the same effect as q->nr_requests.
- */
-static int dd_to_word_depth(struct blk_mq_hw_ctx *hctx, unsigned int qdepth)
-{
-	struct sbitmap_queue *bt = &hctx->sched_tags->bitmap_tags;
-	const unsigned int nrr = hctx->queue->nr_requests;
-
-	return ((qdepth << bt->sb.shift) + nrr - 1) / nrr;
-}
-
 /*
  * Called by __blk_mq_alloc_request(). The shallow_depth value set by this
  * function is used by __blk_mq_get_tag().
@@ -517,7 +503,7 @@ static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	 * Throttle asynchronous requests and writes such that these requests
 	 * do not block the allocation of synchronous requests.
 	 */
-	data->shallow_depth = dd_to_word_depth(data->hctx, dd->async_depth);
+	data->shallow_depth = dd->async_depth;
 }
 
 /* Called by blk_mq_update_nr_requests(). */
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 189140bf11fc..4adf4b364fcd 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -213,12 +213,12 @@ int sbitmap_get(struct sbitmap *sb);
  * sbitmap_get_shallow() - Try to allocate a free bit from a &struct sbitmap,
  * limiting the depth used from each word.
  * @sb: Bitmap to allocate from.
- * @shallow_depth: The maximum number of bits to allocate from a single word.
+ * @shallow_depth: The maximum number of bits to allocate from the bitmap.
  *
  * This rather specific operation allows for having multiple users with
  * different allocation limits. E.g., there can be a high-priority class that
  * uses sbitmap_get() and a low-priority class that uses sbitmap_get_shallow()
- * with a @shallow_depth of (1 << (@sb->shift - 1)). Then, the low-priority
+ * with a @shallow_depth of (sb->depth >> 1). Then, the low-priority
  * class can only allocate half of the total bits in the bitmap, preventing it
  * from starving out the high-priority class.
  *
@@ -478,7 +478,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
  * sbitmap_queue, limiting the depth used from each word, with preemption
  * already disabled.
  * @sbq: Bitmap queue to allocate from.
- * @shallow_depth: The maximum number of bits to allocate from a single word.
+ * @shallow_depth: The maximum number of bits to allocate from the queue.
  * See sbitmap_get_shallow().
  *
  * If you call this, make sure to call sbitmap_queue_min_shallow_depth() after
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index d3412984170c..89be98859d5a 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -208,8 +208,27 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 	return nr;
 }
 
+static unsigned int __map_depth_with_shallow(const struct sbitmap *sb,
+					     int index,
+					     unsigned int shallow_depth)
+{
+	unsigned int word_depth, shallow_word_depth, reminder;
+
+	word_depth = __map_depth(sb, index);
+	if (shallow_depth >= sb->depth)
+		return word_depth;
+
+	shallow_word_depth = word_depth * shallow_depth;
+	reminder = do_div(shallow_word_depth, sb->depth);
+
+	if (reminder >= (index + 1) * word_depth)
+		shallow_word_depth++;
+
+	return shallow_word_depth;
+}
+
 static int sbitmap_find_bit(struct sbitmap *sb,
-			    unsigned int depth,
+			    unsigned int shallow_depth,
 			    unsigned int index,
 			    unsigned int alloc_hint,
 			    bool wrap)
@@ -218,12 +237,12 @@ static int sbitmap_find_bit(struct sbitmap *sb,
 	int nr = -1;
 
 	for (i = 0; i < sb->map_nr; i++) {
-		nr = sbitmap_find_bit_in_word(&sb->map[index],
-					      min_t(unsigned int,
-						    __map_depth(sb, index),
-						    depth),
-					      alloc_hint, wrap);
+		unsigned int depth = __map_depth_with_shallow(sb, index,
+							      shallow_depth);
 
+		if (depth)
+			nr = sbitmap_find_bit_in_word(&sb->map[index], depth,
+						      alloc_hint, wrap);
 		if (nr != -1) {
 			nr += index << sb->shift;
 			break;
@@ -406,27 +425,9 @@ EXPORT_SYMBOL_GPL(sbitmap_bitmap_show);
 static unsigned int sbq_calc_wake_batch(struct sbitmap_queue *sbq,
 					unsigned int depth)
 {
-	unsigned int wake_batch;
-	unsigned int shallow_depth;
-
-	/*
-	 * Each full word of the bitmap has bits_per_word bits, and there might
-	 * be a partial word. There are depth / bits_per_word full words and
-	 * depth % bits_per_word bits left over. In bitwise arithmetic:
-	 *
-	 * bits_per_word = 1 << shift
-	 * depth / bits_per_word = depth >> shift
-	 * depth % bits_per_word = depth & ((1 << shift) - 1)
-	 *
-	 * Each word can be limited to sbq->min_shallow_depth bits.
-	 */
-	shallow_depth = min(1U << sbq->sb.shift, sbq->min_shallow_depth);
-	depth = ((depth >> sbq->sb.shift) * shallow_depth +
-		 min(depth & ((1U << sbq->sb.shift) - 1), shallow_depth));
-	wake_batch = clamp_t(unsigned int, depth / SBQ_WAIT_QUEUES, 1,
-			     SBQ_WAKE_BATCH);
-
-	return wake_batch;
+	return clamp_t(unsigned int,
+		       min(depth, sbq->min_shallow_depth) / SBQ_WAIT_QUEUES,
+		       1, SBQ_WAKE_BATCH);
 }
 
 int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
-- 
2.39.2

