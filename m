Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9EB84E1C;
	Tue, 17 Dec 2024 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403475; cv=none; b=ey6Ks335GhyyDeKh7hxsIgLiWtOWYapdzBdclSN1VuC3jtWNz3Mge1auM4MNZryvEWI/XUMCaf2mYKYswJhPyUVLWdvXHOSB/j9weOaDKQMeIUQ/HlPyTep5xmKF7RtN5WfRHp3ElxDpixb5bQjNrwq/OYmHU8mTAmJPMbBsyLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403475; c=relaxed/simple;
	bh=j+LT9LQcC+fMKtmYV6yS0Laov4aaG0UX4qIxbAPTanE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kwA/ZD2eaoNzB1dVkjMJSFDB6ia2civ1gcuWSEqhU6ohFPOzbwf7cn14mTOSKbOGDApg3M6QqwCoq/qHwgJHx/wLa7BMgXr80/WP5qnSBeNzEcAtkyZ4rOJtHxGQYwOFtBWmUqYN48fGHZ4Qja0LlO6HGb/jyP9YM9DXZmBK/qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YC1NM4CLSz4f3lW6;
	Tue, 17 Dec 2024 10:44:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 137411A0196;
	Tue, 17 Dec 2024 10:44:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHMYWE5WBndhZJEw--.48443S6;
	Tue, 17 Dec 2024 10:44:23 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	akpm@linux-foundation.org,
	ming.lei@redhat.com,
	yang.yang@vivo.com,
	bvanassche@acm.org,
	osandov@fb.com,
	paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 RFC 2/4] lib/sbitmap: fix shallow_depth tag allocation
Date: Tue, 17 Dec 2024 10:40:45 +0800
Message-Id: <20241217024047.1091893-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
References: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHMYWE5WBndhZJEw--.48443S6
X-Coremail-Antispam: 1UD129KBjvJXoW3WF47uFy7Wr4DKF4xGF48WFg_yoW7GF48pF
	4xK3WxGrWFyryj9rn8G3yDZF90qw4DGwnxGF4fWw1Fkr45Janavr9YkFyaqa4xCFWkZFWU
	ZFWrXry8G34UXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
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

Currently, shallow_depth is used by bfq, kyber and mq-deadline, they both
pass in the value for the whole sbitmap, while sbitmap treats the value
for just one word. Which means, shallow_depth never work as expected,
and there really is no such functional tests to covert it.

Consider that callers doesn't know which word will be used, and it's
not possible to distinguish the last word and previous word. Fix this
problem by treating shallow_depth for the whole sbitmap in
sbitmap_find_bit().

Fixes: 00e043936e9a ("blk-mq: introduce Kyber multiqueue I/O scheduler")
Fixes: a52a69ea89dc ("block, bfq: limit tags for writes and async I/O")
Fixes: 07757588e507 ("block/mq-deadline: Reserve 25% of scheduler tags for synchronous requests")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 include/linux/sbitmap.h |  6 ++---
 lib/sbitmap.c           | 55 +++++++++++++++++++++--------------------
 2 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 189140bf11fc..92e77bc13cf6 100644
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
+ * with a @shallow_depth of (sb->depth << 1). Then, the low-priority
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
index d3412984170c..6b8b909614a5 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -208,8 +208,27 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 	return nr;
 }
 
+static unsigned int __map_depth_with_shallow(const struct sbitmap *sb,
+					     int index,
+					     unsigned int shallow_depth)
+{
+	unsigned int pre_word_bits = 0;
+
+	if (shallow_depth >= sb->depth)
+		return __map_depth(sb, index);
+
+	if (index > 0)
+		pre_word_bits += (index - 1) << sb->shift;
+
+	if (shallow_depth <= pre_word_bits)
+		return 0;
+
+	return min_t(unsigned int, __map_depth(sb, index),
+				   shallow_depth - pre_word_bits);
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

