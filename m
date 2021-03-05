Return-Path: <SRS0=MGRw=ID=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE40C433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 15:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0FE64F27
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 15:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCEPTb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 10:19:31 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12699 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhCEPTU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 10:19:20 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DsWYZ2qwSzlSkl;
        Fri,  5 Mar 2021 23:17:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Mar 2021 23:19:08 +0800
From:   John Garry <john.garry@huawei.com>
To:     <hare@suse.de>, <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <axboe@kernel.dk>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pragalla@codeaurora.org>, <kashyap.desai@broadcom.com>,
        <yuyufen@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH v3 3/3] blk-mq: Lockout tagset iterator when exiting elevator
Date:   Fri, 5 Mar 2021 23:14:54 +0800
Message-ID: <1614957294-188540-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All queues associated with a tagset are frozen when one queue is exiting
an elevator. This is to ensure that one queue running
blk_mq_queue_tag_busy_iter() cannot hold a stale request reference for
the queue who is exiting the elevator.

However, there is nothing to stop blk_mq_all_tag_iter() being run for
the tagset, and, again, getting hold of a stale request reference. A kasan
UAF can be triggered for this scenario:

BUG: KASAN: use-after-free in bt_tags_iter+0xe0/0x128 
Read of size 4 at addr ffff001085330fcc by task more/3038 
 
 CPU: 1 PID: 3038 Comm: more Not tainted 5.12.0-rc1-11926-g7359e4a1604d-dirty #750 
 Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21 Nemo 2.0 RC0 04/18/2018
Call trace: 
dump_backtrace+0x0/0x2d0 
show_stack+0x18/0x68 
dump_stack+0x100/0x16c 
print_address_description.constprop.13+0x68/0x30c
kasan_report+0x1d8/0x240 
__asan_load4+0x9c/0xd8 
bt_tags_iter+0xe0/0x128
__blk_mq_all_tag_iter+0x320/0x3a8
blk_mq_tagset_busy_iter+0x84/0xb8
scsi_host_busy+0x88/0xb8 
show_host_busy+0x1c/0x48 
dev_attr_show+0x44/0x90
sysfs_kf_seq_show+0x128/0x1c8
kernfs_seq_show+0xa0/0xb8
seq_read_iter+0x210/0x660
kernfs_fop_read_iter+0x208/0x2b0 
new_sync_read+0x1ec/0x2d0
vfs_read+0x188/0x248 
ksys_read+0xc8/0x178 
__arm64_sys_read+0x44/0x58 
el0_svc_common.constprop.1+0xc4/0x190
do_el0_svc+0x90/0xa0 
el0_svc+0x24/0x38
el0_sync_handler+0x90/0xb8 
el0_sync+0x154/0x180 
 
To avoid this, reject the tagset iterators when the queue is exiting
the elevator.

This should not break any semantics in blk_mq_all_tag_iter(), as, since
all queues are frozen, there should be no active tags to iterate.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/blk-mq-tag.c     | 5 +++++
 block/blk-mq.c         | 1 +
 block/blk.h            | 4 ++++
 include/linux/blk-mq.h | 1 +
 4 files changed, 11 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 7ff1b20d58e7..5950fee490e8 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -358,11 +358,16 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 {
 	int i;
 
+	if (!atomic_inc_not_zero(&tagset->iter_usage_counter))
+		return;
+
 	for (i = 0; i < tagset->nr_hw_queues; i++) {
 		if (tagset->tags && tagset->tags[i])
 			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
 					      BT_TAG_ITER_STARTED);
 	}
+
+	atomic_dec(&tagset->iter_usage_counter);
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9cb60bf7ac24..326e1b0e5b83 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3493,6 +3493,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 			goto out_free_mq_rq_maps;
 		}
 	}
+	atomic_set(&set->iter_usage_counter, 1);
 
 	mutex_init(&set->tag_list_lock);
 	INIT_LIST_HEAD(&set->tag_list);
diff --git a/block/blk.h b/block/blk.h
index 1a948bfd91e4..461e5b54eb5f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -214,9 +214,13 @@ static inline void elevator_exit(struct request_queue *q,
 		blk_mq_quiesce_queue(tmp);
 	}
 
+	while (atomic_cmpxchg(&set->iter_usage_counter, 1, 0) != 1);
+
 	blk_mq_sched_free_requests(q);
 	__elevator_exit(q, e);
 
+	atomic_set(&set->iter_usage_counter, 1);
+
 	list_for_each_entry(tmp, &set->tag_list, tag_set_list) {
 		if (tmp == q)
 			continue;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2c473c9b8990..30a21335767b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -263,6 +263,7 @@ struct blk_mq_tag_set {
 
 	struct mutex		tag_list_lock;
 	struct list_head	tag_list;
+	atomic_t		iter_usage_counter;
 };
 
 /**
-- 
2.26.2

