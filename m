Return-Path: <SRS0=SfBO=36=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8E8C2BA83
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 02:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9740C20715
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 02:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgBJCNf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Feb 2020 21:13:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbgBJCNf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 9 Feb 2020 21:13:35 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EA3B6AAEBF29FA3C27C1;
        Mon, 10 Feb 2020 10:13:32 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.66) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 10 Feb 2020
 10:13:23 +0800
Subject: Re: [PATCH] block: revert pushing the final release of request_queue
 to a workqueue.
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>, <chaitanya.kulkarni@wdc.com>,
        <damien.lemoal@wdc.com>, <dhowells@redhat.com>,
        <asml.silence@gmail.com>, <ajay.joshi@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>,
        <luoshijie1@huawei.com>, jan kara <jack@suse.cz>
References: <20200206111052.45356-1-yukuai3@huawei.com>
 <70ce8830-2594-2b7b-9ca9-5fb7edd374d7@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <f89ae154-d6b7-0a3b-060d-f3131b0c1c1d@huawei.com>
Date:   Mon, 10 Feb 2020 10:13:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <70ce8830-2594-2b7b-9ca9-5fb7edd374d7@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/2/10 9:00, Bart Van Assche wrote:
> Have you already noticed patch "[PATCH] blktrace: Protect q->blk_trace
> with RCU"? If not, have you already tried to verify whether that patch
> fixes the use-after-free detected by syzbot?

I just tested and confirmed the patch didn't fix the problem.

By the way, I think Ming is right about "So release not by wq just
reduces the chance, instead of fixing it completely.", and "move
blk_mq_debugfs_unregister() into blk_unregister_queue()" is a good
choice. However, blk_trace_shutdown() and blk_mq_exit_queue() also
remove some files or dirs, and they may need to move to
blk_unregister_queue().

I tested following patch fixes the problem, however I'm not sure if
move blk_trace_shutdown() and blk_mu_exit_queue() is ok or we should
just move debgfs-related part.

---
  block/blk-core.c  |  3 ---
  block/blk-sysfs.c | 12 ++++++------
  2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 50a5de025d5e..1ab9808e73c7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -395,9 +395,6 @@ void blk_cleanup_queue(struct request_queue *q)
         del_timer_sync(&q->backing_dev_info->laptop_mode_wb_timer);
         blk_sync_queue(q);

-       if (queue_is_mq(q))
-               blk_mq_exit_queue(q);
-
         /*
         ┊* In theory, request pool of sched_tags belongs to request queue.
         ┊* However, the current implementation requires tag_set for freeing
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fca9b158f4a0..a0f64d641cb0 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -893,11 +893,6 @@ static void __blk_release_queue(struct work_struct 
*work)
         if (queue_is_mq(q))
                 blk_mq_release(q);

-       blk_trace_shutdown(q);
-
-       if (queue_is_mq(q))
-               blk_mq_debugfs_unregister(q);
-
         bioset_exit(&q->bio_split);

         ida_simple_remove(&blk_queue_ida, q->id);
@@ -1043,8 +1038,13 @@ void blk_unregister_queue(struct gendisk *disk)
         ┊* Remove the sysfs attributes before unregistering the queue data
         ┊* structures that can be modified through sysfs.
         ┊*/
-       if (queue_is_mq(q))
+
+       blk_trace_shutdown(q);
+       if (queue_is_mq(q)) {
                 blk_mq_unregister_dev(disk_to_dev(disk), q);
+               blk_mq_exit_queue(q);
+               blk_mq_debugfs_unregister(q);
+       }

         kobject_uevent(&q->kobj, KOBJ_REMOVE);
         kobject_del(&q->kobj);
--
2.17.2


