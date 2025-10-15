Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0299D1E51EC;
	Wed, 15 Oct 2025 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493340; cv=none; b=LPv2+N48WLPOdWn98DiePtVs+JoUHIpmOkAQ/5f3juMIGJFTnV99boEkvG3+o7W2YjlI9/5LDF0Vxiz/g2iJOgo30GBZHd7FqO8Mj+acb+buPv/7hjf+ZHwAiTSpfGyG+JpCtqLvSU/QW1kzWP0SulceyHKY+F8/l9lcytv1SXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493340; c=relaxed/simple;
	bh=QywEXJQDwzIBsIoMC48r7hsSuVI4Yke3YOfvtOdpS1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UHzbXxY3yc8avIAOSHDAROQn4+dLNirFWHTyFYP7TsTCUo3kag+ElXZhuffOz/SFYiO+dQipjaQUjkvEm/om9VOZSju+hgI7brmVlDIRng06m0hdPUTjtEyur2A4qIyHn47NsdSguHjuVsCPPaA5MA8CWCq8r0gFPUpB1vV9lmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PSf34zEJ; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PSf34zEJ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rISyZZohDOA48rYR7QnxUvmI0kDql7L2L+cpbICOFNA=;
	b=PSf34zEJFi/ru4qEC55lGXW0MgHcgIu29OFSoePMljv8dRDymUDbPFi/GdEOrHmbyHCU4IMMK
	WaT4N8QaQ+G8AAh9FKwJF/bSdNAYGIdRvYYxut7FSh34zUWw2bl52vQXFWGkr59dVY+xRXvNNUs
	Oiu/hPknyCgBKtzye99EsKQ=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cmZ0456pfz12LFc;
	Wed, 15 Oct 2025 09:54:44 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
	by mail.maildlp.com (Postfix) with ESMTPS id 02C521800EB;
	Wed, 15 Oct 2025 09:55:30 +0800 (CST)
Received: from huawei.com (10.50.87.129) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 15 Oct
 2025 09:55:29 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <axboe@kernel.dk>, <clm@meta.com>, <nilay@linux.ibm.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai3@huawei.com>, <yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <johnny.chenyi@huawei.com>
Subject: [PATCH] blk-mq: fix stale tag depth for shared sched tags in blk_mq_update_nr_requests()
Date: Wed, 15 Oct 2025 09:48:27 +0800
Message-ID: <20251015014827.2997591-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500007.china.huawei.com (7.202.194.92)

Commit 7f2799c546db ("blk-mq: cleanup shared tags case in
blk_mq_update_nr_requests()") moves blk_mq_tag_update_sched_shared_tags()
before q->nr_requests is updated, however, it's still using the old
q->nr_requests to resize tag depth.

Fix this problem by passing in expected new tag depth.

Fixes: 7f2799c546db ("blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-sched.c | 2 +-
 block/blk-mq-tag.c   | 5 +++--
 block/blk-mq.c       | 2 +-
 block/blk-mq.h       | 3 ++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index d06bb137a743..e0bed16485c3 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -557,7 +557,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
 	if (blk_mq_is_shared_tags(flags)) {
 		/* Shared tags are stored at index 0 in @et->tags. */
 		q->sched_shared_tags = et->tags[0];
-		blk_mq_tag_update_sched_shared_tags(q);
+		blk_mq_tag_update_sched_shared_tags(q, et->nr_requests);
 	}
 
 	queue_for_each_hw_ctx(q, hctx, i) {
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index c7a4d4b9cc87..5b664dbdf655 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -622,10 +622,11 @@ void blk_mq_tag_resize_shared_tags(struct blk_mq_tag_set *set, unsigned int size
 	sbitmap_queue_resize(&tags->bitmap_tags, size - set->reserved_tags);
 }
 
-void blk_mq_tag_update_sched_shared_tags(struct request_queue *q)
+void blk_mq_tag_update_sched_shared_tags(struct request_queue *q,
+					 unsigned int nr)
 {
 	sbitmap_queue_resize(&q->sched_shared_tags->bitmap_tags,
-			     q->nr_requests - q->tag_set->reserved_tags);
+			     nr - q->tag_set->reserved_tags);
 }
 
 /**
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 09f579414161..d626d32f6e57 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4941,7 +4941,7 @@ struct elevator_tags *blk_mq_update_nr_requests(struct request_queue *q,
 		 * tags can't grow, see blk_mq_alloc_sched_tags().
 		 */
 		if (q->elevator)
-			blk_mq_tag_update_sched_shared_tags(q);
+			blk_mq_tag_update_sched_shared_tags(q, nr);
 		else
 			blk_mq_tag_resize_shared_tags(set, nr);
 	} else if (!q->elevator) {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index af42dc018808..c4fccdeb5441 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -186,7 +186,8 @@ void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags);
 void blk_mq_tag_resize_shared_tags(struct blk_mq_tag_set *set,
 		unsigned int size);
-void blk_mq_tag_update_sched_shared_tags(struct request_queue *q);
+void blk_mq_tag_update_sched_shared_tags(struct request_queue *q,
+					 unsigned int nr);
 
 void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
-- 
2.39.2

