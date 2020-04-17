Return-Path: <SRS0=bgcA=6B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641F6C38A29
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 12:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C83A21D94
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 12:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgDQMZW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:25:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45982 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728751AbgDQMZW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 08:25:22 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EBCD24DFF128255D29B4;
        Fri, 17 Apr 2020 20:25:16 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 20:25:07 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <bvanassche@acm.org>
CC:     <yukuai3@huawei.com>, <yi.zhang@huawei.com>, <yuyufen@huawei.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC] block: fix access of uninitialized pointer address in bt_for_each()
Date:   Fri, 17 Apr 2020 20:51:34 +0800
Message-ID: <20200417125134.45117-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I recently got a KASAN warning like this in our 4.19 kernel:

 ==================================================================
 BUG: KASAN: slab-out-of-bounds in bt_for_each+0x1dc/0x2c0
 Read of size 8 at addr ffff8000c0865000 by task sh/2023305

 Call trace:
 dump_backtrace+0x0/0x310
 show_stack+0x28/0x38
 dump_stack+0xd8/0x108
 print_address_description+0x68/0x2d0
 kasan_report+0x124/0x2e0
 __asan_load8+0x88/0xb0
 bt_for_each+0x1dc/0x2c0
 blk_mq_queue_tag_busy_iter+0x1f0/0x3e8
 blk_mq_in_flight+0xb4/0xe0
 part_in_flight+0x124/0x178
 part_round_stats+0x128/0x3b0
 blk_account_io_start+0x2b4/0x3f0
 blk_mq_bio_to_request+0x170/0x258
 blk_mq_make_request+0x734/0xdd8
 generic_make_request+0x388/0x740
 submit_bio+0xd8/0x3d0
 ext4_io_submit+0xb4/0xe0 [ext4]
 ext4_writepages+0xb44/0x1c00 [ext4]
 do_writepages+0xc8/0x1f8
 __filemap_fdatawrite_range+0x200/0x2a0
 filemap_flush+0x30/0x40
 ext4_alloc_da_blocks+0x54/0x200 [ext4]
 ext4_release_file+0xfc/0x150 [ext4]
 __fput+0x15c/0x3a8
 ____fput+0x24/0x30
 task_work_run+0x1a4/0x208
 do_notify_resume+0x1a8/0x1c0
 work_pending+0x8/0x10

 Allocated by task 3515778:
 kasan_kmalloc+0xe0/0x190
 kmem_cache_alloc_trace+0x18c/0x418
 alloc_pipe_info+0x74/0x240
 create_pipe_files+0x74/0x2f8
 __do_pipe_flags+0x48/0x168
 do_pipe2+0xa0/0x1d0
 __arm64_sys_pipe2+0x3c/0x50
 el0_svc_common+0xb4/0x1d8
 el0_svc_handler+0x50/0xa8
 el0_svc+0x8/0xc

 Freed by task 3515778:
 __kasan_slab_free+0x120/0x228
 kasan_slab_free+0x10/0x18
 kfree+0x88/0x3d8
 free_pipe_info+0x150/0x178
 put_pipe_info+0x138/0x1c0
 pipe_release+0xe8/0x120
 __fput+0x15c/0x3a8
 ____fput+0x24/0x30
 task_work_run+0x1a4/0x208
 do_notify_resume+0x1a8/0x1c0
 work_pending+0x8/0x10

 The buggy address belongs to the object at ffff8000c0864f00#012 which belongs to the cache kmalloc-256 of size 256
 The buggy address is located 0 bytes to the right of#012 256-byte region [ffff8000c0864f00, ffff8000c0865000)
 The buggy address belongs to the page:
 page:ffff7e0003021900 count:1 mapcount:0 mapping:ffff80036d00fc00 index:0x0 compound_mapcount: 0
 flags: 0xffffe0000008100(slab|head)
 raw: 0ffffe0000008100 ffff7e0003617f88 ffff7e000d1a6208 ffff80036d00fc00
 raw: 0000000000000000 0000000000150015 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
 ffff8000c0864f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8000c0864f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 >ffff8000c0865000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ^
 ffff8000c0865080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8000c0865100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ==================================================================

After looking into it, I think it's because bt_for_each() accessed
uninitialized pointer address:

thread1			thread2
blk_mq_alloc_tag_set
...
blk_mq_init_queue
...
submit_bio(bio1)	submit_bio(bio2)
 blk_mq_get_request
  blk_mq_get_tag
  			 ...
  			 bt_for_each
  			  bt_iter
  			   rq = tags->rqs[b]
  			    rq->q		----> here
  blk_mq_rq_ctx_init
   tags->rqs[a] = rq

blk_mq_get_tag() is called before blk_mq_rq_ctx_init(), which leaves a
window for bt_for_each() to access 'tags->rqs[tag]->q' before
'tags->rqs[tag]' is set in blk_mq_rq_ctx_init(). While blk_mq_init_tags()
is using 'kcalloc()' for 'tags->rqs'. And I think the problem exist in
mainline, too.

The problem haven't been reporduced unless I manually sleep a while
before 'tags->rqs[tag]' is set:

@@ -275,6 +275,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
        struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
        struct request *rq = tags->static_rqs[tag];
        req_flags_t rq_flags = 0;
+       static int debug_count = 0;

        if (data->flags & BLK_MQ_REQ_INTERNAL) {
                rq->tag = -1;
@@ -286,6 +287,12 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
                }
                rq->tag = tag;
                rq->internal_tag = -1;
+               if (!strcmp(dev_name(data->q->backing_dev_info->dev), "250:0")) {
+                       if (debug_count == 0) {
+                               debug_count++;
+                               msleep(5000);
+                       }
+               }
                data->hctx->tags->rqs[rq->tag] = rq;
        }

BTW, I noticed there is a similar problem that haven't been solved yet:
https://lore.kernel.org/linux-block/1545261885.185366.488.camel@acm.org/

I'm trying to fix the problem by replacing 'kcalloc' as 'kzalloc' for
'tags->rqs', and set 'tags->rqs[tag]' to 'NULL' before putting the tag.

---
 block/blk-mq.c | 3 ++-
 block/blk-mq.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7ed16ed13976..48b74d0085c7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -485,6 +485,7 @@ static void __blk_mq_free_request(struct request *rq)
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 	const int sched_tag = rq->internal_tag;
 
+	hctx->tags->rqs[rq->tag] = NULL;
 	if (rq->tag != -1)
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
@@ -1999,7 +2000,7 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 	if (!tags)
 		return NULL;
 
-	tags->rqs = kcalloc_node(nr_tags, sizeof(struct request *),
+	tags->rqs = kzalloc_node(nr_tags, sizeof(struct request *),
 				 GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
 				 node);
 	if (!tags->rqs) {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index a6094c27b827..2a55292d3d51 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -196,6 +196,7 @@ static inline void blk_mq_put_driver_tag_hctx(struct blk_mq_hw_ctx *hctx,
 	if (rq->tag == -1 || rq->internal_tag == -1)
 		return;
 
+	hctx->tags->rqs[rq->tag] = NULL;
 	__blk_mq_put_driver_tag(hctx, rq);
 }
 
@@ -207,6 +208,7 @@ static inline void blk_mq_put_driver_tag(struct request *rq)
 		return;
 
 	hctx = blk_mq_map_queue(rq->q, rq->mq_ctx->cpu);
+	hctx->tags->rqs[rq->tag] = NULL;
 	__blk_mq_put_driver_tag(hctx, rq);
 }
 
-- 
2.21.1

