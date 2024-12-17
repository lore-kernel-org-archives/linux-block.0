Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA3513DBB6;
	Tue, 17 Dec 2024 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403476; cv=none; b=HWCywPcvbh2G/PimA6PAu9v+w8vnoO0cqL7D/u68m1LW70jQklDQU9dVU+3upGBL6Uwi1AAkpT2lhbOutlpI3D6hOTaqa2gPnPhBGvoCOi1cv8v4RZMOrxF023S9QlwgpJstbrVldXMUBs9aRfwQBdDAOP274sDI2RJmN6zMlf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403476; c=relaxed/simple;
	bh=fBY0IkGRzmci9c0dwhhGUl9Nsn/ahC9Wq/2R6REVevI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RyF1zCj+ZmZAP3wIt+47qrKa3ad3Y9eQ3ousTLAgwOe5+/pw5arOGWcYwLfNx2EUkJFynVQeO0cgCkwTGYrPilNieTRutenndnx6gFplkUXEJ7bbZnKFDscPRttRgBis6C1YLLua8vs2LzvmdlJNcrcvSWpGdfrvyl2GHUY1tbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YC1NT0p2Nz4f3jqb;
	Tue, 17 Dec 2024 10:44:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 84C1D1A018C;
	Tue, 17 Dec 2024 10:44:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHMYWE5WBndhZJEw--.48443S5;
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
Subject: [PATCH RFC v2 1/4] block/mq-deadline: Revert "block/mq-deadline: Fix the tag reservation code"
Date: Tue, 17 Dec 2024 10:40:44 +0800
Message-Id: <20241217024047.1091893-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAHMYWE5WBndhZJEw--.48443S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1fJry7ZryUKry5tw4fKrg_yoW5Ww1xpr
	4rJanFkr1rJF4q9F1Ut39xZr10gws3WryfJF1Yqw1Skr1DAa9rXF15tFWrZFyIvrWxCa1j
	9rWqqr95JwnFvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	vjDU0xZFpf9x0JU4OJ5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

This reverts commit 39823b47bbd40502632ffba90ebb34fff7c8b5e8.

1) Set min_shallow_depth to 1 will end up setting wake_batch to 1,
   and this will cause performance degradation in some high concurrency
   test, for both IO bandwidth and cpu usage.

   async_depth can be changed by sysfs, and the minimal value is 1. This
   is why min_shallow_depth is set to 1 at initialization to make sure
   functional is correct if async_depth is set to 1. However, sacrifice
   performance in the default scenario is not acceptable.

2) dd_to_word_depth() is supposed to scale down async_depth, however, user
   can set low nr_requests and sb->depth can be less than 1 << sb->shift,
   then dd_to_word_depth() will end up scale up async_depth.

Fixes: 39823b47bbd4 ("block/mq-deadline: Fix the tag reservation code")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/mq-deadline.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 91b3789f710e..1f0d175a941e 100644
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
@@ -527,9 +513,9 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
 	struct deadline_data *dd = q->elevator->elevator_data;
 	struct blk_mq_tags *tags = hctx->sched_tags;
 
-	dd->async_depth = q->nr_requests;
+	dd->async_depth = max(1UL, 3 * q->nr_requests / 4);
 
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
+	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_depth);
 }
 
 /* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */
-- 
2.39.2

