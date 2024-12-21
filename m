Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4EF1EC4DE;
	Sat, 21 Dec 2024 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734774068; cv=none; b=Kzmz47wiwDutiGXD/LHJGtdsi3/ms0jmtx6tW/dYiFxssYWGqxZFgykKwpZyCRZgrCzBU29w1RyzL9A81i+JPoWXrYKxbfpBu4hZ7SeFYpWU2UeCTuFnML41xxz8yzeA1kK/LNbInlkT3sIqcdspThZjba2q0qoWpNhRzOJBR3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734774068; c=relaxed/simple;
	bh=gaX55RseTRAcsjkSIrxid4DXTHF78Q1yGOJyqdVZBFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nDMeXyuFDm+yhH4jFP71+2H91aatwPYpHFHmzaqT03o4tY4IrNzZ3YPFQWsOyYXmKgz16M7+IgJdK78bifjXVhy0u387QG8LFXbRiy8CQRUteaKgvvQKLy1N1jIPYa48tsuunWZuBoQ7MCCRlS/P8fBTH8yOp4V4INGOzfIM3Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YFfRF2qzQz4f3jcv;
	Sat, 21 Dec 2024 17:40:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F29551A0568;
	Sat, 21 Dec 2024 17:41:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHIoYqjWZnocfeFA--.21383S5;
	Sat, 21 Dec 2024 17:41:00 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	akpm@linux-foundation.org,
	ming.lei@redhat.com,
	yang.yang@vivo.com,
	yukuai3@huawei.com,
	bvanassche@acm.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v3 1/7] lib/sbitmap: convert shallow_depth from one word to the whole sbitmap
Date: Sat, 21 Dec 2024 17:37:04 +0800
Message-Id: <20241221093710.926309-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241221093710.926309-1-yukuai1@huaweicloud.com>
References: <20241221093710.926309-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHIoYqjWZnocfeFA--.21383S5
X-Coremail-Antispam: 1UD129KBjvJXoW3JrW8CryDAF1rGr45tF45Awb_yoW3GFy5pF
	4xt3W7KryrtF1j9rn8t3yDZF1aqws8Gr9xJF4Sqw1FkryDJan3Xr1FkFy5XFyxZFWkAFWj
	kFWrXry8Gw1UXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JU2dgAUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Both kyber and mq-deadline record internal 'async_depth' to throttle
asynchronous requests, and they both calculate shallow_dpeth based on
sb->shift, with the respect that sb->shift is the available tags in one
word.

However, sb->shift is not the availbale tags in the last word, see
__map_depth:

if (index == sb->map_nr - 1)
  return sb->depth - (index << sb->shift);

What's worse, bfq just calculate shallow_depth as allowed tags for the
whole sbitmap.

On the one hand, callers doesn't know if the last word in bitmap will be
used; on the other hand, bfq can allow only 1 request for the whole
sbitmap. Fix above problems by using shallow_depth to the whole sbitmap,
also change kyber and mq-deadline to follow this.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/kyber-iosched.c   |  9 ++-----
 block/mq-deadline.c     | 16 +-----------
 include/linux/sbitmap.h |  6 ++---
 lib/sbitmap.c           | 55 +++++++++++++++++++++--------------------
 4 files changed, 34 insertions(+), 52 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 4155594aefc6..ccfefa6a3669 100644
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
index 5528347b5fcf..853985bd13d4 100644
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
index d3412984170c..f2e90ac6b56e 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -208,8 +208,27 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 	return nr;
 }
 
+static unsigned int __map_depth_with_shallow(const struct sbitmap *sb,
+					     int index,
+					     unsigned int shallow_depth)
+{
+	unsigned int lower_bound = 0;
+
+	if (shallow_depth >= sb->depth)
+		return __map_depth(sb, index);
+
+	if (index > 0)
+		lower_bound += (index - 1) << sb->shift;
+
+	if (shallow_depth <= lower_bound)
+		return 0;
+
+	return min_t(unsigned int, __map_depth(sb, index),
+				   shallow_depth - lower_bound);
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

