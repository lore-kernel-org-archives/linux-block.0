Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008DF4502F;
	Tue, 23 Sep 2025 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611481; cv=none; b=f5tSwxtYd7M9ZmzKy3YVjlTsz5mq7fgUG+QTU/bDqj8tlgLXORIUIvPML6Knw/TMeCA3mxhiO+ejMJd9sOYnLPFMjXQH06j2oTMKyspVUH7r7fvEIRRDMPoMWxCbMmDmaP3eD/vGaptFO1RrNgZFoBf/tQQTdu3/wkVW7klM0UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611481; c=relaxed/simple;
	bh=waC9dgIqg8z/AIiVMHOz+qm2FlxkiISRWa2YwZxCvBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uHgSMV9KDR6J67qCs1bpZAJRVEMRt3rol/giLDisJie+wPfVECFFWyi1I2ihhryA+cUNu48kS9PhdOxCWfc1dH2NG/ET60GHJwPNJIkGn2y5Dy7ijY/iqd1dq0m/uizKcNl0MAuxbZFtAoQpbAYKPBGZ2/eHpQl0enyW6iTokRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cWB3L3hclzKHMW3;
	Tue, 23 Sep 2025 15:11:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 568E01A0F60;
	Tue, 23 Sep 2025 15:11:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3CGEPSNJofU8hAg--.14578S4;
	Tue, 23 Sep 2025 15:11:13 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	martin.petersen@oracle.com,
	hare@suse.de,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH] blk-mq: fix null-ptr-deref in blk_mq_free_tags() from error path
Date: Tue, 23 Sep 2025 15:01:01 +0800
Message-Id: <20250923070101.3507251-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3CGEPSNJofU8hAg--.14578S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy3Xr4UKrWrGrW5JF15XFb_yoW8uw4UpF
	W3Ga1UK343KrnrZFsrta9rA340kanYqF4xGas3uw15ZrnxCrWagF1vqr45Zr10vrZ8CFsI
	gF45tryrA3WDJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

blk_mq_free_tags() can be called after blk_mq_init_tags(), while
tags->page_list is still not initialized, causing null-ptr-deref.

Fix this problem by initializing tags->page_list at blk_mq_init_tags(),
meanwhile, also free tags directly from error path because there is no
srcu barrier.

Fixes: ad0d05dbddc1 ("blk-mq: Defer freeing of tags page_list to SRCU callback")
Reported-by: syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68d1b079.a70a0220.1b52b.0000.GAE@google.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c | 9 +++++++++
 block/blk-mq.c     | 2 --
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a63d21a4aab4..23f7731f19d1 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -569,6 +569,8 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
 	spin_lock_init(&tags->lock);
+	INIT_LIST_HEAD(&tags->page_list);
+
 	if (bt_alloc(&tags->bitmap_tags, depth, round_robin, node))
 		goto out_free_tags;
 	if (bt_alloc(&tags->breserved_tags, reserved_tags, round_robin, node))
@@ -606,6 +608,13 @@ void blk_mq_free_tags(struct blk_mq_tag_set *set, struct blk_mq_tags *tags)
 {
 	sbitmap_queue_free(&tags->bitmap_tags);
 	sbitmap_queue_free(&tags->breserved_tags);
+
+	/* if tags pages is not allocated yet, free tags directly */
+	if (list_empty(&tags->page_list)) {
+		kfree(tags);
+		return;
+	}
+
 	call_srcu(&set->tags_srcu, &tags->rcu_head, blk_mq_free_tags_callback);
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4ccf11cadf8c..09f579414161 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3582,8 +3582,6 @@ static int blk_mq_alloc_rqs(struct blk_mq_tag_set *set,
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 
-	INIT_LIST_HEAD(&tags->page_list);
-
 	/*
 	 * rq_size is the size of the request plus driver payload, rounded
 	 * to the cacheline size
-- 
2.39.2

