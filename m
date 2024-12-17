Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F79018035;
	Tue, 17 Dec 2024 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403475; cv=none; b=gAfFxzhnPAfxbFlNrM64794SbXTPas/vpCkTSJXcjRXQSRQPjIhTi6e18ZsUUNKq29LtVGoB0r5X+8+U2E9xlFf8yjlXAGWKZ9GlpQbnZ4T3fQj7KH3GWDti5VSkuRl3GIwWhEjPiJnzdEOOwyLLiP6BtHgz1f9kBtUdUOk/ELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403475; c=relaxed/simple;
	bh=K9SoLNCfEeUaljYFOjFnHTxHoqjk1HY5h19jRWTR4As=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WPePlKg0EhbiGXRiBo0S58IfnsaYyjA8BPZkvan6kUqVJEXEeTNfraFNkLZ4aza8u9pXc/aYyu5vMe6DcnVq+yupWa9Dmn4xrjCZv4fXQWVN7veogI+Z0MPDYWNlw7xkLKDJL5sgBj7m7VqOSz1FGtDBTL24CnojOZ7DQcnKqyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YC1NN4JZBz4f3lWG;
	Tue, 17 Dec 2024 10:44:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1C67A1A018D;
	Tue, 17 Dec 2024 10:44:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHMYWE5WBndhZJEw--.48443S8;
	Tue, 17 Dec 2024 10:44:24 +0800 (CST)
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
Subject: [PATCH RFC v2 4/4] block/mq-deadline: introduce min_async_depth
Date: Tue, 17 Dec 2024 10:40:47 +0800
Message-Id: <20241217024047.1091893-5-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAHMYWE5WBndhZJEw--.48443S8
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4DAF4Dtw4ruFWftr4fZrb_yoW5AF47pr
	W5Ja1kKr1jqF4j9rWDA3y3Xr1rWws5Wry3GF1rt3yfCF95ArZxXF1rtF13WF93XFZ7Aw47
	Kr1qqayfJ3Z8tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

min_shallow_depth must be less or equal to any shallow_depth value, and
it's 1 currently, and this will change default wake_batch to 1, causing
performance degradation for fast disk with high concurrency. This patch
make following changes:

- set default minimal async_depth to 64, to avoid performance
  degradation in the commen case. And user can set lower value if
  necessary.
- disable throttling asynchronous requests by default, to prevent
  performance degradation in some special setup. User must set a value
  to async_depth to enable it.
- if async_depth is set already, don't reset it if user sets new
  nr_requests.

Fixes: 07757588e507 ("block/mq-deadline: Reserve 25% of scheduler tags for synchronous requests")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/mq-deadline.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 1f0d175a941e..9be0a33985ce 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -24,6 +24,16 @@
 #include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
 
+/*
+ * async_depth is used to reserve scheduler tags for synchronous requests,
+ * and the value will affect sbitmap wake_batch. The default minimal value is 64
+ * because the corresponding wake_batch is 8, and lower wake_batch may affect
+ * IO performance.
+ */
+static unsigned int min_async_depth = 64;
+module_param(min_async_depth, int, 0444);
+MODULE_PARM_DESC(min_async_depth, "The minimal number of tags available for asynchronous requests");
+
 /*
  * See Documentation/block/deadline-iosched.rst
  */
@@ -513,9 +523,12 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
 	struct deadline_data *dd = q->elevator->elevator_data;
 	struct blk_mq_tags *tags = hctx->sched_tags;
 
-	dd->async_depth = max(1UL, 3 * q->nr_requests / 4);
+	if (q->nr_requests > min_async_depth)
+		sbitmap_queue_min_shallow_depth(&tags->bitmap_tags,
+						min_async_depth);
 
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_depth);
+	if (q->nr_requests <= dd->async_depth)
+		dd->async_depth = 0;
 }
 
 /* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */
@@ -814,7 +827,7 @@ STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MA
 STORE_JIFFIES(deadline_prio_aging_expire_store, &dd->prio_aging_expire, 0, INT_MAX);
 STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX);
 STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
-STORE_INT(deadline_async_depth_store, &dd->async_depth, 1, INT_MAX);
+STORE_INT(deadline_async_depth_store, &dd->async_depth, min_async_depth, INT_MAX);
 STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
 #undef STORE_FUNCTION
 #undef STORE_INT
-- 
2.39.2

