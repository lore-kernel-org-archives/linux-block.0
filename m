Return-Path: <SRS0=DGx4=32=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D400C2D0B1
	for <linux-block@archiver.kernel.org>; Thu,  6 Feb 2020 11:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17333206CC
	for <linux-block@archiver.kernel.org>; Thu,  6 Feb 2020 11:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBFLMF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:12:05 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36448 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727560AbgBFLMF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Feb 2020 06:12:05 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 90BFE2624F6B1E4B9F84;
        Thu,  6 Feb 2020 19:11:55 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 6 Feb 2020
 19:11:46 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <chaitanya.kulkarni@wdc.com>, <damien.lemoal@wdc.com>,
        <bvanassche@acm.org>, <dhowells@redhat.com>,
        <asml.silence@gmail.com>, <ajay.joshi@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>, <luoshijie1@huawei.com>
Subject: [PATCH] block: revert pushing the final release of request_queue to a workqueue.
Date:   Thu, 6 Feb 2020 19:10:52 +0800
Message-ID: <20200206111052.45356-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot is reporting use after free bug in debugfs_remove[1].

This is because in request_queue, 'q->debugfs_dir' and
'q->blk_trace->dir' could be the same dir. And in __blk_release_queue(),
blk_mq_debugfs_unregister() will remove everything inside the dir.

With futher investigation of the reporduce repro, the problem can be
reporduced by following procedure:

1. LOOP_CTL_ADD, create a request_queue q1, blk_mq_debugfs_register() will
create the dir.
2. LOOP_CTL_REMOVE, blk_release_queue() will add q1 to release queue.
3. LOOP_CTL_ADD, create another request_queue q2,blk_mq_debugfs_register()
will fail because the dir aready exist.
4. BLKTRACESETUP, create two files(msg and dropped) inside the dir.
5. call __blk_release_queue() for q1, debugfs_remove_recursive() will
delete the files created in step 4.
6. LOOP_CTL_REMOVE, blk_release_queue() will add q2 to release queue.
And when __blk_release_queue() is called for q2, blk_trace_shutdown() will
try to release the two files created in step 4, wich are aready released
in step 5.

|thread1		  |kworker	             |thread2               |
| ----------------------- | ------------------------ | -------------------- |
|loop_control_ioctl       |                          |                      |
| loop_add                |                          |                      |
|  blk_mq_debugfs_register|                          |                      |
|   debugfs_create_dir    |                          |                      |
|loop_control_ioctl       |                          |                      |
| loop_remove		  |                          |                      |
|  blk_release_queue      |                          |                      |
|   schedule_work         |                          |                      |
|			  |			     |loop_control_ioctl    |
|			  |			     | loop_add             |
|			  |			     |  ...                 |
|			  |			     |blk_trace_ioctl       |
|			  |			     | __blk_trace_setup    |
|			  |			     |   debugfs_create_file|
|			  |__blk_release_queue       |                      |
|			  | blk_mq_debugfs_unregister|                      |
|			  |  debugfs_remove_recursive|                      |
|			  |			     |loop_control_ioctl    |
|			  |			     | loop_remove          |
|			  |			     |  ...                 |
|			  |__blk_release_queue       |                      |
|			  | blk_trace_shutdown       |                      |
|			  |  debugfs_remove          |                      |

commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression") pushed the
final release of request_queue to a workqueue, witch is not necessary
since commit 1e9364283764 ("blk-sysfs: Rework documention of
__blk_release_queue").

[1] https://syzkaller.appspot.com/bug?extid=903b72a010ad6b7a40f2
References: CVE-2019-19770
Fixes: commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression")
Reported-by: syzbot <syz...@syzkaller.appspotmail.com>
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 block/blk-sysfs.c      | 18 +++++-------------
 include/linux/blkdev.h |  2 --
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fca9b158f4a0..3f448292099d 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -862,8 +862,8 @@ static void blk_exit_queue(struct request_queue *q)
 
 
 /**
- * __blk_release_queue - release a request queue
- * @work: pointer to the release_work member of the request queue to be released
+ * blk_release_queue - release a request queue
+ * @@kobj:    the kobj belonging to the request queue to be released
  *
  * Description:
  *     This function is called when a block device is being unregistered. The
@@ -873,9 +873,10 @@ static void blk_exit_queue(struct request_queue *q)
  *     of the request queue reaches zero, blk_release_queue is called to release
  *     all allocated resources of the request queue.
  */
-static void __blk_release_queue(struct work_struct *work)
+static void blk_release_queue(struct kobject *kobj)
 {
-	struct request_queue *q = container_of(work, typeof(*q), release_work);
+	struct request_queue *q =
+		container_of(kobj, struct request_queue, kobj);
 
 	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
 		blk_stat_remove_callback(q, q->poll_cb);
@@ -904,15 +905,6 @@ static void __blk_release_queue(struct work_struct *work)
 	call_rcu(&q->rcu_head, blk_free_queue_rcu);
 }
 
-static void blk_release_queue(struct kobject *kobj)
-{
-	struct request_queue *q =
-		container_of(kobj, struct request_queue, kobj);
-
-	INIT_WORK(&q->release_work, __blk_release_queue);
-	schedule_work(&q->release_work);
-}
-
 static const struct sysfs_ops queue_sysfs_ops = {
 	.show	= queue_attr_show,
 	.store	= queue_attr_store,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 04cfa798a365..dff4d032c78a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -580,8 +580,6 @@ struct request_queue {
 
 	size_t			cmd_size;
 
-	struct work_struct	release_work;
-
 #define BLK_MAX_WRITE_HINTS	5
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
-- 
2.17.2

