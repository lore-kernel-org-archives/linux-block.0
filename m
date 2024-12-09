Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E948A22069F;
	Mon,  9 Dec 2024 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745516; cv=none; b=Cf9nfTPdUZEz2Zl06Df5WvZWJBUmYUo5G1nOdniFOc3UrgHAeRmNk5UodCxFY3JZ7YsPWgXpuFtb0K8bR220Veq+vFQ2LYkhpzvCyCiLVqc2B1YqSvuQikjqtzG+zEevH/vd3cZqhd9D62lTMtMThYG3AaUk8htOMhSfo9/k6Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745516; c=relaxed/simple;
	bh=9V9xeIAC8+LAWsBNoznh8AfBkrZFjIT+yC15uz7ELIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkjLxGvtKz2nZhcaJINY86VcdsWqvZ6XVxqNK5rT19itjg9TV637Uisuu9k9P76J3cxmqRkoyjs95P1r84nXt3aAbgiU9YccIca9LG9JRTV6o8dCsANw0wYOnTG76CVfUyM5PENy9BD++dT90Vi0ra7ZyrcRZ+Ba7OF48N5T5TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y6L3S5PWgz4f3kFG;
	Mon,  9 Dec 2024 19:58:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EBAB21A147E;
	Mon,  9 Dec 2024 19:58:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4dk21Zn1extEA--.18505S7;
	Mon, 09 Dec 2024 19:58:31 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	akpm@linux-foundation.org,
	yang.yang@vivo.com,
	ming.lei@redhat.com,
	yukuai3@huawei.com,
	bvanassche@acm.org,
	osandov@fb.com,
	paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC 3/3] lib/sbitmap: fix shallow_depth tag allocation
Date: Mon,  9 Dec 2024 19:55:22 +0800
Message-Id: <20241209115522.3741093-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
References: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4dk21Zn1extEA--.18505S7
X-Coremail-Antispam: 1UD129KBjvJXoWxuFy8Xw1rZF1rWr4rCFW8tFb_yoW5AFykpF
	48K3WfKr4Fyr129rs8C34DZFyrGw4DGwnrJFWfWw1Fkr45JanaqryrKFyaqa47CFZ7ZFWj
	yF4rXry8G34jqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v2
	6r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHWlkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently, shallow_depth is used by bfq, kyber and mq-deadline, they both
pass in the value for the whole sbitmap, while sbitmap treate the value
for just one word. Which means, shallow_depth never work as expected,
and there really is no such functional tests to covert it.

Consider that callers doesn't know which word will be used, and how many
bits are available in the last word, fix this problem by treating
shallow_depth for the whole sbitmap in sbitmap_find_bit().

Fixes: 00e043936e9a ("blk-mq: introduce Kyber multiqueue I/O scheduler")
Fixes: a52a69ea89dc ("block, bfq: limit tags for writes and async I/O")
Fixes: 07757588e507 ("block/mq-deadline: Reserve 25% of scheduler tags for synchronous requests")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 include/linux/sbitmap.h |  2 +-
 lib/sbitmap.c           | 31 +++++++++++++++++++++++++------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index e1730f5fdf9c..ffb9907c7070 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -461,7 +461,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
  * sbitmap_queue, limiting the depth used from each word, with preemption
  * already disabled.
  * @sbq: Bitmap queue to allocate from.
- * @shallow_depth: The maximum number of bits to allocate from a single word.
+ * @shallow_depth: The maximum number of bits to allocate from the queue.
  * See sbitmap_get_shallow().
  *
  * If you call this, make sure to call sbitmap_queue_min_shallow_depth() after
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 9d4213ce7916..13831c7536a3 100644
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
-- 
2.39.2

