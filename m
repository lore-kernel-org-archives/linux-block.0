Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F511F931;
	Mon,  9 Dec 2024 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745517; cv=none; b=p4FHk9bdtnPm6UDX823IGMsFH2MC3H8rDA9eP4H0cuUG2LaTn36Vd9ToN46VkMJiJaP8bNW0lyiZR2tv0qGdZhlV/gPrV4yGaekFuq5FdfY97v/2Wf3i7hTvKxdKcpnv5PhPeHdv1GFglUwDotYJekabSHC5VIyZfm6gJKF3EJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745517; c=relaxed/simple;
	bh=5nkEV1ILLRaoHBEnwkZe5Vv72bmyTnJD94Hh1J+cDeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FCs5kbgEQcIS9F7Y26JEtoavcf4EF5oikzB2aRFeIYbyzm80Oskcdz38W5kh06cLTS5uNngpa5iXjtoY4mUS++pGiffKvhc9CyBgxr7kI0HhBqXSjN3Jt+LTgHKlQCa/77Srg5rh9V77zI1co1Vw6cJ0hFuI/m0L1rroqYsu7jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y6L3R53qPz4f3kFP;
	Mon,  9 Dec 2024 19:58:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DD0011A058E;
	Mon,  9 Dec 2024 19:58:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4dk21Zn1extEA--.18505S5;
	Mon, 09 Dec 2024 19:58:30 +0800 (CST)
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
Subject: [PATCH RFC 1/3] block/mq-deadline: Revert "block/mq-deadline: Fix the tag reservation code"
Date: Mon,  9 Dec 2024 19:55:20 +0800
Message-Id: <20241209115522.3741093-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXc4dk21Zn1extEA--.18505S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWr13ZFWDAw1kGFW5Zr1DJrb_yoW5XrWfpF
	W5JanFkr1rJF4DuF4DJ398Zr1ktws3WryfJF1aqwnakF1DAa9xXF1rtFWrZFWIvrWxCa1j
	9r4qq3s5ZwnFqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v2
	6r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjrHUDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

This reverts commit 39823b47bbd40502632ffba90ebb34fff7c8b5e8.

Because tag reservation is not fixed and will introduce performance
problem.

1) Set min_shallow_depth to 1 will end up setting wake_batch to 1,
   deadline has no reason to do this. And this will cause performance
   degradation in some high concurrency test, for both IO bandwidth
   and cpu usage.
2) async_depth is nr_requests, hence shallow_depth will always set to
   1 << bt->sb.shift. For consequence, no tag can be reserved.

The next patch will fix tag reservation again.

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

