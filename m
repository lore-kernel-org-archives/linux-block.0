Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9110C433E9
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 02:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEEA564E6B
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 02:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhCACKu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Feb 2021 21:10:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13010 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhCACKs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Feb 2021 21:10:48 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DpkFM0cLKzjTZb;
        Mon,  1 Mar 2021 10:08:23 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Mar 2021
 10:09:53 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <josef@toxicpanda.com>, <ming.lei@redhat.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <yuyufen@huawei.com>
Subject: [RFC PATCH 1/2] blk-mq: test tags bitmap before get request
Date:   Sun, 28 Feb 2021 21:14:43 -0500
Message-ID: <20210301021444.4134047-2-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210301021444.4134047-1-yuyufen@huawei.com>
References: <20210301021444.4134047-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For now, we set hctx->tags->rqs[i] when get driver tag successfully.
The request either comes from sched_tags->static_rqs[] with scheduler,
or comes from tags->static_rqs[] with no scheduler. But, the value won't
be clear when put driver tag. Thus, tags->rqs[i] still remain old request.

We can free these sched_tags->static_rqs[] requests when switch elevator,
update nr_requests or update nr_hw_queues. After that, unexpected access
of tags->rqs[i] may cause use-after-free crash.

For example, we reported use-after-free of request in nbd device
by syzkaller:

BUG: KASAN: use-after-free in blk_mq_request_started+0x24/0x40 block/blk-mq.c:644
Read of size 4 at addr ffff80036b77f9d4 by task kworker/u9:0/10086
Call trace:
 dump_backtrace+0x0/0x310 arch/arm64/kernel/time.c:78
 show_stack+0x28/0x38 arch/arm64/kernel/traps.c:158
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x144/0x1b4 lib/dump_stack.c:118
 print_address_description+0x68/0x2d0 mm/kasan/report.c:253
 kasan_report_error mm/kasan/report.c:351 [inline]
 kasan_report+0x134/0x2f0 mm/kasan/report.c:409
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 __asan_load4+0x88/0xb0 mm/kasan/kasan.c:699
 __read_once_size include/linux/compiler.h:193 [inline]
 blk_mq_rq_state block/blk-mq.h:106 [inline]
 blk_mq_request_started+0x24/0x40 block/blk-mq.c:644
 nbd_read_stat drivers/block/nbd.c:670 [inline]
 recv_work+0x1bc/0x890 drivers/block/nbd.c:749
 process_one_work+0x3ec/0x9e0 kernel/workqueue.c:2156
 worker_thread+0x80/0x9d0 kernel/workqueue.c:2311
 kthread+0x1d8/0x1e0 kernel/kthread.c:255
 ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:1174

The syzkaller test program sended a reply package to client
without client sending request. After receiving the package,
recv_work() try to get the remained request in tags->rqs[]
by tag, which have been free.

To avoid this type of problem, we may need to ensure the request
valid when get it by tag.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-mq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4d7c1caa439..5362a7958b74 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -836,9 +836,17 @@ void blk_mq_delay_kick_requeue_list(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
+static int blk_mq_test_tag_bit(struct blk_mq_tags *tags, unsigned int tag)
+{
+	if (!blk_mq_tag_is_reserved(tags, tag))
+		return sbitmap_test_bit(&tags->bitmap_tags->sb, tag);
+	else
+		return sbitmap_test_bit(&tags->breserved_tags->sb, tag);
+}
+
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 {
-	if (tag < tags->nr_tags) {
+	if (tag < tags->nr_tags && blk_mq_test_tag_bit(tags, tag)) {
 		prefetch(tags->rqs[tag]);
 		return tags->rqs[tag];
 	}
-- 
2.25.4

