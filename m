Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10E8C2BB40
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 11:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACBB8238A0
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 11:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgLQLMh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 06:12:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9223 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgLQLMg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 06:12:36 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CxTnh2yljzkrjc;
        Thu, 17 Dec 2020 19:11:04 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 17 Dec 2020 19:11:44 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>, <hare@suse.de>, <ppvk@codeaurora.org>,
        <bvanassche@acm.org>, <kashyap.desai@broadcom.com>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
Date:   Thu, 17 Dec 2020 19:07:53 +0800
Message-ID: <1608203273-170555-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

References to old IO sched requests are currently cleared from the
tagset when freeing those requests; switching elevator or changing
request queue depth is such a scenario in which this occurs.

However, this does not stop the potentially racy behaviour of freeing
and clearing a request reference between a tagset iterator getting a
reference to a request and actually dereferencing that request.

Such a use-after-free can be triggered, as follows:

==================================================================
BUG: KASAN: use-after-free in bt_iter+0xa0/0x120
Read of size 8 at addr ffff00108d589300 by task fio/3052

CPU: 32 PID: 3052 Comm: fio Tainted: GW
5.10.0-rc4-64839-g2dcf1ee5054f #693
Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon
D05 IT21 Nemo 2.0 RC0 04/18/2018
Call trace:
dump_backtrace+0x0/0x2d0
show_stack+0x18/0x68
dump_stack+0x100/0x16c
print_address_description.constprop.12+0x6c/0x4e8
kasan_report+0x130/0x200
__asan_load8+0x9c/0xd8
bt_iter+0xa0/0x120
blk_mq_queue_tag_busy_iter+0x2d8/0x540
blk_mq_in_flight+0x80/0xb8
part_stat_show+0xd8/0x238
dev_attr_show+0x44/0x90
sysfs_kf_seq_show+0x128/0x1c8
kernfs_seq_show+0xa0/0xb8
seq_read_iter+0x1ec/0x6a0
seq_read+0x1d0/0x250
kernfs_fop_read+0x70/0x330
vfs_read+0xe4/0x250
ksys_read+0xc8/0x178
__arm64_sys_read+0x44/0x58
el0_svc_common.constprop.2+0xc4/0x1e8
do_el0_svc+0x90/0xa0
el0_sync_handler+0x128/0x178
el0_sync+0x158/0x180

This is found experimentally by running fio on 2x SCSI disks - 1x disk
holds the root partition. Userspace is constantly triggering the tagset
iter from reading the root (gen)disk partition info. And so if the IO
sched is constantly changed on the other disk, eventually the UAF occurs,
as described above.

For experiments sake, a mdelay() is added to trigger the UAF within a
sane timeframe, as follows:

+++ b/block/blk-mq-tag.c
@@ -215,8 +215,11 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
         * We can hit rq == NULL here, because the tagging functions
         * test and set the bit before assigning ->rqs[].
         */
-       if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
-               return iter_data->fn(hctx, rq, iter_data->data, reserved);
+       if (rq) {
+               mdelay(50);
+               if (rq->q == hctx->queue && rq->mq_hctx == hctx)
+                       return iter_data->fn(hctx, rq, iter_data->data, reserved);
+       }
        return true;
 }

This delay increases the window for the iter in between getting the
request reference and actually dereferencing it.

To solve this problem, lockout the per-hw queue tagset iterators while
freeing IO sched tags.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/blk-mq-tag.c | 20 ++++++++++++++++++--
 block/blk-mq-tag.h |  3 +++
 block/blk-mq.c     |  2 ++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a6df2d5df88a..853ed5b889aa 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -358,10 +358,19 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 {
 	int i;
 
 	for (i = 0; i < tagset->nr_hw_queues; i++) {
-		if (tagset->tags && tagset->tags[i])
-			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
+		if (tagset->tags && tagset->tags[i]) {
+			struct blk_mq_tags *tags = tagset->tags[i];
+
+			if (!atomic_inc_not_zero(&tags->iter_usage_counter))
+				continue;
+
+			__blk_mq_all_tag_iter(tags, fn, priv,
 					      BT_TAG_ITER_STARTED);
+
+			atomic_dec(&tags->iter_usage_counter);
+		}
 	}
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
@@ -435,9 +444,14 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		if (!blk_mq_hw_queue_mapped(hctx))
 			continue;
 
+		if (!atomic_inc_not_zero(&tags->iter_usage_counter))
+			continue;
+
 		if (tags->nr_reserved_tags)
 			bt_for_each(hctx, tags->breserved_tags, fn, priv, true);
 		bt_for_each(hctx, tags->bitmap_tags, fn, priv, false);
+
+		atomic_dec(&tags->iter_usage_counter);
 	}
 	blk_queue_exit(q);
 }
@@ -461,6 +475,8 @@ static int blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
 		     round_robin, node))
 		goto free_bitmap_tags;
 
+	atomic_set(&tags->iter_usage_counter, 1);
+
 	tags->bitmap_tags = &tags->__bitmap_tags;
 	tags->breserved_tags = &tags->__breserved_tags;
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 7d3e6b333a4a..563019d60f05 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -11,6 +11,9 @@ struct blk_mq_tags {
 
 	atomic_t active_queues;
 
+	/* Only interesting for driver tags */
+	atomic_t	iter_usage_counter;
+
 	struct sbitmap_queue *bitmap_tags;
 	struct sbitmap_queue *breserved_tags;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8465d7c5ebf0..a61279be0120 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2315,7 +2315,9 @@ void __blk_mq_free_rqs_ext(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 void blk_mq_free_rqs_ext(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx, struct blk_mq_tags *ref_tags)
 {
+	while (atomic_cmpxchg(&ref_tags->iter_usage_counter, 1, 0) != 1);
 	__blk_mq_free_rqs_ext(set, tags, hctx_idx, ref_tags);
+	atomic_set(&ref_tags->iter_usage_counter, 1);
 }
 			 
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
-- 
2.26.2

