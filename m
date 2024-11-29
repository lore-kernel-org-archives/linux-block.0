Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF596156F28;
	Fri, 29 Nov 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871873; cv=none; b=GUYF77Ob822gvx/iqUNnRF8K0yEp/vFB/dao7VWt+H97vAWiLAQpH+WnYjBM5i0GQwVa1cVVY9pFay/faWGWNoa8bIqDwRcHXUZH6DFAFRzq/2bp70ggN1OwLgz6wqVqQ5Gas5xRc3I2cU4qtkuagqc5epUxS38gWbpTpa+gBQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871873; c=relaxed/simple;
	bh=XaeKftVeXGyRZzGmIiuFCz58QtyDN9yONfT5pfxu1kg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bRxxIHSojDKbLdu1aeMTaWovRETyfdi112nyA4X5LDUoXWSqz8+mR5KRHvFWXd/KnHALR84Rb8TXOQ4Gyt++o50la5qHh/QQSj3O4MmOckj7rxVqkMm6s76MmSfGV5ewLmw7kTuAkFDvtiCdPVA6WjS0rk2G9KSSr6K+mI4yrDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y06yV08lRz4f3jXJ;
	Fri, 29 Nov 2024 17:17:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D40F21A0568;
	Fri, 29 Nov 2024 17:17:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4eyhkln+8ShDA--.44415S4;
	Fri, 29 Nov 2024 17:17:40 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: yukuai3@huawei.com,
	axboe@kernel.dk,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] block, bfq: fix bfqq uaf in bfq_limit_depth()
Date: Fri, 29 Nov 2024 17:15:09 +0800
Message-Id: <20241129091509.2227136-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4eyhkln+8ShDA--.44415S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKw4xCFWxXF4UAFyrGw1Utrb_yoWxXrWkpr
	ZIg393Ar48Ja45Xr4xt3W2kryFkF43W3srtFn3Kw1fZFWDAwnIgF90y3W0qF1F9r95Aa47
	JF1vga4DXF17XFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUU
	UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Set new allocated bfqq to bic or remove freed bfqq from bic are both
protected by bfqd->lock, however bfq_limit_depth() is deferencing bfqq
from bic without the lock, this can lead to UAF if the io_context is
shared by multiple tasks.

For example, test bfq with io_uring can trigger following UAF in v6.6:

==================================================================
BUG: KASAN: slab-use-after-free in bfqq_group+0x15/0x50

Call Trace:
 <TASK>
 dump_stack_lvl+0x47/0x80
 print_address_description.constprop.0+0x66/0x300
 print_report+0x3e/0x70
 kasan_report+0xb4/0xf0
 bfqq_group+0x15/0x50
 bfqq_request_over_limit+0x130/0x9a0
 bfq_limit_depth+0x1b5/0x480
 __blk_mq_alloc_requests+0x2b5/0xa00
 blk_mq_get_new_requests+0x11d/0x1d0
 blk_mq_submit_bio+0x286/0xb00
 submit_bio_noacct_nocheck+0x331/0x400
 __block_write_full_folio+0x3d0/0x640
 writepage_cb+0x3b/0xc0
 write_cache_pages+0x254/0x6c0
 write_cache_pages+0x254/0x6c0
 do_writepages+0x192/0x310
 filemap_fdatawrite_wbc+0x95/0xc0
 __filemap_fdatawrite_range+0x99/0xd0
 filemap_write_and_wait_range.part.0+0x4d/0xa0
 blkdev_read_iter+0xef/0x1e0
 io_read+0x1b6/0x8a0
 io_issue_sqe+0x87/0x300
 io_wq_submit_work+0xeb/0x390
 io_worker_handle_work+0x24d/0x550
 io_wq_worker+0x27f/0x6c0
 ret_from_fork_asm+0x1b/0x30
 </TASK>

Allocated by task 808602:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 __kasan_slab_alloc+0x83/0x90
 kmem_cache_alloc_node+0x1b1/0x6d0
 bfq_get_queue+0x138/0xfa0
 bfq_get_bfqq_handle_split+0xe3/0x2c0
 bfq_init_rq+0x196/0xbb0
 bfq_insert_request.isra.0+0xb5/0x480
 bfq_insert_requests+0x156/0x180
 blk_mq_insert_request+0x15d/0x440
 blk_mq_submit_bio+0x8a4/0xb00
 submit_bio_noacct_nocheck+0x331/0x400
 __blkdev_direct_IO_async+0x2dd/0x330
 blkdev_write_iter+0x39a/0x450
 io_write+0x22a/0x840
 io_issue_sqe+0x87/0x300
 io_wq_submit_work+0xeb/0x390
 io_worker_handle_work+0x24d/0x550
 io_wq_worker+0x27f/0x6c0
 ret_from_fork+0x2d/0x50
 ret_from_fork_asm+0x1b/0x30

Freed by task 808589:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 kasan_save_free_info+0x27/0x40
 __kasan_slab_free+0x126/0x1b0
 kmem_cache_free+0x10c/0x750
 bfq_put_queue+0x2dd/0x770
 __bfq_insert_request.isra.0+0x155/0x7a0
 bfq_insert_request.isra.0+0x122/0x480
 bfq_insert_requests+0x156/0x180
 blk_mq_dispatch_plug_list+0x528/0x7e0
 blk_mq_flush_plug_list.part.0+0xe5/0x590
 __blk_flush_plug+0x3b/0x90
 blk_finish_plug+0x40/0x60
 do_writepages+0x19d/0x310
 filemap_fdatawrite_wbc+0x95/0xc0
 __filemap_fdatawrite_range+0x99/0xd0
 filemap_write_and_wait_range.part.0+0x4d/0xa0
 blkdev_read_iter+0xef/0x1e0
 io_read+0x1b6/0x8a0
 io_issue_sqe+0x87/0x300
 io_wq_submit_work+0xeb/0x390
 io_worker_handle_work+0x24d/0x550
 io_wq_worker+0x27f/0x6c0
 ret_from_fork+0x2d/0x50
 ret_from_fork_asm+0x1b/0x30

Fix the problem by protecting bic_to_bfqq() with bfqd->lock.

CC: Jan Kara <jack@suse.cz>
Fixes: 76f1df88bbc2 ("bfq: Limit number of requests consumed by each cgroup")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 28c2bb06e859..95dd7b795935 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -582,23 +582,31 @@ static struct request *bfq_choose_req(struct bfq_data *bfqd,
 #define BFQ_LIMIT_INLINE_DEPTH 16
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
+static bool bfqq_request_over_limit(struct bfq_data *bfqd,
+				    struct bfq_io_cq *bic, blk_opf_t opf,
+				    unsigned int act_idx, int limit)
 {
-	struct bfq_data *bfqd = bfqq->bfqd;
-	struct bfq_entity *entity = &bfqq->entity;
 	struct bfq_entity *inline_entities[BFQ_LIMIT_INLINE_DEPTH];
 	struct bfq_entity **entities = inline_entities;
-	int depth, level, alloc_depth = BFQ_LIMIT_INLINE_DEPTH;
-	int class_idx = bfqq->ioprio_class - 1;
+	int alloc_depth = BFQ_LIMIT_INLINE_DEPTH;
 	struct bfq_sched_data *sched_data;
+	struct bfq_entity *entity;
+	struct bfq_queue *bfqq;
 	unsigned long wsum;
 	bool ret = false;
-
-	if (!entity->on_st_or_in_serv)
-		return false;
+	int depth;
+	int level;
 
 retry:
 	spin_lock_irq(&bfqd->lock);
+	bfqq = bic_to_bfqq(bic, op_is_sync(opf), act_idx);
+	if (!bfqq)
+		goto out;
+
+	entity = &bfqq->entity;
+	if (!entity->on_st_or_in_serv)
+		goto out;
+
 	/* +1 for bfqq entity, root cgroup not included */
 	depth = bfqg_to_blkg(bfqq_group(bfqq))->blkcg->css.cgroup->level + 1;
 	if (depth > alloc_depth) {
@@ -643,7 +651,7 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
 			 * class.
 			 */
 			wsum = 0;
-			for (i = 0; i <= class_idx; i++) {
+			for (i = 0; i <= bfqq->ioprio_class - 1; i++) {
 				wsum = wsum * IOPRIO_BE_NR +
 					sched_data->service_tree[i].wsum;
 			}
@@ -666,7 +674,9 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
 	return ret;
 }
 #else
-static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
+static bool bfqq_request_over_limit(struct bfq_data *bfqd,
+				    struct bfq_io_cq *bic, blk_opf_t opf,
+				    unsigned int act_idx, int limit)
 {
 	return false;
 }
@@ -704,8 +714,9 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	}
 
 	for (act_idx = 0; bic && act_idx < bfqd->num_actuators; act_idx++) {
-		struct bfq_queue *bfqq =
-			bic_to_bfqq(bic, op_is_sync(opf), act_idx);
+		/* Fast path to check if bfqq is already allocated. */
+		if (!bic_to_bfqq(bic, op_is_sync(opf), act_idx))
+			continue;
 
 		/*
 		 * Does queue (or any parent entity) exceed number of
@@ -713,7 +724,7 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 		 * limit depth so that it cannot consume more
 		 * available requests and thus starve other entities.
 		 */
-		if (bfqq && bfqq_request_over_limit(bfqq, limit)) {
+		if (bfqq_request_over_limit(bfqd, bic, opf, act_idx, limit)) {
 			depth = 1;
 			break;
 		}
-- 
2.39.2

