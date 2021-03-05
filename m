Return-Path: <SRS0=MGRw=ID=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6FCC433E9
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 15:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C607C65093
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 15:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhCEPTb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 10:19:31 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13442 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhCEPTW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 10:19:22 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DsWZS6TNdzjV27;
        Fri,  5 Mar 2021 23:17:52 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Mar 2021 23:19:08 +0800
From:   John Garry <john.garry@huawei.com>
To:     <hare@suse.de>, <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <axboe@kernel.dk>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pragalla@codeaurora.org>, <kashyap.desai@broadcom.com>,
        <yuyufen@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH v3 2/3] blk-mq: Freeze and quiesce all queues for tagset in elevator_exit()
Date:   Fri, 5 Mar 2021 23:14:53 +0800
Message-ID: <1614957294-188540-3-git-send-email-john.garry@huawei.com>
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

A use-after-free may occur if blk_mq_queue_tag_busy_iter() is run on a
queue when another queue associated with the same tagset is switching IO
scheduler:

BUG: KASAN: use-after-free in bt_iter+0xa0/0x120
Read of size 8 at addr ffff0410285e7e00 by task fio/2302

CPU: 24 PID: 2302 Comm: fio Not tainted 5.12.0-rc1-11925-g29a317e228d9 #747
Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21 Nemo 2.0 RC0 04/18/2018 
 Call trace:
dump_backtrace+0x0/0x2d8 
show_stack+0x18/0x68
dump_stack+0x124/0x1a0
print_address_description.constprop.13+0x68/0x30c
kasan_report+0x1e8/0x258 
__asan_load8+0x9c/0xd8
bt_iter+0xa0/0x120 
blk_mq_queue_tag_busy_iter+0x348/0x5d8
blk_mq_in_flight+0x80/0xb8
part_stat_show+0xcc/0x210
dev_attr_show+0x44/0x90
sysfs_kf_seq_show+0x120/0x1c0
kernfs_seq_show+0x9c/0xb8
seq_read_iter+0x214/0x668
kernfs_fop_read_iter+0x204/0x2c0
new_sync_read+0x1ec/0x2d0
vfs_read+0x18c/0x248
ksys_read+0xc8/0x178
__arm64_sys_read+0x44/0x58
el0_svc_common.constprop.1+0xc8/0x1a8
do_el0_svc+0x90/0xa0
el0_svc+0x24/0x38
el0_sync_handler+0x90/0xb8
el0_sync+0x154/0x180

Indeed, blk_mq_queue_tag_busy_iter() already does take a reference to its
queue usage counter when called, and the queue cannot be frozen to switch
IO scheduler until all refs are dropped. This ensures no stale references
to IO scheduler requests will be seen by blk_mq_queue_tag_busy_iter().

However, there is nothing to stop blk_mq_queue_tag_busy_iter() being
run for another queue associated with the same tagset, and it seeing
a stale IO scheduler request from the other queue after they are freed.

To stop this happening, freeze and quiesce all queues associated with the
tagset as the elevator is exited.

Signed-off-by: John Garry <john.garry@huawei.com>
---

I think that this patch is what Bart suggested:
https://lore.kernel.org/linux-block/c0d127a9-9320-6e1c-4e8d-412aa9ea9ca6@acm.org/

 block/blk.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index 3b53e44b967e..1a948bfd91e4 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -201,10 +201,29 @@ void elv_unregister_queue(struct request_queue *q);
 static inline void elevator_exit(struct request_queue *q,
 		struct elevator_queue *e)
 {
+	struct blk_mq_tag_set *set = q->tag_set;
+	struct request_queue *tmp;
+
 	lockdep_assert_held(&q->sysfs_lock);
 
+	mutex_lock(&set->tag_list_lock);
+	list_for_each_entry(tmp, &set->tag_list, tag_set_list) {
+		if (tmp == q)
+			continue;
+		blk_mq_freeze_queue(tmp);
+		blk_mq_quiesce_queue(tmp);
+	}
+
 	blk_mq_sched_free_requests(q);
 	__elevator_exit(q, e);
+
+	list_for_each_entry(tmp, &set->tag_list, tag_set_list) {
+		if (tmp == q)
+			continue;
+		blk_mq_unquiesce_queue(tmp);
+		blk_mq_unfreeze_queue(tmp);
+	}
+	mutex_unlock(&set->tag_list_lock);
 }
 
 ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
-- 
2.26.2

