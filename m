Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9E8C432BE
	for <linux-block@archiver.kernel.org>; Sun,  8 Aug 2021 03:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE9160EE8
	for <linux-block@archiver.kernel.org>; Sun,  8 Aug 2021 03:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhHHDHd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Aug 2021 23:07:33 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8376 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhHHDHc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Aug 2021 23:07:32 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gj3tq4MLNz8477;
        Sun,  8 Aug 2021 11:03:15 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 8 Aug 2021 11:07:09 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 8 Aug
 2021 11:07:09 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 2/2] nbd: hold tags->lock to prevent access freed request through blk_mq_tag_to_rq()
Date:   Sun, 8 Aug 2021 11:17:52 +0800
Message-ID: <20210808031752.579882-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210808031752.579882-1-yukuai3@huawei.com>
References: <20210808031752.579882-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Our test reported a uaf problem:

Read of size 4 at addr ffff80036b790b54 by task kworker/u9:1/31105

Workqueue: knbd0-recv recv_work
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
 process_one_work+0x3ec/0x9e0 kernel/workqueue.c:2147
 worker_thread+0x80/0x9d0 kernel/workqueue.c:2302
 kthread+0x1d8/0x1e0 kernel/kthread.c:255
 ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:1174

This is because tags->static_rq can be freed without clearing tags->rq,
Ming Lei had fixed the problem while itering tags, howerver, the problem
still exist in blk_mq_tag_to_rq().

Thus fix the problem by holding tags->lock, so that tags->rq can be
cleared before tags->static_rq is freed.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c38317979f74..c7ca16f0adbd 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -712,12 +712,22 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 	memcpy(&handle, reply.handle, sizeof(handle));
 	tag = nbd_handle_to_tag(handle);
 	hwq = blk_mq_unique_tag_to_hwq(tag);
-	if (hwq < nbd->tag_set.nr_hw_queues)
-		req = blk_mq_tag_to_rq(nbd->tag_set.tags[hwq],
-				       blk_mq_unique_tag_to_tag(tag));
-	if (!req || !blk_mq_request_started(req)) {
-		dev_err(disk_to_dev(nbd->disk), "Unexpected reply (%d) %p\n",
-			tag, req);
+	if (hwq < nbd->tag_set.nr_hw_queues) {
+		unsigned long flags;
+		struct blk_mq_tags *tags = nbd->tag_set.tags[hwq];
+
+		blk_mq_tags_lock(tags, &flags);
+		req = blk_mq_tag_to_rq(tags, blk_mq_unique_tag_to_tag(tag));
+		if (!blk_mq_request_started(req)) {
+			dev_err(disk_to_dev(nbd->disk), "Request not started (%d) %p\n",
+				tag, req);
+			req = NULL;
+		}
+		blk_mq_tags_unlock(tags, &flags);
+	}
+
+	if (!req) {
+		dev_err(disk_to_dev(nbd->disk), "Unexpected reply (%d)\n", tag);
 		return ERR_PTR(-ENOENT);
 	}
 	trace_nbd_header_received(req, handle);
-- 
2.31.1

