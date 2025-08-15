Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CFE2BDC09;
	Fri, 15 Aug 2025 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245414; cv=none; b=Ff8396EJ/mNRN7SfMmGBeJIPYo+3tEnSTXdn3NNNWZhLVXaIEvFw8wS1H5hixuMWoVdYAqaYVDMLgJ2PoErNnQcIiHCaauRwr/+7WVeL7U0K2IvAUQEA4vGMWpg0baQLC48qm2fl0OAvHFR2IrwxC4VjSVVYMH+gFdDj+GRY9ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245414; c=relaxed/simple;
	bh=JvyIOwpLHAkd49CL8/fvocRVASWsFuJRSncCBdL3grU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CsWUykXOKqRilIdiDtBXGGWVIKI96bubnSMS2D8f04zTEgftAXMxV0FV91GPXhRuByHJiU0PIfJMMiahKLn4Rfc/C78n3g3wOyxcjzk0K9KFP9HatRpBck7oNXIZqeS9MR2nOOE2cfS6nI894aSsj8D60jyeti1b069Brzen9AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c3FCP6yW2zKHMjH;
	Fri, 15 Aug 2025 16:10:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 491C11A0F34;
	Fri, 15 Aug 2025 16:10:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxBc655o+xX_Dg--.53834S10;
	Fri, 15 Aug 2025 16:10:09 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	hare@suse.de,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 06/10] blk-mq: split bitmap grow and resize case in blk_mq_update_nr_requests()
Date: Fri, 15 Aug 2025 16:02:12 +0800
Message-Id: <20250815080216.410665-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250815080216.410665-1-yukuai1@huaweicloud.com>
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjxBc655o+xX_Dg--.53834S10
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWkXF18Ww1xJr4DWF17KFg_yoW8Xw18pF
	Wa9a1ak3sYqr15ZFWIqasrX3ZYgFs3XF1Syr4ftFyFgr10gr4agw4Sgr9xXFy8trZ3CayS
	krs8trWvyr1UXrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

No functional changes are intended, make code cleaner and prepare to fix
the grow case in following patches.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1e85fcd474c2..11c8baebb9a0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4931,21 +4931,26 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 			blk_mq_tag_update_sched_shared_tags(q);
 		else
 			blk_mq_tag_resize_shared_tags(set, nr);
+	} else if (!q->elevator) {
+		queue_for_each_hw_ctx(q, hctx, i) {
+			if (!hctx->tags)
+				continue;
+			sbitmap_queue_resize(&hctx->tags->bitmap_tags,
+				nr - hctx->tags->nr_reserved_tags);
+		}
+	} else if (nr <= q->elevator->et->nr_requests) {
+		queue_for_each_hw_ctx(q, hctx, i) {
+			if (!hctx->tags)
+				continue;
+			sbitmap_queue_resize(&hctx->sched_tags->bitmap_tags,
+				nr - hctx->sched_tags->nr_reserved_tags);
+		}
 	} else {
 		queue_for_each_hw_ctx(q, hctx, i) {
 			if (!hctx->tags)
 				continue;
-			/*
-			 * If we're using an MQ scheduler, just update the
-			 * scheduler queue depth. This is similar to what the
-			 * old code would do.
-			 */
-			if (hctx->sched_tags)
-				ret = blk_mq_tag_update_depth(hctx,
-						&hctx->sched_tags, nr);
-			else
-				ret = blk_mq_tag_update_depth(hctx,
-						&hctx->tags, nr);
+			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
+						      nr);
 			if (ret)
 				goto out;
 		}
-- 
2.39.2

